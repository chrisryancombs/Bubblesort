# CS200 Project 8
# Bubblesort
# Done in QtSpim
# Christopher Combs 2016

.data
array:              .space   40
readnumsprompt:     .asciiz "How many numbers do you want to enter(1-10)? "
numberprompt:       .asciiz "Enter a number from one to ten: "
errormessage:       .asciiz "Bad input. Try again. "


.text
.globl main

main:
    jal        readnums
    move       $t9, $s0


    li         $v0, 10
    syscall

readnums:
    la         $s0, array
    la         $a0, readnumsprompt       # ask for number of inputs
    li         $v0, 4
    syscall
    li         $v0, 5                    # gets number of inputs
    syscall


    move       $s1, $v0                  # also save for use as a loop counter


    bgt        $s1, 10, error            # try again if input above 10
    blez       $s1, error                # try again if input below 1

    li         $t4, 4
    mult       $s1, $t4                  #find upper end of counter
    mflo       $t0
    li         $t2, 0                    #set loop counter to zero

    j          inputloop
error:
    la         $a0, errormessage         # tell the user to try again
    li         $v0, 4
    syscall
    j          readnums

inputloop:
    beq        $t0, $t2, endreadnums     # leave if added right amount of ints
    addi       $t2, 4                    # increment loop counter


    la         $a0, numberprompt         # ask for number
    li         $v0, 4
    syscall
    li         $v0, 5                    # gets number
    syscall

    move       $t1, $v0
    sw         $t1, array($t2)           #store int in array


    j          inputloop

endreadnums:
    jr         $ra
