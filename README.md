# QAZ Keyamp

This repo contains a basic version of my QAZ Keymap. I have stripped out some of
the combos that are specific to the programs I use regularly for mathematics
typesetting and programming. However,all of the interesting general-use combos
are here. 
 
## They Keymap 
```
**BASE**  
Q,W,E,R,T,Y,U,I,O,P,  
LT(_NAV,A),S,D,F,G,H,J,K,L,QUOT,  
MT(MOD_LSFT,Z),X,C,V,B,N,M,COMMA,MT(MOD_RSFT,DOT),  
LCTL,DYN_REC_START1,DYN_REC_START1,MT(MOD_LCTL,SPACE),LT(_NUM_SYM,SPACE),DYN_MACRO_PLAY1,DYN_MACRO_PLAY1,RALT,  

**NUMBERS**  
1,2,3,4,5,6,7,8,9,0,  
TRNS,DYN_REC_START1,DYN_MACRO_PLAY1,F,G,SCLN,MINS,EQL,QUOT,NO,  
TRNS,DYN_REC_START2,DYN_MACRO_PLAY2,DYN_REC_STOP,TRNS,TRNS,TRNS,LBRC,RBRC,  
TRNS,TRNS,RGB_MODE_FORWARD,TRNS,TRNS,RGB_VAI,TRNS,TRNS,  

**NAVIGATION**  
TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,HOME,UP,END,PGUP,  
TRNS,TRNS,BSPC,DEL,LOCK_SHIFT,TRNS,LEFT,DOWN,RGHT,PGDN,  
TRNS,CUT,COPY,LCTL(V),TRNS,TRNS,TRNS,TRNS,TRNS,  
TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,  

**MOUSE**  
TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,HOME,MS_U,END,PGUP,  
TRNS,BTN2,BTN3,BTN1,TRNS,TRNS,MS_L,MS_D,MS_R,PGDN,  
TRNS,ACL0,ACL1,ACL2,TRNS,TRNS,TRNS,TRNS,TRNS,  
TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,  
```

## The Combos
```
L,S...Toggle Mouse Layer On/Off
COMMA,DOT...Slash
A,S...Tab
Q,W...Escape
W,E...Grave
O,P...Backspace
J,K...Backspace
L,QUOTE...Enter
F,J...Backslash
K,L...Delete
ALT,CTL...GUI Key
F,1...F1
F,2...F2
F,3...F3
F,4...F4
F,5...F5
F,6...F6
F,7...F7
F,8...F8
F,9...F9
G,0...F10
G,1...F11
G,2...F12
R,E,S,T...Reset Keyboard
J,C...Copy
J,X...Cut
J,V...Paste
I,O...Kill To End of Line
U,I...Kill To Start of Line
```

## Combo Processor

This repo also contains an R script to process a pair of text files into QMK com
bo code. It will take care of everything including creating the combo count.  

`keys.txt` holds a list of pipe-separated key abbreviations. Here is a sample
from mine:  
```BTN2|KC_BTN2
MS_R|KC_MS_R
DOT|MT(MOD_RSFT,KC_DOT)
COMMA|KC_COMMA
```

`combos.txt` holds the combos. This also uses pipes to separate fields. The
syntax is `Combo Description | QMK Code to Execute | Comma-separated list of key
 abbreviations.` Here is a sample:  
 ```Mouse Layer|layer_move(_BASE)|MS_R,BTN2
Base Layer|layer_move(_MOU)|L,S
Slash|SEND_STRING(SS_TAP(X_SLSH))|COMMA,DOT
Tab|SEND_STRING(SS_TAP(X_TAB))|A,S
Escape|SEND_STRING(SS_TAP(X_ESC))|Q,W
Grave|SEND_STRING(SS_TAP(X_GRV))|W,E
Backspace|SEND_STRING(SS_TAP(X_BSPC))|O,P
Backspace|SEND_STRING(SS_TAP(X_BSPC))|J,K
 ```
To use the script, simply run `Rscript processor.R`. Of course, you will need R installed o
n your machine. Do `apt install R-base` or install from binaries on the [R
Project Website](https://www.r-project.org/). 
