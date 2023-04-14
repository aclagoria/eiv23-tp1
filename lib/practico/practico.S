/* En este archivo escribirás tu solución.
 * Para ello deberás completar las rutinas en código
 * ensamblador.
 * Puedes usar los registros R0 a R12 pues ya está preservado
 * el valor de los registros que deben mantenerse.
 * Los registros R0 a R3 contienen los argumentos al entrar a
 * la rutina y contendrán el valor devuelto al salir.
 * Si realizas un llamado a subrutina, los registros R0 a R3 y el
 * registro R12 pueden cambiar su valor (y en particular, R0 contiene 
 * normalmente el valor devuelto), los registros R4 a R11 preservan
 * su valor.
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm


/**
 * Sumar dos enteros de 32 bit
 *  suma(2,3) => 5
 * Entrada
 *  a->R0, b->R1 : sumandos, enteros de 32 bit con signo 
 * Salida
 *  R0     : suma, entero de 32 bit con signo
 */
defun suma
    push {r4-r11,lr}
    // Insertar código a continuación
    ADD R0, R1
    // Retorno, antes R0 debe tener el valor correcto
    pop {r4-r11,pc}
endfun suma

/**
 * Sumar los números de un arreglo en memoria de enteros de
 * 32 bit con resultado de 64 bit.
 *
 * sumatoria(5,(uint32_t[]){1,2,3,4,5}) => 15
 *
 * Entrada 
 *  n->R0    : Cantidad de números en registro R0, entero de 32 bit
 *  b->R1    : Dirección en memoria del primer número, puntero a
 *             entero de 32 bit con signo.
 * Salida
 *  R1:R0 : Sumatoria, entero de 64 bit con signo 
 */
defun sumatoria
    push {r4-r11,lr}
    // Insertar código a continuación
    MOV R2, #0 // parte baja
    MOV R3, #0 // parte alta
    MOV R4, #0 // inicio de índice
    
    bucle: CMP R0, R4 // bandera, R0-R4
    BEQ Retorno // salta a retorno si R0=R4 (osea si la bandera Z modif por cmp es igual a 1)
    LDR R5, [R1,R4,lsl #2] //esto sucede si R4<R0 EN R5 guardo el elemento de R1 en la posicion R4 ej si quiero sacar de R1 el valor 3(osea R5=3) R4debe ser 2
    CMP R5,#0 //bandera R5-0
    BLT negativo //R5<0
    ADDS R2, R5 //R2=R2+R5 Y BANDERA C
    MOV R6,0X00000000 //extension de signo de un numero positivo /* R3:R2=R3:R2+R6:R5 */
    ADC R3, R3,R6 //R3=R3+R6+C
    ADD R4, #1 //R4=R4+1
    BAL bucle // saltar siempre a bucle

    negativo: ADDS R2, R5 //R2=R2+R5 Y BANDERA C
    MOV R6, 0XFFFFFFFF// EXTENSION DE SIGNO DE NUMERO NEGATIVO
    ADC R3, R3,R6 //R3=R3+R6+C
    ADD R4, #1 //R4=R4+1
    BAL bucle

    Retorno: MOV R1,R3 //R1=R3
    MOV R0,R2 //R0=R2

    
    // Retorno, antes R1:R0 debe tener el valor correcto
    pop {r4-r11,pc}
endfun sumatoria

/**
 * Encuentra la posicion del máximo elemento de un arreglo
 *
 * posicion_maximo(4,(uint32_t[]){1,4,2,3}) => 1
 *
 * Entrada:
 *  n->R0 : cantidad de números en el arreglo, entero de 32 bit
 *  b->R1 : posición en memoria del primer número, puntero
 *          a entero de 32 bit con signo.
 * Salida:
 *  R0 : posición del máximo elemento en el arreglo, entero
 *       de 32 bit.
 */
defun posicion_maximo
    push {r4-r11,lr}
    // Insertar código a continuación
    MOV R2, #0 //primer índice
    CMP R0, #1 //bandera R0-1 
    BLE Retornar // salta a retornar si R0 es menor o igual a 1 (con signo)
    LDR R3, [R1,R2,LSL #2] // en R3 guardo el elemento de R1 en la posicion R2 ej si quiero sacar de R1 el valor 3(osea R3=3) R2 debe ser 3
    MOV R4, #1 //segundo índice
    Bucle: CMP R4, R0 // bandera, R4-R0
    BEQ Retornar // si R0=R4 salta a retornar
    LDR R5,[R1,R4,LSL #2] 
    CMP R3,R5
    BLT menor // si R3<R5 salta a menor
    IncrementarR4: ADD R4, #1
    BAL Bucle
    menor:
    MOV R3, R5
    MOV R2, R4
    BAL IncrementarR4

    Retornar: MOV R0, R2


    // Retorno, antes R0 debe tener el valor correcto
    pop {r4-r11,pc}
endfun posicion_maximo

/**
 * Ordenar de menor a mayor un arreglo de números en memoria.
 * La ordenación es en el lugar, sobreescribiendo el arreglo
 * original.
 *
 * uint32_t vals[]={4,1,3,5,2,6,7};
 * ordenar_en_sitio_menor_a_mayor(7,vals)
 * luego vals contendrá {1,2,3,4,5,6,7}
 *
 * Entrada:
 *  n->R0 : Cantidad de números en el arreglo, entero de 32 bit
 *  b->R1 : Dirección del primer número, puntero a entero de
 *          32 bit con signo.
 * Salida:
 *  Sin valor de salida. El arreglo dado debe haber sido ordenado
 *  sobreescribiendo los valores originales.
 */
defun ordenar_en_sitio_menor_a_mayor
    push {r4-r11,lr}
    // Insertar código a continuación

    // Retorno
    pop {r4-r11,pc}
endfun ordenar_en_sitio_menor_a_mayor
