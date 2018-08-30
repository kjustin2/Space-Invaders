# jpk91
# Justin Paul Kramer

.include "convenience.asm"
.include "display.asm"

.eqv GAME_TICK_MS      16
.eqv MAX_BULLETS       60
.eqv ENEMY_BULLET       5

.data
# don't get rid of these, they're used by wait_for_next_frame.
last_frame_time:  .word 0
frame_counter:    .word 0

# my variables
got_bullet: .byte 0
got_life: .byte 0
set_diff: .byte 0
hurt_player: .byte
0 0 1 0 0
0 2 1 2 0
5 5 1 5 5
1 5 1 5 1
1 0 1 0 1
hurt_player2: .byte 
0 6 0 6 0
6 3 3 3 6
0 6 0 6 0
3 0 0 0 3
0 0 1 0 0
hurt_player3: .byte 
0 0 2 0 0
0 2 0 2 0
0 2 1 2 0
2 0 6 0 2
1 1 1 1 1
more_bullets: .byte
7 3 3 0 0
7 3 3 3 0
7 3 3 3 3
7 3 3 3 0
7 3 3 0 0
more_lives: .byte
0 1 0 1 0
1 0 1 0 1
1 0 0 0 1
0 1 0 1 0
0 0 1 0 0
make_hurt: .byte 0
wait_player: .byte 0
game_end: .byte 0
use_byte_two: .byte 2
player_lives: .byte 3
change_enemy_fire: .byte 0
check_byte: .byte 0
enemy_check_frames: .byte 0
enemies_array: .word 1:20
check_word: .word 0
my_intro: .asciiz "Up Hard"
my_next1: .asciiz "Down Easy"
my_next2: .asciiz "Else"
my_next3: .asciiz "Normal"
my_win: .asciiz "You Have"
my_win2: .asciiz "WON THIS"
my_win3: .asciiz "GAME!!!"
my_end: .asciiz "You Have"
my_end2: .asciiz "LOST THE"
my_end3: .asciiz "GAME!"
my_diff1: .asciiz "on Hard"
my_diff2: .asciiz "on Easy"
game_loser: .asciiz "GAME OVER!"
game_winner: .asciiz "YOU WIN!"
enemies: .word 80
player_xcor: .word 30
right: .word 57
left: .word 42
move_down_enemy: .byte 0
player_ycor: .word 49
left_limit: .word 2
right_limit: .word 57
top_limit: .word 46
bot_limit: .word 52
bullet_count: .word 50
use_zero: .word 0
fire_delay: .word 60
enemy_fire_delay: .byte 40
enemy_bullet_active: .byte 0:ENEMY_BULLET
check_frames: .word 0
bullet_x: .byte 0:MAX_BULLETS
bullet_y: .byte 0:MAX_BULLETS
enemy_bullet_x: .byte 0:ENEMY_BULLET
enemy_bullet_y: .byte 0:ENEMY_BULLET
bullet_active: .byte 0:MAX_BULLETS
use_byte_one: .byte 1
use_byte_zero: .byte 0
enemy_xcor: .word 5, 15, 25, 35, 45, 5, 15, 25, 35, 45, 5, 15, 25, 35, 45, 5, 15, 25, 35, 45, 5, 15, 25, 35, 45
enemy_ycor: .word 
05 05 05 05 05
12 12 12 12 12
19 19 19 19 19 
26 26 26 26 26 
33 33 33 33 33
enemy_right_side: .word 45
enemy_switch_direction: .byte 0
enemy_move_frame: .word 15
enemy_image: .byte
2 2 2 2 2
0 2 1 2 0
0 2 1 2 0
2 1 2 1 2
0 0 1 0 0
player_image: .byte
0 0 3 0 0
0 5 3 5 0
5 5 3 5 5
3 5 3 5 3
3 0 3 0 3
intro_image1: .byte
2 2 2 2 2
0 0 0 0 0
0 0 2 0 0
0 0 0 0 0
2 2 2 2 2
intro_image2: .byte
1 0 0 0 1
1 0 0 0 1
1 0 1 0 1
1 0 0 0 1
1 0 0 0 1
intro_image3: .byte
1 0 0 0 1
0 0 0 0 0
0 1 0 1 0
0 0 0 0 0
0 0 1 0 0
intro_image4: .byte
0 0 5 0 0
0 0 0 0 0
0 5 5 5 0
0 0 0 0 0
5 0 0 0 5
intro_image5: .byte
4 0 4 0 4
4 0 0 0 4
0 0 0 0 0
4 0 0 0 4
4 0 4 0 4
intro_image6: .byte
3 3 0 3 3 
3 0 0 0 0
0 3 0 3 3 
3 0 0 0 0
3 3 0 3 3
intro_image7: .byte
2 0 2 2 2
2 0 0 0 2
2 0 2 2 2
0 0 2 0 0
2 0 0 0 2
intro_image8: .byte
1 1 0 1 1 
1 0 0 0 0
1 1 0 1 1
0 0 0 0 1
1 1 0 1 1
intro_image12: .byte
2 2 2 0 2
2 0 0 0 2
2 2 2 0 2
0 0 0 0 0
2 0 0 0 0
intro_image14: .byte
6 0 6 6 6 
6 0 0 0 0
0 0 0 0 0
6 0 0 0 0
6 0 6 6 6
player_image2: .byte
0 6 0 6 0
6 6 6 6 6
0 6 0 6 0
6 0 0 0 6
0 0 4 0 0
player_image3: .byte
0 0 4 0 0
0 4 0 4 0
0 4 1 4 0
4 0 1 0 4
1 1 1 1 1

