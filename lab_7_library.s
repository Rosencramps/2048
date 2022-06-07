	.text
	.global uart_init
	.global output_character
	.global read_character
	.global read_string
 	.global output_string
	.global read_from_push_btns
 	.global illuminate_LEDs
	.global illuminate_RGB_LED
	.global read_tiva_push_button
	.global read_keypad
	.global GPIO_INIT
	.global L3ADD
	.global indent
	.global int2string
	.global string2int
	.global uart_interrupt_init
	.global gpio_interrupt_init
	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler		; This is needed for Lab #6
	.global simple_read_character
	.global get_color_code
	.global game_led_state
	.global Timer_init
	.global game_quit
	.global lab7
	.global swh_sel_menu




	 .data
	.global prompt
	.global results
	.global num_1_string
	.global num_2_string
	.global reprompt
	.global total
	.global keysPressed
	.global sw1Pressed
	.global count
	.global exiting
	.global keys
	.global sw1
	.global retVal
	.global direction
	.global lab7
	.global h_print_board

	;.global ptr_to_game_completed
	;.global ptr_to_number_to_win
	;.global ptr_to_pause_state

	.global game_completed
	.global number_to_win
	.global pause_state
	.global pause_nums
	.global pause_menu
	.global gameBoardData
	.global putty_resize
	.global putty_clear
	.global cursor_save
	.global cursor_hide
	.global cursor_show
	.global cursor_move
	.global square_down
	.global cursor_restore
	.global putty_resize2
	.global putty_left

prompt:	.string "Please enter number to add together: ", 0
result:	.string "placeholder", 0
num_1_string: 	.string "placeholder", 0
num_2_string:  	.string "placeholder", 0
reprompt:	.string "Would you like to restart? Type 'y'(yes) or 'n'(n): ", 0
total:	.string "Sum: ", 0
keysPressed:	.string "Keys pressed:  ", 0
sw1Pressed:		.string "SW1 pressed:   ", 0
count:		.string "000000000000000000", 0
exiting:	.string "Game Over: Crashed into wall", 0
keys:	.word	0x00000000
sw1:	.word	0x00000000
retVal:	.word	0x00000000

putty_resize2: .string 27,"[8;10;62t",0
putty_left: .string 27,"[1;1H",0

ptr_to_prompt:		.word prompt
ptr_to_result:		.word result
ptr_to_num_1_string:	.word num_1_string
ptr_to_num_2_string:	.word num_2_string
ptr_to_reprompt:		.word reprompt
ptr_to_total:		.word total
ptr_to_keys_pressed:	.word keysPressed
ptr_to_sw1_pressed:		.word sw1Pressed
ptr_to_count:			.word count
ptr_to_exit:			.word exiting
ptr_to_keys:			.word keys
ptr_to_sw1:				.word sw1
ptr_to_retVal:			.word retVal
ptr_to_direction:		.word direction
ptr_to_game_completed:	.word game_completed
ptr_to_number_to_win:	.word number_to_win
ptr_to_pause_state:		.word pause_state
ptr_to_pmenu:			.word pause_menu
ptr_to_pnums:			.word pause_nums
ptr_to_putty_left:		.word putty_left

ptr_to_gameBoardData:	.word gameBoardData
ptr_to_putty_resize:	.word putty_resize
ptr_to_putty_resize2:	.word putty_resize2
ptr_to_putty_clear:		.word putty_clear
ptr_to_cursor_save:		.word cursor_save
ptr_to_cursor_hide:		.word cursor_hide
ptr_to_cursor_show:		.word cursor_show
ptr_to_cursor_move:		.word cursor_move
ptr_to_square_down:		.word square_down
ptr_to_cursor_restore:	.word cursor_restore


; Lab 3 constants
U0: 	.equ 0xc000 ; UART0 Register
U0T: 	.equ 0x4000 ; UART0 REgister Top
FROFF:	.equ 0x0018 ; UART0 Flag Register Offset
TFF: 	.equ 0x0020	; bit location for TxFF
RFE:	.equ 0x0010	; bit loacation for RxFE

