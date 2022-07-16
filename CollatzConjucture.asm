.model small
.stack 64

.data
  
    try dw 6            ;variable try with value of 6
    check dw 0       
    
.code

main proc far
     
     mov AX, @data
     mov DS, AX
     mov ES, AX
     mov AX, try        ;Assigning try to accumulator AX
     cmp try, 1         ;code that compares try and 1
     je main endp       

.loop1:
     mov BX, 2
     div BX             ;divide (DX AX)/BX
     cmp DX, 0          ;code that compares DX and 0
     jne .odd           ;if DX != 0 jump to odd
     mov try, AX        ;Assigning value of accumulator AX to try
     jmp .loop2         ;jump to .loop2
     
.odd:
    mov AX, try
    mov DX, 3
    mul DX              ;multiply AX and DX
    inc AX              ;increments AX
    mov try, AX
    
.loop2:
    inc check           ;increments check
    cmp try, 1          ;code that compares try and 1
    jne .loop1          ;if try != 1 jump to .loop1
 
mov AX, 4C00H
int 21H

main endp
    
    