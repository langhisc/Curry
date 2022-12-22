# Curry

This tiny Swift package extends the Swift language with a currying operator.
The operator is a double caret: ^^
It's left-associative.
The currying operator binds a function, method, or closure (the LHS) to a set of arguments (the RHS).  The value of the expression is a new closure that will automatically run the original LHS with the arguments given.  The arguments are captured at the operator usage site.
Alternatively, you can bind the LHS to just its first argument, producing a closure that requires only the remaining arguments. 
This package also defines a function notation for the latter usage style.
