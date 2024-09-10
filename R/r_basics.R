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
# tips: use only lower case, follow suggestions below (no periods in names)

x <- "this is string" # in R, read as assigning the string to variable x
x
x
typeof(x)
x <- 10 # assigning a variable to something
x ^ 2 # always refers to the assigned value; in this case, to the power of

x <- 'pizza'
pizza <- "x" # variable names can be most anything
pizza
# my var <- 42 # not everything though
my_var <- 42 # that's better
# my_var = 42 # works, but not standard in R
# my_var.pdx <- 42 # works, but don't do it as it confuses things
x <- my_var # helps reader follow assignment direction




# data structures ----
# vectors have a single dimension, like a column or row of data
# vectors of volumes (typically a column)
# R will flip numbers to characters if there is one row of characters in the column

a <- c("1", "2", "3") # c() stands for collect (what's inside)
a
a <- c(1, 2 ,3)
a
a + 1

a <- c(1, 2, 3, "4")
a
typeof(a) # R will auto-type to the form that "works"
a + 1

a <- c(1, 2 ,3)
a < 3

any(a < 3) # tests whether any comparison  TRUE
all(a < 3) # tests whether all comparisons TRUE

3 %in% a # testing member in a vector
4 %not in% a # doesn't work as a negation
!4 %in% a # this works, "4 is not in a"; ! negates the statement



# data frames - the key structure for data science, multi-dimensional
#   collections of vectors


# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values


