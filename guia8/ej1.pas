{) La siguiente función calcula la potencia n-ésima de un número X ( X n
 ) en forma iterativa, siendo n y
X enteros. Se pide:
a) Desarrollarla en forma recursiva.
b) Considerar n negativo. }

Program ej1;


function potenciaXn(X,N:integer):real;
begin
  if(N=0)then 
    potenciaXn:=1
  else 
   begin
     if(N=0) then
        potenciaXn:=1
     else 
        if(N>0) then
         potenciaXn:= X * potenciaXn(X,N-1)
        else 
         potenciaXn:= (1/X) * potenciaXn(X,N+1); 
   end;  
  
end;




begin
  WriteLn(potenciaXn(-1,2):8:4);
end.