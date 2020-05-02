;elvia

.286

include Libreria.lib
IMPcarac MACRO caden,col
    MOV AH,09h
    MOV AL,caden
    MOV BH,0 
    MOV BL,col
    MOV CX,1
    INT 10h
    
    INC SI
ENDM
PINTB MACRO C,L
    MOV AX,0600H
        MOV BH,35H
        MOV CL,C;x1
        MOV DL,C;x2            
        MOV CH,L;y1
        MOV DH,L;y2
        INT 10H
ENDM
PRINTCAR MACRO caracter
    MOV AH,02H
    ;ADD caracter,30H
    MOV DL,caracter
    INT 21H
ENDM
pintarRenglon macro color, y
    mov ah, 06
    mov al, 00
    ;mov bh, 00000010b
    mov bh, color
    mov ch, y
    mov cl, 0
    mov dl, 79
    mov dh, y
    int 10h
endm

RELLENAR MACRO cadena
    LOCAL llenar
    LOCAL salir
    MOV SI,0
    
    llenar:
    MOV AH,01H
    INT 21H
    CMP AL,0DH
    
    JE salir
    MOV cadena[SI],AL
    INC SI
    CMP SI,10
    JE salir
    JMP llenar
    
    salir:
    write buf
ENDM

LIMITE MACRO X1,X2,Y1,Y2
    LOCAL falla
    LOCAL salte
    
        CMP CX,X1
        JB falla;<
        CMP CX,X2
        JA falla;>
        CMP DX,Y1
        JB falla;<
        CMP DX,Y2
        JA falla;>
        MOV AH,01H
        JMP salte
        falla:
        MOV AH,00H
        salte:
        CMP AH,1
ENDM

PILA SEGMENT Stack
    DB 32 DUP('Stack')
PILA ENDS

DATOS SEGMENT
    leerCad DB 'Leer una cadena:','$'
    letSal DB 'Salir:','$'
    letLeer DB 'Leer una cadena:','$'
    letSalir DB 'Salir',0AH,0DH,'$'
    let DB 'Elija caracteres:',0AH,0DH,'$'
    let2 DB 'k2:',0AH,0DH,'$'
    let3 DB 'h3',0AH,0DH,'$'
    let4 DB 'h4',0AH,0DH,'$'
    color DB 5,'$'
    
    buf DB 0AH,0DH,'$'
  
    opcion   DB('?')
    opcionMEN DB ('?')
    tecla DB('?')
    
    cadena1 DB 10 DUP (' '),'$'
    cadena2 DB 10 DUP (' '),'$'
    cadena3 DB 10 DUP (' '),'$'
    cadena4 DB 10 DUP (' '),'$'
    cadena5 DB 10 DUP (' '),'$'
    
    ;val   DB 2 DUP (' '),'$'   ;DB 0,0,24H
    val DB '$'
DATOS ENDS

CODIGO SEGMENT 'CODE'
    ASSUME SS:PILA, DS:DATOS, CS:CODIGO
    
    MAIN PROC FAR
    inicio ;MACRO DE INICIO
    MENU:
    posicionar 6,30
    write leerCad
    posicionar 8,30
    write letSal
     
    IC:
         CALL mostrarRaton
         LIMITE 240,368,48,56
         JE ITERACION
         LIMITE 240,280,64,72
         JE sal1
         JMP IC
    ITERACION:   call limpiarP         
    posicionar 0,20 ;MACRO PARA POSICIONAR  1eH
    write letLeer ;MACRO PARA MOSTRAR LETRERO  
    posicionar 15,30 ;MACRO PARA POSICIONAR  1eH
    write letSalir 
    posicionar 2,20
    RELLENAR cadena1
    jmp ITE
    sal1:
    jmp SALI
    ITE:     call mostrarRaton
    LIMITE 160,168,16,24
    JE Opc1
    LIMITE 168,176,16,24
    JE Opc2
    LIMITE 176,184,16,24
    JE Opc3
    jmp IT1
        Opc1:
        jmp Opc11
        Opc2:
        jmp Opc22
        IT1:
    LIMITE 184,192,16,24
    JE Opc4
    LIMITE 192,200,16,24
    JE Opc5
    LIMITE 200,208,16,24
    JE Opc6
    jmp IT2
        Opc3:
        jmp Opc33
        Opc4:
        jmp Opc44
        IT2:
    LIMITE 208,216,16,24
    JE Opc7
    LIMITE 216,224,16,24
    JE Opc8
    jmp IT3
        Opc5:
        jmp Opc55
        Opc6:
        jmp Opc66
        IT3:
    LIMITE 224,232,16,24
    Je opc9  
    LIMITE 240,280,120,128
    Je SALI   
    jmp ITEr
    SALI:
    jmp SALIR
    ITEr:
    jmp IT4
    Opc7:
    jmp Opc77
    IT4:
    JMP ITE    
    CALL limpiarP    
    SALIR:    CALL limpiarP
    RET
    Opc11:
    call opci1
    Opc22:
    call opci2
    Opc33:
    call opci3
    Opc44:
    call opci4    
    Opc55:
    call opci5
    Opc66:
    call opci6
    Opc77:
    call opci7
    Opc8:
    call opci8
      Opc9:
      call opci9
      Opc10:
      call opci10
      JMP ITE
    RET
    MAIN ENDP
    empezarRaton proc near
        mov ax,00
        int 33h
        ret
    empezarRaton endp

    mostrarRaton proc near
        cursor:
         MOV AX,01H
         INT 33H
         MOV AX,03H
         INT 33H
    
         CMP BX,1
         JNZ cursor
        ret
    mostrarRaton endp  
    opci1 proc near
    posicionar 2,20
    IMPcarac cadena1[0],color
      posicionar 4,20
     IMPcarac cadena1[0],color
      JMP ITE
    opci1 endp
    
    opci2 proc near
    posicionar 2,21
    IMPcarac cadena1[1],color
   posicionar 4,21
      IMPcarac cadena1[1],color
      JMP ITE
      opci2 endp
      
      opci3 proc near
      posicionar 2,22
      IMPcarac cadena1[2],color
      posicionar 4,22
      IMPcarac cadena1[2],color
      JMP ITE
      opci3 endp
      
      opci4 proc near
      posicionar 2,23
      IMPcarac cadena1[3],color
      posicionar 4,23
      IMPcarac cadena1[3],color
      JMP ITE
      opci4 endp
      
      opci5 proc near
      posicionar 2,24
      IMPcarac cadena1[4],color
      posicionar 4,24
      IMPcarac cadena1[4],color
      JMP ITE
      opci5 endp
      
      opci6 proc near
      posicionar 2,25
      IMPcarac cadena1[5],color
      posicionar 4,25
      IMPcarac cadena1[5],color
      JMP ITE
      opci6 endp
      
      opci7 proc near
      posicionar 2,26
      IMPcarac cadena1[6],color
      posicionar 4,26
      IMPcarac cadena1[6],color
      JMP ITE
      opci7 endp
      
      opci8 proc near
      posicionar 2,27
      IMPcarac cadena1[7],color
      posicionar 4,27
      IMPcarac cadena1[7],color
      JMP ITE
      opci8 endp
      
      opci9 proc near
      posicionar 2,28
      IMPcarac cadena1[8],color
      posicionar 4,28
      IMPcarac cadena1[8],color
      JMP ITE
      opci9 endp
      
      opci10 proc near
      posicionar 2,29
      IMPcarac cadena1[9],color
      posicionar 4,29
      IMPcarac cadena1[9],color
      JMP ITE
      opci10 endp
      
CODIGO ENDS
END MAIN
