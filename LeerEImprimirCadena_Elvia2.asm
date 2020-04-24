TITLE
.MODEL SMALL
write MACRO buffer
  MOV AH,09H
  LEA DX,buffer
  INT 21H
ENDM

.STACK

.DATA
    letrero DB ('Ingresa tu nombre: '),0AH,0DH,'$'
    letrero2 DB ('Ingresa tu apellido: '),0AH,0DH,'$'
    letrero3 DB 0AH,0DH,('Tu nombre es: '),0AH,0DH,'$'
    nombre DB 10 DUP (' '),'$'
    apellido DB 10 DUP (' '),'$'
    salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
        
        write letrero
  
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
        write letrero2
        mov si,0h
        CiApe2:
        MOV AH ,01h
        INT 21H
        CMP AL, 0DH
        JE salir
        MOV apellido[SI],AL
        INC SI
        CMP SI,10
        JE salir
        JMP CiApe2
        
        salir:
        write letrero3
        write nombre
        write apellido
        .exit
        RET

END main
        