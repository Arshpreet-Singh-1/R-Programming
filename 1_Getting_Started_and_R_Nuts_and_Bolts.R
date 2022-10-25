#--------------------------------------
# Getting Started and R Nuts and Bolts
#--------------------------------------

#-------------------------------
# Entering Input and Evaluation
#-------------------------------

# '<-' symbol is assignment operator
# '#' character indicates a comment


x <- 5  # nothing printed
print(x) # explicit printing

# Output : [1] 5
# [1] indicated that x is vector and 5 is first element
x  # auto-printing occurs

msg <- "hello"
msg

p <- # incomplete expression

x <- 1:20 # ':' operator is used to create integer sequences
x

#--------------------------------------
# Data Types - R Objects and Attributes
#--------------------------------------

# R has five basic or "atomic" classes of objects : 
# characters , numeric (real numbers) , integer , complex , logical(True/False)
# most basic object is a vector which can only contain objects of same class
# But list which is represented as vector can contain objects of different classes
# empty vectors can be created  with vector() function

# numbers in R is generally treated as numeric objects(i.e. double precision real numbers)
# if you explicitly want an integer , you need to specify the L suffix

x <- 1
class(x) # "numeric"

y <- 1L
class(y) # "integer"

x <- 1/0 
x        # Inf

y <- 1/Inf
y        # 0

z <- 0/0
z        # NaN ("not a number")- undefined value/ missing value  
         
# R objects can have attributes :
# names,dimnames , dimensions (e.g. metrics , arrays) , class , length , other user-defined attributes/metadata
# attributes of object can be accessed using attributes() function

#-------------------------------
# Data Types - Vectors and Lists
#-------------------------------

# Creating Vectors
# The c() function can be used to create vecrtors of objects 

x <- c(0.5 , 0.6) 
x
class(x) # numeric

x <- c(TRUE , FALSE) 
x
class(x) # logical

x <- c(T , F) 
x
class(x) # logical

x <- c("A" , "B" , "C") 
x
class(x) # character

x <- 9:29 
x
class(x) # integer

x <- c(1+0i , 2+4i)
x
class(x) # complex

# using the vector() function

x <- vector("numeric" , length = 10)
x

# Mixing Objects 
# when different objects are mixed in a vector , coercion occurs so that every element in the vector is of the same class

y <- c(1.7 , "a")
y
class(y) # character

y <- c(TRUE , 2)
y
class(y) # numeric

y <- c("a" , FALSE)
y
class(y) # character


# Explicit Coercion
# Objects can be explicitly coerced from one class to another using as.* function , if available

x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)

# Nonsensical coerciom results in NAs
x <- c("a" , "b" , "c")
as.numeric(x)
as.logical(x)
as.complex(x)

# Lists
# Lists are a special type of vector that can contain elements of different classes

x <- list(1 , "a", TRUE , 1+4i)
x

#----------------------
# Data Types - Matrices
#----------------------

# Matrices
# Matrices are vectors with dimensions attribute.
# The dimension attribute is itself an integer vector of length 2 (nrow , ncol)

m <- matrix(nrow = 2 , ncol = 3)
m
dim(m)
attributes(m)

# Matrices are constructed column-wise

m <- matrix(1:6 , nrow = 2 , ncol = 3)
m

# Matrcies can also be created directly from vectors by adding a dimension attribute

m <- 1:10
m
dim(m) <- c(2,5)
m

# cbind-ing and rbind-ing
# Matrices can be created by column-binding or row-binding with cbind() and rbind()

x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

#---------------------
# Data Types - Factors 
#---------------------

# Factors 
# Factors are used to represent categorical data
# Factors can be unordered or ordered
# one can think of factor as an integer vector where each integer has a label
# factors are treated specially by modelling functions like lm() and glm()
# using factors with labels is better then using integeres because factors are self-describing ; 
# having a variable that has values "Male" and "Female" is better than a variable that has values 1 and 2 


x <- factor(c("yes","yes","no","yes","no"))
x

table(x)
unclass(x)

# the order of levels can be set using the levels argument to factor()
# this can be important in linear modelling because the first level is used as baseline level
x <- factor(c("yes","yes","no","yes","no"),
            levels = c("yes" , "no"))
x

#----------------------------
# Data Types - Missing Values
#----------------------------

