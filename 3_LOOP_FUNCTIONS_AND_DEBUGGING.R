#------------------------
# LOOP FUNCTIONS - lapply
#------------------------

# Looping on the Command Line
# writing for,while loop is useful when programming but not particularly easy when working interactively on the command line
# There are some functions which implement looping to make life easier

# lapply : Loop Over a list and evaluate a function on each element
# sapply : Same as lapply but try to simplify the result
# apply : Apply a function over the margins of an array
# tapply : Apply a function over subsets of a vector
# mapply : Multiverse version of lapply

# An auxiliary function split is also useful , particularly in conjunction with lapply.

# lapply
# lapply takes three arguments : (1) a list x ; (2) a function FUN ; (3) other arguments via its ... argument
# If x is not a list , it will coerced to a list using as.list

lapply

# lapply always returns a list , regardless of the class of the input

x <- list(a = 1:5 , b = rnorm(10))
lapply(x,mean)

x <- list(a = 1:4 , b = rnorm(10) , c = rnorm(20 , 1) , d = rnorm(100,5))
lapply(x,mean)

x <- 1:4
lapply(x,runif)

x <- 1:4
lapply(x,runif , min = 0 , max = 10)

# lapply and friends make heavy use of anonymous functions

x <- list(a = matrix(1:4 , 2,2) , b = matrix(1:6 , 3,2))
x

# an anonymous function for extracting the first column of each matrix
lapply(x , function(elt) elt[,1])

# sapply
# sapply will try to simplify the result of lapply if possible
# if the result is a list where every element is length 1 , then a vector is returned
# if the result is a list where every element is a vector of the same length(>1) , a matrix is returned
# if it can't figure things out , a list is returned

x <- list(a = 1:4 , b = rnorm(10) , c = rnorm(20 , 1) , d = rnorm(100,5))
lapply(x,mean)
sapply(x,mean)
mean(x)

#-----------------------
# LOOP FUNCTIONS - apply
#-----------------------

# apply is used to evaluate a function ( often a an anonymous one) over the margins of an array.
# It is most often used to apply a function to the rows or columns of a matrix
# It can be used with general arrays , e.g taking the average of an array of matrices
# It is not really faster than writing a loop , but it works in one line !

str(apply)

# x is an array
# MARGIN is an interger vector indicating which margins should be "retained"
# FUN is a function to be applied
# ... is for other arguments to be passes to FUN

x <- matrix(rnorm(200) , 20 , 10)
apply(x,2,mean)
apply(x,1,sum)

# col/row sums and means
# For sums and means of matrix dimensions , we have some shortcuts
# rowSums = apply(x,1 ,sum)
# rowMeans = apply(x,1,mean)
# colSums = apply(x,2,sum)
# colMeans = apply(x,2,mean)
# The shortcut functions are much faster , but you won't notice unless you're using a large matrix

x <- matrix(rnorm(200) , 20 , 10)
apply(x , 1 , quantile , probs = c(0.25 , 0.75))

a <- array(rnorm(2*2*10) , c(2,2,10))
a
apply(a , c(1,2) , mean)
rowMeans( a , dims = 2)

#------------------------
# LOOP FUNCTIONS - mapply
#------------------------

str(mapply)

# mapply is a multivariate apply of sorts which applies function in parallel over a set of arguments
# FUN is a function to apply
# ... contains arguments to apply over
# MoreArgs is a list of other arguments to FUN
# SIMPLIFY indicates whether the resukt should be simplified

list(rep(1,4) , rep(2,3) , rep(3,2) , rep(4,1))
mapply(rep , 1:4 , 4:1)

# vectorizing a function 
noise <- function(n , mean , sd){
  rnorm(n, mean , sd)
}

noise(5 , 1 , 2)
noise(1:5 , 1:5 , 2)

mapply(noise , 1:5 , 1:5 , 2)

list(noise(1,1,2) , noise(2,2,2) , noise(3,3,2) , noise(4,4,2) , noise( 5,5,2))

#------------------------
# LOOP FUNCTIONS - tapply
#------------------------

# tapply is used to apply a function over subsets of a vector

str(tapply)

# x is a vector
# INDEX is a factor or list of factors ( or else they are coerced to factors)
# FUN is a function to be applied
# ... contains other arguments to be passed FUN
# simplify , should we simplify the result ? 

x <- c(rnorm(10) , runif(10) , rnorm(10,1))
f <- gl(3,10)
f
tapply(x , f, mean)
tapply(x , f , range)

#-----------------------
# LOOP FUNCTIONS - split
#-----------------------

# split takes a vector or other objects and splits it into groups determined by a factor or list of factors

str(split)
# x is a vector(or list) or dataframe
# f is a factor (or coerced to one) or a list of factors
# drop indicates whether empty factors levels should be dropped


x <- c(rnorm(10) , runif(10) , rnorm(10,1))
x
f <- gl(3,10)
split(x,f)

lapply(split(x,f) , mean)

library(datasets)
head(airquality)

s <- split(airquality , airquality$Month)
lapply(s , function(x) colMeans(x[,c("Ozone" , "Solar.R" , "Wind")]))
sapply(s , function(x) colMeans(x[,c("Ozone" , "Solar.R" , "Wind")]))
sapply(s , function(x) colMeans(x[,c("Ozone" , "Solar.R" , "Wind")] , na.rm = TRUE))


x <- rnorm(10)
x
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1,f2)
str(split(x, list(f1,f2) , drop = TRUE))

#-----------------------------------------
# Debugging Tools - Diagnosing the Problem
#-----------------------------------------

# Indications that something's not right
# message : A generic notification/diagnostic message produced by the message function ; execution of the function continues
# warning : An indication that something is wrong but not necessarily fatal ; execution of the function continues ; generated by the warning function
# error : An indication that a fatal problem has occured ; execution stops ; produced by the stop function
# condition : A generic concept for indicating that something unexpected can occur ; programmers can create their own conditions 

log(-1) # warning

printmessage <- function(x) {
  if(x>0)
    print("x is greater than zero")
  else
    print("x is less than or equal to zero")
  invisible(x)
}
printmessage(1)
printmessage(NA) #error

printmessage2 <- function(x) {
  if(is.na(x))
    print("x is a missing value!")
  else if(x>0)
    print("x is greater than zero")
  else
    print("x is less than or equal to zero")
  invisible(x)
}
x <- log(-1)
printmessage2(x) 

# How do you know that something is wrong with your function?
# what was your input? how did you call the function?
# what were you expecting? Output , messages , other results?
# what did you get?
# How does what you get differ from what you were expecting?
# Were your expectations correct in the first place?
# Can you reproduce the problem(exactly)?


#------------------------------
# Debugging Tools - Basic Tools
#------------------------------

# The primary tools for debugging functions in R are :
# traceback : prints out the function call stack after an error occurs
# debug : flags a function for "debug" mode which allows you to stop through execution of a function one line at a time 
# browser : suspends the execution of a function wherever it is called and puts the function in debug mode
# trace : allows you to insert debugging code into a function a specific places
# recover : allows toy to modify the error behavior so that you can browse the function call stack

# These are interactive tools specifically designed to allow you to pick through a function
# There's also the more blunt technique of inserting print/cat statements in the function


#----------------------------------
# Debugging Tools - Using the Tools
#----------------------------------

# traceback
rm(x)
rm(y)


mean(x)
traceback()

lm(y ~ x)
traceback()

# debug

debug(lm)
lm(y ~ x)

# recover
options(error = recover)
read.csv("nosuchfile")
