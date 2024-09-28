function [x erR iter] = gauss_SeidelOpt(A,b,w)#prec A cuadrada
  # 0<w<2, si w=1, equivalente G-S sin relajacion
  #w<1 sub-relajacion, posible convergencia si antes no lo hacia
  #w>1 sobre-relajacion, convergencia mas rapida, si convergia anteriormente
  #w>2 diverge
  filas=rows(A);
  columnas=columns(A);
  maxIter = 500;
  x=zeros(columnas,1);#x0
  tolerancia = 0.001;
  erR=1;#error de convergencia
  iter=0;

  while (erR>tolerancia && iter<maxIter)#def G-S
    xAnt = x;
    for i=1:filas#cada xi
      sum = b(i,1) - A(i,[1:i-1  i+1:filas])*x([1:i-1  i+1:filas],1);
      x(i,1) =(sum)*w/A(i,i)+(1-w)*x(i,1);
    endfor
    iter++;
    erR=norm(x-xAnt);
  endwhile
  return
endfunction