.text

# --------------------------------------------------------------------------------------------------

.globl main
main:
	# set up anything you need to here,
	# and wait for the user to press a key to start.
_main_loop:
	# check for input,
	# update everything,
	# then draw everything.
	beq s0, 0x01, _hard
	beq s0, 0x02, _easy
	bne s0, 0x00, _after_intro
	li a0, 5
	li a1, 13
	la a2, intro_image1
	jal display_blit_5x5
	li a0, 12
	li a1, 13
	la a2, intro_image2
	jal display_blit_5x5
	li a0, 19
	li a1, 13
	la a2, intro_image3
	jal display_blit_5x5
	li a0, 26
	li a1, 13
	la a2, intro_image4
	jal display_blit_5x5
	li a0, 33
	li a1, 13
	la a2, intro_image5
	jal display_blit_5x5
	li a0, 40
	li a1, 13
	la a2, intro_image6
	jal display_blit_5x5
	li a0, 47
	li a1, 13
	la a2, intro_image7
	jal display_blit_5x5
	li a0, 54
	li a1, 13
	la a2, intro_image8
	jal display_blit_5x5
	li a0, 14
	li a1, 5
	la a2, intro_image8
	jal display_blit_5x5
	li a0, 21
	li a1, 5
	la a2, intro_image12
	jal display_blit_5x5
	li a0, 28
	li a1, 5
	la a2, intro_image4
	jal display_blit_5x5
	li a0, 35
	li a1, 5
	la a2, intro_image14
	jal display_blit_5x5
	li a0, 42
	li a1, 5
	la a2, intro_image6
	jal display_blit_5x5
	li a0, 13
	li a1, 24
	la a2, my_intro
	jal display_draw_text
	li a0, 5
	li a1, 34
	la a2, my_next1
	jal display_draw_text
	li a0, 19
	li a1, 45
	la a2, my_next2
	jal display_draw_text
	li a0, 14
	li a1, 55
	la a2, my_next3
	jal display_draw_text
	jal input_get_keys
	move s0, v0
	b _after_intro
_hard:
	beq s0, 0x03, _after_intro
	li t0, 1
	sb t0, set_diff
	li t0, 80
	sw t0, fire_delay
	li t0, 30
	sw t0, enemy_fire_delay
	li t0, 0x03
	move s0, t0
	b _after_intro
_easy:
	beq s0, 0x03, _after_intro
	li t0, 2
	sb t0, set_diff
	li t0, 50
	sw t0, fire_delay
	li t0, 50
	sw t0, enemy_fire_delay
	li t0, 0x03
	move s0, t0
	b _after_intro
