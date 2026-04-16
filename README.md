# Practica 1 Digital 1

## Integrantes:
- Mateo Echavarria Perez
- Juan Sebastian Mejia Ortiz

## Descripcion general de la practica:
En esta practica se hicieron los ejercicios de la guia que proponian realizar trabajos para aprender
sobre diseno de circuitos digitales utilizando SystemVerilog para este fin,
de esta forma implementando en una tarjeta FPGA DE10Lite no solo una de las compuertas que se
implementaron por simulacion en ngspice de la practica pasada, sino tambien creacion de un sistema
combinacional considerablemente mas complejo.
Este hace uso de un ALU con operaciones completamente personalizadas, una ROM que de igual forma
es unica para el grupo de trabajo y un decodificador para que se pueda visualizar la informacion
de forma simple y comprensible.

### Tabla de Operaciones del ALU
| SEL[2:0] | Operacion ALU |
| :--- | :---: |
| 000 | S = A + B |
| 001 | S = A - B |
| 010 | S = B - 1 |
| 011 | S = A and B |
| 100 | S = A or B |
| 101 | S = A xor B |
| 110 | S = A << 1 |
| 111 | S = A << 2 |

### Tabla de datos en la ROM
| ADDR[2:0] | Dato ROM - Hexadecimal |
| :--- | :---: |
| 000 | 2 |
| 001 | 7 |
| 010 | 6 |
| 011 | 0 |
| 100 | F |
| 101 | A |
| 110 | 8 |
| 111 | 9 |