SYSCLCT: .equ 0x400F ;System clock address base top
SYSCLC: .equ 0xE000 ;System clock address base bottom
SYSCLC_OFF: .equ 0x608 ;System clock offset address
GPIO_DIR: .equ 0x400; GPIO Direction register offset
GPIO_DEN: .equ 0x51C; GPIO Digital enable register offset
GPIO_DATA: .equ 0x3FC; GPIO Data register offset
GPIO_RES: .equ 0x510; GPIO pull up resister offset

GPIO_F_BASET: .equ 0x4002 ; GPIO Port F Base address top
GPIO_F_BASE: .equ 0x5000 ; GPIO Port F Base address bottom
GPIO_B_BASET: .equ 0x4000 ; GPIO Port B Base address top
GPIO_B_BASE: .equ 0x5000 ; GPIO Port B Base address bottom
F_PIN_EN: .equ 0xE; 0x1E<- pins 1-4 (for button) 0xE(pins1-3) ; Variable for number of pins for enable
F_PIN_ENA: .equ 0x1E; ^ for pins 1-4
RED:	.equ 0x2 ;Code for red color led (pin 1) 0010 0x2
GREEN:	.equ 0x8;Code for green color led (pin 3) 1000 0x8
BLUE:	.equ 0x4 ;Code for blue color led (pin 2) 0100 0x4
PURPLE:	.equ 0x6;Code for purple (blue + red) color led (pins 1 & 2) 0110 0x6
YELLOW:	.equ 0xA;Code for yellow (green + blue) color led (pins 1 & 3) 1010 0xA
CYAN:	.equ 0xC;Code for cyan (green + blue) color led (pins  2 & 3) 1100 0xC
WHITE:	.equ 0xE;Code for white (red + green + blue) color led (pins 1, 2, & 3) 1110 0xE
LED_OFF: .equ 0x0; code for all off

game_led_state:
	PUSH {r4-r12,lr}

	ldr r5, ptr_to_game_completed
	ldr r5, [r5]

	cmp r5, #0
	BEQ led_num

	cmp r5, #1 ;1 is win, 2 is loss
	mov r0, #GREEN
	BEQ led_done
	;BNE led_lose

;led_lose:
	cmp r5, #2
	mov r0, #RED
	BEQ led_done

led_num:
	ldr r5, ptr_to_number_to_win
	ldr r5, [r5]

	cmp r5, #2048
	mov r0, #YELLOW
	BEQ led_done

	cmp r5, #1024
	mov r0, #PURPLE
	BEQ led_done

	cmp r5, #512
	mov r0, #WHITE
	BEQ led_done

	cmp r5, #256
	mov r0, #CYAN
	BEQ led_done

	;ldr r5, ptr_to_pause_state

led_done:
	BL illuminate_RGB_LED

	POP {r4-r12,lr}
	MOV pc, lr

