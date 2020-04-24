;GERONIMO APARICIO ELVIA
;LEE E IMPRIME EL NOMBRE Y APELLIDO EN PANTALLA 
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
    letrero DB ('Ingresa tu nombre: '),0AH,0DH,'$'
    letrero2 DB ('Ingresa tu apellido paterno: '),0AH,0DH,'$'
    letrero22 DB ('Ingresa tu apellido materno: '),0AH,0DH,'$'
    letrero3 DB ('Tu nombre es: '),0AH,0DH,'$'
    nombre DB 10 DUP (' '),'$'
    apellido DB 10 DUP (' '),'$'
    apellido2 DB 10 DUP (' '),'$'
    salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      
      call clear
      ;position 1h, 20h
        posicionar 0020h
        write letrero
        position 2h, 20h
  
        ;COMPARAR CON EL 0DH, que es enter
        CiNombre:
        MOV AH ,01h
        INT 21H
        CMP AL, 0DH
        JE CiApe
        MOV nombre[SI],AL
        INC SI
        CMP SI,10
        JE CiApe
        JMP CiNombre
        
        CiApe:
        position 3h, 20h
        write letrero2
        position 4h, 20h
        mov si,0h
        
        CiApe2:
        MOV AH ,01h
        INT 21H
        CMP AL, 0DH
        JE CiApeM
        MOV apellido[SI],AL
        INC SI
        CMP SI,10
        JE salir
        JMP CiApe2
        
        CiApeM:
        position 5h, 20h
        write letrero22
        position 6h, 20h
        mov si,0h
        
        CiApeM2:
        MOV AH ,01h
        INT 21H
        CMP AL, 0DH
        JE salir
        MOV apellido2[SI],AL
        INC SI
        CMP SI,10
        JE salir
        JMP CiApeM2
        
        salir:
        position 7h, 20h
        write letrero3
        position 9h, 20h
        write nombre
        write apellido
        write apellido2
        .exit
        RET
        
        main endp
        
       clear PROC 
        MOV AH,06H
        MOV BH,5FH        ;2FH VERDE, 3FH AZUL
        MOV CX,0000H      ; Limpia desde la esquina izquierda (0,0)
        MOV DX,184FH      ; limpia desde la esquina inferior derecha con coordenadas (24,79) en decimal o (18,4F) en hexadecimal
        INT 10H
        RET
       clear ENDP

END main
        