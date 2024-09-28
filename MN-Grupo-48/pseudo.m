 #Definicion-A----------------------------------------------------------------------------------------
 coef = 1#coef inicial para tramos verticales
 #definir tramos horizontales
  Recorrer i=1 hasta columnas de ciudad 
    Recorrer j=1 hasta filas de ciudad
     pos=pos+1; #posicion del nodo 
     si (j==1)
       A(pos,tramo)=coef#definir coeficiente 
       coef*=-1 #cambiar signo tramo
     sino si(j==columnas de ciudad)#si esta en la ultima fila
       A(pos,tramo)=coef
       tramo+=1 #avanzar tramo
     sino
       A(pos,tramo)=coef
       coef*=-1 
       tramo+=1 
       A(pos,tramo)=coef
       coef*=-1 
      FinSi
    FinRecorrer
  FinRecorrer
 
#definir tramos verticales 
 coefTramo = 1;#coef inicial para tramos verticales
 Recorrer i=1 hasta columnas de ciudad
  Recorrer j=0 hasta filas de ciudad-1
   pos=i+j*columnas;
   Si(j==0)#si en la primera fila
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
   Sino Si(j==filas de ciudad-1)#si esta en la ultima fila
     A(pos,tramo)=coefTramo;
     tramo = tramo + 1;
   Sino
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
     tramo = tramo + 1; 
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
    FinSi
   FinRecorrer
  FinRecorrer
  
  
  
#Definicion-b----------------------------------------------------------------------------------------
 b=vector terminos indep.
 idx = 1 #posicion fila en b donde irá dicho flujo
 signoFlujo = -1 #Signo de flujo, entrante negativo, saliente positivo
 #Definir flujos dado valores horizontales de frontera
  Recorrer  i=1 hasta cantidad de filas de la ciudad/grilla
    b(idx,1) = signoFlujo*flujosh(i,1)#Asignarle valor hi,1 
    signoFlujo=-signoFlujo 
    idx = idx+columnas-1  #posicion del flujo fronterizo opuesto
    b(idx,1) = signoFlujo*flujosh(i,2) #Asignarle valor hi,2 
    idx=idx+1 #posicion del flujo fronterizo siguiente
  FinRecorrer  
 idx=1 
 signoFlujo = 1 
#Definir flujos dado valores verticales de frontera
  Recorrer j=1 hasta cantidad de columnas de la ciudad/grilla
    b(idx,1) = b(idx,1) + signoFlujo*flujosv(1,j) #Asignarle valor v1,j 
    signoFlujo = -signoFlujo 
    idx = idx+columnas*(filas-1)  
    b(idx,1) = b(idx,1) + signoFlujo*flujosv(2,j)# Asignarle valor v2,j 
    idx= idx+1-(columnas*(filas-1)) #posicion del flujo fronterizo siguiente
  FinRecorrer

#Brindar-flujos----------------------------------------------------------------------------------------------------------------------------------------------
  Recorrer x=cantidad de tramos provistos hasta 1 #iterar valores flujo
    col = flujos(x,1)  #id del tramo (columna de A)
    valorTramo = flujos(x,2)  #valor del tramo (columna de A)
    valorDescubierto = valorTramo*columna tramo(col) #brindar informacion
    eliminar columna anteriormente incognita
    b=b-valorDescubierto #añadir valores despejados
  FinRecorrer
    
#Eliminación-Gaussiana-Con-Pivoteo-Parcial------------------------------------------------------------------------------------------------
  M=A|b #matriz ampliada
  #Escalerizacion hacia abajo
  Recorrer j=1 hasta columnasA
   M = pivoteoParcial(M,columnaActual)#cambiar fila con mayor valor abs 
    Recorrer i=j+1 hasta filasA 
      Si (M(i,j) != 0)  #no lo va a simplificar
        l = M(i,j)/M(j,j) #coef de simplificacion pivote
        M(i,de j hasta columnasM) = M(i,de j hasta columnasM) - l*M(j,de j hasta columnasM)#simplificar filas  
      FinSi
    FinRecorrer
  FinRecorrer
  
  #sustitucionHaciaAtras------------------------------------------------------------------------------------------------------------------------
  Recorrer i=filasA hasta 1
   x(i,1)=(b(i,1)-A(i,i+1 hasta columnasA)*x(i+1 hasta columnasA,1))/A(i+1 hasta columnasA,i+1 hasta columnasA)              despeje y sust. 
  FinRecorrer
  
  
  
  
  
  
  
  
  
#reducir filas nulas-------------------------------------------------------------------------------------------------------------------------
  Mientras (Existan filas Nulas en A y su correspondencia en b sea nula)#fila de 0s en M
   Eliminar ultima fila
   filas = filas-1#actualizar cantidad de filas
  FinMientras
#Pivoteo-Parcial----------------------------------------------------------------------------------------------------------------------------------------
  #es local a cada columna
  maximo valor actual= diagonal(A|b) #valor maximo inicialmente es el valor de la diagonal
  fila_Maxima = columna_actual # fila con el valor maximo
  Recorrer i=columna actual+1 hasta filas 
    Si (fila actual >  abs(maximo valor actual))
      maximo valor actual = valorFilaActual #actualizar valor maximo
      fila_Maxima = i#guardar fila con valor maximo
    FinSi
  Cambiar fila actual por fila_Maxima
  

# casoPuente(M,filas,columnas,columnasA)----------------------------------------------------------------------------------------------
  Escalerizacion hacia arriba, analogo a menos de nivel de los indices a lo definido en elimGauss 
  x=vector solucion
  puente=M(todas las filas,puente=S98)#tomar columna puente
  eliminar columna puente de M
  columnasA = columnasA-1#actualizar columnas
  columnas = columnas-1
  Recorrer i=1 hasta filas
    x(i,1)=M(i,columnas)/M(i,i)#despeje diagonales
    Si(puente(i,1)!=0 && M(i,i)>0)#cambio signos en funcion del puente
     puente(i,1)=-puente(i,1)
    FinSi
   x=[x puente]#devolver el sis indeterminado
  FinRecorrer
  
#Jacobi forma matricial(A)
  max_itereraciones = 100 #condicion de corte maxima
  tol = 0.001 #tolerancia, condicion corte
  x=x0 #x0 inicial
  E=-matriz triangular inferior  
  F=-matriz tiangular superior   
  Di=matriz diagonal inversa
  Qj = w*(Di*(E+F)) + (1-w)*identidad(filasA) # Q de Jacobi con relajacion
  rj = (Di*b)*w # r de Jacobi con relajacion
  err=0
  Mientras (iteraciones<max_iteraciones y err>tol)#corta por maxIter maximo
    x_k = x_k+1;
    x_k+1 = Qj*x + rj #calcular x_{iter} 
    iter++#aumentar iterador
    err=norma(x_k+1 - x_k) # norma infinito,euclidia,etc
  FinMientras
  x_sol = x
#G-S forma iterativa directa
Mientras(err>tolerancia && iteraciones<max_iteraciones)#def G-S
    x_k=x_k+1;
    Recorrer i=1 hasta filasA#cada xi
      x_k+1(i) =b(i,1) - A(i,[de 1 a filasA-i])*x([1 a filasA-1],1)*w/A(i,i)+(1-w)*x(i,1)
    FinRecorrer
    iteraciones++#aumentar iteraciones
    err=norma(x_k+1-x_k)#actualizar error 
FinMientras