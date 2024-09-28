#Une los flujos de tramos previamente conocidos y los descubiertos, de manera ordenada
#1era col id tramo; 2da col valor tramo
function tramos = todosLosTramos(flujos,x,incognitas,conocidos)
  tramos = zeros(incognitas,2);
  id=1;
  id2=1;
  for i=1:incognitas
   if (id<=conocidos && flujos(id,1)==i)
       tramos(i,2)=flujos(id,2);
       id = id+1;
    else
       tramos(i,2)=x(id2,1);
       id2=id2+1;
   endif
   tramos(i,1)=i;
  endfor
  return
end
