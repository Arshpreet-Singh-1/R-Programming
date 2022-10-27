#--------------------
# Programming with R
#--------------------

#----------------------------------
# Control Structures - Introduction
#----------------------------------

# Control Structures :
# Control Structures in R allow you to control the flow of execution of the program , depending on runtime conditions . Common structures are :
# if , else : testing a condition
# for : execute a loop a fixed number of times
# while : execute a loop while a condition is true
# repeat : execute an infinite loop
# break : break the execution of a loop 
# next : skip an iteration of a loop
# return : exit a function
# Most control structures are not used in interactive sessions , but rather when writing functions or longer expressions

#-----------------------------
# Control Structures - If-else
#-----------------------------

# if(<condition>){
#   # do something
# }else{
#   # do something else
# }

# if(<condition1>){
#   # do something
# }else if(<condition2>){
#   # do something different
# }else{
#   # do something else
# }

x <- 2
if(x > 3){
  y <- 10
}else{
  y <- 0
}
y

x <- 4
y <- if(x>3){
  10
}else{
  0
}
y

# Of Course , the else clause is not necessary 

#-------------------------------
# Control Structures - For loops
#-------------------------------

x <- c("a" , "b" , "c" , "d")

for(i in 1:4){
  print(x[i])
}

for(i in seq_along(x)){
  print(x[i])
}

for(letter in x){
  print(letter)
}

for(i in 1:4) print(x[i])

# Nested for loops

x <- matrix(1:6 , 2 , 3)
for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    print(x[i,j])
  }
}

#---------------------------------
# Control Structures - While loops
#---------------------------------


count <- 0
while(count < 10){
  print(count)
  count <- count + 1
}

# sometimes there will be more than one condition in the test

z <- 5
while( z >= 3 && z <= 10){
  print(z)
  coin <- rbinom(1,1,0.5)
  if(coin == 1){
    z <- z + 1
  }else{
    z <- z - 1
  }
}

#-------------------------------------------
# Control Structures - Repeat , Next , Break
#-------------------------------------------

count <- 0
repeat{
  print(count)
  count <- count + 1
  if(count >= 10){
    break
  }
}

# next is used to skip an iteration of a loop

for( i in 1:10){
  if(i==5){
    next
  }
  print(i)
}

#----------------------
# Your First R Function
#----------------------

add <- function(x,y){
  x + y
}
add(3,5)

above10 <- function(x){
  use <- x > 10
  x[use]
}
x <- 1:20
above10(x)

aboveN <- function(x,n = 10){
  use <- x > n
  x[use]
}
aboveN(x,12)
aboveN(x)

columnmean <- function(y , removeNA = TRUE){
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(y[,i] , na.rm = removeNA)
  }
  means
}
columnmean(airquality)
columnmean(airquality , FALSE)

#-------------------
# Functions - Part 1
#-------------------

# f <- function(<arguments>){
#   ## do something 
# }

# Functions are created using the function() directive and are stored as R object
# Functions can be passed as arguments to other functions
# Functions can be nested, so that you can define a function inside of another function
# The return value of a function is the last expression in the function body to be evaluated 

# Function Arguments 
# Functions have named arguments which potentially have default values
# The formal arguments are the arguments included in the function definition 
# the formals function returns a list of all the formal arguments of a function
# Not every function call in R makes use of all the formal arguments 
# Function arguments can be missing or might have default values

# Argument Matching 
# R functions arguments can be matched positionally or by name . So the following calls to sd are all equivalent

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata , na.rm = FALSE)
sd(na.rm = FALSE , x = mydata)
sd(na.rm = FALSE , mydata)

# you can mix positional matching with matching with name . 
# when an argument is matched by name , it is "taken out" of the argument list and the remaining unnamed arguments are matched in the order that they are listed in the function definition

args(lm)

# The following two cells are equivalent
lm(data = mydata , y ~ x , model = FALSE , 1:100)
lm(y ~ x , mydata , 1 :100 , model = FALSE)

# named arguments are useful on the command line when you have a long argument list and you want to used the defaults for everything except for an argument near the end of the list
# named arguments also help if you can remember the name of the argument and not its position on the argument list

# Function argument can also be partially matched . 
# Order of operations : 
# 1. check for exact match for a named argument
# 2. check for a partial match
# 3. check for a positional match


#-------------------
# Functions - Part 2 
#-------------------

# In addition to not specifying a default value ,you can also set an argument value to NULL

f <- function(a , b = 1 , c = 2 , d = NULL){
  
}

# Lazy Evaluation
# Arguments to functions are evaluated lazily , so they are evaluated only as needed

f <- function(a,b){
  a^2
}
f(2)
# This function never actually uses the argument b , so calling f(2) will not produce an error because the 2 gets positionally matched to a 

f <- function(a,b){
  print(a)
  print(b)
}
f(45)

# "45" got printed first before the error was triggered
# This is because b did not have to be evaluated until after print(a) 
# Once the function tried to evaluate print(b) it had to throw an error

# The "..." Argument
# The ... argument indicate a variable number of arguments that are usually passed on to other functions
# ... is often used when extending another function and you don't want to copy the entire argument list of original function

