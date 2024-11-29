{) Indicar las modificaciones que serían necesarias para utilizar un tipo procedimiento, en lugar de
TFunc, muestre los cambios para el punto i. del inciso a) }

program ej10;
type
TM= array [1..255,1..255] of integer;
Tfunc = function (mat:TM;FoC,N:byte):real; // Seria un TProce = procedure (Params);


function PromFila(matriz:TM;FoC,N:byte):real; // Seria un procedimiento que tendria max como parametro Var o por referencia, donde modificaria su valor;
var 
j:byte;
acum:real;
begin
  acum:=0;
  for j:=1 to N do 
    begin
      acum:=acum+matriz[Foc,j];
    end;
   PromFila:=acum/N; 
end;

function PromCol(matriz:TM;FoC,N:byte):real;
var 
i:byte;
acum:real;
begin
  acum:=0;
  for i:=1 to N do 
    begin
      acum:=acum+matriz[i,FoC];
    end;
   PromCol:=acum/N; 
end;

procedure llenarDatos(var mat:TM;var N:byte);
var 
i,j:byte;
begin
  WriteLn('Ingrese N');
  ReadLn(N);
  for i:=1 to N do 
   for j:=1 to N do 
     begin
        WriteLn('Ingrese el valor de la pos ',i,',',j);
        readln(mat[i,j]);
     end;
end;

Procedure Maximo (Mat:TM; N:Byte; Func:TFunc; var maxk:Byte);
Var
max, prom: real;
k: byte;
Begin
  max:= Func(Mat, 1, N);  // No haria una asignacion, llamaria al procedimiento con max como parametro; Proce(Mat,1,N,max);
  maxk:= 1;
  For k:= 2 to N do
   Begin
    prom := Func(Mat, k, N);
    if max < prom then
      begin
        max := prom;
        maxk := k;
      end;
   end;
End;

procedure mostrarMatriz(matriz:TM;N:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to N do 
       begin
         Write(matriz[i,j],' ');
       end;
      WriteLn;
   end;
end;


var 
mat:TM;
N:byte;
funcElegida:Tfunc;
maxk:byte;
begin
  llenarDatos(mat,N);
  funcElegida:=@PromFila; //ProceEle:=@PromFila;
  Maximo(mat,N,funcElegida,maxk); // Maximo(mat,N,ProceEle,maxk);
  mostrarMatriz(mat,N);
  WriteLn('La fila de mayor promedio es: ',maxk);
  funcElegida:=@PromCol;
  Maximo(mat,N,funcElegida,maxk);
   WriteLn('La columna de mayor promedio es: ',maxk);
end.