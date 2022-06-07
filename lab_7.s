	.data

	.global keysPressed
	.global sw1Pressed
	.global count
	.global exiting
	.global keys
	.global sw1
	.global retVal
	.global gameBoardData
	.global testloc
	.global direction
	.global x
	.global putty_resize
	.global test_color
	.global copy_string
	.global game_completed
	.global number_to_win
	.global pause_state
	.global game_led_state
	.global pause_nums
	.global pause_menu
	.global putty_clear
	.global putty_resize
	.global gameBoardData
	.global putty_resize
	.global putty_clear
	.global cursor_save
	.global cursor_hide
	.global cursor_show
	.global cursor_move
	.global square_down
	.global cursor_restore
	.global putty_clear_start

game_completed:	.word	0x00000000 ; 1= won, 2= lost, 0= ongoing game
number_to_win:	.word	0x00000800 ; default to 2048
pause_state:	.word	0x00000000
score:			.word	0x00000000
time:			.word 	0x00000000
time_tick:		.byte	0x00
gameBoardArray: .word	0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
gameBACopy: 	.word	0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
arrayindex:		.word	0x00000000
testloc:		.word	0x00000000
direction: 		.byte 	0x00		; 0 for no movement, 1 for up, 2 for left, 3 for down, and 4 for right
x:				.word	0x00000000
copy_string: 	.string "00000000", 0
print_score: .string 27,"[38;5;15m 0      ", 0
print_time: .string 27,"[38;5;15m 0     ", 0

gameBoardData:	.string "score:                       time:        ", 0xA, 0xD
				.string "+---------+---------+---------+---------+ ", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "+---------+---------+---------+---------+ ", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "+---------+---------+---------+---------+ ", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "+---------+---------+---------+---------+ ", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "|         |         |         |         |", 0xA, 0xD
				.string "+---------+---------+---------+---------+ ", 0


	.text

	.global uart_interrupt_init
	.global gpio_interrupt_init
	.global UART0_Handler
	.global Switch_Handler
	.global Timer_Handler		; This is needed for Lab #6
	.global Timer_init
	.global simple_read_character
	.global output_character	; This is from your Lab #4 Library
	.global read_string		; This is from your Lab #4 Library
	.global output_string		; This is from your Lab #4 Library
	.global uart_init		; This is from your Lab #4 Library
	.global GPIO_INIT
	.global int2string
	.global indent
	.global lab7
	.global get_color_code
	.global game_quit
	.global h_print_board
	;.global ptr_to_game_completed
	;.global ptr_to_number_to_win
	;.global ptr_to_pause_state

pause_menu: .string 27,"[48;5;00m", 27, "[38;5;87m Press SW2 to quit the current game                          ", 27, "[1E", 0
			.string 27,"[48;5;00m", 27, "[38;5;87m Press SW3 to restart the current game                       ", 27, "[1E", 0
			.string 27,"[48;5;00m", 27, "[38;5;87m Press SW4 to resume the current game                        ", 27, "[1E", 0
			.string 27,"[48;5;00m", 27, "[38;5;87m Press SW5 to select the winning number for the current game ", 27, "[38;5;15m", 0

pause_nums: .string 27,"[48;5;11m", 27, "[38;5;00m Press SW2 to set win condition to 2048", 27, "[1E", 0
			.string 27,"[48;5;13m", 27, "[38;5;00m Press SW3 to set win condition to 1024", 27, "[1E", 0
			.string 27,"[48;5;15m", 27, "[38;5;00m Press SW4 to set win condition to 512 ", 27, "[1E", 0
			.string 27,"[48;5;14m", 27, "[38;5;00m Press SW5 to set win condition to 256 ", 27, "[1E", 0

putty_resize: .string 27,"[8;26;42t ",0
cursor_save: .string 27, "[s", 0
cursor_hide: .string 27, "[?25l ", 0
cursor_show: .string 27, "[?25h", 0
cursor_move: .string 27,"[03;02H", 0
test_color:		.string 27, "[48;5;04m         ", 0 ;27, "[48;5;0m",0
print_num:	.string 27, "[38;5;15m    2    ", 0
square_down: .string 27, "[9D", 27, "[1B", 0
cursor_restore: .string 27, "[u", 27, "[48;5;0m", 0
cursor_move2: .string 27,"[15;22H", 0
test_color2:		.string 27, "[48;5;13m         ", 0 ;27, "[48;5;0m",0
print_num2:	.string 27, "[38;5;00m    4    ", 0
cursor_mv_score: .string 27,"[0;07H", 0
cursor_mv_time: .string 27,"[0;36H", 0
putty_clear: .string 27,"[2J",0
putty_clear_start: .string 27,"[3J",0

cursor_arr: .string 27,"[03;02H", 0 ;top left corner of top left cell (cell 0)
			.string 27,"[03;12H", 0
			.string 27,"[03;22H", 0
			.string 27,"[03;32H", 0
			.string 27,"[09;02H", 0
			.string 27,"[09;12H", 0
			.string 27,"[09;22H", 0
			.string 27,"[09;32H", 0
			.string 27,"[15;02H", 0
			.string 27,"[15;12H", 0
			.string 27,"[15;22H", 0
			.string 27,"[15;32H", 0
			.string 27,"[21;02H", 0
			.string 27,"[21;12H", 0
			.string 27,"[21;22H", 0
			.string 27,"[21;32H", 0 ;top left corner of bottom right cell (cell 15)


