## El algoritmo permite dejar la matriz con sus diagonales no nulas pivoteando unicamente las filas.
function A = diagonalNoNula(A)
  filas=rows(A);
  cols=columns(A);

  ## registro con cantidad de filas con valor distinto a 0 para cada incognita(columna) del sistema(matriz)
  ## y marcar si se encuentran ubicadas en alguna diagonal.
  visited=zeros(0,0);

  ## se completa el registro visited, para cada columna(incognita) se recorre todas las filas y se realizan
  ## operaciones de orden constante, matriz de tamaño n*(n+1) --> O(n^2)
  for j=1:cols-1
    count=0;
    for i=1:filas
      if (A(i,j)!=0)
        count++;
      end
    end
    visited=[visited;[count 0]];
  end

  ## Se itera hasta comprobar que cada incognita se encuentra ubicada en una diagonal, en cada iteración es seguro
  ## que se ubica una fila en el lugar correspondiente por tanto seran n iteraciones.
  ## las operaciones realizadas en cada iteración son suma de O(n).
  for h=1:cols-1
    ## obtener el minimo en una lista de tamaño n. O(n)
    m = getMin(visited);

    ## solo es necesario pivotear si la diagonal de la incognita siendo considerada presenta un 0
    if(A(m,m)==0)
      ## se obtiene la primera fila con valor distinto a 0 y dicha fila no ha sido fijada, en el peor caso nos llevara O(n).
      rw = foundNext(A,m,visited);

      ## pivoteo de las filas
      if (rw<=m)
        A([rw m],:) = A([m rw],:);
      else
        A([m rw],:) = A([rw m],:);
      end
    end

    visited(m,2)=1; #se marca como fijada la fila para la icognita siendo considerada

    ## se actualiza el registro por las incognitas que aparecen en la fila fijada
    for k=1:cols-1
      if(A(m,k)!=0)
        visited(k,1)--;
      end
    end
  end
endfunction

function m = getMin(v)
  min_ac=5;
  m=0;
  for i=1:rows(v)
    if (v(i,1)<min_ac) && (v(i,2)==0)
      min_ac=v(i,1);
      m=i;
    end
  end
endfunction

function rw = foundNext(A,x,v)
    found=false;
    rw=0;
    while !found
      rw++;
      if (A(rw,x)!=0) && (v(rw,2)==0)
        found=true;
      endif
    endwhile
    return
endfunction
disp(A)