# Missing Values
# Missing Values are denoted by NA or NaN for undefined mathematical operations
# is.na() is used to test objects if they are NA
# is.nan() is used to test for NAN
# NA values have a class also , so there are integer NA , character NA , etc
# A NaN value is also NA , but the converse is not true

x <- c(1,2,NA,10,3)
is.na(x)
is.nan(x)

x <- c(1,2,NaN,NA,4)
is.na(x)
is.nan(x)

#-------------------------
# Data Types - Data Frames
#-------------------------

# Data Frames are used to store tabular data
# They are represented as a speacial type of list where every element of the list has to have the same length
# Each element of the list can be thought of as a column and the length of each element of the list is the number of rows 
# Unlike matrices , data frames can store different classes of objects in each column (just like lists)
# data frames also have a special attribute called row.names
# data frames are usually created by called read.table() or read.csv()
# can be converted to a matrix by calling data.matrix()


df <- data.frame( foo = 1:4,
                  bar = c(T,T,F,F))
df
nrow(df)
ncol(df)


#-----------------------------
# Data Types - Names Attribute
#-----------------------------

# R objects can also have names , which is very useful for writing readable code and self-describing objects

x <- 1:3
names(x)
names(x) <- c("foo" , "bar" , "norf")
x
names(x)

x <- list(a = 1 , b = 2 , c = 3)
x

m <- matrix(1:4 , nrow = 2 , ncol = 2)
dimnames(m) <- list(c("a","b") , c("c","d"))
m

#---------------------
# Reading Tabular Data
#---------------------

# Reading data
# There are few principal functions reading data into R
# read.table , read.csv , for reading tabular data
# readLines , for reading lines of text files
# source, for reading in R code files (inverse of dump)
# dget , for reading in R code files (inverse of dput)
# load , for reading saved workspaces
# unserialize , for reading single R objects in binary form

# Writing Data
# There are analogous functions for writing data to files
# write.table , writeLines , dump , dput , save and serialize

# Reading Data files with read.table
# read.table has a few important arguments :
# file , name of a file , or a connection
# header , logical indicating if the file has a header line
# sep , a string indincating how the columns are separated
# colClasses , a character vector indicating the class of each column in the dataset
# nrows , the number of rows in the dataset
# comment.char , a character string indicating the comment character
# skip , the number of lines to skip from the the brginning
# stringAsFactor , should character variable be coded as factors ?

# read.table
# for small to moderately sized datasets , you can call read.table without specifying any other arguments

data <- read.table("foo.txt")

# R will automatically :
# skip lines that begin with #
# figure out how many rows are there ( and how much memory needs to be allocated)
# figure what type of variable is in each column of the table . Telling R all these things directly makes R run faster and more efficient
# read.csv is identical to read.table except that default separator is comma.


#---------------------
# Reading Large Tables
#---------------------

# with much larger datasets , doing the following things will make your life easier and will prevent R from choking
# Read the help page for read.table , which contain many hints
# Make a rough calculation of the memory required to store your dataset . If the dataset is larger than the amount of RAM on your computer , you can probably stop right here.
# set comment.char = "" if there are no commented line in your file

# using the colClasses argument can make 'read.table' run much faster , often twice as fast.
# if all columns are "numeric" , for example ,  then set colClasses = "numeric"
# a quick an dirty way to figure out the classes of each column is the following :

intial <- read.table('datatable.txt' , nrows = 100)
classes <- sapply(initial , class)
tabAll <- read.table("datatable.txt" ,
                     colClasses =  classes)

# set nrows 
# This doesn't make R run faster but it helps with memory usage
# A mild overestimate is okay . You can use the Unix tool wc to calculate the number of lines in a file

# Know the System:
# How much memory is available ?
# what other applications are in use ?
# Are there other users logged into the same system ?
# what operating system ?
# Is the OS 32 or 64 bit ?

# Calculating Memory Requirements :
# I have a dataframe with 1,500,000 rows and 120 columns , all of which are numeric data . 
# Roughly how much memory is required to store this data frame?
# 1,500,000 x 120 x 8 bytes/numeric
# = 1440000000 bytes
# = 1440000000/2^20 bytes/MB
# = 1,373.29 MB
# = 1.34 GB

#---------------------
# Textual Data Formats
#---------------------