format_arr: .string 27,"[48;5;00m         ", 27, "[9D", 27, "[1B", 27,"[48;5;00m         ", 27, "[9D", 27, "[1B", 27,"[48;5;00m         ", 27, "[9D", 27, "[1B", 27, "[48;5;00m         ", 27, "[9D", 27, "[1B",  27,"[48;5;00m         ",  0 ;0 (each line 127 characters)
			.string 27,"[48;5;01m         ", 27, "[9D", 27, "[1B", 27,"[48;5;01m         ", 27, "[9D", 27, "[1B", 27,"[38;5;15m    2    ", 27, "[9D", 27, "[1B", 27, "[48;5;01m         ", 27, "[9D", 27, "[1B",  27,"[48;5;01m         ",  0 ;2 (1)
			.string 27,"[48;5;02m         ", 27, "[9D", 27, "[1B", 27,"[48;5;02m         ", 27, "[9D", 27, "[1B", 27,"[38;5;15m    4    ", 27, "[9D", 27, "[1B", 27, "[48;5;02m         ", 27, "[9D", 27, "[1B",  27,"[48;5;02m         ",  0 ;4 (2)
			.string 27,"[48;5;03m         ", 27, "[9D", 27, "[1B", 27,"[48;5;03m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m    8    ", 27, "[9D", 27, "[1B", 27, "[48;5;03m         ", 27, "[9D", 27, "[1B",  27,"[48;5;03m         ",  0 ;8
			.string 27,"[48;5;04m         ", 27, "[9D", 27, "[1B", 27,"[48;5;04m         ", 27, "[9D", 27, "[1B", 27,"[38;5;15m    16   ", 27, "[9D", 27, "[1B", 27, "[48;5;04m         ", 27, "[9D", 27, "[1B",  27,"[48;5;04m         ",  0 ;16
			.string 27,"[48;5;05m         ", 27, "[9D", 27, "[1B", 27,"[48;5;05m         ", 27, "[9D", 27, "[1B", 27,"[38;5;15m    32   ", 27, "[9D", 27, "[1B", 27, "[48;5;05m         ", 27, "[9D", 27, "[1B",  27,"[48;5;05m         ",  0 ;32
			.string 27,"[48;5;06m         ", 27, "[9D", 27, "[1B", 27,"[48;5;06m         ", 27, "[9D", 27, "[1B", 27,"[38;5;15m    64   ", 27, "[9D", 27, "[1B", 27, "[48;5;06m         ", 27, "[9D", 27, "[1B",  27,"[48;5;06m         ",  0 ;64
			.string 27,"[48;5;09m         ", 27, "[9D", 27, "[1B", 27,"[48;5;09m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m   128   ", 27, "[9D", 27, "[1B", 27, "[48;5;09m         ", 27, "[9D", 27, "[1B",  27,"[48;5;09m         ",  0 ;128
			.string 27,"[48;5;10m         ", 27, "[9D", 27, "[1B", 27,"[48;5;10m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m   256   ", 27, "[9D", 27, "[1B", 27, "[48;5;10m         ", 27, "[9D", 27, "[1B",  27,"[48;5;10m         ",  0 ;256
			.string 27,"[48;5;11m         ", 27, "[9D", 27, "[1B", 27,"[48;5;11m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m   512   ", 27, "[9D", 27, "[1B", 27, "[48;5;11m         ", 27, "[9D", 27, "[1B",  27,"[48;5;11m         ",  0 ;512
			.string 27,"[48;5;12m         ", 27, "[9D", 27, "[1B", 27,"[48;5;12m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m   1024  ", 27, "[9D", 27, "[1B", 27, "[48;5;12m         ", 27, "[9D", 27, "[1B",  27,"[48;5;12m         ",  0 ;1024
			.string 27,"[48;5;13m         ", 27, "[9D", 27, "[1B", 27,"[48;5;13m         ", 27, "[9D", 27, "[1B", 27,"[38;5;00m   2048  ", 27, "[9D", 27, "[1B", 27, "[48;5;13m         ", 27, "[9D", 27, "[1B",  27,"[48;5;13m         ",  0 ;2048 (11)

ptr_to_exit:			.word exiting
ptr_to_testloc:			.word testloc
ptr_to_gameBoardData:	.word gameBoardData
ptr_to_direction:		.word direction
ptr_to_x:				.word x
ptr_to_putty_resize:	.word putty_resize
ptr_to_putty_clear:		.word putty_clear
ptr_to_test_color:		.word test_color
ptr_to_cursor_save:		.word cursor_save
ptr_to_cursor_hide:		.word cursor_hide
ptr_to_cursor_show:		.word cursor_show
ptr_to_cursor_move:		.word cursor_move
ptr_to_square_down:		.word square_down
ptr_to_cursor_restore:	.word cursor_restore
ptr_to_print_num:		.word print_num
ptr_to_print_num2:		.word print_num2
ptr_to_test_color2:		.word test_color2
ptr_to_cursor_move2:	.word cursor_move2
ptr_to_cursor_mv_score:	.word cursor_mv_score
ptr_to_print_score:		.word print_score
ptr_to_cursor_mv_time:	.word cursor_mv_time
ptr_to_print_time:		.word print_time
ptr_to_copy_string:		.word copy_string
ptr_to_gbarray:			.word gameBoardArray
ptr_to_gbcopy:			.word gameBACopy
ptr_to_arrayindex:		.word arrayindex
ptr_to_game_completed:	.word game_completed
ptr_to_number_to_win:	.word number_to_win
ptr_to_score:			.word score
ptr_to_time:			.word time
ptr_to_time_tick:		.word time_tick
ptr_to_cursor_arr:		.word cursor_arr
ptr_to_format_arr:		.word format_arr
ptr_to_pause_state:		.word pause_state
ptr_to_pmenu:			.word pause_menu
ptr_to_pnums:			.word pause_nums
ptr_to_pcs:				.word putty_clear_start

lab7:	; This is your main routine which is called from your C wrapper
	PUSH {lr}   		; Store lr to stack

    bl uart_init
    bl GPIO_INIT
	bl uart_interrupt_init
	bl gpio_interrupt_init
	bl Timer_init

	ldr r0, ptr_to_putty_resize	; scale PuTTY window
	BL output_string
	ldr r0, ptr_to_pcs			; less window scroll
	BL output_string
	ldr r0, ptr_to_cursor_hide	; hide cursor
	BL output_string

	MOV r1, #0x01		; spawn in first two tiles
	ldr r0, ptr_to_gbcopy
	str r1, [r0]
	BL spawn_tile
	ldr r0, ptr_to_gbcopy
	str r1, [r0]
	BL spawn_tile

	;ldr r1, ptr_to_pmenu
	;mov r0, r1
	;BL output_string
	;add r1, r1, #86
	;mov r0, r1
	;BL output_string
	;add r1, r1, #86
	;mov r0, r1
	;BL output_string
	;add r1, r1, #86
	;mov r0, r1
	;BL output_string


	BL indent
	BL indent
	BL indent
	ldr r0, ptr_to_gameBoardData
	BL output_string


	LDR r4, ptr_to_gameBoardData

