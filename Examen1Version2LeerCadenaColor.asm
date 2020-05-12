;GERONIMO APARICIO ELVIA
;EXAMEN LEE E IMPRIME EL NOMBRE EN PANTALLA CON DIFERENTE COLOR EN CADA LETRAS

.MODEL SMALL
include Library.lib

.STACK

.DATA
    letrero DB ('Ingresa tu nombre: '),0AH,0DH,'$'
    letrero3 DB ('Tu nombre es: '),0AH,0DH,'$'
    nombre DB 10 DUP (' '),'$'
    val DB (''),'$'
    color DB (''),'$'
    ;salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      
      position 0020h
        write letrero
        position 0120h
        mov si,0h
  
        ;COMPARAR CON EL 0DH, que es enter
        CiNombre:
            MOV AH ,01h
            INT 21H
            MOV nombre[SI],AL
            CMP AL, 0DH
            JE salir
            INC SI
            CMP SI,10
            JE salir
        JMP CiNombre
        
        
        salir:
        position 0720h
        write letrero3
        
        
        MOV SI,0H      
        mov val, 20h
        mov color, 2
        
      ciclo2:
      posicionar 9, val
         CMP nombre[si],0DH
         JE salir2
         
         impCaracter nombre[SI],color
         INC color
         INC val
         INC SI
         CMP SI,10
         JE salir2
        jmp ciclo2
        
        salir2:
        call read
        call clear
        .exit  
        RET
        
        main endp
END main
        