_after_intro:
	beq s0, 0x00, _end
	lb t0, game_end
	lb t1, use_byte_one
	lb t2, use_byte_two
	beq t0, t1, _bad_end
	beq t0, t2, _super_end
	jal player_move
	jal shooting
	jal enemy_move
	jal check_collision
	jal enemy_fire
	jal check_collision3
	jal check_collision4
	lb t0, wait_player
	lb t1, use_byte_zero
	bne t0, t1, _skip_player
	jal check_collision2
	b _rest_normal
_skip_player:
	lb t1, wait_player
	dec t1
	sb t1, wait_player
_rest_normal:
	jal draw_lives
	b _end
_bad_end:
	li a0, 8
	li a1, 18
	la a2, my_end
	jal display_draw_text
	li a0, 8
	li a1, 30
	la a2, my_end2
	jal display_draw_text
	li a0, 18
	li a1, 42
	la a2, my_end3
	jal display_draw_text
	li a0, 4
	li a1, 5
	la a2, game_loser
	jal display_draw_text
	li t0, 1
	lb t1, set_diff
	beq t0, t1, _on_hard
	li t0, 2
	beq t0, t1, _on_easy
	b _end
_super_end:
	li a0, 8
	li a1, 18
	la a2, my_win
	jal display_draw_text
	li a0, 8
	li a1, 30
	la a2, my_win2
	jal display_draw_text
	li a0, 18
	li a1, 42
	la a2, my_win3
	jal display_draw_text
	li a0, 9
	li a1, 5
	la a2, game_winner
	jal display_draw_text
	li t0, 1
	lb t1, set_diff
	beq t0, t1, _on_hard
	li t0, 2
	beq t0, t1, _on_easy
	b _end
_on_hard:
	li a0, 11
	li a1, 52
	la a2, my_diff1
	jal display_draw_text
	b _end
_on_easy:
	li a0, 11
	li a1, 52
	la a2, my_diff2
	jal display_draw_text
_end:
	jal	display_update_and_clear
	jal	wait_for_next_frame
	b	_main_loop

_game_over:
	exit

# --------------------------------------------------------------------------------------------------
# call once per main loop to keep the game running at 60FPS.
# if your code is too slow (longer than 16ms per frame), the framerate will drop.
# otherwise, this will account for different lengths of processing per frame.

wait_for_next_frame:
enter	s0
	lw	s0, last_frame_time
_wait_next_frame_loop:
	# while (sys_time() - last_frame_time) < GAME_TICK_MS {}
	li	v0, 30
	syscall # why does this return a value in a0 instead of v0????????????
	sub	t1, a0, s0
	bltu	t1, GAME_TICK_MS, _wait_next_frame_loop

	# save the time
	sw	a0, last_frame_time

	# frame_counter++
	lw	t0, frame_counter
	inc	t0
	sw	t0, frame_counter
leave	s0

# --------------------------------------------------------------------------------------------------

# .....and here's where all the rest of your code goes :D

player_move:
enter
	jal input_get_keys
	lw a0, player_xcor
	lw a1, player_ycor
	lw t2, left_limit
	lw t3, right_limit
	lw t4, top_limit
	lw t5, bot_limit
	and t1, v0, KEY_L
	bne t1, KEY_L, _move_right
_move_left:
	dec a0
	sw a0, player_xcor
_move_right:
	and t1, v0, KEY_R
	bne t1, KEY_R, _move_up
	inc a0
	sw a0, player_xcor
_move_up:
	and t1, v0, KEY_U
	bne t1, KEY_U, _move_down
	dec a1
	sw a1, player_ycor
_move_down:
	and t1, v0, KEY_D
	bne t1, KEY_D, _check
	inc a1
	sw a1, player_ycor

_check:
	bge a0, 2, _back_right
_back_left:
	sw t2, player_xcor
_back_right:
	ble a0, 57, _back_up
	sw t3, player_xcor
_back_up:
	bge a1, 46, _back_down
	sw t4, player_ycor
_back_down:
	ble a1, 52, _ender_move
	sw t5, player_ycor

