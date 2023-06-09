# build from existing stack with existing index, or dimensions
#' @export RasterArray
setMethod("initialize",signature="RasterArray",
	definition=function(.Object,stack, index=NULL, dim=NULL){
		if(!requireNamespace("terra", quietly=TRUE)) stop("This class requires the terra package.")
		# automatic wrapper
		if(is.null(index)) index <- 1:nlayers(stack)
		# some defense for index
		if(is.null(dim)){ 
			if(!inherits(stack,"SpatRaster")) stop("The 'stack' has to be a 'SpatRaster' - class object.")
			if(!is.numeric(index)) stop("The 'index' has to be a 'numeric' object.")
			

			# where were supposed to be NAs
			bNA <- is.na(index)

			if(any(index[!bNA]%%1!=0) | any(index[!bNA]<1)) stop("The 'index' has to contain positive integer values.")
			
			# the number of valid entries mis the number of layers
			if(sum(!bNA)!=nlayers(stack)) stop("You have to provide as many layers as many valid entries in index.")

			# reorder the stack
			noNAInd <- index[!bNA]
			newStack <- stack[[noNAInd]]

			# force index to be monotonous integer sequence
			newIndex <- index
			newIndex[] <- NA
			newIndex[!bNA] <- 1:nlayers(stack)

			# store final object
			.Object@index <- newIndex
			.Object@stack <- newStack
			
		}else{
			if(!is.numeric(dim)) stop("The 'dim' argument has to be a 'numeric' vector.")
			if(nlayers(stack)!=prod(dim, na.rm=TRUE)) warning("The number of layers in the does not equal the product of the 'dim' vector.")
			.Object@stack<- stack
			index <- array(1:nlayers(stack), dim=dim)
			# in case of reuse
			index[duplicated(as.numeric(index))] <- NA
			.Object@index<- index
			
			
		}
		return(.Object)
	}
)


setMethod(
	"show",
	signature="RasterArray", 
	function (object) 
	{
	    cat(paste0("class         : ", class(object), "\n"))
	    ## if (rotated(object)) {
	    ##     cat("rotated     : TRUE\n")
	    ## }
	    mnr <- 15
	#   if (filename(object) != "") {
	#       cat("filename    :", filename(object), "\n")
	#   }

	    nl <- nlayers(object)
	    if (nl > 0) {
	   		cat("Element properties: \n")
			cat(paste0("- class       : ",class(object@stack[[1]]), "\n"))
			dims <- dim(object@stack[[1]])
			cat(paste0("- dimensions  : ", dims[1],", ",dims[2]," (nrow, ncol)\n"))
			reses <- terra::res(object@stack[[1]])
			cat(paste0("- resolution  : ",reses[1],", ",reses[2]," (x, y)\n"))
			extent <- terra::ext(object@stack[[1]])
			cat(paste0("- extent      : ", extent$xmin, ", ",extent$xmax,", ",extent$ymin,", ",extent$ymax, " (xmin, xmax, ymin, ymax)\n"))
			refsys <- paste(terra::crs(object@stack[[1]], describe=TRUE)$name)
			cat(paste0("- coord.ref.  : ",refsys,"\n"))

  			cat("Array properties: \n")
  			adim <- dim(object)
  			allName <- names(object)
		   
	        if(length(adim)==1){
		        cat("- dimensions  : ", paste(adim, collapse=", "), 
		            "  (vector)\n", 
		            sep = "")
		      
		    }else{
		    	allName<- dimnames(object)
		    	if(length(allName)==2){
			    	cat("- dimensions  : ", paste(adim, collapse=", "), 
			            "  (nrow, ncol)\n", 
			            sep = "")
			    }else{
			    	cat("- dimensions  : ", paste(adim, collapse=", "), 
			            "  (nrow, ncol, ...)\n", 
			            sep = "")
			    }
		#    	for(i in 1:length(allName)){
		#			if(i==1) cat("- rownames    : ", paste(allName[[i]], collapse=", "), "\n", sep = "")
		#			if(i==2) cat("- colnames    : ", paste(allName[[i]], collapse=", "), "\n", sep = "")
		#			if(i>2) cat(paste("- Dim", i, " names", sep=""), "  : ", paste(allName[[i]], collapse=", "), "\n", sep = "")
		#    	}
				

		    	  
		    }
		    cat("- num. layers : ", nlayers(object), "\n", 
		        sep = "")
			cat("- missing     : ", sum(is.na(object@index)), "\n", 
				sep = "")
		    cat("- proxy:\n ")
			theProx <- proxy(object)
			theProx[] <- abbrev(theProx)
			print(theProx)
		   
	    } else {
	        cat("nlayers       :", nl, "\n")
			if(sum(is.na(object@index))>0){
				cat("- missing     : ", sum(is.na(object@index)), "\n", 
					sep = "")
				cat("- proxy:\n ")
				theProx <- proxy(object)
				theProx[] <- abbrev(theProx)
				print(theProx)
			}
	    } 
	    cat("\n")
	}
)






#' Positions of missing values in a '\code{\link[via:RasterArray-class]{RasterArray}}'-class object
#' 
#' The function behaves similar to the regular \code{is.na()} function applied to the proxy object of a '\code{RasterArray}'.
#' 
#' @param x A \code{RasterArray} class object.
#' @return A \code{logical} \code{vector}, \code{matrix} or \code{array} matching the structure of the \code{RasterArray}.
#' 
#' @examples
#' ex <- rastex() 
#' ex[2] <- NA
#' is.na(ex)
#' 
#' @export
is.na.RasterArray<-function(x){
	is.na(proxy(x))
}





