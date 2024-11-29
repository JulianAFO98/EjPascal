{Dado un arreglo V de N elementos ordenados en forma ascendente con componentes repetidas, 
generar W con la frecuencia de los elementos de V. Mostrar W 
Ejemplo: N=10; V=(2,2,3,3,3,3,7,9,9,9)    W=(2,4,1,3)}

Program ej8;
type 
TV = array [1..10] of byte;

procedure GenerarW(V:TV;N1:byte;var W:TV;var N2:byte);
var 
i:byte;
numEvaluado:byte;
begin
  N2:=0;
  if(N1<>0)then
    begin
      numEvaluado:=V[1];
      N2:=N2+1;
      W[N2]:=1;
    end;
    
  for i:=2 to N1 do 
   begin
     if(numEvaluado=V[i]) then
       begin
         W[N2]:=W[N2]+1;
       end
     else 
       begin
         numEvaluado:=V[i];
         N2:=N2+1;
         W[N2]:=1;
       end;  
   end;
end;

procedure mostrarVec(W:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(W[i],' ');
   end;
   WriteLn();
end;

const 
V : TV = (2,2,3,3,3,3,7,9,9,9);
N = 10;
var 
W:TV;
WN:byte;
begin
  GenerarW(V,N,W,WN);
  mostrarVec(W,WN);
end.