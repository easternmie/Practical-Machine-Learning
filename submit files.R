write.files <- function(x){

  if (!file.exists('submission')) {
    dir.create('submission')
  }
  
  n = length(x)
  for(i in 1:n){
    filename = paste0('submission/problem_id_',i,'.txt')
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}