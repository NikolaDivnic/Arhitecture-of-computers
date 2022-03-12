! inicijalizacija simulacije
dc x.1, x.9996
dc x.0, x.9998
onkp false, x.1, x.1
onkp false, x.1, x.1
onkp true, x.1, x.1
ondma x.1, x.1
ondma x.1, x.1
ondma x.1, x.1
ondma x.1, x.1
kpreg 1.1, r0, x.1
kpreg 1.1, r1, x.2
kpreg 1.1, r2, x.3
kpreg 1.1, r3, x.4
kpreg 1.1, r4, x.5
kpreg 1.1, r5, x.6
kpreg 1.1, r6, x.7
kpreg 1.1, r7, x.8
kpreg 2.1, r0, x.9
kpreg 2.1, r1, x.a
kpreg 2.1, r2, x.b
kpreg 2.1, r3, x.c
kpreg 2.1, r4, x.d
kpreg 2.1, r5, x.e
kpreg 2.1, r6, x.f
kpreg 2.1, r7, x.10
reg pc, x.4000
reg ivtp, x.4000
reg sp, x.9000
! kraj inicijalizacije

org x.4000
intd 
ldimm x.100, r0

mvrir r0, ivtp 
ldimm x.500, r0
stmem x.105, r0

ldimm x.1000, r0
stmem x.104, r0

ldimm x.1500, r0
stmem x.103, r0

ldimm x.2000, r0
stmem x.102, r0

ldimm x.2500, r0
stmem x.101, r0

ldimm x.3000, r0
stmem x.100, r0
ldimm x.5, r3 
stmem x.f102, r3
inte
ldimm x.6000, r0 
ldimm x.8, r1
ldimm x.5, r3
stmem x.f200, r3


ldimm x.5000, r4 
ldimm x.9, r5

ldimm x.f, r3 
clr ra 
stmem x.f100, r3

ldimm x.1, r3 
loop1: ldmem x.f201, rc
	and rc, rc, r3 
	beql loop1 
	ldmem x.f203, r7 
	stri [r0], r7 
	inc r0 
	dec r1 
	bneq loop1

clr r0
stmem x.f200, r0

ldimm x.1, r3 
wait1: and ra, ra, r3
	beql wait1





!drugi deo


ldimm x.9996, re
push re
ldimm x.8, re
push re
ldimm x.5000, re
push re
jsr process

ldimm x.9998, re
push re
ldimm x.8, re
push re
ldimm x.6000, re
push re
jsr process





! kraj drugog dela



! pocetak treceg dela

ldimm x.8, r1
stmem x.F004, r1
ldimm x.5000, r1
stmem x.F005, r1
ldimm x.3, r1
stmem x.f002, r1
ldimm x.ff ,r1
stmem x.f000, r1

clr r0


ldimm x.1, r3 
wait2: and r0, r0, r3
	beql wait2



ldimm x.1, r1
stmem x.F044, r1
ldimm x.9999, r1
stmem x.F046, r1
ldimm x.1, r1
stmem x.f042, r1
ldimm x.7e ,r1
stmem x.f040, r1

clr r0


ldimm x.1, r3 
wait3: and r0, r0, r3
	beql wait3





! kraj treceg dela



halt

process:
	pop r7
	pop ra
	pop rc
	pop re
	ldrid [re]x.0,rd
	push re
	push rc
	push ra
	push r7
	ldimm x.1, rb
	and rd,rd,rb
	beql min
	bneq max
	rts

max:
	pop r7
	pop re !request 
	pop rd !velicina niza
	pop rc !adresa niza
	ldrid [rc]x.0, ra 
	loop2:
		inc rc 
		dec rd 
		beql izadji 
		ldrid [rc]x.0, rb
		cmp ra, rb
		blss promena 
		jmp loop2

	rts

min:
	pop r7
	pop re
	pop rd
	pop rc
	ldrid [rc]x.0, ra 
	loop3:
		inc rc
		dec rd 
		beql izadji 
		ldrid [rc]x.0, rb
		cmp rb, ra
		blss promena2 
		jmp loop3 
	rts

promena:
	mvrrl ra, rb 
	jmp loop2

promena2:
	mvrrl ra, rb 
	jmp loop3
izadji:
	inc re
	push r7
	stri [re], ra
	rts


!prekid prvi
org x.500
dec r5 
bneq prenos
stmem x.f100, r5 
ldimm x.1, ra 
jmp back
prenos:
	ldmem x.f103, rb 
	stri [r4], rb
	inc r4
back:
rti



!treca prekidna rutina

org x.2000
ldimm x.1, r0
ldimm x.0, rf
stmem x.f000,rf 
rti

org x.2500
ldimm x.1, r0
ldimm x.0, rf
stmem x.f040,rf 
rti