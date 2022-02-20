
      .data 
list1: .word  3, 7, 1, -2, 6   	#dizi olu�turdum ,de�erleri att�m
size1: .word  5			#dizi boyutunu yine diziye att�m
list2: .word  2, 6, 8, 5, 7, 9
size2: .word  6
c�kt�: .word  0
      .text
      la   $t0, list1  		#dizinin ba�lang�� adresini att�m 
      la   $t1, list2
      la   $t4, size1   	#dizinin boyutunu tutan de�i�kenin adresini att�m
      la   $t5, size2
      lw   $t4, 0($t4)	        #dizinin boyutunu att�m 
      lw   $t5, 0($t5)
      
      bge  $t5, $t4, E	        #ko�ullu ifade ile loop  i�inde
      move $t6, $t4             #ne kadar d�nece�ini tuttum
      j    loop
E:    move $t6, $t5
 
loop: blez $t4, A   	        #d�ng�m�z i�in ko�ul
      addi $t4, $t4, -1         #d�ng�y� 1 azaltt�k
      lw   $t9, 0($t0)          #de�erimizi t9'a att�k
      add  $t7,$t7, $t9         #t7 i�ine d�n�� de�erlerimizi toplad�m
      addi $t0, $t0, 4	        #adresi 4 artt�rd�k
A:    blez $t5, B        
      addi $t5, $t5, -1
      lw   $t9, 0($t1)
      add  $t8,$t8, $t9   
      addi $t1, $t1, 4
B:    addi $t6, $t6, -1
      bgtz $t6, loop
      
      bgtz $t8,P
      sub  $t8, $0,  $t8	#e�er 2. dizi sonucu eksi ise onu eksiledim ��karma i�in     
P:    sub  $t8, $t7, $t8
      mul  $t8, $t8, $t8	#ve farklar�n�n �arp�m�n� ald�m
      
      la   $a0, list1		#print fonksyonuna yollamak i�in verileri tzeledim
      la   $a1, list2
      la   $a2, size1       
      la   $a3, size2
      lw   $a2, 0($a2)	  
      lw   $a3, 0($a3)
      jal  print1
      li   $v0, 10
      jal  print2
      li   $v0, 10
      la   $a0, c�kt�		#sonucu yollamak i�in c�kt� de�ikenin
      lw   $a0, 0($a0)		#adresini ve de�erini a0'a y�kledik
      add  $a0, $a0, $t8 
      
      jal  print3
      li   $v0, 10
      syscall	
      .data 
space:.asciiz  " "         
head: .asciiz  " 1. dizimiz : \n"
head1: .asciiz "\n 2. dizimiz : \n"
body: .asciiz  "\n sonuc : \n"
      .text 
 
print1:move  $t0, $a0		#dizi ba�lang�� adresi
       move  $t4, $a2		#dizi boyutu adresi     	
      
       la    $a0, head		#head i�indeki stringi yazd�r    
       li    $v0, 4
       syscall 
     
 
out1:  lw   $a0, 0($t0)         #dizi indisteki de�eri yazd�r
       li   $v0, 1              
       syscall                  
    
       la   $a0, space          #space'te yazan stringi yazd�r 
       li   $v0, 4              
       syscall                  
 
       addi $t0, $t0, 4         #dizimizin adresini 4 artt�r 
       addi $t4, $t4, -1        #d�ng�y� 1 azalt  
       bgtz $t4, out1           
       jr   $ra                 #d�n��
      
      
print2:move $t1, $a1 	
       move $t5, $a3 
       
       la   $a0, head1    
       li   $v0, 4
       syscall      
 
out2:  lw   $a0, 0($t1)      
       li   $v0, 1           
       syscall                
    
       la   $a0, space        
       li   $v0, 4            
       syscall               
 
       addi $t1, $t1, 4       
       addi $t5, $t5, -1      
       bgtz $t5, out2          
       jr   $ra       
print3:move $t8, $a0
 
       la   $a0, body    
       li   $v0, 4
       syscall
       
       la   $a0, 0($t8)      
       li   $v0, 1           
       syscall
       jr   $ra   
