.model small
.stack 64

.data
    
    array dw 1,12,23,34,45,56,67,78,89,91 ;word array with 10 items
    goto dw 5 dup <?>                     ;destination
    
.code

main proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX
    mov CX, 10         ;10 loops
    lea SI, array      ;source index to source location
    lea DI, goto       ;destination index to destination
    
.loop1:
    mov AX, [SI]       ;moves content of source index to AX
    cmp AX, 1          ;code to compare if AX == 1
    je .loop2          ;if true jump to .loop2
    cmp AX, 2          ;code to compare if AX == 2
    je .prime          ;if true jump 2 prime
    mov BX, AX

.checker:
    mov AX, [SI]
    dec BX             ;decrement BX
    xor DX, DX         ;sets the value of DX to 0
    div BX             ;divides (DX AX/BX)
    cmp DX, 0          ;code to compare if DX == 0
    je .loop2          ;if true, jump to .loop2
    cmp BL, 2          ;code to compare if BL == 2
    jne .checker       ;if false jump to .checker
    
.prime:
    mov AX, [SI]       
    mov [DI], AX       ;transfer AX to goto
    mov AX, 2          ;AX = 2
    add DI, AX         ;add to DI
    
.loop2:
    mov AX, 2          ;AX = 2
    add SI, AX         ;add to SI
    
  loop .loop1
  
mov AX, 4C00H
int 21H

main endp