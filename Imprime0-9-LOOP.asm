;GERONIMO APARICIO ELVIA
;imprime los numeros del 9 al 0 utilizando LOOP 
TITLE
.MODEL SMALL
write MACRO buffer
  MOV AH,09H
  LEA DX,buffer
  INT 21H
ENDM

position MACRO row, column 
    MOV AH,02H
    MOV DH, row ;fila
    MOV DL, column ;Columna
    INT 10H
ENDM

posicionar MACRO column
    MOV AH,02H
    MOV DX,column
    MOV BH,00H
    INT 10H
ENDM
.STACK

.DATA
    letrero DB ('Resultado loop: '),0AH,0DH,'$'
    salto DB ('  '),'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      
      call clear
        posicionar 0020h
        write letrero
        position 2h, 20h
        
        MOV CX,9
        ciclo:
            write salto
            mov ah, 02h
            mov dx, cx
            add dx, 30h
            int 21h
        loop ciclo
        
        .exit
        RET
        
        main endp
        
       clear PROC 
        MOV AH,06H
        MOV BH,2FH        ;2FH VERDE, 3FH AZUL
        MOV CX,0000H      ; Limpia desde la esquina izquierda (0,0)
        MOV DX,184FH      ; limpia desde la esquina inferior derecha con coordenadas (24,79) en decimal o (18,4F) en hexadecimal
        INT 10H
        RET
       clear ENDP

END main
        