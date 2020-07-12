# Determine the output format of the document
outputFormat = opts_knit$get("rmarkdown.pandoc.to")

# Figure and Table Caption Numbering, for HTML do it manually
capTabNo = 1; capFigNo = 1;

# Function to add the Table Number
capTab = function(x){
  if(outputFormat == 'html'){
    x = paste0("Table ",capTabNo,". ",x)
    capTabNo <<- capTabNo + 1
  }; x
}

# Function to add the Figure Number
capFig = function(x){
  if(outputFormat == 'html'){
    x = paste0("Figure ",capFigNo,". ",x)
    capFigNo <<- capFigNo + 1
  }; x
}