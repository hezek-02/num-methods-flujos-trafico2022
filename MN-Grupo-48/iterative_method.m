function [x erR iter] = iterative_method (A,b,type,w)
  ##---------------------------------------------
  ## calculo del radio espectral : max(abs(eigs(Q)))
  ## type indica el metodo iterativo a utilizar: 0: Jacobi, 1: Gauss-Seidel
  ## w es utilizado en caso de que querer relajar el metodo.
  ## tol indica la toleracia durante las iteraciones, aproximacion relativa al problema

  ## Se retorna x_sol como la solucion obtenida y el vector erR con los errores
  ## obtenidos en cada iteración realizada.
  ##---------------------------------------------
  
  row=rows(A);
  col=columns(A);
  
  x=zeros(row,1);#x_0
  max_iter = 500; #cota de iteraciones
  tol = 0.001; #cota de error de convergencia
  iter=0; #nro de iteraciones
  
  E=-tril(A,-1); #matriz triangular inferior A(2:row,1:col);
  F=-triu(A,+1); #matriz tiangular superior  A(1:rows,2:col);
  D=diag(diag(A)); #matriz diagonal
  
  if(type==0)#Jacobi
    Di = invDiagonal(D,row); #inversa de la matriz
    Q = w*(Di*(E+F)) + (1-w)*eye(row); # Q de Jacobi
    r = (Di*b)*w; # r de Jacobi
    #disp(max(abs(eig(Q)))); #radio(espectral de Qj)
  else #Gauss-Seidel, matricial
    C = inv(D-w*E);
    Q = C*(w*F+(w-1)*D);# Q de Gs
    r = C*w*b;# r de Gs
    #disp(max(abs(eig(Q))));#radio(espectral de Qgs)
  endif

  ## Comienza iteraciones
  erR=1;
  while (iter<max_iter) && (erR>tol)#si nunca llegase a reducirse el residuo se corta por maxIter
    xAnt=x;
    x = Q*x + r;
    iter++;
    erR=norm(x-xAnt);
  endwhile
  
  function D = invDiagonal(D,filas)
   for i=1:filas
     D(i,i)=1/D(i,i);
   endfor
   return
  endfunction
  
  return
endfunction



