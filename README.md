# Ruby Annotations Demo

A few simple demos showing how to use `method_added` for creating C#/Java style annotations in Ruby.

---

To see a deprecation warning demo, run:
```
$ ruby demo.rb
```
This should print out 'old' and 'new', with a warning above 'old' saying the method is deprecated

---

To see a usage stats demo, run:
```
$ ruby demo2.rb
```
This should print out some usage stats after calling demo methods a number of times

---

To see a demo showing doc generation, run:
```
$ ruby demo3.rb
```
This should print out some dummy docs for methods 'Demo#one' and 'Demo#two'
