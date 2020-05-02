;GERONIMO APARICIO ELVIA
;LEE E IMPRIME EL NOMBRE Y APELLIDO EN PANTALLA 
;TITLE

.MODEL SMALL
include Library.lib

.STACK

.DATA
    letrero DB ('Ingresa tu nombre: '),0AH,0DH,'$'
    letrero2 DB ('Ingresa tu apellido paterno: '),0AH,0DH,'$'
    letrero22 DB ('Ingresa tu apellido materno: '),0AH,0DH,'$'
    letrero3 DB ('Tu nombre es: '),0AH,0DH,'$'
    nombre DB 10 DUP (' '),'$'
    ;salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      
      call clear
      position 0020h
        write letrero
        position 0120h
        mov si,0h
  
        ;COMPARAR CON EL 0DH, que es enter
        CiNombre:
        MOV AH ,01h
        INT 21H
        CMP AL, 0DH
        JE salir
        MOV nombre[SI],AL
        INC SI
        CMP SI,10
        JE salir
        JMP CiNombre
        
        
        salir:
        position 0720h
        write letrero3
        position 0920h
        write nombre
      
        .exit
        RET
        
        main endp

END main
        