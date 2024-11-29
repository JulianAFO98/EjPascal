{Desarrollar un procedimiento recursivo que devuelva en un arreglo los máximos de cada fila de una
matriz de MxN. }
Program ej8;
type
TM = array [1..255,1..255] of integer;
TV = array [1..255] of integer;

procedure llenarDatos(var Matriz:TM;var N,M:byte);
var 
i,j:byte;
arch:text;
begin
  WriteLn('Ingrese N y M');
  ReadLn(N,M);
  Assign(arch,'ej8.txt');
  Reset(arch);
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      Read(arch,Matriz[i,j]);
   end;
   Close(arch);
end;




procedure GenerarArrMax(Matriz:TM;i,j,M:byte;var arrMax:TV);
var 
max:integer;
begin
   if(i>0) then 
    begin
      if(j>0) then 
       begin
         arrMax[i]:=matriz[i,j];
         GenerarArrMax(matriz,i,j-1,M,arrMax);
         if(matriz[i,j]>arrMax[i]) then 
          arrMax[i]:=Matriz[i,j];
       end
      else 
        GenerarArrMax(matriz,i-1,M,M,arrMax);
    end;
     

end;


procedure mostrarVec(vec:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   Write(vec[i],' ');
end;

var 
Mat:TM;
Vec:TV;
N,M:byte;

begin
  llenarDatos(Mat,N,M);
  GenerarArrMax(Mat,N,M,M,vec);
  mostrarVec(Vec,N);
end.

//OPCION 2


{function calcularMaxFila(matriz:TM;fila,M:byte):integer;
var 
max:integer;
begin
  if(M>1)then
   begin
     max:=calcularMaxFila(matriz,fila,M-1);
     if(max>matriz[fila,M]) then
        calcularMaxFila:=max
     else 
        calcularMaxFila:=matriz[fila,M];   
   end 
  else 
   calcularMaxFila:=matriz[fila,M];
end;

procedure GenerarArrMax(Matriz:TM;i,M:byte;var arrMax:TV);
begin
   if(i>0) then 
    begin
      arrMax[i]:=calcularMaxFila(Matriz,i,M);
      GenerarArrMax(matriz,i-1,M,arrMax);
    end;
     

end;}