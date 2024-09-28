function [] = contraBarra(nA,nb,nx)
 disp("Ejecutando contraBarra Octave") 
 #Comparacion con \ Octave
 if(issquare(nA)==1) #si la matriz es cuadrada
  contraBarraOctave = nA\nb;
  disp(contraBarraOctave);
  if(nA\nb==nx)
    disp("contraBarraOctave con una fila que es CL de otra/s, es igual a nuestra solución");
  else
    disp("contraBarraOctave con una fila que es CL de otra/s, es diferente a nuestra solución por");
    disp(contraBarraOctave-nx);
  endif
 else#Comparacion con \ Octave con filas sin CL
  nA(56,:)=[];#Ahora nA es cuadrada, sino es cuadrada habra errores
  nb(56,:)=[];#esto para el caso que nos brinden mas de 41 flujos
  contraBarraOctave = nA\nb;
  disp(contraBarraOctave);
  if(contraBarraOctave==nx)
    disp("contraBarraOctave con una fila que es CL de otra/s, es igual a nuestra solución");
  else
    disp("contraBarraOctave con una fila que es CL de otra/s, es diferente a nuestra solución por");
    disp(contraBarraOctave-nx);
  endif
 endif 
endfunction
