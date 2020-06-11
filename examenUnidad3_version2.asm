;GERONIMO APARICIO ELVIA
; LEE una cadena,Y PINTA LAS VOLCALES QUE EL USUARIO ELIJE 

.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa una cadena: '),0AH,0DH,'$'
    letrero2 DB ('Presiona la vocal a escanear: '),0AH,0DH,'$'
    letreroV DB ('a  e  i  o  u'),0AH,0DH,'$'
    letSalir DB ('1.-Clic en "1", para salir'),0AH,0DH,'$'
    vocal DB ('?'),'$'
    ;color DB ('?'),'$'
    cadena DB 10 DUP (' '),'$'
    longN EQU $-cadena
    array Dw 5 DUP (' '),'$'
    val Dw (0),'$'
    valAr Dw (0),'$'
    letrero4 DB ('El caracter esta en la posicion:'),'$'
    letPA DB ('2.- Ingresar nueva cadena'),'$'
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
      call clear
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
        posicionar 14,20
        write letPA
        posicionar 15,20
        write letSalir
        JMP elegir
        
        INICIO2:
        JMP INICIO
        elegir:
        call showMouse
        pulsar:
        call mouseIz
        CMP BX, 1
        Jne pulsar
        mov bl,0h
       
       convertC cordX, cordY ; convierte las coordenadas y
                       ; los valores se guardan en cordX  y cordY  
          CMP cordY,8
          je vocales
            CMP cordX,20
            JE opc
            jmp pulsar ;; prum
          vocales:
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
          jmp pulsar
          opc:
          ;CMP cordX,20
          ;JNE pulsar
          CMP cordY, 14
          JE INICIO2
          CMP cordY, 15
          JE salir2
          JMP pulsar
          A:
          mov vocal,'a'
          mov color,14
          mov valAr,0
          JMP iniScan
          E:
          mov vocal,'e'
          mov color,12
          mov valAr,1
          JMP iniScan
          I:
          mov vocal,'i'
          mov color,11
          mov valAr,2
          JMP iniScan
          O:
          mov vocal,'o'
          mov color,10
          mov valAr,3
          JMP iniScan
          U:
          mov vocal,'u'
          mov color,13
          mov valAr,4
          JMP iniScan
          pulsar2:
          jmp pulsar
          salir2:
          jmp salir
         iniScan:
          MOV AL, vocal
        ;MOV val,0620h
        MOV val, 1
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
        MOV cadena[di],'.'
        ;add BX,1
        position 0620h
        SUB contador, CL
        mov cl, contador
        add contador,19
        posicionar 6,contador
        impCaracter vocal, color
        add val,1
        position 0920h
        ;add val,30h
        ;MOV si,0
        ;mov si, valAr
        ;MOV array[si],val
        ;write val
        
        JMP scan
        
        salir:
        call clear
        .exit  
        RET
        
        main endp
END main
        
