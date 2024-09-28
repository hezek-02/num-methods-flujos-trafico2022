
function b = defMatriz_b (filas,columnas,flujosh,flujosv)
 b=zeros(filas*columnas,1);
 idx = 1;
 signoFlujo = -1;
 for i=1:filas #O(filas)
  b(idx,1) = signoFlujo*flujosh(i,1);#hi,1
  signoFlujo = -signoFlujo;
  idx = idx+columnas-1;
  b(idx,1) = signoFlujo*flujosh(i,2);#hi,2
  idx=idx+1;
 endfor
 idx=1;
 signoFlujo = 1;
 for j=1:columnas #O(columnas)
  b(idx,1) = b(idx,1) + signoFlujo*flujosv(1,j);#v1,j 
  signoFlujo = -signoFlujo;
  idx = idx+columnas*(filas-1);
  b(idx,1) = b(idx,1) + signoFlujo*flujosv(2,j);#v2,j
  idx= idx+1-(columnas*(filas-1));
 endfor
 return
endfunction