myplot <- function(x,y, type = 'l' , ...){
  plot(x,y,type = type , ...)
}

# Generic functions use ... so that extra arguments can be passed to methods
mean

# The ... argument is also necessary when the number of arguments passed to the function cannot be known in advance

args(paste)
args(cat)
mean

# One Catch with ... is that any argument that appear after ... on the argument list must be named explicitly and cannot be parially matched

paste("a" , "b" , sep = ':')
paste("a" , "b" , se = ':')


#-------------------------------
# Scoping Rules - Symbol Binding
#-------------------------------

lm
lm <- function(x) {x*x}
lm

# how does R know what value to assign to symbol lm? 
# when R tries to bind a value to a symbol , it searches through a series of enviornments
# The search list can be found by using search function

search()

# The global environment or the user's workspace is always the first element of the search list and the bse package is always the last
# The order of the packages on search list matters!
# User's can configure which packages get loaded on startup so you cannot assume that there will be a set list of packages available
# When a user loads a package with library the namespace of that package gets put in position 2 of the search list(by default) and everything else gets shifted down the list
# R has separate namespace for functions and non-functions so it's possible to have an object named c and a function named c


# Scoping Rules :
# The Scoping rules determine how a value os associated with a free variable  in a function
# R uses lexical scoping or static scoping . A common alternate is dynamic scoping
# Related to the scoping rules is how R uses the search list to bind a value to a symbol
# Lexical scoping turns out to be particularly useful for simplifying statistical computations

f <- function(x, y){
  x^2 + y/z
}

# x,y ---> formal arguments
# z   ---> free variable(not formal arguments and not local variables)
# Scoping rules of a language determine how values are assigned to free varibales

# Lexical Scoping 
# Lexical Scoping in R means that the value of free variables are searched in the environment in which the function was defines

# What is an environment ?
# An environment is a collection of (symbol/value ) pairs, i.e x is symbol and 3.14 might be its value 
# Every environment has a parent environment , it is possible for an environment to have multiple "children"
# the only environment without a parent is the empty environment 
# A function + an environment = a closure or function closure

# Searching for the value for a free variable :
# If the value of a symbol is not found in the environment in which a function was defined , then the search is continued in the parent environment
# The search continues down the sequence of parent environment until we hit the top-level environment , this usually the global environment (workspace) or namespace of a package
# After the top-level environment , the search continues down the search list until we hit the empty environment . If a value of a given symbol cannot be found once the empty environment is arrived at , then an error is thrown


make.power <- function(n){
  pow <- function(x){
    x^n
  }
  pow
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
square(3)

ls(environment(cube))
get("n" , environment(cube))

ls(environment(square))
get("n" , environment(square))


y <- 10
f <- function(x){
  y <- 2
  y^2 + g(x)
}
g <- function(x){
  x*y
}
f(3) 

# Lexical Scoping ---> value of y in function g is looked up in environment in which the function was defined , in this case the global enviornment , so the value of y is 10
# Dynamic Scoping ---> value of y is looked up in the enviornment from which the function was called , so the value of y would be 2

rm(y)
g <- function(x){
  a <- 3
  x + a + y
}
g(2)
y <- 3
g(2)

# Other Languages that support Lexical Scoping:
# Scheme , Perl , Python , Common Lisp (all languages converge to Lisp)

# Consequences of Lexical Scoping :
# In R , all objects must be stored in memory 
# All functions must carry a pointer to their respective defining environment , which could be anywhere
# In S-PLUS , free variables are always looked up in the global workspace , so everything can be stored on the disk because the "defining enviornment" of all functions is the same


#---------------------
# Dates and Times in R
#---------------------

# Dates are represented by the Date class
# Times are represented by the POSIXct or the POSIXlt class
# Dates are stored internally as the number of day since 1970-01-01
# Times are stored internally as number of seconds since 1970-01-01


# Dates are represented by the Date class and can be coerced from a character string using the as.Date() function

x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-02"))

# Times can be coerced from a character string using the as.POSIXlt or as.POSIXct function

# POSIXct is just very large integer under the hood; it is useful class when you want to store times in something like a dataframe
# POSIXlt is a list underneath and it stores a bunch of the other useful information like the day of week , day of the year , month m day of month

# There are number of generic functions that works on date and time
# weekdays ( give the day of week) , months(give the month name) , quarters(give the quarter number)
x <- Sys.time()
x
class(x)
unclass(x)
x$sec
p <- as.POSIXlt(x)
p
class(p)
names(unclass(p))
p$sec

# There is strptime function in case your dates are written in different format

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring , "%B %d, %Y %H:%M")
x
class(x)


# mathematical operations on dates and times
x <- as.Date("2012-01-01")
class(x)
y <- strptime("9 Jan 2011 11:34:21" , '%d %b %Y %H:%M:%S')
class(y)
x-y
x <- as.POSIXlt(x)
x-y

# even keeps track of leap years , leap seconds , daylight savings , and time zones

x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y

x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00" , tz = "GMT")
y-x

weekdays(x)
months(x)
quarters(x)