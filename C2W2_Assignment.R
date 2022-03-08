#by default, it creates 2x2 square matrix
makeCacheMatrix <- function(x = matrix(1:4,2,2)) {
  c <- NULL
  #set function assigns the x value and clears the cache (c) from parent environment
  set <- function(y) {
    x <<- y
    c <<- NULL
  }
  #basically gets x value
  get <- function() x
  #cache the solve
  setinverse <- function(solve) c <<- solve
  #get the solve
  getinverse <- function() c
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


#This solves for the inverse matrix

cacheSolve <- function(x, ...) {
  c <- x$getinverse()
  if(!is.null(c)) {
    message("getting cached data")
    return(c)
  }
  data <- x$get()
  c <- solve(data, ...)
  x$setinverse(c)
  c
}
