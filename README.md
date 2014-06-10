Java KNN
===

Java 7/8 implementations of K nearest neighbour, cause everybody is showing off how small/fast it is in [favourite](http://philtomson.github.io/blog/2014/05/29/comparing-a-machine-learning-algorithm-implemented-in-f-number-and-ocaml/) [language]( X. All the implementations actually do k=1, leaving out the part of selecting the top k and then combining the “votes” in some suitable way.

Here it is in the most boring language imaginable, not using any Java 7/8 features that may be applicable, at an honest 61 LOC.

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
All benchmarks were performed on an early MBP. I used JDK 1.7.0_60, the Rust nightly build from (10 June 2014), OCaml 4.01.0. I tried to get the F# version to compile, but failed. The Java version is executed as is with default params, and without warmup. The Rust version was compiled via `rustc -O`, the OCaml version with `ocamlopt str.cmxa`. Timings (only printing a single run, stddev wasn’t significant, try it yourself):

```
javac src/Knn.java 
time java -cp src Knn
Accuracy: 94.39999999999999%

real	0m2.836s
user	0m2.923s
sys	0m0.155s
```

```
rustc -O src/knn.rs 
time ./knn
Percentage correct: 94.4%

real	0m2.899s
user	0m2.851s
sys	0m0.034s
```

```
ocamlopt str.cmxa -o knn-ml src/knn.ml 
time ./knn-ml 
Percentage correct:94.400000

real	0m12.915s
user	0m12.795s
sys	0m0.110s

```