lab6loop:
	NOP
	; waiting for interrupts
	NOP
	B lab6loop


exit:
	LDR r0, ptr_to_exit
	BL output_string
	BL indent
	BL indent


	POP {lr}		; Restore lr from the stack
	MOV pc, lr


Timer_init:
	PUSH {r4-r12, lr}

	MOV r4, #0xE000
	MOVT r4, #0x400F
	LDRB r5, [r4, #0x604]
	ORR r5, r5, #0x0001			; set Timer0 for enabling clock gating control
	STRB r5, [r4, #0x604]

	MOV r4, #0x0000
	MOVT r4, #0x4003
	LDRB r5, [r4, #0x00C]
	AND r5, r5, #0xFE			; Disable TAEN, general purpose timer control register
	STRB r5, [r4, #0x00C]

	LDRB r5, [r4, #0x0]
	AND r5, r5, #0xF8			; Set timer to 32 bit mode via GPTCR and setting GPTMCFG bit
	STRB r5, [r4, #0x0]

	LDRB r5, [r4, #0x04]
	AND r5, r5, #0xFE			; Set timer to periodic mode via GPTTAMR and TAMR bit
	STRB r5, [r4, #0x04]

	LDR r5, [r4, #0x028]
	MOV r5, #0x1200			; Set timer to interval period GPTILR to number of clock ticks (8 mil for .5 second)
	MOVT r5, #0x007A
	STR r5, [r4, #0x028]

	LDRB r5, [r4, #0x018]
	ORR r5, r5, #0x01			; Set timer to interrupt processor GPTIMR set enable TATOIM
	STRB r5, [r4, #0x018]

	MOV r4, #0xE000
	MOVT r4, #0xE000
	LDR r5, [r4, #0x100]
	MOV r8, #0x0
	MOVT r8, #0x0008
	ORR r5, r5, r8			; Configure processor to allow timer to interrupt set bit 19 in EN0 to 1
	STR r5, [r4, #0x100]


	MOV r4, #0x0000
	MOVT r4, #0x4003
	LDRB r5, [r4, #0x00C]
	ORR r5, r5, #0x01			; Enable TAEN, general purpose timer control register
	STRB r5, [r4, #0x00C]

	;MOV r4, #0x0000
	;MOVT r4, #0x4003
	;LDRB r5, [r4, #0x000]
	;AND r5, #0xFFFE			; Disable TAEN, general purpose timer control register
	;STRB r5, [r4, #0x000]

	POP {r4-r12, lr}
	MOV pc, lr

Timer_Handler:
	PUSH {r4-r12, lr}

	MOV r4, #0x0000;
	MOVT r4, #0x4003; Timer 0 base address storage into r4 #0x40030000
	LDRB r5, [r4, #0x024] ; load GPTMICR into r5 and clear the interrupt from the same interrupt clear register
	ORR r5, r5, #0x01 ; set TATOCINT to 1 to clear interrupt
	STRB r5, [r4, #0x024] ;store changed interrupt bit

	LDR r8, ptr_to_pause_state
	LDR r8, [r8]
	cmp r8, #1 ; if paused (=1) jump to end of handler
	BEQ h_done_paused

	BL game_led_state

	LDR r5, ptr_to_testloc
	LDR r4, [r5]
	ADD r4, r4, #0x01
	STRB r4, [r5] ;test incrementer

	LDR r4, ptr_to_game_completed
	LDRB r5, [r4]
	;CMP r5, #0x01		; won
	;BEQ h_done
	;CMP r5, #0x02		; lost
	;BEQ h_done


	LDR r4, ptr_to_direction
	LDRB r5, [r4]		; r5 holds direction byte from memory

	CMP r5, #0x00
	BEQ h_done
	;BEQ h_debug_loop_d
	CMP r5, #0x01
	BEQ up
	CMP r5, #0x02
	BEQ left
	CMP r5, #0x03
	BEQ down
	CMP r5, #0x04
	BEQ right


up:
	LDR r4, ptr_to_arrayindex
	LDR r5, [r4]
	CMP r5, #0x00	; ensure arrayindex offset isnt zero, arrayindex will always be 0 when not in use
	ITT EQ
	MOVEQ r5, #0x3C	; current tile, start at bottom right of board
	STREQ r5, [r4]

	MOV r10, #0x04	; loop 4 times each timer_handler (only bottom three rows of game board get iterated)
	; this will load the index that this function left off on
	MOV r4, r5
	ldr r11, ptr_to_gbarray
timer_h_up_loop:
	ldr r5, [r11, r4]	; load array contents of current tile index r4 into r5
	SUB r7, r4, #0x10	; go to index of tile above (4 * 4 bytes)
	ldr r6, [r11, r7]	; load array contents of tile above r5

	CMP r6, #0x00	; tile above is empty
	ITTTT EQ
	MOVEQ r8, r5	; copy bottom tile into top tile
	MOVEQ r5, #0x00	; set bottom tile to zero
	STREQ r5, [r11, r4]
	STREQ r8, [r11, r7]
	CMP r6, #0x00	; tile above is empty
	IT EQ
	BLEQ trailing_tiles_up

	SUB r4, r4, #0x4		; minus 4 bytes since every index is one word
	SUB r10, r10, #0x01		; decrement counter for 4 tiles

	; updating arrayindex and direction in .data
	LDR r6, ptr_to_arrayindex
	MOV r5, #0x00
	CMP r4, #0x0C			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ merge_up			; merge any valid pairs
	CMP r4, #0x0C			; compare to see if 3 iterations of timer_handler has ran
	ITTTE EQ
	STREQ r5, [r6]			; storing zero to arrayindex .data
	LDREQ r9, ptr_to_direction
	STREQ r5, [r9]			; storing zero to direction .data
	STRNE r4, [r6]			; store current tile into array index
	CMP r4, #0x0C			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ spawn_tile			; spawn new tile
	CMP r10, #0x00
	BEQ h_done
	B timer_h_up_loop

trailing_tiles_up:
	PUSH {r5,r10,lr}

	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes
	SDIV r8, r8, r1	; all of row 1 will be zero, row 2 will be 1, row 3 = 2, row 4 = 3

	ADD r9, r4, #0x10	; go to index of 1 tiles below current
	CMP r8, #0x03
	BEQ trailing_loop_up_end	; only concerned about two middle rows
	CMP r8, #0x00
	BEQ trailing_loop_up_end

trailing_loop_up:
	LDR r10, [r11, r9]	; load array contents tile below
	MOV r1, #0x00
	STR r1, [r11, r9]	; after loading contents of tile below current, set to zero
	SUB r5, r9, #0x10	; go to tile below current
	STR r10, [r11, r5]	; store contents of tile below into tile above
	ADD r9 ,r9, #0x10	; only used when current tile index is in row 1 (second from top most row) if the CMP does branch back to trailing_loop_up
	CMP r8, #0x01
	ITT EQ
	SUBEQ r8, r8, #0x01
	BEQ trailing_loop_up

trailing_loop_up_end:

	POP {r5,r10,lr}
	MOV pc, lr

merge_up:
	PUSH {r4-r10,lr}
	; rll is address to gbarray

	MOV r4, #0x00 ; current tile offset (top left of board)
merge_up_loop:
	LDR r5, [r11, r4]	; loading current tile data
	ADD r6, r4, #0x10	; get tile below current
	LDR r7, [r11, r6]	; loading below current tile data

	CMP r5, r7			; check if both tiles are the same number
	BNE merge_up_not_equal_tiles
	CMP r5, #0x0000			; check if they are zero
	BEQ merge_up_not_equal_tiles
	ADD r5, r5, r5		; change to next power
	STR r5, [r11, r4]	; set current to higher power
	MOV r1, r5			; parameter for calc_score
	BL calc_score		; update player score
	MOV r7, #0x0000
	STR r7, [r11, r6]	; set below to zero
	; move trailing tiles up
	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes
	SDIV r8, r8, r1	; all of row 1 = 0, row 2 = 1, row 3 = 2, row 4 = 3
	MOV r1, #0x03
	SUB r8, r1, r8	; row 1 = 3, row 2 = 2, row 3 = 1, row 4 = 0
	PUSH {r4-r7}	; preserve registers
merge_up_loop_loop:
	LDR r5, [r11, r4]	; loading current tile data
	ADD r6, r4, #0x10	; get tile below current
	LDR r7, [r11, r6]	; loading below current tile data
	CMP r5, #0x00		; current tile is empty
	ITT EQ
	STREQ r7, [r11, r4]	; store below tile into current tile
	STREQ r5, [r11, r6]	; store current tile (which is zero) into below tile
	SUB r8, r8, #0x01	; decrement count
	CMP r8, #0x00
	ITT GT
	ADDGT r4, r4, #0x10	; change current to tile below current
	BGT merge_up_loop_loop	; iterate every tile below current
	POP {r4-r7}



merge_up_not_equal_tiles:
	CMP r4, #0x30		; only iterates top 3 rows
	ITE EQ
	BEQ merge_up_done	; reached last tile
	ADDNE r4, #0x04		; move to next tile
	B merge_up_loop

merge_up_done:
	POP {r4-r10,lr}
	MOV pc, lr



down:
	LDR r4, ptr_to_arrayindex
	LDR r5, [r4]

	MOV r10, #0x04	; loop 4 times gor each tile in a row
	; this will load the index that this function left off on
	MOV r4, r5
	ldr r11, ptr_to_gbarray
timer_h_down_loop:
	ldr r5, [r11, r4]	; load array contents of current tile index r4 into r5
	ADD r7, r4, #0x10	; go to index of tile below (4 * 4 bytes)
	ldr r6, [r11, r7]	; load array contents of tile below r5

	CMP r6, #0x00	; tile below is empty
	ITTTT EQ
	MOVEQ r8, r5	; copy top tile into bottom tile
	MOVEQ r5, #0x00	; set top tile to zero
	STREQ r5, [r11, r4]
	STREQ r8, [r11, r7]
	CMP r6, #0x00	; tile below is empty
	IT EQ
	BLEQ trailing_tiles_down

	ADD r4, r4, #0x4		; plus 4 bytes since every index is one word
	SUB r10, r10, #0x01		; decrement counter for 4 tiles

	; updating arrayindex and direction in .data
	LDR r6, ptr_to_arrayindex
	MOV r5, #0x00
	CMP r4, #0x30			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ merge_down			; merge any valid pairs
	CMP r4, #0x30			; compare to see if 3 iterations of timer_handler has ran
	ITTTE EQ
	STREQ r5, [r6]			; storing zero to arrayindex .data
	LDREQ r9, ptr_to_direction
	STREQ r5, [r9]			; storing zero to direction .data
	STRNE r4, [r6]			; store current tile into array index
	CMP r4, #0x30			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ spawn_tile			; spawn new tile
	CMP r10, #0x00
	BEQ h_done
	B timer_h_down_loop

trailing_tiles_down:
	PUSH {r5,r10,lr}

	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes
	SDIV r8, r8, r1	; all of row 1 will be zero, row 2 will be 1, row 3 = 2, row 4 = 3
	MOV r1, #0x03
	SUB r8, r1, r8

	SUB r9, r4, #0x10	; go to index of 1 tiles above current
	CMP r8, #0x03
	BEQ trailing_loop_down_end	; only concerned about two middle rows
	CMP r8, #0x00
	BEQ trailing_loop_down_end

trailing_loop_down:
	LDR r10, [r11, r9]	; load array contents tile below
	MOV r1, #0x00
	STR r1, [r11, r9]	; after loading contents of tile above current, set to zero
	ADD r5, r9, #0x10	; go to tile above current
	STR r10, [r11, r5]	; store contents of tile below into tile above
	SUB r9 ,r9, #0x10	; only used when current tile index is in row 2 if the CMP does branch back to trailing_loop_up
	CMP r8, #0x01
	ITT EQ
	SUBEQ r8, r8, #0x01
	BEQ trailing_loop_down

trailing_loop_down_end:

	POP {r5,r10,lr}
	MOV pc, lr

merge_down:
	PUSH {r4-r10,lr}
	; rll is address to gbarray

	MOV r4, #0x3C ; current tile offset (bottom right of board)
merge_down_loop:
	LDR r5, [r11, r4]	; loading current tile data
	SUB r6, r4, #0x10	; get tile above current
	LDR r7, [r11, r6]	; loading below current tile data

	CMP r5, r7			; check if both tiles are the same number
	BNE merge_down_not_equal_tiles
	CMP r5, #0x0000			; check if they are zero
	BEQ merge_down_not_equal_tiles
	ADD r5, r5, r5		; change to next power
	STR r5, [r11, r4]	; set current to higher power
	MOV r1, r5			; parameter for calc_score
	BL calc_score		; update player score
	MOV r7, #0x0000
	STR r7, [r11, r6]	; set below to zero
	; move trailing tiles up
	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes
	SDIV r8, r8, r1	; all of row 1 = 0, row 2 = 1, row 3 = 2, row 4 = 3
	;MOV r1, #0x03
	;SUB r8, r1, r8	; row 1 = 3, row 2 = 2, row 3 = 1, row 4 = 0
	PUSH {r4-r7}	; preserve registers
merge_down_loop_loop:
	LDR r5, [r11, r4]	; loading current tile data
	SUB r6, r4, #0x10	; get tile above current
	LDR r7, [r11, r6]	; loading below current tile data
	CMP r5, #0x00		; current tile is empty
	ITT EQ
	STREQ r7, [r11, r4]	; store above tile into current tile
	STREQ r5, [r11, r6]	; store current tile (which is zero) into above tile
	SUB r8, r8, #0x01	; decrement count
	CMP r8, #0x00
	ITT GT
	SUBGT r4, r4, #0x10	; change current to tile above current
	BGT merge_down_loop_loop	; iterate every tile below current
	POP {r4-r7}



merge_down_not_equal_tiles:
	CMP r4, #0x00		; only iterates bottom 3 rows
	ITE EQ
	BEQ merge_down_done	; reached last tile
	SUBNE r4, #0x04		; move to next tile
	B merge_down_loop

merge_down_done:
	POP {r4-r10,lr}
	MOV pc, lr


left:
	LDR r4, ptr_to_arrayindex
	LDR r5, [r4]
	CMP r5, #0x00	; ensure arrayindex offset isnt zero
	ITT EQ
	MOVEQ r5, #0x3C	; current tile, start at bottom right of board
	STREQ r5, [r4]

	MOV r10, #0x04	; loop 4 times each timer_handler (only right three rows of game board get iterated)
	; this will load the index that this function left off on
	MOV r4, r5
	ldr r11, ptr_to_gbarray
timer_h_left_loop:
	ldr r5, [r11, r4]	; load array contents of current tile index r4 into r5
	SUB r7, r4, #0x04	; go to index of tile left (4 bytes)
	ldr r6, [r11, r7]	; load array contents of tile left

	CMP r6, #0x00	; tile left is empty
	ITTTT EQ
	MOVEQ r8, r5	; copy right tile into left tile
	MOVEQ r5, #0x00	; set right tile to zero
	STREQ r5, [r11, r4]
	STREQ r8, [r11, r7]
	CMP r6, #0x00	; tile left is empty
	IT EQ
	BLEQ trailing_tiles_left

	SUB r4, r4, #0x10		; minus (4 * 4) bytes
	SUB r10, r10, #0x01		; decrement counter for 4 tiles

	; updating arrayindex and direction in .data
	LDR r6, ptr_to_arrayindex
	MOV r5, #0x00
	CMP r4, #0x04			; compare to see if 3 iterations of timer_handler has ran **END VALUE
	IT EQ
	BLEQ merge_left			; merge any valid pairs
	CMP r4, #0x04			; compare to see if 3 iterations of timer_handler has ran
	ITTT EQ
	STREQ r5, [r6]			; storing zero to arrayindex .data
	LDREQ r9, ptr_to_direction
	STREQ r5, [r9]			; storing zero to direction .data
	CMP r4, #0x04			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ spawn_tile			; spawn new tile
	CMP r10, #0x00
	BEQ left_h_done
	B timer_h_left_loop

left_h_done:
	; store current tile into array index
	ADD r4, r4, #0x3C		; add 60 (0x3C) to start at bottom of next column during next timer interrupt
	STR r4, [r6]
	CMP r4, #0x30			; last tile to be checked
	IT EQ
	STREQ r5, [r6]
	B h_done

trailing_tiles_left:
	PUSH {r5,r10,lr}

	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes

	; skipping 1st and 4th column
	CMP r8, #0x00
	BEQ trailing_loop_left_end
	CMP r8, #0x03
	BEQ trailing_loop_left_end
	CMP r8, #0x04
	BEQ trailing_loop_left_end
	CMP r8, #0x07
	BEQ trailing_loop_left_end
	CMP r8, #0x08
	BEQ trailing_loop_left_end
	CMP r8, #0x0B
	BEQ trailing_loop_left_end
	CMP r8, #0x0C
	BEQ trailing_loop_left_end
	CMP r8, #0x0F
	BEQ trailing_loop_left_end

	ADD r9, r4, #0x04	; copy index of 1 tiles right current
	AND r8, r8, #0x0001	; will be 0 if even, 1 if odd,,,,  odd(1) = column 2, even(0) = column 3
	MOV r1, #0x02
	SUB r8, r1, r8		; column 2 = 1, column 3 = 2

trailing_loop_left:
	LDR r10, [r11, r9]	; load array contents tile below
	MOV r1, #0x00
	STR r1, [r11, r9]	; after loading contents of tile right current, set to zero
	SUB r5, r9, #0x04	; go to tile right current
	STR r10, [r11, r5]	; store contents of tile right into tile left
	ADD r9 ,r9, #0x04	; only used when current tile index is in column 1 if the CMP does branch back to trailing_loop_up
	CMP r8, #0x01
	ITT EQ
	SUBEQ r8, r8, #0x01
	BEQ trailing_loop_left

trailing_loop_left_end:

	POP {r5,r10,lr}
	MOV pc, lr

merge_left:
	PUSH {r4-r10,lr}
	; rll is address to gbarray

	MOV r4, #0x00 ; current tile offset (top left of board)
merge_left_loop:
	CMP r4, #0x3C
	IT GT
	SUBGT r4, r4, #0x3C
	LDR r5, [r11, r4]	; loading current tile data
	ADD r6, r4, #0x04	; get tile right current
	LDR r7, [r11, r6]	; loading right current tile data

	CMP r5, r7			; check if both tiles are the same number
	BNE merge_left_not_equal_tiles
	CMP r5, #0x0000			; check if they are zero
	BEQ merge_left_not_equal_tiles
	ADD r5, r5, r5		; change to next power
	STR r5, [r11, r4]	; set current to higher power
	MOV r1, r5			; parameter for calc_score
	BL calc_score		; update player score
	MOV r7, #0x0000
	STR r7, [r11, r6]	; set right to zero
	; move trailing tiles up
	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes

	; assigning each tile to a column
	CMP r8, #0x03
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x04
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x05
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x06
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x07
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x08
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x09
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x0A
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x0B
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x0C
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x0D
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x0E
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x0F
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x00
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x01
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x02
	IT EQ
	MOVEQ r8, #0x01
	; column 1 = 3, column 2 = 2, column 3 = 1, column 4 = 0
	PUSH {r4-r7}	; preserve registers
merge_left_loop_loop:
	LDR r5, [r11, r4]	; loading current tile data
	ADD r6, r4, #0x04	; get tile right current
	LDR r7, [r11, r6]	; loading right current tile data
	CMP r5, #0x00		; current tile is empty
	ITT EQ
	STREQ r7, [r11, r4]	; store right tile into current tile
	STREQ r5, [r11, r6]	; store current tile (which is zero) into right tile
	SUB r8, r8, #0x01	; decrement count
	CMP r8, #0x00
	ITT GT
	ADDGT r4, r4, #0x04	; change current to tile right current
	BGT merge_left_loop_loop	; iterate every tile below current
	POP {r4-r7}

merge_left_not_equal_tiles:
	CMP r4, #0x3C		; only iterates top 3 rows
	ITE EQ
	BEQ merge_left_done	; reached last tile
	ADDNE r4, #0x10		; move to next tile
	B merge_left_loop

merge_left_done:
	POP {r4-r10,lr}
	MOV pc, lr


right:
	LDR r4, ptr_to_arrayindex
	LDR r5, [r4]

	MOV r10, #0x04	; loop 4 times each timer_handler (only right three rows of game board get iterated)
	; this will load the index that this function left off on
	MOV r4, r5
	ldr r11, ptr_to_gbarray
timer_h_right_loop:
	ldr r5, [r11, r4]	; load array contents of current tile index r4 into r5
	ADD r7, r4, #0x04	; go to index of tile right (4 bytes)
	ldr r6, [r11, r7]	; load array contents of tile right

	CMP r6, #0x00	; tile right is empty
	ITTTT EQ
	MOVEQ r8, r5	; copy left tile into right tile
	MOVEQ r5, #0x00	; set left tile to zero
	STREQ r5, [r11, r4]
	STREQ r8, [r11, r7]
	CMP r6, #0x00	; tile right is empty
	IT EQ
	BLEQ trailing_tiles_right

	ADD r4, r4, #0x10		; plus (4 * 4) bytes
	SUB r10, r10, #0x01		; decrement counter for 4 tiles

	; updating arrayindex and direction in .data
	LDR r6, ptr_to_arrayindex
	MOV r5, #0x00
	CMP r4, #0x38			; compare to see if 3 iterations of timer_handler has ran **END VALUE
	IT EQ
	BLEQ merge_right			; merge any valid pairs
	CMP r4, #0x38			; compare to see if 3 iterations of timer_handler has ran
	ITTT EQ
	STREQ r5, [r6]			; storing zero to arrayindex .data
	LDREQ r9, ptr_to_direction
	STREQ r5, [r9]			; storing zero to direction .data
	CMP r4, #0x38			; compare to see if 3 iterations of timer_handler has ran
	IT EQ
	BLEQ spawn_tile			; spawn new tile
	CMP r10, #0x00
	BEQ right_h_done
	B timer_h_right_loop

right_h_done:
	; store current tile into array index
	SUB r4, r4, #0x3C		; add 60 (0x3C) to start at top of next column during next timer interrupt
	STR r4, [r6]
	CMP r4, #0x0C			; last tile to be checked
	IT EQ
	STREQ r5, [r6]
	B h_done

trailing_tiles_right:
	PUSH {r5,r10,lr}

	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes

	; skipping 1st and 4th column
	CMP r8, #0x00
	BEQ trailing_loop_right_end
	CMP r8, #0x03
	BEQ trailing_loop_right_end
	CMP r8, #0x04
	BEQ trailing_loop_right_end
	CMP r8, #0x07
	BEQ trailing_loop_right_end
	CMP r8, #0x08
	BEQ trailing_loop_right_end
	CMP r8, #0x0B
	BEQ trailing_loop_right_end
	CMP r8, #0x0C
	BEQ trailing_loop_right_end
	CMP r8, #0x0F
	BEQ trailing_loop_right_end

	SUB r9, r4, #0x04	; copy index of 1 tiles left of current
	AND r8, r8, #0x0001	; will be 0 if even, 1 if odd,,,,  odd(1) = column 2, even(0) = column 3
	ADD r8, r8, #0x01	; column 2 = 2, column 3 = 1

trailing_loop_right:
	LDR r10, [r11, r9]	; load array contents tile left
	MOV r1, #0x00
	STR r1, [r11, r9]	; after loading contents of tile left current, set to zero
	ADD r5, r9, #0x04	; go to tile left current
	STR r10, [r11, r5]	; store contents of tile left into tile right
	SUB r9 ,r9, #0x04	; only used when current tile index is in column 2 if the CMP does branch back to trailing_loop_up
	CMP r8, #0x01
	ITT EQ
	SUBEQ r8, r8, #0x01
	BEQ trailing_loop_right

trailing_loop_right_end:

	POP {r5,r10,lr}
	MOV pc, lr

merge_right:
	PUSH {r4-r10,lr}
	; rll is address to gbarray

	MOV r4, #0x3C ; current tile offset (bottom right of board)
merge_right_loop:
	CMP r4, #0x04
	IT LT
	ADDLT r4, r4, #0x3C
	LDR r5, [r11, r4]	; loading current tile data
	SUB r6, r4, #0x04	; get tile left current
	LDR r7, [r11, r6]	; loading left current tile data

	CMP r5, r7			; check if both tiles are the same number
	BNE merge_right_not_equal_tiles
	CMP r5, #0x0000		; check if they are zero
	BEQ merge_right_not_equal_tiles
	ADD r5, r5, r5		; change to next power
	STR r5, [r11, r4]	; set current to higher power
	MOV r1, r5			; parameter for calc_score
	BL calc_score		; update player score
	MOV r7, #0x0000
	STR r7, [r11, r6]	; set left to zero
	; move trailing tiles up
	MOV r1, #0x04	; placeholder
	SDIV r8, r4, r1	; div by 4 since each index is 4 bytes

	; assigning each tile to a column
	CMP r8, #0x03
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x04
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x05
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x06
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x07
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x08
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x09
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x0A
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x0B
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x0C
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x0D
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x0E
	IT EQ
	MOVEQ r8, #0x02
	CMP r8, #0x0F
	IT EQ
	MOVEQ r8, #0x03
	CMP r8, #0x00
	IT EQ
	MOVEQ r8, #0x00
	CMP r8, #0x01
	IT EQ
	MOVEQ r8, #0x01
	CMP r8, #0x02
	IT EQ
	MOVEQ r8, #0x02
	; column 1 = 0, column 2 = 1, column 3 = 2, column 4 = 3
	PUSH {r4-r7}	; preserve registers
merge_right_loop_loop:
	LDR r5, [r11, r4]	; loading current tile data
	SUB r6, r4, #0x04	; get tile left current
	LDR r7, [r11, r6]	; loading left current tile data
	CMP r5, #0x00		; current tile is empty
	ITT EQ
	STREQ r7, [r11, r4]	; store left tile into current tile
	STREQ r5, [r11, r6]	; store current tile (which is zero) into left tile
	SUB r8, r8, #0x01	; decrement count
	CMP r8, #0x00
	ITT GT
	SUBGT r4, r4, #0x04	; change current to tile left current
	BGT merge_right_loop_loop	; iterate every tile left current
	POP {r4-r7}



merge_right_not_equal_tiles:
	CMP r4, #0x30		; only iterates top 3 rows
	ITE EQ
	BEQ merge_right_done	; reached last tile
	SUBNE r4, #0x10		; move to next tile
	B merge_right_loop

merge_right_done:
	POP {r4-r10,lr}
	MOV pc, lr


h_done:
	PUSH {r0}
	;ptr_to_time:
	LDR r4, ptr_to_time_tick
	LDRB r5, [r4]
	CMP r5, #0x01
	ITTTT EQ
	LDREQ r6, ptr_to_time
	LDREQ r7, [r6]
	ADDEQ r7, r7, #0x01	; increment time by 1
	STREQ r7, [r6]		; store new time
	EOR r5, r5, #0x01	; flip time_tick
	STRB r5, [r4]		; store new flipped time_tick

	; todo check if game is done

h_print_board:
h_debug:
	ldr r0, ptr_to_cursor_save
	BL output_string

	BL print_score_time


	ldr r1, ptr_to_gbarray


	mov r5, #0 ; loop counter


h_debug_loop:
	cmp r5, #15
	bgt h_debug_loop_d
	mov r6, #0 ; clear r6
	mov r7, #9 ; Pointer increment constant value
	;ldr r0, ptr_to_cursor_move
	mul r6, r5, r7
	ldr r0, ptr_to_cursor_arr
	add r0, r0, r6 ; 0 start, 9
	BL output_string

	mov r7, #4
	mul r6, r5, r7
	mov r8, r1
	add r8, r8, r6

	ldr r8, [r8]
	mov r0, r8
	BL get_color_code
	;POP{r0}
	mov r2, r0


	ldr r0, ptr_to_format_arr
	mov r7, #128
	mul r6, r2, r7
	add r0, r0, r6
	BL output_string

	add r5, r5, #1

	B h_debug_loop
h_debug_loop_d:


	ldr r0, ptr_to_cursor_restore
	BL output_string

	POP {r0}
h_done_paused:
	POP {r4-r12, lr}
	BX lr       	; Return

Print_Board:
	PUSH {r4-r12, lr}


	PUSH {r4-r12, lr}
	MOV pc, lr

print_score_time:
	PUSH {r4-r11, lr}
	; //// score
	ldr r0, ptr_to_cursor_mv_score
	BL output_string

	ldr r4, ptr_to_score
	ldr r0, [r4]	; get current score, first arg
	ldr r1, ptr_to_copy_string ; string for int2string, second arg
	BL int2string
	ldr r1, ptr_to_copy_string ; string for int2string, second arg


	ldr r4, ptr_to_copy_string
	ldr r5, ptr_to_print_score
	MOV	r10, #0x00	; offset for copy_string
	MOV r11, #0x0B	; offset for score
copy_score:
	LDRB r6, [r4, r10]	; copy_string data
	CMP r6, #0x00		; check for end of string
	ITTTT NE
	STRBNE r6, [r5, r11]	; store current char into ansi data
	ADDNE r10, r10, #0x01
	ADDNE r11, r11, #0x01
	BNE copy_score

	ldr r0, ptr_to_print_score	; output now updated ansi sequence
	BL output_string

	; //// time
	ldr r0, ptr_to_cursor_mv_time
	BL output_string

	ldr r4, ptr_to_time
	ldr r0, [r4]	; get current time, first arg
	ldr r1, ptr_to_copy_string ; string for int2string, second arg
	BL int2string
	ldr r1, ptr_to_copy_string ; string for int2string, second arg


	ldr r4, ptr_to_copy_string
	ldr r5, ptr_to_print_time
	MOV	r10, #0x00	; offset for copy_string
	MOV r11, #0x0B	; offset for score
copy_time:
	LDRB r6, [r4, r10]	; copy_string data
	CMP r6, #0x00		; check for end of string
	ITTTT NE
	STRBNE r6, [r5, r11]	; store current char into ansi data
	ADDNE r10, r10, #0x01
	ADDNE r11, r11, #0x01
	BNE copy_time

	ldr r0, ptr_to_print_time	; output now updated ansi sequence
	BL output_string

	POP {r4-r11, lr}
	MOV pc, lr


copy_gameBoard:
	PUSH {r4-r11, lr}

	ldr r4, ptr_to_gbarray
	ldr r7, ptr_to_gbcopy

	MOV r11, #0x00	; counter/ array offset
copy_gameBoard_loop:
	MOV r5, #0x04
	MUL r8, r11, r5		; multiply by 4 to account for word size tiles
	LDR r5, [r4, r8]	; gbarray
	STR r5, [r7, r8]	; gbcopy

	CMP r11, #0x0F
	ITT NE
	ADDNE r11, r11, #0x01
	BNE copy_gameBoard_loop

	POP {r4-r11, lr}
	MOV pc, lr


; returns 0 for no change, 1 for change in r1
gameboard_changed:
	PUSH {r4-r11, lr}

	ldr r4, ptr_to_gbarray
	ldr r7, ptr_to_gbcopy
	MOV r1, #0x00	; no change by default

	MOV r11, #0x00	; counter/ array offset
gameboard_changed_loop:
	MOV r5, #0x04
	MUL r8, r11, r5		; multiply by 4 to account for word size tiles
	LDR r5, [r4, r8]	; gbarray
	LDR r6, [r7, r8]	; gbcopy

	CMP r5, r6		; compare each values of the same index in each array
	IT NE
	MOVNE r1, #0x01	; set return to be 1 since two values where NE

	CMP r11, #0x0F
	ITT NE
	ADDNE r11, r11, #0x01
	BNE gameboard_changed_loop

	POP {r4-r11, lr}
	MOV pc, lr


spawn_tile:
	PUSH {r4-r11, lr}

	BL gameboard_changed	; if gameboard changed, then spawn in a new tile
	CMP r1, #0x00
	BEQ spawn_tile_done


	; (random) variables
	LDR r4, ptr_to_time
	LDR r4, [r4]	; get current game time
	LDR r5, ptr_to_score
	LDR r5, [r5]	; get current score


	ADD r4, r4, r5	; add score to game time
	MUL r4, r4, r5	; mul by score
	ADD r4, r4, pc	; add pc to game time, why not
	ADD r4, r4, r5	; add score to game time
	MOV r8, #0x03		; mod by 3
	UDIV r6, r4, r8
	MUL r6, r6, r8
	SUB r5, r4, r6		; r5 is remainder mod 3

	CMP r5, #0x00
	IT EQ
	MOVEQ r10, #0x02
	CMP r5, #0x01
	IT EQ
	MOVEQ r10, #0x02
	CMP r5, #0x02
	IT EQ
	MOVEQ r10, #0x04

	MOV r8, #0x0000
	ldr r9, ptr_to_gbarray
check_game_over:
	MOV r11, #0x04
	MUL r11, r11, r8	; mul by 4 since each tile is of size word
	ldr r7, [r9, r11]
	CMP r7, #0x00
	IT EQ
	BEQ create_tile

	CMP r8, #0x0F		; 16 iterations
	ITTT EQ
	MOVEQ r7, #0x02
	LDREQ r8, ptr_to_game_completed
	STREQ r7, [r8]
	BEQ spawn_tile_done

	ADD r8, r8, #0x01
	B check_game_over

create_tile:

	MOV r8, #0x000F
	MOVT r8, #0x0000	; used to AND with since the board has 16 slots, this will give a number [0, 16]

	MOV r5, r4
	MOV r8, #0x0F		; mod by 15
	UDIV r6, r5, r8
	MUL r6, r6, r8
	SUB r4, r5, r6		; r4 is remainder divided by 15
	NOP

create_tile_loop:
	MOV r8, #0x001F
	MOVT r8, #0x0000	; used to AND with since the board has 16 slots, this will give a number [0, 16]

	MOV r6, #0x04
	MUL r5, r4, r6		; multiply by 4 since each tile offset in memory is 4 bytes apart

	ldr r9, ptr_to_gbarray
	ldr r7, [r9, r5]
	CMP r7, #0x00		; found empty tile
	ITT EQ
	STREQ r10, [r9, r5]
	BEQ	spawn_tile_done

	ADD r4, r4, #0x03	; keep adding 6 until a number [0, 16] is an open tile in gbarray

	CMP r4, #0x1F		; if r4 > 16 start count back to 0
	IT GE
	SUBGE r4, #0x1F


	B create_tile_loop

spawn_tile_done:
	BL copy_gameBoard	; copy current gameboard into gameBoardCopy

	POP {r4-r11, lr}
	MOV pc, lr

; parameters: new value of two merged tiles in r1
calc_score:
	PUSH {r4-r11, lr}

	LDR r4, ptr_to_score
	LDR r5, [r4]	; r5 is score
	ADD r6, r5, r1	; add new tile to score of newly merged tile
	STR r6, [r4]

	LDR r4, ptr_to_number_to_win
	LDR r8, ptr_to_game_completed
	LDR r6, [r4]	; load number to win the game
	CMP r6, r1		; compare number to win to newly merge tile number
	ITT GE			; if new tile is greater than or equal to number_to_win
	MOVGE r9, #0x01	; 1 for true, the game is over
	STRGE r9, [r8]	; store 1 to game_completed


	POP {r4-r11, lr}
	MOV pc, lr

game_quit:
	.end
