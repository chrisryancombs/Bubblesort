# CS200 Project 8
# Bubblesort
# Done in QtSpim
# Christopher Combs 2016


.data
array:              .space  40
sorted:             .space  40
readnumsprompt:     .asciiz "How many numbers do you want to enter(1-10)? "
numberprompt:       .asciiz "Enter a number: "
errormessage:       .asciiz "Bad input. Try again. "
displaymessage:     .asciiz "Here is your sorted array: "
space:              .asciiz "  "


.text
.globl main


main:

    jal        readnums

    li         $t2, 0
    sub        $s2, $s3, 4
    jal        bsort


    la         $a0, displaymessage
    li         $v0, 4
    syscall


    li         $t1, 0
    li         $t2, 0
    jal        printnums


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
    move       $s3, $t0
    li         $t2, 0                    #set loop counter to zero


    j          inputloop


error:

    la         $a0, errormessage         # tell the user to try again
    li         $v0, 4
    syscall


    j          readnums

inputloop:

    beq        $s3, $t2, endreadnums     # leave if added right amount of ints
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

bsort:

    beq        $s3, $t2, outsideloop     # leave if printed right amount of ints
    add        $t5, $t2, 4
    lw         $t6, array($t2)           # save current val and one val ahead
    lw         $t7, array($t5)
    bge       $t7, $t6, skipswap             # ignore swap if need be



    sw         $t6, array($t5)           # swap
    sw         $t7, array($t2)

    addi       $t2, 4                    # increment loop counter
    j          bsort

skipswap:
    addi       $t2, 4                    # increments but doesnt swap
    j          bsort                     # jump back to next iteration of bsort

outsideloop:
    li         $t2, 0
    addi       $t1, 1
    beq        $t1, $s3, endreadnums     # once we have looped enough times, return to main
    j          bsort

printnums:

    beq        $s3, $t2, endreadnums     # leave if printed right amount of ints
    addi       $t2, 4                    # increment loop counter


    lw         $t4, array($t2)           # read current number in array
    move       $a0, $t4
    li         $v0, 1                    # print out number
    syscall


    la         $a0, space                # parse with two spaces
    li         $v0, 4
    syscall
    j          printnums
