#### R Basics ####
# "A foolish consistency is the hobgoblin of 
#   little minds"   -Ralph Waldo Emerson 

# Literals ----
"this is a string literal" # double quotes preferred in R but not required
42
J
T
FALSE
TRUE
F


# Operators ----
#Arithmetic
2 + 3 # note the spacing, spaces matter for legibility and error checking.
2 - 3
2 * 3 # multiplication
2 / 3
2 ** 3 #but be careful this is an exponent


# Comparison
2 = 2 #NOT equal, error
2 == 2 # tests for equality

"Joe" == "joe" # case sensitive

2 == 1 + 1 # Ok
2 == (1 + 1) # better

2 != 1 #tests inequality
2 != 2 #tests inequality

2 < 3
2 > 3
2 <= 2
2 >= 3

# somewhat tricky
TRUE == 1 #
FALSE == 0
isTRUE(TRUE) # testing if the argument is literally TRUE
isTRUE(1)
?isTRUE # queries built-in help

2 < 3 & 2 > 3 # both have to pass to return TRUE
2 < 3 | 2 > 3 # either one TRUE, all TRUE; pipe key (above the enter key) is "OR"

2 < 3 & (2 == 1 | 2 == 2) # use parenthesis to group statements for ordering

# type matters (sometimes)
"joe" # string or character type
typeof("joe")
42 # numeric type (double precision, floating point)
typeof(42)
TRUE
typeof(TRUE) # logical or boolean type

42 == "42" # equality can cross types
identical(42, "42") # type matters for identity


# variables ----


# data structures ----
# vectors have a single dimension, like a column or row of data

# data frames - the key structure for data science, multi-dimensional
#   collections of vectors


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