_ender_move:
	lb t0, wait_player
	lb t1, use_byte_zero
	bne t0, t1, _hurt
	li t2, 1
	lb t3, set_diff
	beq t3, t2, _hard_lookin
	li t2, 2
	beq t3, t2, _easy_looks
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, player_image
	jal display_blit_5x5
	b _end_moveing
_hard_lookin:
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, player_image2
	jal display_blit_5x5
	b _end_moveing
_easy_looks:
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, player_image3
	jal display_blit_5x5
	b _end_moveing
_hurt:
	li t0, 1
	lb t1, set_diff
	beq t0, t1, _hurt_hard
	li t0, 2
	beq t0, t1, _hurt_easy
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, hurt_player
	jal display_blit_5x5
	b _end_moveing
_hurt_hard:
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, hurt_player2
	jal display_blit_5x5
	b _end_moveing
_hurt_easy:
	lw a0, player_xcor
	lw a1, player_ycor
	la a2, hurt_player3
	jal display_blit_5x5
_end_moveing:
leave

shooting:
enter s0, s1
	li s0, 0
	li s1, 0
	jal input_get_keys
	lw t0, check_frames
	lw t1, use_zero
	bne v0, KEY_B, _no_press
	bne t0, t1, _no_press
	lw t2, fire_delay
	sw t2, check_frames
	lw t0, bullet_count
	beq t0, t1, _no_press
	dec t0
	sw t0, bullet_count
_search_bullet_loop:
	li t4, MAX_BULLETS
	lb t0, bullet_active(s0)
	lb t1, use_byte_zero
	beq t0, t1, _can_make_bullet
	inc s0
	bne s0, t4, _search_bullet_loop
	b _no_press
_can_make_bullet:
	lb t0, use_byte_one
	sb t0, bullet_active(s0)
	lw t0, player_xcor
	lw t1, player_ycor
	inc t0
	inc t0
	sb t0, bullet_x(s0)
	sb t1, bullet_y(s0)
_no_press:
	li a0, 2
	li a1, 58
	lw a2, bullet_count
	jal display_draw_int
	lw t0, check_frames
	dec t0
	sw t0, check_frames
	lw t0, check_frames
	lw t1, use_zero
	bge t0, t1, _bullet_loop
	sw t1, check_frames
	li s1, 0
_bullet_loop:
	lb t0, bullet_active(s1)
	lb t1, use_byte_one
	bne t0, t1, _shootloop_end
_show_bullet:
	lb t0, bullet_y(s1)
	dec t0
	lb t2, use_byte_zero
	blt t0, t2, _lose_bullet
	sb t0, bullet_y(s1)
	lb a0, bullet_x(s1)
	lb a1, bullet_y(s1)
	li a2, COLOR_WHITE
	jal display_set_pixel
_rest_bullet:
	b _shootloop_end
_lose_bullet:
	lb t0, use_byte_zero
	sb t0, bullet_active(s1)
	lw t0, bullet_count
	li t1, 0
	bne t0, t1, _rest_bullet
	li t0, 1
	sb t0, game_end
	b _rest_bullet
_shootloop_end:
	inc s1
	li t4, MAX_BULLETS
	bne s1, t4, _bullet_loop
leave s1, s0

enemy_move:
enter s0, s1, s2, s3, s4
	li s0, 0
	lw t2, right
	lw t3, left
	lb s3, enemy_switch_direction
	lw t1, enemy_right_side
	beq t1, t2, _switch_left
	beq t1, t3, _switch_right
	b _after_switch
_switch_right:
	lb s3, use_byte_zero
	sb s3, enemy_switch_direction
	lb s4, use_byte_one
	sb s4, move_down_enemy
	b _after_switch
_switch_left:
	lb s3, use_byte_one
	li s4, 1
	sb s3, enemy_switch_direction
	lb s4, use_byte_one
	sb s4, move_down_enemy
_after_switch:
	li s2, 0
	lw s1, enemies
	lw t0, enemy_move_frame
	dec t0
	sw t0, enemy_move_frame
	lw t1, use_zero
	bne t1, t0, _draw_loop