# dumping and dputing are useful because the resulting textual format is edit-able , and in the case of corruption , potentially recoverable
# unlike writing out a table or csv file , dump and dpout preserve the metadata (sacrificing some readabilty) , so that another user don't have to specify it all over again
# Textual formats can work much better with version control programs like subversion or git which can only track chnages meaningfully in text files
# Textual formats can be loner-lived ; if there is corruption somewhere in the file , it can be easier to fix the problem
# Textual formats adhere to the "Unix philosophy"
# Downside : the format is not very space-efficient

# dput-ting R Objects
# Another way to pass data around is by deparsing the R object with dput and reading it back in using dget
y <- data.frame(a = 1 ,b = "a")
dput(y)
dput(y , file = "y.R")
new.y <- dget("y.R")
new.y


# Dumping R Objects :
# Multiple objects can be deparsed using the dump function and read back in using source
x <- "foo"
y <- data.frame(a = 1 , b = "a")
dump(c("x","y") , file = "data.R")
rm(x,y)
source("data.R")
y
x

#----------------------------------------------
# Connections : Interfaces to the Outside World
#----------------------------------------------

# file , open a connection to a file
# gzfile , open a connection to a file compressed with gzip
# bzfile , open a connection to a file compressed with bzip2
# url , opens a connection to a webpage

str(file)
# description is the name of the file
# open is code indicating :
# "r" read only , "w" writing , "a" appending
# "rb" , "wb" , "ab" reading , writing and appending in bianry mode (windows)


con <- file("foo.txt" , "r")
data <- read.csv(con)
close(con)
# is same as 
data <- read.csv("foo.txt")


con <- gzfile("words.gz")
x <- readLines(con,10)
x 

con <- url("http://www.jhsph.edu","r")
x <- readLines(con)
head(x)

#--------------------
# Subsetting - Basics
#-------------------- 

# [] always returns an object of the same class as the original
# can be used to select more than one element (there is one exception)

# [[]] is used to extract element of list or a data frame
# it can only be used to extract a single element and the class of returned object will not necessarily be list or data frame

# $ is used to extract elements of a list or data frame by name 
# semantics are similar to that of [[]]

x <- c("a","b","c","c","d","d")
x[1]
x[2]
x[1:4]
x[x >"a"]

#-------------------
# Subsetting - Lists
#--------------------

x <- list(foo = 1:4 , bar = 0.6)
x[1]
x[[1]]
x$foo
x["bar"]
x[["bar"]]
x$bar

x <- list(foo = 1:4 , bar = 0.6 , baz = "hello")
x[c(1,3)]

# the [[]] operator can be used with computed indices
# $ can only be used with literal names

x <- list(foo = 1:4 , bar = 0.6 , baz = "hello")
names <- "foo"
x[[names]] # computed index for "foo"
x$names # element 'name' doesn't exist
x$foo # element 'foo' does exist

# Subsetting nested element of a list

x <- list(a = list(10,12,14) , b = c(3.14,2.01))
x[[c(1,3)]]
x[[c(2,1)]]
x[[1]][[3]]
x[[2]][[1]]

#----------------------
# Subsetting - Matrices
#----------------------

m <- matrix(1:6 , 2, 3)
m

# matrices can be subsetted in usual way with (i,j) type indices
m[1,2]
m[2,1]
# indices can also be missing
m[1,]
m[,2]
m[1:2 , 1:2]

# by default when a single element of a matrix is retrieved , it is returned as a vector of length 1
# rather than a 1 x 1 matrix . This behaviour can be turned off by setting drop = FALSE
m[1,2,drop = FALSE]
# similarly for single column or row
m[1,,drop = FALSE]

#-----------------------------
# Subsetting - Partial Matching
#------------------------------

# Partial matching of names is allowed with [[]] and $
x <- list(aardvark = 1:5)
x
x$a
x[["a"]]
x[["a" , exact = FALSE]]

#-------------------------------------
# Subsetting - Removing Missing Values
#-------------------------------------

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)
bad
x[bad]
x[!bad]

x <- c(1,2,NA,4,NA,5)
y <- c("a","b",NA,"d",NA,"f")
good <- complete.cases(x,y)
good
x[good]
y[good]

airquality[1:6,]
good <- complete.cases(airquality)
airquality[good,][1:6,]

#----------------------
# Vectorized Operations
#----------------------

x <- 1:4 ; y <- 6:9
x + y
x > 2
x >= 2
y == 8
x * y
x / y

m1 <- matrix(1:4 , 2,2) ; m2 <- matrix(rep(10,4) , 2, 2)
m1 * m2 # element wise multiplication
m1 %*% m2 # true matrix multiplcation