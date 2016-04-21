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

Chapter 9
---------

### 20

```c
	void main() { 
		int value = 2, list[5] = {1,3,5,7,9};
		swap(value, list[0]);
		swap(list[0], list[1]];
		swap(value, list[value]);
	}

	void swap(int a, int b) {
		int temp ;
		temp = a;
		a = b;
		b = temp;
	}
```

a. by value

value list[@]   swap-a swap-b swap-temp statement
----- --------- ------ ------ --------- -------------------
2     1,3,5,7,9 N/A    N/A    N/A       initial
2     1,3,5,7,9 2      1      N/A       swap(value,list[0])
2     1,3,5,7,9 2      1      2         temp = a
2     1,3,5,7,9 1      1      2         a = b
2     1,3,5,7,9 1      2      2         b = temp
2     1,3,5,7,9 N/A    N/A    N/A       return
2     1,3,5,7,9 1      3      N/A       swap(list[0],list[1])
2     1,3,5,7,9 1      3      1         temp = a
2     1,3,5,7,9 3      3      1         a = b
2     1,3,5,7,9 3      1      1         b = temp
2     1,3,5,7,9 N/A    N/A    N/A       return
2     1,3,5,7,9 2      5      N/A       swap(value,list[value])
2     1,3,5,7,9 2      5      2         temp = a
2     1,3,5,7,9 5      5      2         a = b
2     1,3,5,7,9 5      2      2         b = temp
2     1,3,5,7,9 N/A    N/A    N/A       return
----- --------- ------ ------ --------- -------------------

b. by reference

value list[@]   swap-a swap-b swap-temp statement
----- --------- ------ ------ --------- -------------------
2     1,3,5,7,9 N/A    N/A    N/A       initial
2     1,3,5,7,9 2      1      N/A       swap(value,list[0])
2     1,3,5,7,9 2      1      2         temp = a
1     1,3,5,7,9 1      1      2         a = b
1     2,3,5,7,9 1      2      2         b = temp
1     2,3,5,7,9 N/A    N/A    N/A       return
1     2,3,5,7,9 2      3      N/A       swap(list[0],list[1])
1     2,3,5,7,9 2      3      2         temp = a
1     3,3,5,7,9 3      3      2         a = b
1     3,2,5,7,9 3      2      2         b = temp
1     3,2,5,7,9 N/A    N/A    N/A       return
1     3,2,5,7,9 1      2      N/A       swap(value,list[value])
1     3,2,5,7,9 1      2      1         temp = a
2     3,2,5,7,9 2      2      1         a = b
1     3,1,5,7,9 2      1      1         b = temp
1     3,1,5,7,9 N/A    N/A    N/A       return
----- --------- ------ ------ --------- -------------------

c. by name

value list[@]   swap-a swap-b swap-temp statement
----- --------- ------ ------ --------- -------------------
2     1,3,5,7,9 N/A    N/A    N/A       initial
2     1,3,5,7,9 2      1      N/A       swap(value,list[0])
2     1,3,5,7,9 2      1      2         temp = a
1     1,3,5,7,9 1      1      2         a = b
1     2,3,5,7,9 1      2      2         b = temp
1     2,3,5,7,9 N/A    N/A    N/A       return
1     2,3,5,7,9 2      3      N/A       swap(list[0],list[1])
1     2,3,5,7,9 2      3      2         temp = a
1     3,3,5,7,9 3      3      2         a = b
1     3,2,5,7,9 3      2      2         b = temp
1     3,2,5,7,9 N/A    N/A    N/A       return
1     3,2,5,7,9 1      2      N/A       swap(value,list[value])
1     3,2,5,7,9 1      2      1         temp = a
2     3,2,5,7,9 2      5[^1]  1         a = b
1     3,2,1,7,9 2      1      1         b = temp
1     3,2,1,7,9 N/A    N/A    N/A       return
----- --------- ------ ------ --------- -------------------

[^1]: note that name passing will mess with arrays indexed with a mutated var.

d. by value result

value list[@]       swap-a swap-b swap-temp statement
----- ------------- ------ ------ --------- -------------------
2     1,3,5,7,9     N/A    N/A    N/A       initial
2     1,3,5,7,9     2      1      N/A       swap(value,list[0])
2     1,3,5,7,9     2      1      2         temp = a
2     1,3,5,7,9     1      1      2         a = b
2     1,3,5,7,9     1      2      2         b = temp
1[^2] 2,3,5,7,9     N/A    N/A    N/A       return
1     2,3,5,7,9     2      3      N/A       swap(list[0],list[1])
1     2,3,5,7,9     2      3      2         temp = a
1     2,3,5,7,9     3      3      2         a = b
1     2,3,5,7,9     3      2      2         b = temp
1     3,2,5,7,9     N/A    N/A    N/A       return
1     3,2,5,7,9     1      2      N/A       swap(value,list[value])
1     3,2,5,7,9     1      2      1         temp = a
1     3,2,5,7,9     2      2      1         a = b
1     3,2,5,7,9     2      1      1         b = temp
2     3,2,1[^3],7,9 N/A    N/A    N/A       return
----- ------------- ------ ------ --------- -------------------

[^2]: value result returns the vaue back up to the parameters from the caller.
[^3]: Aliasing can play a problem here.

### 21

	procedure p(x,y,z)
	int a,b;
	begin
		a := x;
		b := y;
		if x = y then
			z := a+b+z;
		else
			z := a+b - z;
		y := x + z;
	end;

	m := 2; /* main program */
	n := 1;
	p(m,m,n)

a. by value

m   n   p-x p-y p-z p-a p-b stmt
--- --- --- --- --- --- --- ----------
2   N/A N/A N/A N/A N/A N/A m = 2
2   1   N/A N/A N/A N/A N/A n = 1
2   1   2   2   1   N/A N/A p(m,m,n)
2   1   2   2   1   N/A N/A int a,b
2   1   2   2   1   2   N/A a = x
2   1   2   2   1   2   2   b = y
2   1   2   2   5   2   2   z = a+b+z
2   1   N/A N/A N/A N/A N/A return
--- --- --- --- --- --- --- ----------
m = 2, n = 1

b. by reference

m   n   p-x p-y p-z p-a p-b stmt
--- --- --- --- --- --- --- ----------
2   N/A N/A N/A N/A N/A N/A m = 2
2   1   N/A N/A N/A N/A N/A n = 1
2   1   2   2   1   N/A N/A p(m,m,n)
2   1   2   2   1   N/A N/A int a,b
2   1   2   2   1   2   N/A a = x
2   1   2   2   1   2   2   b = y
2   5   2   2   5   2   2   z = a+b+z
2   5   N/A N/A N/A N/A N/A return
--- --- --- --- --- --- --- ----------
m = 2, n = 5

c. by name

m   n   p-x p-y p-z p-a p-b stmt
--- --- --- --- --- --- --- ----------
2   N/A N/A N/A N/A N/A N/A m = 2
2   1   N/A N/A N/A N/A N/A n = 1
2   1   2   2   1   N/A N/A p(m,m,n)
2   1   2   2   1   N/A N/A int a,b
2   1   2   2   1   2   N/A a = x
2   1   2   2   1   2   2   b = y
2   5   2   2   5   2   2   z = a+b+z
2   5   N/A N/A N/A N/A N/A return
--- --- --- --- --- --- --- ----------
m = 2, n = 5

