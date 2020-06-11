;GERONIMO APARICIO ELVIA
; LEE una cadena,Y PINTA LAS VOLCALES QUE EL USUARIO ELIJE 

.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa una cadena: '),0AH,0DH,'$'
    letrero2 DB ('Presiona la vocal a escanear: '),0AH,0DH,'$'
    letreroV DB ('a  e  i  o  u'),0AH,0DH,'$'
    letrero3 DB ('1.-Clic en "1", para salir'),0AH,0DH,'$'
    vocal DB ('?'),'$'
    ;color DB ('?'),'$'
    cadena DB 10 DUP (' '),'$'
    longN EQU $-cadena
    val DW (0),'$'
    letrero4 DB ('El caracter esta en la posicion:'),'$'
    color DB ('?'),'$'
    contador   DB ('?'),'$'
    cordX Db 0
    cordY Db 0
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      MOV ES,AX
      
      INICIO:
      ;call clear
      position 0020h
        write letrero
        position 0120h
        mov si,0h
  
        ;COMPARAR CON EL 0DH, que es enter#    
        CiNombre:; Guarda la cadena en nombre
            MOV AH ,01h
            INT 21H
            MOV cadena[SI],AL
           CMP AL, 0DH
           JE next
           INC SI
           CMP SI,10
           JE next
           JMP CiNombre
        
        next:
        position 0320h
        write letrero2
        posicionar 6,20
        write cadena
        posicionar 8,20
        write letreroV
        
        ;elegir:
        call showMouse
        pulsar:
        call mouseIz
        CMP BX, 1
        Jne pulsar
        mov bl,0h
       
       convertC cordX, cordY ; convierte las coordenadas y
                       ; los valores se guardan en cordX  y cordY  
          CMP cordY,8
          JNE pulsar
          CMP cordX,20
          JE A 
          CMP cordX,23
          JE E 
          CMP cordX,26
          JE I
          CMP cordX,29
          JE O
          CMP cordX,32
          JE U
          JMP pulsar
          A:
          mov vocal,'a'
          mov color,14
          JMP iniScan
          E:
          mov vocal,'e'
          mov color,12
          JMP iniScan
          I:
          mov vocal,'i'
          mov color,11
          JMP iniScan
          O:
          mov vocal,'o'
          mov color,10
          JMP iniScan
          U:
          mov vocal,'u'
          mov color,13
          JMP iniScan
          pulsar2:
          jmp pulsar
         iniScan:
          MOV AL, vocal
        ;MOV val,0620h
        MOV BX, 00H
        scan:                  ;Scanear caracter en la cadena 
        MOV DI,OFFSET cadena
        MOV contador, 10
        ;LEA DI,cadena  
        mov cx,LENGTH cadena 
        cld                    ; direcci?n = avance
        repne scasb            ; repite mientras no sea igual
        jnz pulsar2;notfound              ; termina si no se encontr? la letra
        DEC DI
        sub di,67h
        MOV cadena[di],'-'
        INC BX
        position 0620h
        SUB contador, CL
        mov cl, contador
        add contador,19
        add di, 30h
        mov val, di
        write val
        posicionar 6,contador
        impCaracter vocal, color
        
        position 0920h
        write cadena
        
        JMP scan

     
        position 0920h
        write cadena
        jmp salir
        
        notFound:             ;En caso de que el caracter No se haya encontrado
        posicionar 10, 20h
        write letreroV
        
        
        salir:
        call read
        call clear
        .exit  
        RET
        
        main endp
END main
        
