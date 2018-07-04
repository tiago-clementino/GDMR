library(GDMR)
library(here)

simulator=function(pref,m,n,distance='euclidean',quantifier='leasthalf',level=3,threeshold=.8,max_iterations=8){#,consistent=TRUE){

  #n=4;
  #m=6;
  #consistent=TRUE;
  #quantifier='leasthalf';
  #distance='euclidean';
  dominance='GDD';
  delta=1.;

  consesus_global=.0;
  #threeshold=.8;

  #pref=matrix(0,m,n*n-n);
  #for (i in 1:m) {
  #  pref[i,]=generatePref(n,consistent);
  #}



  #max_iterations=8;

  pref_agregated=NULL;

  count=0;
  pref_agregated=agregation(pref,m,n,quantifier);
  consesus_global=consensus(m,n,pref,pref_agregated,distance,quantifier,level);
  initial_consensus=consesus_global;
  while((consesus_global <= threeshold)&&(max_iterations >= count)){



    prox=proximity(m,n,pref,pref_agregated,distance);
    pref=feedback(pref_agregated,prox,pref,m,n,delta,threeshold,quantifier);

    pref_agregated=agregation(pref,m,n,quantifier);

    consesus_global=consensus(m,n,pref,pref_agregated,distance,quantifier,level);

    count=count+1;
  }

  soluction_table=exploitation(pref_agregated,n,dominance,quantifier);

  soluction_table

  consesus_global

  return (data.frame(initial_consensus,consesus_global,count,distance,quantifier,m,n,level));

}

generate_sample=function(){

  M=c(4,6,8,10,12);
  N=c(4,6,8);
  consensus<-data.frame();

  count = 0;

  for (m in M) {
    for (n in N) {

      pref=matrix(0,m,n*n-n);
      for (i in 1:m) {
        pref[i,]=generatePref(n,TRUE);
      }
      count = count + 1;

      for (level in 1:3){
        for (i in 1:3) {

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='manhattan',quantifier='asmany',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });


          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='euclidean',quantifier='asmany',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='cosine',quantifier='asmany',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='dice',quantifier='asmany',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='jacard',quantifier='asmany',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='manhattan',quantifier='leasthalf',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='euclidean',quantifier='leasthalf',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='cosine',quantifier='leasthalf',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='dice',quantifier='leasthalf',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='jacard',quantifier='leasthalf',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='manhattan',quantifier='most',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='euclidean',quantifier='most',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='cosine',quantifier='most',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='dice',quantifier='most',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });

          tryCatch({
            consensus <- rbind(consensus,cbind(simulator(pref,m,n,distance='jacard',quantifier='most',level),count));

          }, warning = function(w) {
            #print('Estoy en 1')
          }, error = function(e) {
            #print('Estoy en 2')
          }, finally = {
            #print('Estoy en 3')
          });


        }
      }


    }
  }

  out_file = here("./ASCSODSMOCIGDM/data/data2.csv")

  message("Salvando em ", out_file)

  names(consensus)<-c('initial consensus','final consensus','iterations','distance','quantifier','experts','alternatives','level','sample');

  write.csv(consensus,out_file)
}
