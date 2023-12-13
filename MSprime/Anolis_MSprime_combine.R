
args<-commandArgs(TRUE);
directory <- getwd()

Outputprefix <- args[1]


Files <- list.files(pattern = '*.str')

Dat <- list()
for (i in 1:length(Files)) {
  Dat[[i]] <- read.table(Files[i], header = FALSE)
}


Dat_Final <- do.call(cbind, Dat)



write.table(Dat_Final, paste(Outputprefix, '.str'), quote = FALSE, col.names = FALSE, row.names = FALSE)
