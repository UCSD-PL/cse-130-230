#!/usr/bin/env python3

from misc import Failure

# prologable trait
class Prologable():
    def toProlog(self) -> str:
        raise Failure("TODO")

    def __eq__(self, other):
        if isinstance(other, Prologable):
            return self.toProlog() == other.toProlog()
        else:
            return False
    def __str__(self):
        return self.toProlog()


# expression interface
class Expression(Prologable):
    pass

# binop interface
class Bop(Prologable):
    pass
class Plus(Bop):
    pass
class Minus(Bop):
    pass
class Mul(Bop):
    pass
class Div(Bop):
    pass
class Eq(Bop):
    pass
class Neq(Bop):
    pass
class Lt(Bop):
    pass
class Leq(Bop):
    pass
class And(Bop):
    pass
class Or(Bop):
    pass
class Cons(Bop):
    pass

class Const(Expression):
    def __init__(self, i: int):
        self.v = i
    def ctor(self):
        return ("Const", [str(x) for x in [self.v]])
    def toProlog(self):
        return "const(%i)" % self.v
class Bool(Expression):
    def __init__(self, b: bool):
        self.v = b
class NilExpr(Expression):
    def __init__(self):
        return
class Var(Expression):
    def __init__(self, v: str):
        self.v = v
    

class Bin(Expression):
    def __init__(self, l: Expression, o: Bop, r:Expression):
        self.l = l
        self.r = r
        self.o = o
    
class If(Expression):
    def __init__(self, c: Expression, t: Expression, f: Expression):
        self.c = c
        self.t = t
        self.f = f
class Let(Expression):
    def __init__(self, v: str, e: Expression, body: Expression):
        self.v = v
        self.e = e
        self.body = body

class Letrec(Expression):
    def __init__(self, v: str, e: Expression, body: Expression):
        self.v = v
        self.e = e
        self.body = body

class App(Expression):
    def __init__(self, f: Expression, arg: Expression):
        self.f = f
        self.arg = arg

class Fun(Expression):
    def __init__(self, v: str, body: Expression):
        self.v = v
        self.body = body


class Type(Prologable):
    pass

class IntTy(Type):
    def __init__(self):
        return
class BoolTy(Type):
    def __init__(self):
        return
class ArrowTy(Type):
    def __init__(self, l: Type, r: Type):
        self.l = l
        self.r = r
class ListTy(Type):
    def __init__(self, inner: Type):
        self.inner = inner

class VarTy(Type):
    def __init__(self, name: str):
        self.name = name

