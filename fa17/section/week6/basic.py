#
# Lets warm up by building the map and fold we love so much from OCaml in Python.
# Python allows us to implement these both in an imperative way, as well as in a functional way.
# Lets start with map

### Map
# If you recall, the type of map from ocaml is (`a -> `b) -> `a list -> `b list
# In python, we can implement this in an imperative way like so:
def map(f, lst) :
    result = []
    for i in lst :
        result.append(f(i))
    return result

# We can see it work with a simple +1 function below:
def inc(n) : return n + 1

templist = range(10)

# Note here that range(10) creates (in Python2) the list of numbers from 0 to 9 [0...9]
#print templist
#print map(inc, templist)
# [1,2,3,4...50]

# Note that we can implement map in a functional way as well, similarly to ocaml:
def recmap(f, lst) :
    if len(lst) == 0 : return []  # Corresponds to base case when lst is empty
    return [f(lst[0])] + recmap(f,lst[1:])   # Corresponds to recursive case, when lst = [lst[0]] + lst[1:]

# Note in the above function the different syntax for building and concatenating lists! We use + for both, instead of the ::/@ in OCaml

#print recmap(inc, templist)

#Another nice feature in python is list comprehensions. It is a more succinct way to express a map or filter operation. For example:

# We can use list comprehensions to write an even simpler map:
def lcmap(f, lst) :
    return [ f(x) for x in lst]

# We can also use list comprehensions to implement fitler:
def filter(f, lst) :
    return [ x for x in lst if f(x)]

def isEven(n) : return n % 2 == 0

#print filter(isEven, range(10))

### Fold
# Similarly we can implement fold in an "imperative" way:
# f : acc -> elem -> acc'
def fold(f, base, lst) :
    acc = base
    for i in lst :
        acc = f(acc, i)
    return acc

# And see it work:
def sum(a,b) : return a + b
#print fold(sum, 0, [1,2,3,4,5])

#
# Again we can implement fold in a recursive way similar to python
#
def recfold(f, acc, lst) :
    if len(lst) == 0 : return acc
    return fold(f, f(acc, lst[0]), lst[1:])

#print recfold(sum, 0, range(10000))

#b ? fv : sv

def lcfold(f, acc, lst) :
    return acc if len(lst) == 0 else fold(f, f(acc, lst[0]), lst[1:])

#print lcfold(sum, 0, range(10000))

# Finally, python has a rich body of libraries. For example in 4 lines we can download any webpage!
# Lets see next how we can use that to build our very own crawler in crawler.py!
import urllib2

def getWebContent(url) :
    response = urllib2.urlopen(url)
    html = response.read()
    response.close()
    return html

import re
import sys

r = re.compile(r"http[s]?://[a-zA-Z\.-]+")

def extractAllLinks(html) :
    return r.findall(html)

import sys
html = getWebContent(sys.argv[1])
print extractAllLinks(html)
