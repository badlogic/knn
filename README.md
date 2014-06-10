Java KNN
===

Java 7/8 implementations of K nearest neighbour, cause everybody is showing off how small/fast it is in favourite language X. All the implementations actually do k=1, leaving out the part of selecting the top k and then combining the “votes” in some suitable way.

Here it is in the most boring language imaginable, not using any Java 7/8 features that may be applicable, at an honest 63 LOC.

Compiling & Running
===================
Compile via

```bash
javac src/Knn.java
```

Run via

```
java -cp src Knn
```

Alternatively import the awesome project into your favourite IDE, provided it supports Gradle. For Eclipse, use the Spring Eclipse Integration, Intellij IDEA and Netbeans do Gradle out of the box.

Benchmarking
============
This times a single run, consisting of loading the training and validation sets, then classifying all validation samples. No JVM warmup is performed, cause the heavy lifting `distance()` method will be JIT compiled pretty soon. For a super fair comparison we’d have to warm up the JVM, and force the CSV files out of the OS file cache.

It takes between 2.4-2.7 secs on my early 2013 MBP. The equivalent [Rust version](http://huonw.github.io/2014/06/10/knn-rust.html) takes