_move_enemies:
	lw t0, enemy_move_frame
	add t0, t0, 15
	sw t0, enemy_move_frame
	li t2, 0
	lw t0, enemy_ycor(t2)
	li t1, 15
	beq t0, t1, _skip_down
	lb s4, move_down_enemy
	lb t0, use_byte_one
	beq s4, t0, _move_loop_enemy_down
_skip_down:
	lb t0, use_byte_one
	beq s3, t0, _move_loop_enemy_left
	b _move_loop_enemy_right
_move_loop_enemy_down:
	lw t0, enemy_ycor(s2)
	add t0, t0, 1
	sw t0, enemy_ycor(s2)
	add s2, s2, 4
	bne s2, s1, _move_loop_enemy_down
	lb s4, use_byte_zero
	sb s4, move_down_enemy
	lb t0, use_byte_one
	lw t0, right
	inc t0
	sw t0, right
	lw t0, left
	dec t0
	sw t0, left
	b _draw_loop
_move_loop_enemy_right:
	lw t0, enemy_xcor(s2)
	add t0, t0, 1
	sw t0, enemy_xcor(s2)
	add s2, s2, 4
	bne s2, s1, _move_loop_enemy_right
	li t1, 57
	li t0, 42
	sw t1, right
	sw t0, left
	lw t0, enemy_right_side
	inc t0
	sw t0, enemy_right_side
	b _draw_loop
_move_loop_enemy_left:
	lw t0, enemy_xcor(s2)
	sub t0, t0, 1
	sw t0, enemy_xcor(s2)
	add s2, s2, 4
	bne s2, s1, _move_loop_enemy_left
	li t1, 57
	li t0, 42
	sw t1, right
	sw t0, left
	lw t0, enemy_right_side
	dec t0
	sw t0, enemy_right_side
_draw_loop:
	lw t0, enemies_array(s0)
	lw t1, use_zero
	beq t1, t0, _skip_draw
	lw a0, enemy_xcor(s0)
	lw a1, enemy_ycor(s0)
	la a2, enemy_image
	jal display_blit_5x5
_skip_draw:
	add s0, s0, 4
	bne s0, s1, _draw_loop
leave s0, s1, s2, s3, s4

check_collision:
enter s0, s1, s2, s3, s4
	li s3, 0
	li s4, 0
	li s0, 0
_intro:
	li s1, 4
	li s2, 0
	lb t0, enemy_xcor(s3)
check_x_per:
	lb t1, bullet_x(s0)
	beq t0, t1, _to_y
	inc t0
	inc s2
	bne s2, s1, check_x_per
	b _end_col
_to_y:
	lb t0, enemy_ycor(s3)
	lb t1, bullet_y(s0)
	bne t0, t1, _end_col
	lw t0, use_zero
	lb t1, use_byte_zero
	sw t0, enemies_array(s3)
	sb t1, bullet_active(s0)
	li t0, 0
	li t1, 64
	sw t0, enemy_xcor(s3)
	sw t0, enemy_ycor(s3)
	sb t1, bullet_x(s0)
	sb t1, bullet_y(s0)
_end_col:
	inc s0
	li t0, 4
	bne s0, t0, _intro
	li s0, 0
	inc s4
	add s3, s3, 4
	li t0, 20
	bne s4, t0, _intro
	li s0, 0
	li t1, 20
	lb t2, use_byte_one
_end_looper_checker:
	lb t0, enemies_array(s0)
	beq t0, t2, _end_hitting
	inc s0
	beq s0, t1, _special
	b _end_looper_checker
_special:
	lb t0, use_byte_two
	sb t0, game_end
_end_hitting:
leave s0, s1, s2, s3, s4

enemy_fire:
enter s0, s1, s2
	lb s2, change_enemy_fire
	li s0, 0
	li s1, 0
	lb t0, enemy_check_frames
	li t1, 0
	beq t0, t1, _can_fire
	b _no_fire
_can_fire:
	li t4, ENEMY_BULLET
	lb t2, enemy_bullet_active(s0)
	lb t1, use_byte_zero
	lb t0, enemy_fire_delay
	sb t0, enemy_check_frames
	beq t2, t1, _can_make_bullet2
	inc s0
	bne s0, t4, _can_fire
	b _no_fire
