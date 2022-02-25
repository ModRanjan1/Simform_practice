// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract ClassA {
/* Operators:
    * ! (logical negation)
    * && (logical conjunction, “and”)
    * || (logical disjunction, “or”)
    * == (equality)
    * != (inequality)
    
    The operators || and && apply the common short-circuiting rules.
    This means that in the expression f(x) || g(y), if f(x) evaluates to true,
    g(y) will not be evaluated even if it may have side-effects.
*/

/**
    * Comparisons: <=, <, ==, !=, >=, > (evaluate to bool)
    * Bit operators: &, |, ^ (bitwise exclusive or), ~ (bitwise negation)
    * Shift operators: << (left shift), >> (right shift)
    * Arithmetic operators: +, -, unary - (only for signed integers), *, /, % (modulo), ** (exponentiation)
    
    For an integer type X, you can use type(X).min and type(X).max to access the minimum and maximum value representable by the type.
*/
}