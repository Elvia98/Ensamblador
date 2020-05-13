;GERONIMO APARICIO ELVIA
; LEE E IMPRIME DOS CADENAS EN PANTALLA, CAMBIA el nombre1 en el nombre2 UTILIZANDO MOVSB

.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa cadena del nombre1: '),0AH,0DH,'$'
    letrero2 DB ('Ingresa cadena del nombre2: '),0AH,0DH,'$'
    letrero3 DB ('Los nombres son: '),0AH,0DH,'$'
    letrero4 DB ('Nombre1 ha pasado a nombre2. '),0AH,0DH,'$'
    letrero5 DB ('Se imprimen ambas cadenas: '),0AH,0DH,'$'
    nombre DB 30 DUP (' '),'$'
    nombre2 DB 30 DUP (' '),'$'
    val DB (''),'$'
    color DB (''),'$'
    ;salto DB 0AH,0DH,'$'
    
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      MOV ES,AX
      
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
           JE guardar2
           INC SI
           CMP SI,10
           JE guardar2
           JMP CiNombre
        
        guardar2:
        position 0320h
        write letrero2
        position 0420h
        mov si,0h
        
        CiNombre2:; Guarda la cadena en nombre
            MOV AH ,01h
            INT 21H
            MOV nombre2[SI],AL
           CMP AL, 0DH
           JE salir
           INC SI
           CMP SI,10
           JE salir
           JMP CiNombre2
        
        salir:
        position 0720h
        write letrero3
        position 0920h
        write nombre
        posicionar 10, 20h
        write nombre2
        
        cambiaCadena: ; Se cambia el nombre1 en el nombre2
       cld ; borra la bandera Dirección
       mov si,OFFSET nombre ; ESI apunta al origen
       mov di,OFFSET nombre2 ; EDI apunta al destino
       mov cx,30 ; establece el contador a 30
       rep movsb ; se mueve 30 bytes
       
       posicionar 12, 20h
       write letrero4
       posicionar 13, 20h
       write letrero5
       posicionar 15, 20h
       write nombre
       posicionar 16, 20h
       write nombre2

        salir2:
        call read
        call clear
        .exit  
        RET
        
        main endp
END main
        