_can_make_bullet2:
	lb t0, use_byte_one
	sb t0, enemy_bullet_active(s0)
	lw t0, use_zero
	lw t1, enemies_array(s2)
	beq t1, t0, _enemy_dead
	lb t0, enemy_xcor(s2)
	lb t1, enemy_ycor(s2)
	lb t3, change_enemy_fire
	add t3, t3, 12
	li t4, 64
	sb t3, change_enemy_fire
	bgt t3, t4, _reset_fire_change
_back_to_bullet:
	add t0, t0, 2
	add t1, t1, 4
	sb t0, enemy_bullet_x(s0)
	sb t1, enemy_bullet_y(s0)
	b _no_fire
_reset_fire_change:
	lb t3, use_byte_zero
	sb t3, change_enemy_fire
	b _back_to_bullet
_enemy_dead:
	lb t3, change_enemy_fire
	add t3, t3, 4
	li t4, 64
	sb t3, change_enemy_fire
	bgt t3, t4, _reset_fire_change2
	b _no_fire
_reset_fire_change2:
	lb t3, use_byte_zero
	sb t3, change_enemy_fire
_no_fire:
	lb t0, enemy_check_frames
	dec t0
	sb t0, enemy_check_frames
	li s1, 0
_bullet_loop2:
	lb t0, enemy_bullet_active(s1)
	lb t1, use_byte_one
	bne t0, t1, _shootloop_end2
_show_bullet2:
	lb t0, enemy_bullet_y(s1)
	inc t0
	li t2, 64
	bgt t0, t2, _lose_bullet2
	sb t0, enemy_bullet_y(s1)
	lb a0, enemy_bullet_x(s1)
	lb a1, enemy_bullet_y(s1)
	li a2, COLOR_WHITE
	jal display_set_pixel
	b _shootloop_end2
_lose_bullet2:
	lb t0, use_byte_zero
	sb t0, enemy_bullet_active(s1)
_shootloop_end2:
	inc s1
	li t4, ENEMY_BULLET
	bne s1, t4, _bullet_loop2
leave s1, s0, s2

check_collision2:
enter s0, s1, s2, s3, s4
	li s3, 0
	li s0, 0
_intro2:
	li s1, 4
	li s2, 0
	lb t0, player_xcor
check_x_per2:
	lb t1, enemy_bullet_x(s0)
	beq t0, t1, _to_y2
	inc t0
	inc s2
	bne s2, s1, check_x_per2
	b _end_col2
_to_y2:
	lb t0, player_ycor
	lb t1, enemy_bullet_y(s0)
	beq t0, t1, _after_check
_check_rest_y:
	inc t0
	beq t0, t1, _after_check
	li t3, 5
	inc s4
	beq s4, t3, _end_col2
	b _check_rest_y
_after_check:
	lb t0, player_lives
	dec t0
	sb t0, player_lives
	li t0, 120
	sb t0, wait_player
	li t1, 63
	sb t1, enemy_bullet_active(s0)
	sb t1, enemy_bullet_x(s0)
	sb t1, enemy_bullet_y(s0)
_end_col2:
	inc s0
	li t0, 4
	bne s0, t0, _intro2
leave s0, s1, s2, s3, s4

draw_lives:
enter
	lb t0, player_lives
	li t1, 3
	li t2, 2
	li t3, 1
	li t4, 0
	li t5, 4
	beq t0, t5, _four
	beq t0, t1, _three
	beq t0, t2, _two
	beq t0, t3, _one
	beq t0, t4, _game_over2
_four:
	lb t0, set_diff
	li t1, 1
	beq t0, t1, _four_hard
	li t1, 2
	beq t0, t1, _four_easy
	li a0, 37
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 58
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	b _end_this_function
_four_hard:
	li a0, 37
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 58
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	b _end_this_function
_four_easy:
	li a0, 37
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 58
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	b _end_this_function
_three:
	lb t0, set_diff
	li t1, 1
	beq t0, t1, _three_hard
	li t1, 2
	beq t0, t1, _three_easy
	li a0, 58
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	b _end_this_function
_three_hard:
	li a0, 58
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	b _end_this_function
_three_easy:
	li a0, 58
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 44
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	b _end_this_function
_two:
	lb t0, set_diff
	li t1, 1
	beq t0, t1, _two_hard
	li t1, 2
	beq t0, t1, _two_easy
	li a0, 58
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	b _end_this_function
_two_hard:
	li a0, 58
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	b _end_this_function
_two_easy:
	li a0, 58
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	li a0, 51
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	b _end_this_function
_one:
	lb t0, set_diff
	li t1, 1
	beq t0, t1, _one_hard
	li t1, 2
	beq t0, t1, _one_easy
	li a0, 58
	li a1, 58
	la a2, player_image
	jal display_blit_5x5
	b _end_this_function
