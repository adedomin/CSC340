---
title: Asynchronous Programming
subtitle: Advantages and Programming Constructs
author: Anthony DeDominic \<dedominica@my.easternct.edu\>
abstract: 
	- This paper will discuss Asynchronous programming paradigms, methods of writing asynchronous code, advantages of asynchronous programming and examples of asynchronous programming in use. The paper will start with language constructs like callbacks, promises, generators and common javascript libraries. Then talk about advantages of asynchronous design, such as higher throughput and easier concurrency. Later I will discuss projects that use asynchronous concepts and their synchronous counterparts; such projects like nginx vs httpd. Also talk about examples like the Seastar, Shared-nothing, server-side application framework.
date: \today{}
geometry: margin=3cm
fontfamily: mathpazo
fontsize: 10pt
header-includes:
	- \usepackage{fancyhdr}
	- \pagestyle{fancy}
	- \fancyfoot[L]{Asynchronous Programming - DeDominic}
	- \fancyfoot[C]{}
	- \fancyfoot[R]{\thepage}
	- \twocolumn
---

Introduction
============

In this paper I will be exploring the topic of asynchronous processing in contrast to synchronous approach that is more familiar to most programmers.

Asynchronous methods allow for requests to be worked on concurrently, in parallel, before they finish.
In contrast, synchronous methods require a single request to be fulfilled before work on another one can start.
In order to have concurrent parallelism in synchronous methods requires multiple threads or processes and fine grain locking controls to pass information, join processes and other mechanisms.

Synchronous is the opposite of Asynchronous. It implies some connection or dependency on other tasks.
This means that synchronous tasks must communicate with one another using mechanisms like semaphores or signals.

Writing these locking mechanisms can be challenging and hard to implement.
In contrast, using asynchronous methods are much easier;
In asynchronous programming, usually one needs to use simple constructs like callbacks.
No need to worry about things like blocking locks.
This is because tasks are not dependent on each other.

Advantages & Disadvantages
==========================

As described in the introduction there are many advantages to asynchronous design.
One of the biggest ones is very easy concurrency.
However one of the bigger problems is it doesn't scale well with number of CPU cores.

Advantages
----------



Disadvantages
-------------

One of the Biggest disadvantages with asynchronous is it isn't synchronous.
If a task MUST have any dependencies it isn't appropriate for asynchronous.
This isn't necessarily a problem in multiparadigm languages.

Asynchronous programming isn't necessarily easy to start with.
Certain asynchronous features, like callbacks, can lead to confusing and hard to read code.

In Use in Software
==================

Case: httpd
---------------

An example of this is the http server, Apache httpd.
When it was first conceived, they used blocking I/O to process user requests.
In order to allow for concurrent handling of events they started using a prefork model.
The prefork model effectively forked a complete copy of the running httpd instance (memory and all) to service the request from start to end.
This came with the advantages of performance, but also removed concerns of race conditions since the memory was copied.
The disadvantages are the memory costs of running numerous copies of httpd to serve large amount of concurrent requests.

Newer process models used more complex methods to handle this problem, such as the multi-processing module, worker.
This module are much more advanced than the prefork method.
it used less memory by making use of shared memory, limited number of child processes and thread pools.
However it was still very synchronous and came with performance disadvantages.

In order to further enhance Apache httpd, they looked to the Nginx reverse proxy server.
Nginx, uses an asynchronous event driven architecture in handling http requests.
Because of this, Nginx was and still is faster than Apache httpd at serving http requests.
In order to compete, Apache httpd created the events multi-process module.
This module tries to add the benefits of asynchronous to httpd.

Event Driven Programming Constructs
===================================

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
