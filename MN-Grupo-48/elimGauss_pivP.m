
function [M,x] = elimGauss_pivP(M)
  #M=A|b
  columnas = columns(M);#columnas matriz ampliada A|b
  filas = rows(M);#filas =A=b=A|b
  columnasA = columnas-1;#columnas A
  for j=1:columnasA#recorrar columnnas desde 1 hasta A inclusive, por si se hace 0s una fila, si rango = filas entonces basta recorrer de 1...A-1
   M = pivoteoParcial(M,j,filas); #pivoteo Parcial en M(j,j)
    for i=j+1:filas#escalerizar
      if (M(j,j)==0)
       error("Mal");
      elseif (M(i,j) != 0)#ahorrar procesamiento
         l = M(i,j)/M(j,j);#coef de simplificacion pivote
         M(i,j:columnas) = M(i,j:columnas) - l*M(j,j:columnas);#restarse su valor y simplificar valor de pivot, al sumarse
      endif
    endfor
  endfor
  #reducir filas nulas
  while(M(filas,filas)==0 && M(filas,columnas)==0)
   M(filas,:)=[];
   filas = filas-1;
  endwhile

  if (columnasA>filas)#A no es cuadrada escalerizacion hacia arriba
   x = casoPuente(M,filas,columnas,columnasA);
  else#A es cuadrada
   x = zeros(columnasA,1);
   x = sustitucionHaciaAtras(M,filas,columnasA,columnas,x);
   endif
  return
endfunction

function x = sustitucionHaciaAtras(M,filas,columnasA,columnas,x)
  for i=filas:-1:1#recorrer filas de A, desde la anteultima hasta la primera
    if(M(i,i)!=0)
      x(i,1) = (M(i,columnas)-M(i,i+1:columnasA)*x(i+1:columnasA,1))/M(i,i);# en i+1:columnasA = for j=i+1:columnasA
    else
       disp("sistema incompatible ó bien compatible indeterminado");
    endif
  endfor
  return
endfunction

function x = casoPuente(M,filas,columnas,columnasA)
  for j=filas:-1:1#recorrar columnnas desde la ultima a la primera
    for i=j-1:-1:1#escalerizacion hacia arriba
      if (M(i,j) != 0)#ahorrar procesamiento
         l = M(i,j)/M(j,j);#coef de simplificacion pivote
         M(i,j:columnas) = M(i,j:columnas) - l*M(j,j:columnas);#restarse su valor y simplificar valor de pivot, al sumarse
      endif
    endfor
 endfor
  #disp(M);
  x=zeros(columnasA-1,1);
  puente=M(:,columnasA);#tomar columna puente
  M(:,columnasA)=[];#eliminar columna puente
  columnasA = columnasA-1;#actualizar columnas
  columnas = columnas-1;
  for i=1:filas
    x(i,1)=M(i,columnas)/M(i,i);#despeje diagonales
    if(puente(i,1)!=0 && M(i,i)>0)#cambio signo
     puente(i,1)=-puente(i,1);
    endif
  endfor
   x=[x puente];
  return
endfunction