_one_hard:
	li a0, 58
	li a1, 58
	la a2, player_image2
	jal display_blit_5x5
	b _end_this_function
_one_easy:
	li a0, 58
	li a1, 58
	la a2, player_image3
	jal display_blit_5x5
	b _end_this_function
_game_over2:
	lb t1, use_byte_one
	sb t1, game_end
_end_this_function:
leave

check_collision3:
enter s0, s1, s2, s3
	li t0, 1
	lb t1, got_bullet
	beq t0, t1, _hit_taken
	lw s0, player_xcor
	dec s0
	lw s1, player_ycor
	dec s1
	li s3, 0
_player_x_loop:
	li s2, 0
	li t0, 5
	inc s0
	inc s3
	beq s3, t0, _the_end
	b _up_powerx_loop_pre
_player_y_loop_pre:
	li s3, 0
_player_y_loop:
	li s2, 0
	li t0, 5
	inc s1
	inc s3
	beq s3, t0, _the_end
	b _up_powery_loop_pre
_up_powerx_loop_pre:
	li t1, 50
_up_powerx_loop:
	li t0, 5
	beq s0, t1, _player_y_loop_pre
	inc s2
	inc t1
	beq s2, t0, _player_x_loop
	b _up_powerx_loop
_up_powery_loop_pre:
	li t1, 51
_up_powery_loop:
	li t0, 5
	beq s1, t1, _hit_granted
	inc s2
	inc t1
	beq s2, t0, _player_y_loop
	b _up_powery_loop
_hit_granted:
	li t0, 1
	sb t0, got_bullet
	lw t0, bullet_count
	add t0, t0, 10
	sw t0, bullet_count
	lb a0, got_bullet
	li v0, 1
	syscall
	b _hit_taken
_the_end:
	li a0, 50
	li a1, 51
	la a2, more_bullets
	jal display_blit_5x5
_hit_taken:	
leave s0, s1, s2, s3

check_collision4:
enter s0, s1, s2, s3
	li t0, 1
	lb t1, got_life
	beq t0, t1, _hit_taken2
	lw s0, player_xcor
	dec s0
	lw s1, player_ycor
	dec s1
	li s3, 0
_player_x_loop2:
	li s2, 0
	li t0, 5
	inc s0
	inc s3
	beq s3, t0, _the_end2
	b _up_powerx_loop_pre2
_player_y_loop_pre2:
	li s3, 0
_player_y_loop2:
	li s2, 0
	li t0, 5
	inc s1
	inc s3
	beq s3, t0, _the_end2
	b _up_powery_loop_pre2
_up_powerx_loop_pre2:
	li t1, 3
_up_powerx_loop2:
	li t0, 5
	beq s0, t1, _player_y_loop_pre2
	inc s2
	inc t1
	beq s2, t0, _player_x_loop2
	b _up_powerx_loop2
_up_powery_loop_pre2:
	li t1, 48
_up_powery_loop2:
	li t0, 5
	beq s1, t1, _hit_granted2
	inc s2
	inc t1
	beq s2, t0, _player_y_loop2
	b _up_powery_loop2
_hit_granted2:
	li t0, 1
	sb t0, got_life
	lb t0, player_lives
	inc t0
	sb t0, player_lives
	lb a0, got_life
	li v0, 1
	syscall
	b _hit_taken2
_the_end2:
	li a0, 3
	li a1, 48
	la a2, more_lives
	jal display_blit_5x5
_hit_taken2:	
leave s0, s1, s2, s3
