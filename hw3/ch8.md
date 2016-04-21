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

Chapter 8
---------

### 17)

	k = (j + 13) / 27
	loop:
		if k > 10 then goto out
		k = k + 1
		i = 3 * k - 1
		goto loop
	out: . . .

a. Fortran 95

```fortran
	k = (j + 13) / 27
	do while (k.LE.10)
		k = k + 1
		i = 3 * k - 1
	end do
```


b. Ada

```ada
	while_loop: 
		while k <= 10 loop
			k = k + 1;
			i = 3 * k -1;
		end loop while_loop;
```

c. C

```c
	k = (j + 13) / 27
	while (k <= 10) {
		k = k + 1
		i = 3 * k - 1
	}
```

### 18)

a. Fortran 95

```fortran
	select case (k)

		case (1)
			j = 2 * k - 1
		case (2)
			j = 2 * k - 1
		case (3)
			j = 3 * k + 1
		case (5)
			j = 3 * k + 1
		case (4)
			j = 4 * k - 1
		case (6)
			j = k - 2;
		case (7)
			j = k - 2;
		case (8)
			j = k - 2;
	end select
```

b. Ada

```ada
	case k is
		
		when 1 | 2 =>
			j = 2 * k - 1;
		when 3 | 5 =>
			j = 3 * k + 1;
		when 4 =>
			j = 4 * k - 1;
		when 6 | 7 | 8 =>
			j = k - 2;
	end case;

```

c. C

```c
	switch (k) {

		case 1: case 2: 
			j = 2 * k - 1;
			break;
		case 3: case 5:
			j = 3 * k + 1;
			break;
		case 4:
			j = 4 * k - 1;
			break;
		case 6: case 7: case 8:
			j = k - 2;
			break;
	}
```

### 19) rewrite below using no jumps

```c
	j = -3;
	for (i = 0; i < 3; i++) {
		switch (j + 2) {
			case 3:
			case 2: j--; break;
			case 0: j += 2; break;
			default: j = 0;
		}
		if (j > 0) break;
		j = 3 - i
	}
```

```c
	j = -3
	for (int i=0; j <= 0; j = 3 - i++) {
		if (j + 2 == 3 || j + 2 == 2) {
			j--;
		}
		else if (j + 2 == 0) {
			j += 2;
		}
		else {
			j = 0;
		}
	}
```
