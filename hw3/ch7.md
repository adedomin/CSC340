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

Chapter 7
---------

### 11) 7. Describe a situation in which the add operator in a programming language would not be commutative.

Suppose you have a function, $f1()$ that takes an address of a variable, $a$.
Suppose you have a statement like $b = a + f1(\&a)$ or $b = f1(\&a) + a$
If $f1$ modifies its input and depending on which part of the addition statement is evaluated first, it is possible for there to be two different outcomes.

Because either of the above statements may have different outcomes, the addition is not commutative.

### 12) 8. Describe a situation in which the add operator in a programming language would not be associative. 

Similar to above, consider two statements:

$c = (a + b) + f1(\&a)$
$c = a + (b + f1(\&a))$

Both should be equivalent, but due to the potential functional side effects from $f1$, order of evaluation can change the results.

### 13) 9. 

a. $(((a * b)^{1} - 1)^{2} + c)^{3}$
b. $(((a * (b - 1)^{1})^{2} / c)^{3}\: mod\: d)^{4}$
c. $(((a - b)^{1} / c)^{6} \& ((((d * e)^{3} / a)^{4} - 3)^{5})^{2})^{7}$
d. $((-a)^{1}\: or\: ((c = d)^{2}\: and\: e)^{3})^{4}$
e. $(((a > b)^{1}\: xor\: c)^{3}\: or\: (d <= 17)^{2})^{4}$
f. $(-(a + b)^{1})^{2}$

### 14) 10.

a. $(a * (b - (1 + c)))$
b. $(a * ((b - 1) / (c\: mod\: d)))$
c. $((a - b) / (c \& ((d * (e / (a - 3))))))$
d. $(-(a\: or\: (c = (d\: and\: e))))]$
e. $(a > (b\: xor\: (c\: or\: (d <= 17))))$
f. $(-(a + b))$

### 15) 13.

```c
	int fun(int *k) {
		*k += 4;
		return 3 * (*k) - 1;
	}

	// Suppose fun is used in a program as follows:
	void main() {
		int i = 10, j = 10, sum1, sum2;
		sum1 = (i / 2) + fun(&i);
		sum2 = fun(&j) + (j / 2);
	}
```

a. 
  * $5 + (3 * (14) - 1) = 46$
  * $(3 * (14) - 1) + (14 / 2) = 48$
b.
  * $(14 / 2) + (3 * 14 - 1) = 48$
  * $(3 * 14 - 1) + 10 / 2 = 46$

### 16) 

```c
	int fun(int *i) {
		*i += 5;
		return 4;
	}

	void main() {
		int x = 3;
		x = x + fun(&x);
	}
```

a. $x = 3 + 4 = 7$
b. $x = 8 + 4 = 12$
