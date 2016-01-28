

feedback=function(preferencesDF,NAlternatives,NExperts)
{

  dataset=data.frame(matrix(NA, nrow = NExperts, ncol = NAlternatives*NAlternatives))
  for (i in 1:NExperts) {
    for (j in 1:(NAlternatives*NAlternatives)) {
      valor=preferencesDF[i,j]+sign(runif(1,-1,1))*runif(1,0,diferencia);

      if (valor<0)
        valor=0;
      if (valor > 1)
        valor =1;

      dataset[i,j]=valor;
    }
  }

  return (dataset);

}
