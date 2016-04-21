---
title: Homework 3 CSC340
author:
    - Anthony DeDominic \<dedominica@my.easternct.edu\>
date: \today{}
geometry: margin=3cm
fontfamily: mathpazo
fontsize: 10pt
header-includes:
	- \usepackage{fancyhdr}
	- \pagestyle{fancy}
	- \fancyfoot[L]{HW3 - CSC340}
	- \fancyfoot[C]{}
	- \fancyfoot[R]{\thepage}
---

Chapter 6
---------

### 6) 1. What are the arguments for and against representing Boolean values as single bits in memory?

Some hardware may not support bit by bit reading, especially due to endian differences.
On such systems, it is more efficient then to store a single bit in one whole word length.

### 7) 2. How does a decimal value waste memory space?

They waste memory because every single positional digit requires one word size of byte/s to store.
In most cases, it's cheaper to store these numbers in much cheaper binary representations;
many of these representations are only 4 to 8 bytes long, such as IEEE 745 single or double precision floating numbers.

### 8) 7. What significant justification is there for the -> operator in C and C++? 

Because (*var).someval is obnoxious to type and to look at so they implemented the syntactic sugar that is equivelent to it, the -> operator. So instead of (*var).someval, one could do var->someval.

### 9) Using the IEEE Floating Point Standard 754 format for 32 bit (see Figure 6.1 - (a) on page 248), show the bit string (32 bits) for the binary number "1101.10101".

$$
\begin{aligned}
	0b1101.10101 &= 13.21 \\
	13.21 &= (-1)^{0}\times  (1+frac)\times 2^{pow} \\
	\frac{13.21}{2^{pow}} &= 1+frac \\
	\frac{13.21}{2^{3}} &= 1+frac \\
	13.21 &= 1+(0.65125)\times 2^{3} \\
	exponent &= 3+127 \\
	exponent_{2} &= 0b10000010
\end{aligned}
$$

sign exponent fraction
---- -------- -----------------------
   0 10000010 10100110101110000101001 
---- -------- -----------------------

### 10) Express the 16 bit 2’s complement number 1111 1111 1110 1101 in decimal format

	1111 1111 1110 1101 = -19
	0000 0000 0001 0010 + 1
	0000 0000 0001 0011 = 2^0 + 2^1 + 2^4 = 19
