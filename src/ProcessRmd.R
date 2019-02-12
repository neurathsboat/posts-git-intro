#!/usr/bin/env Rscript

# Helper function to replace YAML header with TOML
ReplaceHeader = function(fileName) {
  fileContents = readLines(fileName)
  yamlInd = grep("---", fileContents)
  strippedOfHeader = fileContents[(yamlInd[2] + 1):length(fileContents)]
  newHeader = readLines("header")
  fileWithNewHeader = c(newHeader, strippedOfHeader)
  writeLines(fileWithNewHeader, fileName)
}

# Store file names of files already present
contents0 = dir()

# Post-process .md file
ReplaceHeader("index.md")

# Move new files one level up
newFiles = contents0[!grepl(c(".Rmd|header|.Rproj|.R"),
                            contents0,
                            fixed = FALSE)]
lapply(newFiles, function(x) {
  system(paste("cp -r", x, "../"))
  system(paste("rm -rf", x))
})
