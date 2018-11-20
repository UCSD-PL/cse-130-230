#!/usr/bin/env python3

from misc import Failure
from typing import List

# prologable trait
class Prologable():
    def toProlog(self) -> str:
        raise Failure("TODO")


# expression interface
class Expression(Prologable):
    def ctor(self) -> (str, List[str]):
        raise Failure("TODO")

    def __repr__(self) -> str:
        (name, args) = self.ctor()
        return name + "(" + ",".join(args) + ")"

    def __eq__(self, other):
        if isinstance(other, Expression):
            return self.ctor() == other.ctor()
        else:
            return False

# binop interface
class Bop(Prologable):
    pass
class Plus(Bop):
    def __init__(self):
        return
    def __repr__(self):
        return "Plus()"
    def toProlog(self):
        return "plus"
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
    def __init__(self, v:int):
        self.v = v
    def ctor(self):
        return ("Const", [str(x) for x in [self.v]])
    def toProlog(self):
        return "const(%i)" % self.v
class Bool(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])
class NilExpr(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])
class Var(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])

class Bin(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])
    
class If(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])
class Let(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])

class Letrec(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])

class App(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])

class Fun(Expression):
    def ctor(self):
        return ("TODO", [x for x in ["TODO"]])


# types
class Type(Prologable):

    def pprint(self) -> str:
        raise Failure("TODO")

    def __eq__(self, other):
        if isinstance(other, Type):
            return self.toProlog() == other.toProlog()
        else:
            return False

class IntTy(Type):
    def __repr__(self):
        cname = "TODO"
        args = [x for x in ["TODO"]]
        return cname + "(" + ",".join(args) + ")"
class BoolTy(Type):
    def __repr__(self):
        cname = "TODO"
        args = [x for x in ["TODO"]]
        return cname + "(" + ",".join(args) + ")"
class ArrowTy(Type):
    def __repr__(self):
        cname = "TODO"
        args = [x for x in ["TODO"]]
        return cname + "(" + ",".join(args) + ")"
class ListTy(Type):
    def __repr__(self):
        cname = "TODO"
        args = [x for x in ["TODO"]]
        return cname + "(" + ",".join(args) + ")"

class VarTy(Type):
    def __repr__(self):
        cname = "TODO"
        args = [x for x in ["TODO"]]
        return cname + "(" + ",".join(args) + ")"

