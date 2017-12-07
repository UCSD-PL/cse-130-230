from time import sleep


# First, a brief overview of decorators. The idea with decorators
# is to use higher-order functions for meta-programming, similar to
# mixins.










# Suppose we have some function to debug, length, which is defined
# recursively over a list.

def length(l):
    return 1 + length(l[1:])

# It's looping infinitely, but we're not sure why it's wrong, and we want to debug it without changing the original definition.
# We can use a decorator to print the function's args every time it's called.


# Here's how that looks:


# The decoration site:
# @printer
# def wrappedLen(l):
#     return 1 + wrappedLen(l[1:])


# the call site:
# wrappedLen([1,2,3])

# Notice, the call site is the same as without the decorator!


# OK, so let's try actually defining a decorator:

# A decorator is a function (or class) that takes a function as argument,
# and returns a new function.

# The two things to keep in mind with decorators are:
#   1) What should I do when the decorator is initialized?
#   2) What should I do when the decorator is called down the line?

#   These correspond to the *decoration point* of the decorated function,
#   and the *call site* of the decorated function


# The general formula for function-style decorators is to define an
# inner helper function that does the decorator's logic for 2),
# and to put state needed in 1) before the function.


# For this decorator, let's print out the number of times it's been invoked,
# as well as the arguments at the call-site.

def printer(f):

    printer.counter = -1

    def helper(a):
        sleep(1)
        print "Called ", str(printer.counter), "times with args ", str(a)
        printer.counter += 1
        return f(a)


    return helper

# length([1,2,3])
#
# print out: "Called 3 times with [1,2,3]"



# viola!
@printer
def wrappedLen(l):
    # if (l == []): return 0
    return 1 + wrappedLen(l[1:])

# EQUIVALENT
# wrappedLen = lambda l: 1 + wrappedLen(l[1:])











# That was the "function-style" type of decorator. The decorator is defined
# as a higher-order function that returns another function.
# We can also use classes, the "class-style" flavor of decorators.
# Because functions in python are "anything that can be called",
# a class-based decorator is a class that implements __call__:


# For class-based decorators, the idea is to put state in the constructor
# or as global variables,
# and to put call-site logic in the __call__ area:

# class printer(object): #inherits from object
#     def __init__(self, arg):
#         # TODO
#         return
#     def __call__(self, arg):
#         # TODO
#         return
