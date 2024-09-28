

function A = defMatriz_A(filas,columnas)
 
 A=zeros(filas*columnas,2*filas*columnas-filas-columnas);
 tramo = 1;#tramo inicial
 coefTramo=-1;#coef tramo ini flujos horizontales
 pos=0;
 #Definir coef de tramos horizontales (n(m-1))
 for i=1:filas
  for j=1:columnas
    pos=pos+1;
   if(j == 1)#Parte de columna 1
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;#flujo de ese tramo cambia de estado para proxima interseccion
   elseif(j==columnas)#llego a columna m
     A(pos,tramo)=coefTramo;
     tramo = tramo + 1;
   else
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
     tramo = tramo + 1; #tramo siguiente
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
   endif
  endfor
  #disp(pos);
 endfor
 
 #Definir coef de tramos verticales (m(n-1))
 coefTramo = 1;#coef inicial para tramos verticales
 for i=1:columnas
  for j=0:filas-1
   pos=i+j*columnas;
   if(j==0)#si en la primera fila
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
   elseif(j==filas-1)#si esta en la ultima fila
     A(pos,tramo)=coefTramo;
     tramo = tramo + 1;#tramo siguiente
   else
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
     tramo = tramo + 1; 
     A(pos,tramo)=coefTramo;
     coefTramo = -coefTramo;
  endif
  # disp(pos);
  endfor
 endfor

 return
endfunction
