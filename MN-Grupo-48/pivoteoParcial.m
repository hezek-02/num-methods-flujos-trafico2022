function A = pivoteoParcial(A,c_actual,filas)#es local a cada columna
  vMax=A(c_actual,c_actual);
  f_Max = c_actual;
  for i=c_actual+1:filas#recorre las filas
    if (A(i,c_actual) > abs(vMax))#hay nueva fila con valor mayor en su columna correspondiente
      vMax = A(i,c_actual);
      f_Max = i;#guardar fila con valor maximo
    endif
  endfor
  A([c_actual f_Max],:) = A([f_Max c_actual],:); #cambiar fila j por fila i
  return  
endfunction
