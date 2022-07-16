.model small
.stack 64 

.data
     instruct db 10, 13,'Instruction: 1 = Rock |  2 = Paper | 3 = Scissors', '$'    ;instuction
     Player1 db 10, 13, 'Player 1: ', '$'                                           ;player 1
     Player2 db 10, 13, 'Player 2: ', '$'                                           ;player 2
     Player1Winner db 10, 13,'Player 1 Wins!','$'                                   ;player 1 winning message
     Player2Winner db 10, 13,'Player 2 Wins!','$'                                   ;player 2 winning message
     tie db 10, 13,'Its a TIE! $', 0                                                ;tie message
     linefeed db 13, 10, '$'                                                        ;next line
     again db 10, 13,'Play Again? 1 = Yes, 2 = No: $', 0                            ;play again message
     
    
.code

main proc near
    
startGame:
    mov AX, @data
    mov DS, AX
    mov ES, AX
    lea DX, instruct                ;@data Instruct
    mov AH, 09H
    int 21H
    jmp .promptPlayer1              ;jumps to .promptPlayer1

.promptPlayer1: 
    mov DL, 10                      
    mov AH, 02h                     ;new line 
    int 21h
    mov DX, OFFSET Player1          ;@data Player1
    mov AH, 09h
    int 21h
    jmp .p1
    
.p1:
    mov AH, 08                      ;funtion to read input
    int 21h                         ;input save
    mov AH, 02h                     ;function to display input
    mov BL, AL                      ;copy AL to BL
    mov DL, AL                      ;copy AL to DL to display
    int 21h  
    jmp .promptPlayer2              ;jumps .promptPlayer2
       
.promptPlayer2:
    mov DL, 10                      
    mov AH, 02h                     ;new line 
    int 21h                         
    mov DX, OFFSET Player2          ;@data player2
    mov AH, 09h
    int 21h
    jmp .p2                         ;jumps .p2
    
.p2:
    mov AH, 08                      ;read input
    int 21h                         ;save to AL
    mov AH, 02h                     ;display a char
    mov BH, AL                      ;copy AL to BH
    mov DL, AL                      ;copy AL to DL
    int 21h 
    jmp .condition

    
.condition:
    cmp BL, BH                     ;compare BL == BH
    je .playerTie                  ;jumps to .playerTie if true
    cmp BL, '1'                    ;compare BL == '1'
    je .con1                       ;jumps to .con1 if true
    cmp BL, '2'                    ;compare BL == '2' 
    je .con2                       ;jumps to .con2 if true
    cmp BL, '3'                    ;compare BL == '3'
    je .con3                       ;jumps to .con3 if true
    
    
.con1: 
    cmp BH, '2'                    ;compare BH == '2'
    je .p2Winner                   ;jumps to .p2Winner if true
    cmp BH, '3'                    ;compare BH == '3'
    je .p1Winner                   ;jmps to .p1Winner if true
    
    
.con2:  
    cmp BH, '1'                    ;compare BH == '1'
    je .p1Winner                   ;jumps to .p1Winner if true
    cmp BH, '3'                    ;compare BH == '3'
    je .p2Winner                   ;jumps to .p2Winner if true
    
        
.con3: 
    cmp BH, '1'                    ;comapre BH == '1'
    je .p2Winner                   ;jumps to .p2Winner if true
    cmp BH, '2'                    ;compare BH == '2'
    je .p1Winner                   ;jumps to .p1Winner if true
    
      
.p1Winner:  
    mov DL, 10                      
    mov AH, 02h                    ;new line 
    int 21h
    mov DX, OFFSET Player1Winner   ;@data Player1Winner
    mov AH, 09h
    int 21h
    jmp .playagain
    
.p2Winner: 
    mov DL, 10                      
    mov AH, 02h                    ;new line 
    int 21h 
    mov DX, OFFSET Player2Winner   ;@data Player2Winner
    mov AH, 09h
    int 21h
    jmp .playagain
    
.playerTie:
    mov DL, 10                      
    mov AH, 02h                     ;new line 
    int 21h  
    mov DX, OFFSET tie              ;@data tie
    mov AH, 09h
    int 21h
    jmp .playagain                  ;jumps to .playagain
    
.playagain: 
    mov AH, 09
    mov DX, OFFSET linefeed
    int 21h                         ;new line
    mov DX, OFFSET again            ;@data again
    int 21h
    mov AH, 08                      ;read input
    int 21h                         ;saves data to AL
    mov AH, 02                      ;copy AL to CH
    mov CH, AL                      ;copy AL to DL
    mov DL, AL 
    int 21h                         
    cmp CH, '1'                     ;compares if CH == '1'
    je .repeat                      ;jumps to .repeat if true
    jmp .end                        ;jumps to .end if false
    
.repeat: 
    mov AH, 09
    mov DX, OFFSET linefeed         ;new line
    int 21h 
    jmp startGame                   ;jumps to startGame
    
.end: 
    mov AH, 4CH
    mov AL, 00
    int 21H
    

main endp