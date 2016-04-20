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

Chapter 5
---------

### 1) 6. Scoping

```javascript
	// The main program
	var x;
	function sub1() {
		var x;
		function sub2() {
			. . .
		}
	}
	function sub3() {
		. . .
	}
	// main -> sub1 -> sub2 -> sub3
	// which X is ref'd?
```

  1. static scoping for
    * sub1 -> the x in sub1
	* sub2 -> the x in sub1
	* sub3 -> the x in main
  2. dynamic scoping for
    * sub1 -> the x in sub1
    * sub2 -> the x in sub1
    * sub3 -> the x in sub1

### 2) 7. Scoping 2

```javascript
	var x;
	function sub1() {
		document.write("x = " + x + "<br />");
	}
	function sub2() {
		var x;
		x = 10;
		sub1();
	}
	x = 5;
	sub2();
```

  1. static: "x = 5"
  2. dynamic: "x = 10"

### 3) 8. Variable Scoping

```javascript
	var x, y, z;
	function sub1() {
		var a, y, z;
		function sub2() {
			var a, b, z;
			. . .
		}
		. . .
	}
	function sub3() {
		var a, x, w;
		. . .
	}
```

visible x y z sub1-a sub1-y sub1-z sub2-a sub2-b sub2-z sub3-a sub3-x sub3-w
------- - - - ------ ------ ------ ------ ------ ------ ------ ------ ------
main    x x x 
sub1    x     x      x      x
sub2    x            x             x      x
sub3      x x                                            x     x      x
------- - - - ------ ------ ------ ------ ------ ------ ------ ------ ------

### 4) 10.

```c
	void fun(void) {
		int a, b, c; /* definition 1 */
		. . .
		while (. . .) {
			int b, c, d; /*definition 2 */
			. . . 1
			while (. . .) {
				int c, d, e; /* definition 3 */
				. . .  2
			}
			. . .  3
		}
		. . .  4
	}
```

visible a b c def2 b def2 c def2 d def3 c def3 d def3 e
------- - - - ------ ------ ------ ------ ------ ------
1       x     x      x      x
2       x     x                    x      x      x
3       x     x      x      x
4       x x x
------- - - - ------ ------ ------ ------ ------ ------

### 5) 11.abc

```c
	void fun1(void);
	void fun2(void);
	void fun3(void);
	int main() {
		int a, b, c;
		. . .
	}

	void fun1(void) {
		int b, c, d;
		. . .
	}
	
	void fun2(void) {
		int c, d, e;
		. . .
	}
	
	void fun3(void) {
		int d, e, f;
		. . .
	}
	// dynamic scoping
```c

a. main calls fun1 -> fun1 calls fun2 -> fun2 calls fun3
b. main calls fun1 -> fun1 calls fun3
c. main calls fun2 -> fun2 calls fun3 -> fun3 calls fun1

visible a b c fun1 b fun1 c fun1 d fun2 c fun2 d fun2 e fun3 d fun3 e fun3 f
------- - - - ------ ------ ------ ------ ------ ------ ------ ------ ------
a       x     x                    x                    x      x      x
b       x     x      x                                  x      x      
c       x     x      x      x      x                           x      x
------- - - - ------ ------ ------ ------ ------ ------ ------ ------ ------
