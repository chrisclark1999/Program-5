; Main.asm
; Name: Christopher Clark, Andrew Whitaker
; UTEid: cmc6954, maw5299
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.

               .ORIG x4000
; Sorry we actually do need it. Can you add it back?
; initialize the stack pointer

LD R6 STACK

; set up the keyboard interrupt vector table entry

LD R0 ISR
STI R0 KBIVE

; enable keyboard interrupts

LD R0 STACK
STI R0 KBSR

; start of actual program

FIRSTLOOP
;A
JSR LOAD_INPUT
LD R1 LETTERA
ADD R1 R1 R5	;CHECKS FOR A, IF FALSE: GO BACK - IF TRUE: GO TO U
BRnp FIRSTLOOP

;U
JSR LOAD_INPUT
LD R1 LETTERU
ADD R1 R1 R5	;CHECKS FOR U
BRnp FIRSTLOOP

;G
JSR LOAD_INPUT
LD R1 LETTERG
ADD R1 R1 R5	;CHECKS FOR G
BRnp FIRSTLOOP

LD R0 LINE
OUT




FIRSTLETTER

;U
JSR LOAD_INPUT
LD R1 LETTERU
ADD R1 R1 R5	;CHECKS FOR U
BRnp FIRSTLETTER





SECONDLETTER
;U
JSR LOAD_INPUT
LD R1 LETTERU
ADD R1 R1 R5	;CHECKS FOR U
BRz SECONDLETTER

;A
LD R1 LETTERA	;CHECKS FOR A
ADD R1 R1 R5
BRz THIRDLETTERA

;G
LD R1 LETTERG
ADD R1 R1 R5	;CHECKS FOR G
BRnp FIRSTLETTER




THIRDLETTERA
;U
JSR LOAD_INPUT
LD R1 LETTERU
ADD R1 R1 R5	;CHECKS FOR U
BRz SECONDLETTER

;A
LD R1 LETTERA	;CHECKS FOR A
ADD R1 R1 R5
BRz DONE

;G
LD R1 LETTERG
ADD R1 R1 R5	;CHECKS FOR G
BRnp FIRSTLETTER
BR DONE

THIRDLETTERG
;U
JSR LOAD_INPUT
LD R1 LETTERU
ADD R1 R1 R5	;CHECKS FOR U
BRz SECONDLETTER

;A
LD R1 LETTERA	;CHECKS FOR A
ADD R1 R1 R5
BRnp FIRSTLETTER


DONE
TRAP x25



LOAD_INPUT
ST R7 SAVER7
LDI R0 INPUT
BRz LOAD_INPUT
TRAP x21
ADD R5 R0 #0
AND R1 R1 #0
STI R1 INPUT
LD R7 SAVER7
RET


SAVER7 .BLKW 1
STACK .FILL x4000
INPUT .FILL x4600
KBSR .FILL xFE00
KBIVE .FILL x0180
ISR .FILL x2600
DDR .FILL xFE06
DSR .FILL xFE04
LETTERA .FILL -65
LETTERG .FILL -71
LETTERU .FILL -85
LETTERC .FILL -67
LINE .FILL 124
		.END