uart_interrupt_init:
	PUSH {lr}
	PUSH {r4-r12}

	MOV r3, #0xC000
 	MOVT r3, #0x4000			;load UART0 address into register r3
	LDRB r4, [r3, #0x038]	;load Receive Interrupt Mask (RXIM)
	ORR r4, r4, #0x10		;set bit position 4 to 1 XXX1 XXXX
	STRB r4, [r3, #0x038]

	MOV r3, #0xE000
 	MOVT r3, #0xE000		;load EN0 address into register r3
	LDRB r4, [r3, #0x100]	;load config to allow UART to interrupt processor (UART0)
	ORR r4, r4, #0x20		;set bit position 5 to 1 XX1X XXXX
	STRB r4, [r3, #0x100]

	POP {r4-r12}
	POP {lr}
	MOV pc, lr


gpio_interrupt_init:
	PUSH {lr}
	PUSH {r4-r12}

	MOV r12, #0x5000
	MOVT r12, #0x4002	; Port F

	;Initializing for interrupts
	LDRB r4, [r12, #0x404]
	AND r4, r4, #0xEF			; set GPIO to be Edge Sensitive (Falling or Rising) XXX0 XXXX
	STRB r4, [r12, #0x404]

	LDRB r4, [r12, #0x408]
	AND r4, r4, #0xEF			; Setting GPIO Interrupt Even Register to Control Pin (GPIOEV) XXX0 XXXX
	STRB r4, [r12, #0x408]

	LDRB r4, [r12, #0x40C]		; load config for GPIO rising/falling edge (GPIOIV)
	ORR r4, r4, #0x10			; set 1 to pin 4 for Rising Edge XXX1 XXXX
	STRB r4, [r12, #0x40C]

	LDRB r4, [r12, #0x410]		; load config for GPIO interrupts (GPIOM)
	ORR r4, r4, #0x10			; set 1 to pin 4 to enable (Unmask) XXX1 XXXX
	STRB r4, [r12, #0x410]

	MOV r3, #0xE000
 	MOVT r3, #0xE000		;load top byte of EN0 address into register r3

	LDRB r4, [r3, #0x103]	;load config to allow GPIO to interrupt processor (GPIOF)
	ORR r4, r4, #0x40		;set bit position 6 to 1 X1XX XXXX
	STRB r4, [r3, #0x103]

	MOV r12, #0x4000
	MOVT r12, #0x4000	; Port D
	;Initializing for interrupts
	LDRB r4, [r12, #0x404]
	AND r4, r4, #0xF0			; set GPIO to be Edge Sensitive (Falling or Rising) XXXX 0000
	STRB r4, [r12, #0x404]

	LDRB r4, [r12, #0x408]
	AND r4, r4, #0xF0			; Setting GPIO Interrupt Even Register to Control Pin (GPIOEV) XXXX 0000
	STRB r4, [r12, #0x408]

	LDRB r4, [r12, #0x40C]		; load config for GPIO rising/falling edge (GPIOIV)
	ORR r4, r4, #0x0F			; set 1 to pins 0-3 for Rising Edge XXXX 1111
	STRB r4, [r12, #0x40C]

	LDRB r4, [r12, #0x410]		; load config for GPIO interrupts (GPIOM)
	ORR r4, r4, #0x0F			; set 1 to pins 0-3 to enable (Unmask) XXX1 XXXX
	STRB r4, [r12, #0x410]


	MOV r3, #0xE000
 	MOVT r3, #0xE000		;load EN0 address into register r3
	LDRB r4, [r3, #0x100]	;load config to allow GPIO Port D to interrupt processor (PORT D)
	ORR r4, r4, #0x08		;set bit position 3 to 1 XXXX 1XXX
	STRB r4, [r3, #0x100]


	; Your code to initialize the SW1 interrupt goes here
	; Don't forget to follow the procedure you followed in Lab #4
	; to initialize SW1.

	POP {r4-r12}
	POP {lr}
	MOV pc, lr


UART0_Handler:
	PUSH {r4-r12, lr}

	MOV r3, #0xC000
 	MOVT r3, #0x4000		;load UART0 address into register r3
 	LDRB r4, [r3, #0x044]	;load byte from UARTICR
 	ORR r4, r4, #0x10		;set bit 4 (RXIC) for interrupt clear register
 	STRB r4, [r3, #0x044]

 	BL simple_read_character

 	LDR r8, ptr_to_pause_state
	LDR r9, [r8]
	cmp r9, #1 ;check pause state, if paused go to first pause menu
	BNE u_continue
	cmp r0, #0x70
	;BEQ swh_unpause

	LDR r8, ptr_to_pause_state
	LDR r9, [r8]
	AND r9, r9, #0
	str r9, [r8]

	;bl uart_init
    ;bl GPIO_INIT
	;bl uart_interrupt_init
	;bl gpio_interrupt_init
	;bl Timer_init

	ldr r0, ptr_to_putty_resize
	BL output_string
	ldr r0, ptr_to_putty_clear
	BL output_string
	BL indent
	ldr r0, ptr_to_gameBoardData
	BL output_string
	;BL h_print_board

	B uarth_done

u_continue:

 	ldr r4, ptr_to_direction
 	LDRB r4, [r4]
 	CMP r4, #0x00		; if direction is not 0 ignore the key pressed, this is for animation
 	BNE uarth_done

	CMP r0, #0x77	; w was pressed
	IT EQ
	MOVEQ r5, #0x01	; 1 for w
	CMP r0, #0x61	; a was pressed
	IT EQ
	MOVEQ r5, #0x02	; 2 for a
	CMP r0, #0x73	; s was pressed
	IT EQ
	MOVEQ r5, #0x03	; 3 for s
	CMP r0, #0x64	; d was pressed
	IT EQ
	MOVEQ r5, #0x04	; 4 for d

	LDR r4, ptr_to_direction
	STRB r5, [r4]

uarth_done:

	POP {r4-r12,lr}
	BX lr       	; Return


Switch_Handler:
	PUSH {r4-r12, lr}

	MOV r3, #0x5000
	MOVT r3, #0x4002	; Port F
 	LDRB r4, [r3, #0x41C]	;load byte from UARTICR
 	ORR r4, r4, #0x10		;set bit 4 for interrupt clear register
 	STRB r4, [r3, #0x41C]

 	MOV r3, #0x4000
	MOVT r3, #0x4000	; Port D
 	LDRB r4, [r3, #0x41C]	;load byte from UARTICR
 	ORR r4, r4, #0x10		;set bit 4 for interrupt clear register
 	STRB r4, [r3, #0x41C]

	LDR r8, ptr_to_pause_state
	LDR r9, [r8]
	cmp r9, #1 ;check pause state, if paused go to first pause menu
	BEQ swh_first_menu

	BL read_tiva_push_button ;if not paused check if tiva button pressed, if it is set game to paused, display the menu and resize the window (if not go to end)
	cmp r0, #1
	BNE swh_done_paused
	ORR r9, r9, #1
	str r9, [r8]

	;ldr r0, ptr_to_putty_clear
	;BL output_string
	ldr r0, ptr_to_putty_resize2
	BL output_string
	ldr r0, ptr_to_putty_clear
	BL output_string
	ldr r0, ptr_to_putty_left
	BL output_string

	BL indent
	ldr r1, ptr_to_pmenu
	mov r0, r1
	BL output_string
	add r1, r1, #86
	mov r0, r1
	BL output_string
	add r1, r1, #86
	mov r0, r1
	BL output_string
	add r1, r1, #86
	mov r0, r1
	BL output_string
	;ldr r0, ptr_to_def
	;BL output_string
	B swh_done_paused

swh_first_menu:
	BL read_tiva_push_button
	cmp r0, #1
	BEQ swh_done_paused

	MOV r4, #0x7000
	MOVT r4, #0x4000	; Port D

	LDRB r0, [r4, #GPIO_DATA] 	; Get data from GPIO to see what buttons are being pressed

	and r8, r0, #1 ;;Quit and end
	cmp r8, #1
	BEQ game_quit


	and r8, r0, #2 ;;RESTART
	cmp r8, #2
	BEQ lab7

	and r8, r0, #4 ;;UNPAUSE
	cmp r8, #4
	BEQ swh_unpause

	and r8, r0, #8 ;; Choose win num
	cmp r8, #8
 	BEQ	swh_sel_menu
 	BNE swh_done_paused

swh_sel_menu:
 	;DISPLAY WIN MENU, CHECK FOR STATE, SET STATE TO WIN MENU SELECT STATE

	; TO UNPAUSE   BNE swh_done

 	;MOV r4, #0x7000
	;MOVT r4, #0x4000	; Port D

	;LDRB r0, [r4, #GPIO_DATA] 	; Get data from GPIO to see what buttons are being pressed



	;LDR r4, ptr_to_direction
	;LDRB r5, [r4]		; holds direction byte from memory
	;AND r6, r5, #0x04	; single out orientation bit
	;CMP r6, #0x00		; if zero orientation is horizontal
	;BEQ swh_swap_leftright	; change left and right values
	;BNE swh_swap_updown		; change up and down values

;swh_swap_updown:
;	EOR r5, r5, #0x02
;	STRB r5, [r4]
;	B swh_done

;swh_swap_leftright:
;	EOR r5, r5, #0x01
;	STRB r5, [r4]
;	B swh_done

swh_done:

	ldr r0, ptr_to_putty_resize
	BL output_string
	ldr r0, ptr_to_putty_clear
	BL output_string
	BL indent
	ldr r0, ptr_to_gameBoardData
	BL output_string
	BL h_print_board

swh_done_paused:
	POP {r4-r12, lr}
	BX lr       	; Return

swh_unpause:

	LDR r8, ptr_to_pause_state
	LDR r9, [r8]
	AND r9, r9, #0
	str r9, [r8]

	;bl uart_init
    ;bl GPIO_INIT
	;bl uart_interrupt_init
	bl gpio_interrupt_init
	bl Timer_init
	B swh_done

simple_read_character:
	PUSH {lr} ; Store register lr on stack
	PUSH {r4-r12}	;store non-preserved registers

	; no posting
	MOV r3, #U0
 	MOVT r3, #U0T	;load UART0 address into register r3
	LDRB r0, [r3]	; load char into return r0

	POP {r4-r12}
	POP {lr}
	mov pc, lr

L3ADD:
	PUSH {lr}   ; Store lr to stack
	PUSH {r4-r12}

 	ldr r0, ptr_to_prompt	; argument for output_string
 	BL output_string
 	ldr r0, ptr_to_num_1_string
 	BL read_string			; getting input
 	ldr r0, ptr_to_num_1_string
 	BL string2int			; get first int
 	ADD r4, r0, #0x0000		; store first int in r4

 	ldr r0, ptr_to_prompt	; argument for output_string
 	BL output_string
 	ldr r0, ptr_to_num_2_string
 	BL read_string			; getting input
 	ldr r0, ptr_to_num_2_string
 	BL string2int			; get second int
 	ADD r5, r0, #0x0000		; store second int in r5

 	ADD r6, r4, r5			; Adding two input numbers

	ldr r0, ptr_to_total	; "Sum: "
 	BL output_string

 	ldr r1, ptr_to_result	; string to ouput
 	ADD r0, r6, #0x0000		; int input for int2string
 	BL int2string
 	ldr r0, ptr_to_result	; argument result string for output_string
 	BL output_string

 	BL indent

	POP {r4-r12}
	POP {lr}	  ; Restore lr from stack
	mov pc, lr


indent:
	PUSH {lr}
	MOV r0, #0xA
 	BL output_character
 	MOV r0, #0xD
 	BL output_character
	POP {lr}
	MOV pc, lr

read_tiva_push_button:
	PUSH {lr}
	PUSH {r4-r12}

	MOV r4, #0x5000
	MOVT r4, #0x4002	; Port F

	LDRB r5, [r4, #GPIO_DATA] 	;Get data from GPIO with F port base address and #GPIO_DATA offset
	AND r6, r5, #0x10			;single out bit to check if SW1 is being pressed
	LSR r0, r6, #0x04			;put 4th index bit of I/O DATA into index 0 of r0
	;EOR r0, r0, #0x01			;flipping bit so 1 is pressed and 0 is not

	POP {r4-r12}
	POP {lr}
	MOV pc, lr

read_from_push_btns:
	PUSH {lr} ; Store register lr on stack
   	PUSH {r4-r12}

	MOV r4, #0x7000
	MOVT r4, #0x4000	; Port D

	LDRB r0, [r4, #GPIO_DATA] 	; Get data from GPIO to see what buttons are being pressed
	AND r0, r0, #0x0F			; This will hold the number to be printed in PuTTY


	POP {r4-r12}
	POP {lr}
	MOV pc, lr

read_keypad:
	PUSH {lr} ; Store register lr on stack

	MOV r4, #0x4000
	MOVT r4, #0x4000	; Port A
	MOV r5, #0x7000
	MOVT r5, #0x4000	; Port D

	MOV r8, #0x01
	STRB r8, [r5, #GPIO_DATA]	; setting all output to 1 for Port D

	NOP
	NOP
	NOP
	NOP
	NOP

	LDRB r6, [r4, #GPIO_DATA] 	; Get data from GPIO for Port A
	;LDRB r7, [r5, #GPIO_DATA] 	; Get data from GPIO for Port D

	POP {lr}
	MOV pc, lr

illuminate_RGB_LED:
	PUSH {lr}
	PUSH {r4-r12}

    MOV r8, r0 					;Copy r0 to r8
	MOV r10, #GPIO_F_BASE 		;copy f port base address to r10
	MOVT r10, #GPIO_F_BASET 	;copy top of gpio port f to r10
	STRB r8, [r10, #GPIO_DATA] ;Store color in data gpio port f

	POP {r4-r12}
	POP {lr}
	MOV pc, lr


illuminate_LEDs:
	PUSH {lr} ; Store register lr on stack

	MOV r8, r0 					;Copy r0 to r8
	MOV r10, #GPIO_B_BASE 		;copy b port base address to r10
	MOVT r10, #GPIO_B_BASET 	;copy top of gpio port b to r10
	STRB r8, [r10, #GPIO_DATA]	;Store the led code into pins for display (r8 r-> r10 (GPIO DATA offset), since leds 3-0 pins 3-0 port b

	POP {lr}
	MOV pc, lr


read_string:
	PUSH {lr}
	PUSH {r4-r12}

	MOV r6, r0
	MOVT r6, #0x2000	; move string to r6, so r0 can be used on output_character
	MOV r7, #0x00	; Initializing r7 for offset of one char per iteration of output_loop

seek:					;wait until data is read by RxFE.
	BL read_character
	BL output_character
	CMP r0, #0xD			;check for <return>
	BEQ read_string_done
	STRB r0, [r6, r7]		;storing char of a string
	ADD r7, r7, #0x1		;adding 1 to the offest
	B seek					;continue seek loop

read_string_done:
	MOV r8, #0x00			;null terminator
	STRB r8, [r6, r7]		;append null terminator to string
	MOV r0, #0xA
	BL output_character		;go to next line in PuTTY

	POP {r4-r12}
	POP {lr}
	mov pc, lr


output_string:
	PUSH {lr}   ; Store register lr on stack
	PUSH {r4-r12}	;store non-preserved registers

	MOV r3, #U0
 	MOVT r3, #U0T	;load UART0 address into register r3

	MOV r4, r0
	;MOVT r4, #0x2000	; move string to r4, so r0 can be used on output_character
	MOV r5, #0x00	; Initializing r5 for offset of one char per iteration of output_loop

string_loop:
	LDRB r0, [r4, r5]	; get one char from the string
	ADD r5, r5, #0x01	; increment offset counter
	CMP r0, #0x00	; compare to NULL
	BLNE output_character	; branch if not NULL
	CMP r0, #0x00	; compare to NULL
	BNE string_loop	; branch if not NULL

	POP {r4-r12}
	POP {lr}
	mov pc, lr


read_character:
	PUSH {lr} ; Store register lr on stack
	PUSH {r4-r12}	;store non-preserved registers

read_loop:
	LDRB r4, [r3, #FROFF]	;load r4 with flag register data
	AND r5, r4, #RFE		;single out RxFE bit, store result into r5
	CMP	r5, #RFE			;check to see if RxFE is true (bit == 1)
	BEQ read_loop

	LDRB r0, [r3]			; load char into return r0

	POP {r4-r12}
	POP {lr}
	mov pc, lr


output_character:
	PUSH {lr} ; Store register lr on stack
 	PUSH {r4-r12}	;store non-preserved registers

char_loop:

	LDRB r4, [r3, #FROFF]	;load r4 with flag register data
	AND r5, r4, #TFF		;single out TxFF bit, store result into r5
	CMP	r5, #TFF			;check to see if TxFF is true (bit == 1)
	BEQ char_loop			;loop until TxFF is not full
	STRB r0, [r3]			;load char into 'data' of data register, r3 is the address of UART0

	POP {r4-r12}
	POP {lr}
	mov pc, lr


int2string:
	PUSH {r4-r12, lr}   ; Store register lr on stack

	MOV r4, r1			; r1 hold argument of string base address
	;MOVT r4, #0x2000	; storing base address in r4, this is where our int will be placed
	MOV r5, #0x0000		; address offest/ digit count of integer (starts with one to account for NULL byte)

	ADD r7, r0, #0x0000	; copying intger into r7
	MOV r8, #0xA		; r8 = 10
count_digits:
	UDIV r7, r7, r8 	; remove least sig fig
	ADD r5, r5, #0x01	; increment count
	CMP r7, #0x00		; branches if r7 is not 0
	BNE count_digits

	MOV r7, #0x0000
	STRB r7, [r4, r5]	; storing NULL byte
	SUB r5, r5, #0x1	; decrement offset
i2string_loop:
	CMP r0, #0x0000
	BEQ i2string_done	; branch if int is zero
	UDIV r10, r0, r8	; remove least sig fig, N/2 = n
	MUL r6, r10, r8		; step 1 of modulo nx10
	SUB r6, r0, r6		; step 2 of modulo N-(nx10)
	ADD r6, r6, #0x30	; increment int into ascii char value
	STRB r6, [r4, r5]
	UDIV r0, r0, r8		; remove least sig fig
	SUB r5, r5, #0x1	; decrement offset
	B i2string_loop		; repeat until r0 is zero

i2string_done:
	POP {r4-r12, lr}
	mov pc, lr


string2int:
	PUSH {lr}   ; Store register lr on stack
	PUSH {r4-r12}

	MOV r4, r0
	MOVT r4, #0x2000	; move string to r4, so r0 can be used on output_character
	MOV r5, #0x00	; Initializing r5 for offset of one char per iteration of output_loop
	MOV r7, #0x00	; Total number variable
	MOV r8, #0xA	; Const to keep incrementing r6 by base ten

	LDRB r0, [r4, r5]	; get one char from the string

s2int_loop:
	SUB r0, r0, #0x30	; convert ascii into ints by subtracting 48 since '0' is 48
	ADD r7, r7, r0	; add least sig fig

	ADD r5, r5, #0x01	; increment offset counter
	LDRB r0, [r4, r5]	; get one char from the string
	CMP r0, #0x00	; compare to NULL
	BEQ s2int_done

	MUL r7, r7, r8	; create room for least sig fig
	BL s2int_loop	; repeat until NULL is found

s2int_done:
	MOV r0, #0x0000
	MOVT r0, #0x0000
	ADD r0, r0, r7	; putting total val into output register

	POP {r4-r12}
	POP {lr}
	mov pc, lr


GPIO_INIT:
	PUSH {lr}
	PUSH {r4-r12}

	;Enable GPIO port clock
	MOV r4, #SYSCLC
	MOVT r4, #SYSCLCT	; base address to enable clock to ports
	MOV r5, #0x3F		; Set to 1 to enable clock for all ports A-F
	STRB r5, [r4, #SYSCLC_OFF] ;store at clock offset

	; Base address registers
	; r7 is Port A
	; r8 is Port B
	; r9 is Port C
	; r10 is Port D
	; r11 is Port E
	; r12 is Port F
	MOV r7, #0x4000
	MOVT r7, #0x4000	; Port A
	MOV r8, #0x5000
	MOVT r8, #0x4000	; Port B
	MOV r9, #0x6000
	MOVT r9, #0x4000	; Port C
	MOV r10, #0x7000
	MOVT r10, #0x4000	; Port D
	MOV r11, #0x4000
	MOVT r11, #0x4002	; Port E
	MOV r12, #0x5000
	MOVT r12, #0x4002	; Port F

	;Set direction for GPIO pin
	LDRB r4, [r7, #GPIO_DIR] 	; Loading for Port A since UART uses this port
	ORR r4, r4, #0xC3			; Anding with port to 1100 0011, not change uart data, Port A
	STRB r4, [r7, #GPIO_DIR] 	; set pin direction for Port A

	LDRB r4, [r8, #GPIO_DIR]
	ORR  r4, r4, #0x0F			; setting 0000 1111 for all output, Port B
	STRB r4, [r8, #GPIO_DIR] 	; set pin direction for Port B

	LDRB r4, [r10, #GPIO_DIR] 	; set pin direction for Port D, loading to not change data
	AND r4, r4, #0xF0			; setting XXXX 0000 for all input, Port D
	;ORR r4, r4, #0x0F			; setting 0000 1111 for all output, Port D       This is for keypad
	STRB r4, [r10, #GPIO_DIR] 	; set pin direction for Port D

	LDRB r4, [r12, #GPIO_DIR]
	ORR r4, r4, #0x0E			; setting 0000 1110 for pin directions, Port F
	STRB r4, [r12, #GPIO_DIR] 	; set pin direction for Port F

	;Set GPIO pin digital
	LDRB r4, [r7, #GPIO_DEN] 	; set digital pins for Port A, loading Port A
	ORR r4, r4, #0x3C			; setting 0011 1100 for digital pins, Port A
	STRB r4, [r7, #GPIO_DEN] 	; set digital pins for Port A

	LDRB r4, [r8, #GPIO_DEN]
	ORR r4, r4, #0x0F			; setting 0000 1111 for digital pins, Port B
	STRB r4, [r8, #GPIO_DEN] 	; set digital pins for Port B

	LDRB r4, [r10, #GPIO_DEN]	; loading Port D
	ORR r4, r4, #0x0F			; setting 0000 1111 for digital pins, Port D
	STRB r4, [r10, #GPIO_DEN] 	; set digital pins for Port D

	LDRB r4, [r12, #GPIO_DEN]
	ORR r4, r4, #0x1E			; setting 0001 1110 for digital pins, Port F
	STRB r4, [r12, #GPIO_DEN] 	; set digital pins for Port F

	;Enable pull up resistor
	LDRB r4, [r7, #GPIO_RES]	; load Port A
	AND r4, r4, #0x3C			; setting 0000 0000 for pull up resistors, Port A
	STRB r4, [r7, #GPIO_RES] 	; set pull up resistors for Port A

	LDRB r4, [r8, #GPIO_RES]
	ORR r4, r4, #0x0F			; setting 0000 1111 for pull up resistors, Port B
	STRB r4, [r8, #GPIO_RES] 	; set pull up resistors for Port B

	LDRB r4, [r10, #GPIO_RES]	; load Port D
	AND r4, r4, #0xF0			; setting 0000 0000 for pull up resistors, Port D
	STRB r4, [r10, #GPIO_RES] 	; set pull up resistors for Port D

	LDRB r4, [r12, #GPIO_RES]
	ORR r4, r4, #0x1E			; setting 0001 1110 for pull up resistors, Port F
	STRB r4, [r12, #GPIO_RES] 	; set pull up resistors for Port F

	POP {r4-r12}
	POP {lr}
	MOV pc, lr

get_color_code:
	PUSH {lr}  ; Store register lr on stack
	PUSH {r4-r12}	;store non-preserved registers

	mov r4, r0 ;Copy input value ( for this case 2^x 12>x>0 and find x (log2(x) ) (2048=2^11 so output is 11)
	mov r5, #0

	cmp r4, #0
	BEQ gcc_done

gcc_loop:
	cmp r4, #1
	beq gcc_done
	asr r4, r4, #1
	add r5, r5, #1

	b gcc_loop
gcc_done:
	mov r0, r5 ;Returns the exponent for the base 2

	POP {r4-r12}
	POP {lr}
	mov pc, lr

uart_init:
	PUSH {lr}  ; Store register lr on stack
	PUSH {r4-r12}	;store non-preserved registers

	MOV r3, #U0
 	MOVT r3, #U0T	;load UART0 address into register r3

	; Provide clock to UART0
	MOV r4, #0xE618
	MOVT r4, #0x400F
	MOV r5, #0x1
	STR r5, [r4]
	; Enable clock to PortA
	MOV r4, #0xE608
	MOVT r4, #0x400F
	MOV r5, #0x1
	STR r5, [r4]
	; Disable UART0 Control
	MOV r4, #0xC030
	MOVT r4, #0x4000
	MOV r5, #0x0
	STR r5, [r4]
	; Set UART0_IBRD_R for 115,200 baud
	MOV r4, #0xC024
	MOVT r4, #0x4000
	MOV r5, #0x8
	STR r5, [r4]
	; Set UART0_FBRD_R for 115,200 baud
	MOV r4, #0xC028
	MOVT r4, #0x4000
	MOV r5, #0x2C
	STR r5, [r4]
	; Use System Clock
	MOV r4, #0xCFC8
	MOVT r4, #0x4000
	MOV r5, #0x0
	STR r5, [r4]
	; Use 8-bit word length, 1 stop bit, no parity
	MOV r4, #0xC02C
	MOVT r4, #0x4000
	MOV r5, #0x60
	STR r5, [r4]
	; Enable UART0 Control
	MOV r4, #0xC030
	MOVT r4, #0x4000
	MOV r5, #0x301
	STR r5, [r4]
	; Make PA0 and PA1 as Digital Ports
	MOV r4, #0x451C
	MOVT r4, #0x4000
	LDR r5, [r4]
	ORR r5, r5, #0x03
	STR r5, [r4]
	; Change PA0,PA1 to Use an Alternate Function
	MOV r4, #0x4420
	MOVT r4, #0x4000
	LDR r5, [r4]
	ORR r5, r5, #0x03
	STR r5, [r4]
	; Configure PA0 and PA1 for UART
	MOV r4, #0x452C
	MOVT r4, #0x4000
	LDR r5, [r4]
	ORR r5, r5, #0x11
	STR r5, [r4]

	POP {r4-r12}
	POP {lr}
	mov pc, lr


	.end
