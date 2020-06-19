;GERONIMO APARICIO ELVIA
; LEE E IMPRIME DOS CADENAS EN PANTALLA, y pinta la letra en donde hayan sio diferentes
.MODEL SMALL
include Library.lib
  
.STACK

.DATA
    letrero DB ('Ingresa una cadena: '),'$'
    letrero2 DB ('Ingresa otra cadena: '),'$'
    letrero3 DB ('Las cadenas son: '),'$'
    letrero5 DB ('Se imprimen ambas cadenas: '),'$'
    letPedir DB ('1.- INGRESAR CADENAS'),'$'
    letSalir DB ('2.- SALIR'),'$'
    letDiferentes DB ('* DIFERENTES *'),'$'
    letIguales DB ('* IGUALES *'),'$'
    nombre DB 15 DUP (' '),'$'
    longN EQU $-nombre
    nombre2 DB 15 DUP (' '),'$'
    longN2 EQU $-nombre
    val DB (''),'$'
    val2 DB (''),'$'
    color DB (''),'$'
    contador   DW ('?'),'$'
    cordX Db 0,'$'
    cordY Db 0,'$'
    
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

        saveString nombre;Guarda la cadena en nombre
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
           CMP SI,13
           JE salir
           JMP CiNombre2
        salir:
        position 0720h
        write letrero3
        position 0920h
        write nombre
        posicionar 10, 20h
        write nombre2 
        MOV val2, 15
        
        compararCadenas: ;Compara ambas cadenas
        mov contador,15
        MOV CX,longN
        LEA SI,nombre2 
        LEA DI,nombre  
        REP CMPSB  
  
        CMP CX,0 
        JE same; cadenas inguales
        JMP difer
    
    same:
        posicionar 13, 20h
        write letIguales
        JMP mouse
   difer:
        sub contador, CX
        sub val2, CL
        mov DI,contador
        mov DL, nombre2[DI]
        mov val, DL
        add val2,20h
        posicionar 10,val2
        impCaracter val, 13
        posicionar 12, 20h
        write letDiferentes
   mouse:
        posicionar 20,01h
        write letPedir
        posicionar 21, 01h
        write letSalir
        call showMouse
  pulsar:
        call mouseIz
        CMP BX, 1
        Jne pulsar
        mov bl,0h
        convertC cordX, cordY
        CMP cordY,20
         JE pedir
         CMP cordY,21
           JE salte
            jmp pulsar
    INICIO2:jmp INICIO
   pedir:
       CMP cordX, 20
        JA pulsar
       CMP cordX, 1
        JB pulsar
    limpCad1:
    MOV SI, 0H
          reArray: MOV nombre[SI],''
          INC SI
          CMP SI,14
           JE sigue
          JMP reArray
    sigue:
          MOV SI, 0H
          reArray2: MOV nombre2[SI],''
          INC SI
          CMP SI,14
           JE INICIO2
           JMP reArray2
       JMP INICIO
   salte:
       CMP cordX, 9
        JA pulsar ; si es mayor que 
       CMP cordX, 1
        JB pulsar ; si es menor que 
   salir2:
        call clear
        .exit  
        RET
        
        main endp
END main