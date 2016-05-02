---
title: Node.js and Javascript
author: Anthony DeDominic \<<dedominica@my.easternct.edu>\>
institute: Eastern Connecticut State University
abstract: |
	Javascript is one of the only ways to give users a dynamic experience on the web.
	Though many seem to hate it, it's design allows for a efficient and unique way to handle I/O and request driven services.
	In order to bring these benefits to software outside of the web, Node.js was made.
	It is a framework for running javascript code in the backend.
	This paper will focus on the benefits of javascript, talk about asynchronous I/O and compare it to other scripting languages.
date: \today{}

geometry: margin=3cm
fontfamily: mathpazo
fontsize: 10pt
header-includes:
- \hyphenpenalty 10000
- \usepackage{fancyhdr}
- \pagestyle{fancy}
- \fancyfoot[L]{Asynchronous Programming - DeDominic}
- \fancyfoot[C]{}
- \fancyfoot[R]{\thepage}
- \twocolumn

link-citations: Yes
references:
- id: node-docs
  issued:
  - year: 2016
  title: Node.js v6.0.0 Documentation
  URL: https://nodejs.org/api/cluster.html
	
- id: node-about
  title: About Node.js
  issued:
  - year: 2016
  URL: https://nodejs.org/en/about/
	
- id: slaks-async
  title: Concurrency, part 1 Parallelism, Asynchrony, and Multi-threading Explained
  author: 
  - family: Laks
	given: Schabse
  issued: 
  - year: 2014
  URL: http://blog.slaks.net/2014-12-23/parallelism-async-threading-explained/

- id: w3-serverstat
  title: Usage of web servers broken down by ranking
  issued:
  - year: 2015
  URL: http://w3techs.com/technologies/cross/web_server/ranking

- id: seastar
  title: Seastar Project
  issued:
  - year: 2016
  URL: http://www.seastar-project.org/

- id: pm2
  author: Unitech
  title: PM2
  issued:
  - year: 2016
  URL: https://github.com/Unitech/pm2

- id: npm
  title: npm Documentation
  issued:
  - year: 2016
  URL: https://docs.npmjs.com/
---

Introduction
============

Unlike other popular scripting languages, such as python, Node.js is asynchronous by design.
This leads to some interesting advantages.
Primarily it means much better networking applications.
This is because asynchronous, non-blocking, I/O design of Node.js avoids the need for conventional synchronous concurrency models [@node-about].

Non-blocking, asynchronous I/O, is the principle that many tasks can be started in parallel, but the caller doesn't have to sit and wait for the result.
In contrast, synchronous, blocking I/O, require a single request to be fulfilled before work on another one can start [@slaks-async].
To achieve concurrent parallelism in a blocking I/O system require threading and difficult to use locks.
To control and manage these locking mechanisms can be slow as well.

Writing these locking mechanisms can be challenging and hard to implement.
In contrast, using asynchronous methods are much easier;
In asynchronous programming, usually one needs to use simple constructs like callbacks.
Since Javascript, and Node.js, are single threaded, one can avoid race conditions.


Advantages & Disadvantages of Async
==========================

As described in the introduction there are many advantages to asynchronous design.
However one of the bigger problems is it doesn't scale well with number of CPU cores.
This is mainly due to the challenges of handling events.

Advantages
----------

As described earlier, async allows for a way to handle waiting for work to be done.
Since the caller does not wait for a result, it doesn't waste time waiting for work to be returned.
This frees the thread that made the call to be recycled and continue working on other problems.
When there is work to be done, the callback can then be called and processed.
Usually using a dedicated event loop thread [@slaks-async].

These benefits are immense in situations like socket driven services, such as Internet provided services like website applications.
User requests for instance can be fulfilled in turn easily, without worrying about blocking.
Because there is no blocking, there is no need to manage or create large collections of thread pools and locking mechanisms.
Other software, such as Nginx, exploit this as well which is what made it the second most popular web server [@w3-serverstat].

Disadvantages
-------------

Asynchronous programming isn't necessarily easy to start with.
Certain asynchronous features, like callbacks, can lead to confusing and hard to read code.
An example of this unreadability is the infamous "pyramid of doom" (shown below).

For problems that are CPU bound, the single event loop model used for asynchronous I/O, especially in Javascript, can become unresponsive.
An example of a CPU heavy task is a simple infinite loop like $while(true)$. The loop will complete block the event thread doing CPU work and no other event will be processed.
In a threaded environment, a single thread can be locked by an infinite loop, but other threads can come in and do other work [@slaks-async].
When the loop is locked up nothing can happen, since most, if not all, asynchronous languages have but one main event loop [@node-docs].

The other problem is scaling.
As described earlier, javascript and Node.js have but only one thread for handling events and processing CPU bound problems.
Because of this, applications making use of Node.js can't easily scale to the amount of available CPU cores.
In contrast, threaded solutions can.

