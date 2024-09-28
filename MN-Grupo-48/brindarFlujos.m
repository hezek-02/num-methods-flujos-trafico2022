#prec: los tramos pertenecen a [1,columnas(A)] y [1,filas(b)],
function [newA,newb] = brindarFlujos(A,b,flujos,qtyTramos)
  
  #flujos 42x2,(x,1) id tramo, (x,2) valor tramo
  
for x=qtyTramos:-1:1 #iterar valores flujo
    col = flujos(x,1);#id del tramo (columna de A)
    valorTramo = flujos(x,2);#valor del tramo (columna de A)
    valorDescubierto = valorTramo*A(:,col);#brindar informacion
    A(:,col)= [];#eliminar columna incognita
    b=b-valorDescubierto;#añadir informacion
  endfor 
  newA=A;
  newb=b;
  return
endfunction
