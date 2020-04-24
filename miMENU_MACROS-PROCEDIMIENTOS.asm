;Geronimo Aparicio Elvia
;Menu con macros 
TITLE
.MODEL SMALL

write MACRO buffer
  MOV AH,09H
  LEA DX,buffer
  INT 21H
ENDM

position MACRO column
    MOV AH,02H
    MOV DX,column
    MOV BH,00H
    INT 10H
ENDM
.STACK

.DATA
    letMenu DB ('MENU'),'$'  
    letSuma DB ('1.- Suma'),'$'
    letResta DB ('2.- Resta'),'$'
    letSalir DB ('3.- Salir'),'$'
    
    dato1 DB('?'),'$'
    letPedir DB 0AH,0DH,('Inserte un numero: '),0AH,0DH,'$'
    saltoline DB 0AH,0DH,'$'
    resultado DB 0AH,0DH,('El resultado es:   '),'$'
    mensaje DB 0AH,0DH,('El primer dato debe ser mayor al segundo.'),'$'

.CODE
    main PROC FAR
        MOV AX,@DATA
        MOV ds,AX
         
        MENU:
        CALL clear
        position 0120h
        write letMenu        
        position 0220h
        write letSuma        
        position 0320h
        write letResta        
        position 0420h
        write letSalir
        
        position 0520h
        call read ;AL contiene mi valor 

        CMP AL,31H
        JE SUMA       
        CMP AL,32H
        JE RESTA 
        CMP AL,33H
        JE SALIR
        JMP MENU
       SUMA:
         call clear
         position 0120h
         write letPedir
         call read
         MOV dato1,AL
         
         position 0320h
         write letPedir
         call read
         
         ADD dato1,AL
         SUB dato1,30H
         write resultado
         write dato1
         call read
       JMP MENU
       SALIR:
       JMP SALIR2
       
       RESTA:;PONER condicion el primer numero debe ser mayor al segundo
         call clear
         position 0120h
         write letPedir
         call read
         MOV dato1,AL
         
         position 0320h
         write letPedir
         call read
         
         CMP dato1,AL
         JB mess
           
         SUB dato1,AL
         ADD dato1,30H
         write resultado
         write dato1
         call read
         call clear
       JMP MENU
       mess: 
           position 0520h
           write mensaje
           call read
           JMP RESTA
           RET
              
       SALIR2:
        call clear
        
        .exit
        RET    
        main ENDP
        
clear PROC 
     MOV AH,06H
     MOV BH,3FH        ;2FH VERDE, 3FH AZUL, 71H GRIS
     MOV CX,0000H      ; Limpia desde la esquina izquierda (0,0)
     MOV DX,184FH      ; limpia desde la esquina inferior derecha con coordenadas (24,79) en decimal o (18,4F) en hexadecimal
     INT 10H
     RET
clear ENDP

read PROC
   MOV AH,01H
    INT 21H
    RET
    read ENDP
        
END main
        
