

distanceCalculation=function(a,b,type)
{
  
  if (type=='manhattan'){d=manhattan(a,b);} 
  else if (type=='euclidean') {d=euclidean(a,b);}
  else if (type=='cosine') {d=cosine(a,b);}
  else if(type=='dice') {d=dice(a,b);}
  else if(type=='jacard') {d=jacard(a,b);}
  return(d);
  
}

manhattan=function(a,b)
{
  
  d=sum(abs(a-b));
  return(d)
}


euclidean=function(a,b)
{
  d=sum(sqrt((a-b)*(a-b)));
  return(d);
}

cosine=function(a,b)
{
  den=sqrt(sum(a*a))*sqrt(sum(b*b));
  d=sum(a*b)/den;
  return(d);
}

dice=function(a,b)
{
  den=sqrt(sum(a*a))+sqrt(sum(b*b));
  d=2*sum(a*b)/den;
  return(d);
}

jacard=function(a,b)
{
  den=sqrt(sum(a*a))+sqrt(sum(b*b))-sqrt(sum(a*b));
  d=sum(a*b)/den;  
  return(d);
}

weight=function(r,type)
{
  
  if( type=='leasthalf')
  {
    a=0;
    b=0.5;
  }
  else if(type=='most'){
    a=0.3;
    b=0.8;
  }
  else if(type=='asmany'){
    a=0.5;
    b=1;
  }
  if (r>=0 && r<a){q=0;}
  else if(r>=a && r<=b){q=(r-a)/(b-a);}
  else q=1;
  
  return(q);
}

agregation=function(preferences,M,N,quantifier)
{
  w=array(0,M);
  agregated=data.frame(matrix(0,N,N));
  a=matrix(0,1,M);
  
  print('Estoy en agregacion GDMR2')
  for(i in 1:M){
    w[i]=weight(i/M,quantifier)-weight((i-1)/M,quantifier);
  }
  
  agregated=apply(preferences,2,owa,w= w)
  return(agregated);
}


exploitation=function(agregated,N,dominance,quantifier)
{
  #quantifier='most';
  #dominance degree
  w=array(1,N);
  GDD=matrix(0,1,N);
  GNDD=matrix(0,1,N);
  ps=matrix(0,1,N);
  for (i in 1:N){
    w[i]=weight(i/N,quantifier)-weight((i-1)/N,quantifier);
  }
  for (i in 1:N){
    GDD[i]=owa(agregated[i,],w);
    for (j in 1:N){
      ps[j]=max(c(agregated[j,i]-agregated[i,j],0));
    }
    GNDD[i]=owa(1-ps,w);
    
  }
  #GDD
  #GNDD
  if(dominance=='GDD')
  {
    final=max(GDD);
  }
  else{final=max(GNDD);}
  tabla=rbind(GDD/max(GDD),GNDD/max(GNDD));
  rownames(tabla)=c('GDD','GNDD');
  colnames(tabla) <- 1:N;
  
  return (tabla);
}

owa=function(A,w){
  h=sum(sort(A,decreasing = TRUE)*w);
  return(h);
}



proximity=function(M,N,preferences,agregated)
{
  #***********CONSENSUS MEASURES************************************
  #Level 1 Preference level 
  #Obtengo la Combinaci?n de m elemetos tomados de n en matrices de dimensi?n nxn 
  #browser();
  
  npref=N*N-N;
  
  
  prox_level1=data.frame(matrix(0,M,npref));
  dist_level1=data.frame(matrix(0,M,npref));
  prox_level2=data.frame(matrix(0,M,N));
  dist_level2=data.frame(matrix(0,M,N));
  aux=vector();

  
  cont=1;
  
  for (m1 in 1:M)
  {
   
        for (i in 1:npref)
        {
          
          a=preferences[m1,i];
          b=agregated[i];
          dist_level1[m1,i]=distanceCalculation(a,b,distance);
          
          
        }

    
  }
  prox_level1=1-dist_level1;
  #print(prox_level1)
  
  #level11=apply(preferences,1,distanceCalculation, b, distance)
  
  
  #print(level1);
  #browser();
  
  #Level 2 Alternative Level
  
  
  cont=1;
  
  
  for (m in 1:M)
  {
    
    for (i in seq(1, ((N-1)*(N-1)+1), N-1)) 
    {          
      a=preferences[m,i:(i+N-2)];
      b=agregated[i:(i+N-2)];
      valor=distanceCalculation(a,b,distance);
      aux=c(aux,valor)
      
    }
    dist_level2[cont,]=aux;
    cont=cont+1;
    aux=vector();
    
  }
  prox_level2=1-dist_level2;
  #print(prox_level2)
  

  
  
  #Proximity level3
  
  proximity_level3_experts<<- apply(prox_level2, 1, mean);
  #barplot( proximity_level3_experts, main="Experts' Proximity level to the agregated solution",  xlab="Expert")
  
  proximity_level3_alternatives<<- apply(prox_level2, 2, mean);
  #barplot( proximity_level3_alternatives, main="Alternatives' Proximity to the aggregated solution",  xlab="Alternative")
  
  
  #print(proximity_level3_experts)
  
}





