#!/usr/bin/env python3

from misc import Failure

class profiled(object):
    def __init__(self,f):
        self.__count=0
        self.__f=f
        self.__name__=f.__name__
    def __call__(self,*args,**dargs):
        self.__count+=1
        return self.__f(*args,**dargs)
    def count(self):
        return self.__count
    def reset(self):
        self.__count=0

class traced(object):
    """@traced prints an ASCII art tree of calls and return values from the decorated funciton"""
    __depth=0
    def __init__(self,f):
        self.__f=f
        self.__name__=f.__name__
    def __call__(self,*args,**dargs):
        print ("| "*traced.__depth)+",- "+self.__f.__name__+"("+", ".join([repr(x) for x in args]+[k+"="+repr(v) for k,v in dargs.items()])+")"
        traced.__depth+=1
        try:
            rv=self.__f(*args,**dargs)
        finally:
            traced.__depth-=1
        print ("| "*traced.__depth)+"`- "+repr(rv)
        return rv


class memoized(object):
    """@memoized memoizes the decorated function"""
    def __init__(self,f):
        self.__table={}
        self.__table2=[]
        self.__f=f
        self.__name__=f.__name__
    def __lookup(self,args,dargs):
        k=(args,frozenset(dargs.items()))
        try:
            if k in self.__table:
                return self.__table[k]
        except TypeError:
            for x,y in self.__table2:
                if k==x:
                    return y
        raise KeyError("not found in tables")
    def __store(self,args,dargs,value):
        k=(args,frozenset(dargs.items()))
        try:
            self.__table[k]=value
        except TypeError:
            self.__table2.append((k,value))
    def __call__(self,*args,**dargs):
        t=None
        v=None
        try:
            t,v=self.__lookup(args,dargs)
        except KeyError:
            try:
                v=self.__f(*args,**dargs)
                t=True
            except Exception as e:
                v=e
                t=False
            self.__store(args,dargs,(t,v))
        if t:
            return v
        else:
            raise v

# run some examples.  The output from this is in decorators.out
def run_examples():
    for f,a in [(fib_t,(7,)),
                (fib_mt,(7,)),
                (fib_tm,(7,)),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp.reset,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (even_t,(6,)),
                (quicksort_t,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (change_t,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                ]:
        print("RUNNING %s(%s):" % (f.__name__,", ".join([repr(x) for x in a])))
        rv=f(*a)
        print("RETURNED %s" % repr(rv))

@traced
def fib_t(x):
    if x<=1:
        return 1
    else:
        return fib_t(x-1)+fib_t(x-2)

@traced
@memoized
def fib_mt(x):
    if x<=1:
        return 1
    else:
        return fib_mt(x-1)+fib_mt(x-2)

@memoized
@traced
def fib_tm(x):
    if x<=1:
        return 1
    else:
        return fib_tm(x-1)+fib_tm(x-2)

@profiled
@memoized
def fib_mp(x):
    if x<=1:
        return 1
    else:
        return fib_mp(x-1)+fib_mp(x-2)

@traced
def even_t(x):
    if x==0:
        return True
    else:
        return odd_t(x-1)

@traced
def odd_t(x):
    if x==0:
        return False
    else:
        return even_t(x-1)

@traced
def quicksort_t(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_t([x for x in l[1:] if x<pivot])
    right=quicksort_t([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

@traced
@memoized
def quicksort_mt(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_mt([x for x in l[1:] if x<pivot])
    right=quicksort_mt([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

class ChangeException(Exception):
    pass

@traced
def change_t(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_t(l[1:],a)
    else:
        try:
            return [l[0]]+change_t(l,a-l[0])
        except ChangeException:
            return change_t(l[1:],a)

@traced
@memoized
def change_mt(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_mt(l[1:],a)
    else:
        try:
            return [l[0]]+change_mt(l,a-l[0])
        except ChangeException:
            return change_mt(l[1:],a)



if __name__=="__main__":
    run_examples()
