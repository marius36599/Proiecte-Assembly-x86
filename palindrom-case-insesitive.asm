;Bica Marius Adrian, grupa 1013 C, anul I CSIE
;Programul verifica daca un sir introdus este palindrom indiferent de case(case insensitive) 

.model small
.stack 200h
 
.data
    nr db 50,10
    mesaj db 13,10,'Introduceti sirul de caractere(maxim 50 caractere):$'
    mesaj_nu db 13,10,'Sirul nu este palindrom!$'
    mesaj_da db 13,10,'Sirul este palindrom!$'
	mesaj_final db 13,10,'Apasa enter pt a introduce alt sir sau orice alta tasta pt a inchide programul$'
	
.code

     afisare :
           mov ax,@data
		   mov ds,ax
		   mov ah,9
           mov dx,offset mesaj
           int 21h 

     citeste macro name
           mov ah,0ah
           mov dx,offset name
           int 21h	
	       endm
	
     startagain:
           mov ax,@data
		   mov ds,ax
		   
           citeste nr
		   
           mov si,1
           mov cl,nr[si] ; incarc in CL numarul de cifre al numarului introdus
           mov ch,0
           mov ax,cx
           mov bl,2
           div bl ; in AL este catul impartirii lui AX la 2
           mov ah,0
           inc ax
           inc cx
           mov di,cx
		   inc si
		   inc di
		   
   
	verificare :
	       cmp nr[si],61h
		   jb gata_verificarea
		   cmp nr[si],7Ah
		   ja gata_verificarea
		   
		   sub nr[si],20h
		   jmp gata_verificarea
	   
		   
    palindrom proc
           inc si ; SI creste de la inceputul sirului spre mijloc
           mov bl,nr[di]
		   cmp nr[si],bl
           jne nu_este
           dec di ; DI scade de la sfarsitul sirului spre mijloc
           cmp si,ax ; in sir se va merge pana la pozitia cl+1
           jne palindrom
           mov ah,9
		   mov dx, offset mesaj_da
		   int 21h
           jmp sfarsit	
		   endp

		   
	gata_verificarea :
	       inc si
		   cmp si,di
		   jne verificare
		   mov si,1
		   dec di
		   call palindrom
		   
	   
	 nu_este:   
           mov ah,9
           mov dx,offset mesaj_nu
           int 21h
		   
			
   sfarsit :
           mov ah,9
           mov dx,offset mesaj_final
           int 21h	
		   mov ah,1
		   int 21h
		   cmp al,13
		   je startagain
           mov ah,4ch
           int 21h ; stop program
		   
END 