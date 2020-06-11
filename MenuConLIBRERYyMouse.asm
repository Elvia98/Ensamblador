;Geronimo Aparicio Elvia
;Menu con LIBRERIA, utiliza menú  
TITLE
.MODEL SMALL
include Library.lib
    
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
    cordX Db 0
    cordY Db 0

.CODE
    main PROC FAR
        MOV AX,@DATA
        MOV ds,AX
        MOV ES,AX
        
        MENU:
        CALL clear
        posicionar 1, 20
        write letMenu        
        posicionar 2, 20
        write letSuma        
        posicionar 3, 20
        write letResta        
        posicionar 4, 20
        write letSalir
        
        call showMouse
        pulsar:
        call mouseIz
        CMP BX, 1
        Jne pulsar
        mov bl,0h
       
       convertC cordX, cordY ; convierte las coordenadas y
                             ; los valores se guardan en cordX  y cordY  
          CMP cordX,20
          JNE pulsar
          CMP cordY,2
          JE SUMA 
          CMP cordY,3
          JE RESTA 
          CMP cordY,4
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
                
END main
        
