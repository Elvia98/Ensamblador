;GERONIMO APARICIO ELVIA
; LEE una cadena,Y PINTA LAS VOLCALES QUE EL USUARIO ELIJE 

.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa una cadena: '),0AH,0DH,'$'
    letrero2 DB ('Presiona la vocal a escanear: '),0AH,0DH,'$'
    letreroV DB ('abcdefghijklm'),0AH,0DH,'$'
    letSalir DB ('1.-Clic en "1", para salir'),0AH,0DH,'$'
    vocal DB ('?'),'$'
    ;color DB ('?'),'$'
    cadena DB 10 DUP (' '),'$'
    ;longN EQU $-cadena
    array Dw 10 DUP (' '),'$'
    longN EQU $-array
    val Dw (0),'$'
    valAr Dw (0),'$'
    letrero4 DB ('El caracter esta en la posicion:'),'$'
    letPA DB ('2.- Ingresar nueva cadena'),'$'
    color DB ('?'),'$'
    contador   DB ('?'),'$'
    cordX Db 0,'$'
    cordY Db 0,'$'
    letAbe DB ('abcdefghijklmnopqrstuvwxyz'),'$'
    contLet   DB ('?'),'$'
.CODE

      main PROC FAR
      
      MOV AX, @DATA
      MOV ds,AX
      MOV ES,AX
      
      INICIO:
      call clear
      mov array,0
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
        write letAbe
        posicionar 14,20
        write letPA
        posicionar 15,20
        write letSalir
        JMP elegir
        
        INICIO2:
        JMP INICIO
        elegir:
        call showMouse
        mov si, 0h
        mov al,61h
     
          
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
            opc:
          CMP cordY, 14
          JE INICIO2
          CMP cordY, 15
          JE salir2
          JMP pulsar
          vocales:; ..............................
          cmp cordX, 46
            ja pulsar
          cmp cordX, 20
            jb pulsar
           
            ;position 0102h
            ;write cordX
            mov vocal,23h
            ;write vocal
        mov bl, cordX
        add bl, 77
        mov vocal,bl ;arreAbe[bl]
        ;write vocal
        ;sub bl,95
        cmp bl,112
        je igual
        jmp abe
        igual: mov bl,100
       ;write vocal
      abe: 
      sub bl,95
       mov color,bl    
        JMP iniScan  
          pulsar2:
          jmp pulsar
          salir2:
          jmp salir
         iniScan:
         ;mov ax,0h
          MOV AL, vocal
        
        mov si,0h
        mov cx,0h
        mov di,0h
        mov contLet,0
        mov contLet,30h
        scan:                  ;Scanear caracter en la cadena 
        MOV DI,OFFSET cadena
        MOV contador, 10  
        mov cx,LENGTH cadena 
        cld                    ; direcci?n = avance
        repne scasb            ; repite mientras no sea igual
        jnz posiciones;notfound              ; termina si no se encontr? la letra
        DEC DI
        sub di,67h
        ;mov si,offset valAr
        MOV cadena[di],'.'
        add di,31h
        mov array[si],di ; di es la posicion en donde se encontro el caracter
        ;add BX,1   ;acuerdate de limpiar el arreglo despues de imprimir 
        add si,1h
        ;position 0620h
        SUB contador, CL
        mov cl, contador
        add contador,19
        posicionar 6,contador
        impCaracter vocal, color
        add contador, 20h
        inc contLet
        ;position 0920h
        ;sub contador,3h
        ;write contador 
        JMP scan
        pulsar3:
        jmp pulsar2
        
        posiciones: 
        posicionar 9,25h
        write array; recorrer el arreglo y poner el signo que no se ve nada..........................................
        mov cx,LENGTH array
        mov val,Cx
        add val,30h
        posicionar 12,25h
        write contLet
        MOV SI, 0H
        reArray: MOV array[SI],''
          INC SI
           CMP SI,9
           JE pulsar3
          JMP reArray
        ;mov array, 0
          jmp pulsar2  ;   
      
        
        salir:
        call clear
        .exit  
        RET
        
        main endp
END main
        
