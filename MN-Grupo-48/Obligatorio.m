tic#contador tiempo
load flujosh; #cargar flujos componenete h, matriz 8x2
load flujosv; #cargar flujos componenete v, matriz 7x2
load newflujos42; #cargar flujos componenete S_t, matriz 42x2, primera columna es t, segunda valor del flujo (no contiene todos los flujos)

#notar que 8x7 = 56 ecuaciones

n = 8;#filas
m = 7;#columnas
incognitas=2*m*n-m-n;#2x8x7-8-7= 97 incognitas
datos=newflujos42;#datos brindados, emplear para reducir incognitas
#-------------------------------------------------------------------------------

#Definicion matriz b(solo relacion flujos frontera, sin saber ningun tramo)
b = defMatriz_b(n,m,flujosh,flujosv);
#Definicion matriz A
A = defMatriz_A(n,m);
#brindarle información de ciertos tramos
[nA,nb] = brindarFlujos(A,b,datos,length(datos));#nA matriz A modificada, nb matriz b modificada
Ab = [nA nb];#A|b
#disp(Ab)


###Pruebas Directas##--------------------------------------------------------------------------------
function [Ab nx tramos x] = solucionEscalerizacion(Ab,datos,incognitas)#nx sol incognitas, x todos los tramos, Ab matriz escalerizada, tramos id + valor tramos
  [Ab nx] = elimGauss_pivP(Ab);#devuelve matriz escalerizda y nx vector solucion de las incognitas
  tramos = todosLosTramos(datos,nx,incognitas,length(datos));#SOL de todos los tramos (incluye los conocidos de flujos)
  x=tramos(:,2);#vector solución, todos los tramos (sin id), xTot = vector(#incognitas,1)
  return
endfunction

[AIb nx tramos x] = solucionEscalerizacion(Ab,datos,incognitas);
###Comparar contrabarra##------------------------------------------------------------------------------
#contraBarra(nA,nb,nx);

#disp(AIb);
#disp(nx);
#disp(tramos);
#disp(x);

###Pruebas Iterativos##-------------------------------------------------------------------------------
function [x_sol err iter] = pruebasIterativas(Ab)
  Ab(1,:)=[];#reducir fila Cl, para que A quede cuadrada 
  M = diagonalNoNula(Ab)#consigue que el rho(Qj),rho(Qg-s)<1 en valor abs, cond de convergencia
  A = M(:,1:(columns(M)-1));#Matriz cuadrada
  nb = M(:,columns(M));
  [x_sol err iter] = iterative_method(A,nb,0,1);  #Jacobi w optimo es 1(osea sin relajacion)
  #[x_sol err iter] = iterative_method(A,nb,1,1); #G-s matrices,A,b,0(Jacobi)<->1(Gs matricial),0<w<2 relajación
  [x_sol err iter] = gauss_SeidelOpt(A,nb,1);     #G-s entrada-entrada
  return
endfunction
[x_iter err nroIter] = pruebasIterativas(Ab);
#disp(x_iter);
#disp(err);
#disp(nroIter);

###Caso Puente##-------------------------------------------------------------------------------
function [tramosP TramosEnFuncionDePuente] = casoPuente(nA,nb,datos,incognitas,valorPuente)
  #caso especial- C5,5->C6,6 puente.
  s98 =  zeros(56,1);
  #union de C5,5->C6,6
  nA = [nA s98];
  nA(33,56)=-1;# setear coeficientes del puente C5,5
  nA(41,56)=1;# setear coeficientes del puente C6,6
  [pA xp]=elimGauss_pivP([nA nb]);#pA matriz escalerizada, xp valores en funcion de puente(S98)
  #valores del puente, 0<puente<=350 
  TramosEnFuncionDePuente=xp;
  xp(:,1)= xp(:,1) + valorPuente*xp(:,2);#actualizar sistema con valor puente
  
  tramosP = todosLosTramos(datos,xp(:,1),incognitas,length(datos));#matriz(i,2) valores tramos, (i,1) ids tramos 1<=i<=incognitas
  tramosP(98,1)=98;#definir puente
  tramosP(98,2)=valorPuente;
  xpt=tramosP(:,2);#vector solución, todos los tramos (sin id), xTot = vector(#incognitas,1)
  return
endfunction
[tramosP TramosEnFuncionDePuente] = casoPuente(nA,nb,datos,incognitas,0);
#disp(tramosP);
#disp(TramosEnFuncionDePuente);

toc#´mide´ tiempo junto con tic, 

