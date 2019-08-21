.model small
.stack 50
.data 
  tb1 db 'Nhap so A: $'
  tb2 db 10,13,'Nhap so B: $' 
  tb3 db 10,13,'A*B= $'
  tb4 db 10,13,'A/B= $' 
  tb5 db ' du: $' 
  nhan10 dw 10  
  so dw 0
  s1 dw 0
  s2 dw 0 
  kq dw 0  
  sodu dw 0
.code   
  tbao macro tb
    lea dx,tb
    mov ah,9
    int 21h
  tbao endm
 
  main proc
    mov ax,@data
    mov ds,ax 
    
    tbao tb1
    call nhapso   
    mov s1,ax
    tbao tb2
    call nhapso
    mov s2,ax
   ;A * B   
    mov ax,s1 
    mov cx,s2
    dec cx
   Nhan:
    add ax,s1
    mov kq,ax
    loop Nhan

    tbao tb3   
    mov ax,kq
    call Hienthi  
    
    tbao tb4
    mov ax,s1 
    xor bx,bx
   Chia:
    cmp ax,s2
    jl Du 
    sub ax,s2 
    inc bx
    jmp Chia 
   Du: 
    mov sodu,ax  
    mov ax,bx
    call Hienthi  
    
    cmp sodu,0
    je Exit 
    tbao tb5
    mov ax,sodu
    call Hienthi
    
   Exit:
    mov ah,4ch
    int 21h 
  main endp
   nhapso proc 
    xor ax,ax
    nhap:
    mov ah,1
    int 21h
    cmp al,13
    je thoatnhap
    sub al,30h
    xor bx,bx
    mov bl,al
    mov ax,so
    mul nhan10
    add ax,bx
    mov so,ax
    jmp nhap
    thoatnhap:
    mov ax,so 
    mov so,0
    ret
  nhapso endp  
   Hienthi proc
    mov bx,10
    xor cx,cx
   Lap:
    xor dx,dx
    div bx
    add dx,30h
    push dx
    inc cx
    cmp ax,0
    jne Lap
   Xuat:
    pop dx
    mov ah,2
    int 21h
    loop Xuat 
   ret
   Hienthi endp
end main  