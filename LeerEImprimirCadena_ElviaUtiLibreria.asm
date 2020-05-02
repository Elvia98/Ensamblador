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
    apellido DB 10 DUP (' '),'$'
    apellido2 DB 10 DUP (' '),'$'
    salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      
      call clear
      position 0020h
        write letrero
        position 0120h
  
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
        position 0320h
        write letrero2
        position 0420h
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
        position 0520h
        write letrero22
        position 0620h
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
        position 0720h
        write letrero3
        position 0915h
        write nombre
        write apellido
        write apellido2
        .exit
        RET
        
        main endp

END main
        