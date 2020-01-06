# assembler-collision-test

nasm -fwin32 main.asm

ld main.obj -lmsvcrt -entry=_main -subsystem=console -o test.exe
