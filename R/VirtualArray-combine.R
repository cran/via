#' Combine a one-dimensional '\code{\link[via:XArray-class]{VirtualArray}}'-class object with other objects 
#'
#' NOTE: Sequences that start with an \code{NA} do not yet work. 
#
#' @rdname combine
#' @param x \code{\link[via:XArray-class]{VirtualArray}} object to combine wit other objects.
#' @return A \code{\link[via:XArray-class]{VirtualArray}}-class object.
#' @param ... additional objects to combine. 
#' @export 
setMethod(
	"c",
	"VirtualArray",
	#c.RasterArray<-
	function(x, ...){
		listArg <- list(...)
		finXA <- x
		# store the system call
		callSymb <- sys.call(which=0)
		symbolNames <- names(callSymb)
	
		# run loop only if it is more than 1
		if(length(listArg)!=0){
			for(i in 1:length(listArg)){
				elem <- listArg[[i]]
				# name of the first will be taken care of by c2
				finXA<-c2(finXA, elem)
				# try to overwrite the name - necessary for multiple combinations
				if(!is.null(symbolNames)){
					if(symbolNames[i+2]!=""){
						names(finXA@index)[length(finXA)] <- symbolNames[i+2]
					}
				}
			}
		}
		return(finXA)
	}
)


# pairwise generic
setGeneric("c2", function(x,y,...) standardGeneric("c2"))


