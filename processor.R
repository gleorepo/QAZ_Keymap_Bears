
key_legend <- readLines("key.txt")
combos <- readLines("combos.txt")

combos <- gsub("\\n","\n",combos,fixed=TRUE)

key_legend <- strsplit(key_legend,split="\\|")
combos <- strsplit(combos,split="\\|")

keys <- sapply(key_legend,"[[",1)
qmk_codes <-sapply(key_legend,"[[",2)
descriptions <- sapply(combos,"[[",1)
commands <- sapply(combos,"[[",2)
combo_keys <- sapply(combos,"[[",3)

num_combos <- length(descriptions)
combo_Qmk_Codes <- list()
for(i in 1:num_combos){
  keys_in_combo <- unlist(strsplit(combo_keys[i],","))
  for(j in 1:length(keys_in_combo)){
    keys_in_combo[j] <- qmk_codes[which(keys==keys_in_combo[j])]
  }
  combo_Qmk_Codes <- c(combo_Qmk_Codes,list(keys_in_combo))
}

text <- c()
for(i in 1:num_combos){
  text <- c(text,paste0(combo_keys[i],"...",descriptions[i],collapse=""))
}
text <- paste0(text,collapse="\n")
writeLines(text,"readable_combos.txt")

text <- c()

enum <- c("enum combo_events{")
combo_names <- c()
for(i in 1:num_combos){
  name <- gsub("\\,","",combo_keys[i])
  name <- paste0(c(name,"_COMBO"),collapse="")
  name <- toupper(name)
  combo_names <- c(combo_names,name)
  enum <- c(enum,paste0(name,",",collapse=""))
}

enum <- c(enum,"GET_COMBOS,")
enum <- c(enum,"COMBO_LENGTH","};")

text <- c(text,enum)

lengthString <- "uint16_t COMBO_LEN = COMBO_LENGTH;"

text <- c(text,lengthString)


for(i in 1:num_combos){
  string <- c("const uint16_t PROGMEM ")
  string <- c(string,tolower(combo_names[i]))
  string <- c(string,"[] = {")
  for(j in 1:length(combo_Qmk_Codes[[i]])){
    string <- c(string,combo_Qmk_Codes[[i]][j],",")
  }
  string <- c(string,"COMBO_END};")
  string <- paste0(string,collapse="")
  text <- c(text,string)
}

text <- c(text,"combo_t key_combos[] = {")
for(i in 1:num_combos){
  string <- c("[",combo_names[i],"]"," = ","COMBO_ACTION(",tolower(combo_names[i]),"),")
  string <- paste0(string,collapse="")
  text <- c(text,string)
}

text <- c(text,"};")

text <- c(text,"void process_combo_event(uint16_t combo_index, bool pressed) {")
text <- c(text,"switch(combo_index) {")

for(i in 1:num_combos){
  string <- c("case ",combo_names[i],":")
  string <- paste0(string,collapse="")
  text <- c(text,string)
  string <- c("if (pressed) {",commands[i],";}")
  string <- paste0(string,collapse="")
  text <- c(text,string,"break;")
}
text <- c(text,"}","}")
text <- paste0(text,collapse="\n")
sink("combos.c")
cat(text)
sink()

