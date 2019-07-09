; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
;**********************************************
    ; add your code here

main proc far

mov al, 12h
mov ah, 0   ; set graphics video mode.
int 10h   


mov ax, 1   ;shows mouse cursor
int 33h



Next:
call show_cursor
mov cx , 50
loop $

mov ax, 3   ;get cursor positon in cx,dx
int 33h

call hide_cursor

cmp bx , 1
jne Next
  
call putpix ;call procedure 
jmp Next

mov ah,4ch
int 21h
main endp
 
 
;procedure to print
putpix proc   
mov al, 2   ;color of pixel  
mov ah, 0ch    
shr cx,1    ; cx will get double so we divide it by two
int 10h     ; set pixel.
ret
putpix endp 


;******************************************
show_cursor proc
mov ax, 1 
int 33h   

ret
show_cursor endp
;*********************
 
hide_cursor proc
mov ax, 2 
int 33h   

ret
hide_cursor endp 

;*********************
get_pos_stat proc

mov ax , 3
int 33h

ret
get_pos_stat endp
;******************** 


code ends      
   
  ;********************************************** 
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
