;GERONIMO APARICIO ELVIA
; LEE una cadena,recibe un caracter y lo busca dentro de la cadena, si esta imprime la posicion 

.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa cadena del nombre1: '),0AH,0DH,'$'
    letrero2 DB ('Ingresa el caracter a buscar: '),0AH,0DH,'$'
    letrero3 DB ('No se encontro el caracter dentro de la cadena'),0AH,0DH,'$'
    
    nombre DB 10 DUP (' '),'$'
    longN EQU $-nombre
    val DW (0),'$'
    letrero4 DB ('El caracter esta en la posicion:'),'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      MOV ES,AX
   
      call clear
      position 0020h
        write letrero
        position 0120h
        mov si,0h
  
        ;COMPARAR CON EL 0DH, que es enter#    
        CiNombre:; Guarda la cadena en nombre
            MOV AH ,01h
            INT 21H
            MOV nombre[SI],AL
           CMP AL, 0DH
           JE next
           INC SI
           CMP SI,10
           JE next
           JMP CiNombre
        
        next:
        position 0320h
        write letrero2
        position 0420h
        call read
        
        MOV val,0
        scan:                  ;Scanear caracter en la cadena 
        ;MOV DI,OFFSET nombre
        LEA DI,nombre  
        mov cx,LENGTH nombre 
        cld                    ; dirección = avance
        repne scasb            ; repite mientras no sea igual
        jnz notFound              ; termina si no se encontró la letra
        
        position 0520h
        write letrero4
 
        position 0620h
        sub DI,41H
        MOV val,DI
        write val

     
        position 0920h
        write nombre
        jmp salir
        
        notFound:             ;En caso de que el caracter No se haya encontrado
        posicionar 10, 20h
        write letrero3
        
        
        salir:
        call read
        call clear
        .exit  
        RET
        
        main endp
END main
        