consensus=function(M,N,preferences,distance)
{
  #***********CONSENSUS MEASURES************************************
  #Level 1 Preference level 
  #Obtengo la Combinaci?n de m elemetos tomados de n en matrices de dimensi?n nxn 
  #browser();
  
  npref<<-N*N-N;
  numMa<<-factorial(M)/(factorial(2)*factorial(M-2));
  consensusExperts<<-data.frame(matrix(0,M,M))
  level1<<-data.frame(matrix(0,numMa,npref));
  
  cont=1;
  
  for (m1 in 1:M)
  {
    for (m2 in (m1+1):M)
    {
      if (cont<=numMa){
        for (i in 1:npref)
        {
          
          a=preferences[m1,i];
          b=preferences[m2,i];
          level1[cont,i]=distanceCalculation(a,b,distance);
          
          
        }
      }
      
      cont=cont+1;
    }
  }
  

  #print(level1);
  #browser();
  
  #Level 2 Alternative Level
  

  
  distance_level2<<-data.frame(matrix(0,numMa,N));
  cont=1;
  
  for (m1 in 1:(M-1))
  { 
    
    for (m2 in (m1+1):M)
    {
      aux=vector();
      i=1;
      
      if (cont<=numMa){
        for (i in seq(1, ((N-1)*(N-1)+1), N-1)) 
        {          
          a=preferences[m1,i:(i+N-2)];
          b=preferences[m2,i:(i+N-2)];
          valor=distanceCalculation(a,b,distance);
          aux=c(aux,valor)
          
        }
        #print(m1)
        #print(m2)
        distance_level2[cont,]=aux;
        consensusExperts[m1,m2]<<-mean(1-aux);
        consensusExperts[m2,m1]<<-mean(1-aux);
      }
      cont=cont+1;
      # print(cont)
    }
  }
  
  print('Distance between experts for each alternative, Position (1,1) Means distance between expert 1 and 2 for the first alternative')
  print('Position (1,2) means distance between expert 1,2 for de second alternative')
  #print(distance_level2) 
  
  #Similarity level2
  similarity_level2<<-data.frame(matrix(0,numMa,N));
  similarity_level2<<-1-distance_level2;
  
  # Level 3 on experts
  
  similarity_level3_experts<<-apply(similarity_level2, 1, mean);
  
  mean_consensus_perExpert<<-apply( consensusExperts, 1, sum)/(M-1);
  
  #barplot( similarity_level3_experts, main="Experts'  Similarity level ",  xlab="Expert",col=heat.colors(12))
  similarity_level3_alternatives<<- apply(similarity_level2, 2, mean);
  
  #barplot( similarity_level3_alternatives, main="Alternatives'  Similarity level ",  xlab="Expert", col=heat.colors(12))
  
  
  
  consesus_global<<-mean(similarity_level3_alternatives)
  
  return (consesus_global);#,level1,level2,level3);
}


completenes=function(N,preference)
{
  
  numberIncom=length(which(is.na(preference)));
  completennesLevel=((N*N-N)-numberIncom)/(N*N-N);
  return (completennesLevel);
}


dataFrame2Matrix=function(df,N)
{
  
  contador=1;
  matriz=matrix(NA,N,N)
  for (i in 1:N)
  {
    for (j in 1:N)
    {
      if(i==j)
      {
        matriz[i,j]=0.5;
      }
      else
      {
        matriz[i,j]=df[contador];
        contador=contador+1;
      }
    }
  }
  return (matriz);
  
}

matrix2dataFrame=function(matrix,N)
{
  
  
}