Node.js uses libuv to try to multi-thread javascript [@node-docs].
In order to scale it, one must consider something akin to the "share-nothing" architecture proposed by the Seastar project
But share nothing architecture is mostly just a fancy way of saying multiple, independent, running copies of a program.
So for the parallelism to work, applications must have some shareable state or a method to pass messages to, possibly using sockets or signaling [@seastar].
A more javascript based solution to the problem are load balancers like PM2.
One of PM2's features is being able to run $x$ amount of copies of a given Node.js applications.

Dependency Resolution
=====================

For a scripting language, it's important to expose and make available useful ways to share and include works to and from other developers.
To facilitate this, Node.js uses NPM, The Node Package Manager.
It's a package manager entierly written in javascript.

The biggest advantage of npm over other package managers like CPAN and pip is that it doesn't need to install libraries globally by default or require so called virtual environments or local libraries.
NPM also makes it easy to quickly make and publish applications using a simple json object [@npm].

Writing Asynchronous Javascript
===============================

Callbacks
---------

Event driven, asynchronous, architecture generally depends on the concepts of callbacks.
Callbacks are way to defer processing the results of a function at a later time.
This deferral is paramount to the concept of asynchronous I/O.
Because of this possible deferral, other work can occur in parallel.
This enhances throughput.

Javascript is a prime example of callback use, since the language is entirely single threaded and highly dependent on this model of processing to make it fast.

### Advantages

In order for callbacks to be useful, usually the language requires Lambda abstractions, also known as anonymous functions.

### Disadvantages

In order to process a series of I/O requests in order, one must stack callbacks in a manner like below.

	// snippet showing callback drawbacks
	funct(val, (err,val) => {
		funct(val, (err, val) => {
			funct(val, (err, val) => {
				funct(val, (err, val) => {
					funct(val, (err, val) => {
						callback(err, val)	
					})	
				})	
			})	
		})	
	})

As can be seen, it can get to the point where there are well over 6 levels of indentations.
This drastically effects readability.
Usually to fix this problem, people use libraries like async.js which manages a collection of callbacks to be executed in a certain style or fashion.

Promises
--------

Similar to callbacks, promises allow for a much cleaner way of handling nested I/O requests.
Usually promises have a "resolve" and a "reject" callback.
Use of resolve would imply the event occurred successfully whereas use of the reject callback implies the event failed.
So when processing these promises, calls the then() if it was a success or the catch() method if it fails.
This makes it easier to separate error handling from the logic.

The idea is much the same, a promise is in effect an object that may initially have an unknown value until it completes.
Once completed, much like a callback, more work can be done on it.

	// snippet showing advantages of promises
	// compared to callbacks
	functionCall(val)
		return new Promise((next) => {
			// do work
			next(err, work_done)
		})
	}).then((err, val) => {
		// do stuff
		// error check
		return new Promise((next) => {
			// do other work
			next(err, done)
		})
	}).then((err, stuff) => { 
		//... etc etc
	}).catch((err) => {
		// handle error
	})

As can be seen from the above snippet, promises allow for less indenting than callbacks.
Because of this it is much more readable and almost resembles conventional synchronous code.
This effectively solves the "Pyramid of Doom" problem that plagues javascript or other callback reliant languages.

Generators
----------

Generators are another concept being tested in Javascript ES6.
When used properly, they effectively allow for asynchronous code that appears synchronous.
This happens because generators allow for arbitrary pausing and execution until a function "yields" a result.

	function someFunc(val) {
		if (!val) {
			setTimeout(() => {
				gen.next('error')
			}
		}
		else {
			doSomethingAsync(val, (res) => {
				gen.next(res)	
			})	
		}
	}
	function *generator() {
		var value = yield someFunc(something)
		// do stuff with value
	}
	generator.next()

In this example, yield caused the function to pause until generator.next() is called with a value.
When it is called, yield is given that value.

Conclusion
==========

Javascript with the Node.js runtime allows for solving hard I/O bound problems, easily.
In many cases they are faster at servicing these kinds of requests than synchronous, blocking, I/O.
However, asynchronous, non-blocking, I/O usually leads to design problems that make it less useful in CPU bound problems,
or problems that are more computational than I/O driven.

NPM, the node.js package manager, makes it easy to share code with other javascript developers.
It has advantages over other scripting language package managers.

In terms of writing asynchronous code, passing lambdas, or anonymous functions, as parameters is the dominant way of doing so.
When using lambdas as parameters, they are referred to as callbacks.
Ultimately though, callbacks lead to problems like the pyramid of doom.
As seen in the paper, to solve the readability problems of callbacks, concepts like promises and futures were made.
They help by allowing for more clean and synchronous looking chaining.

Overall Javascript and Node.js are definitely languages I would recommend for developers to look into.
Its easy to use dependency and packaging mechanisms make it easy to get into.
The design of the language also facilitates an easy way to solve many of the web and document driven problems that plague IT, today.

Citations
=========
