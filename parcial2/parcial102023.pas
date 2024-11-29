program parcial102023;
Type 
str10=string[10];
TregCereal = record 
  tipo:str10;
  precioTone:real;
end;
TVCereal = array [1..255] of TregCereal;
TRegSilo = record 
  codigoSilo:byte;
  PrecioFinal:real;
end;
TVR= array [1..255] of TRegSilo;
TM = array[1..255,1..255] of real;



procedure mostrarMatriz(Matriz: TM; N, M: byte);
var
  i, j: byte;
begin
  WriteLn('Matriz de Toneladas:');
  for i := 1 to N do
  begin
    for j := 1 to M do
      Write(Matriz[i, j]:10:2, ' ');  
    WriteLn;  
  end;
end;

procedure mostrarVecCere(Vec: TVCereal; N: byte);
var
  i: byte;
begin
  WriteLn('Listado de Cereales:');
  WriteLn('Tipo      | Precio por Tonelada');
  WriteLn('------------------------------');
  for i := 1 to N do
    WriteLn(Vec[i].tipo:10, ' | ', Vec[i].precioTone:10:2);
end;

procedure mostrarArregloGenerado(Arr: TVR; K: byte);
var
  i: byte;
begin
  WriteLn('Arreglo Generado (Silos con Precio Final):');
  WriteLn('Codigo Silo | Precio Final');
  WriteLn('--------------------------');
  for i := 1 to K do
    WriteLn(Arr[i].codigoSilo:10, ' | ', Arr[i].PrecioFinal:10:2);
end;




function buscarPosCereal(vec:TVCereal;tipoC:str10;N:byte):byte;
var
i:byte; 
begin
  i:=1;
  while (i<=N) and (tipoC<>vec[i].tipo) do 
   i:=i+1;
  buscarPosCereal:=i; 
end;

procedure llenarMatriz(var MatrizTone:TM;Vec:TVCereal;N:byte;M:byte);
var
arch:text;
NumSilo,pos:byte;
tipoC:str10;
Toneladas:real; 
extra:char;
begin
  Assign(Arch,'exportaciones.txt');
  Reset(Arch);
  while not eof(arch) do
    begin
      ReadLn(arch,NumSilo,extra,tipoC,Toneladas);
      pos:=buscarPosCereal(Vec,tipoC,N);
      MatrizTone[pos,NumSilo]:=MatrizTone[pos,NumSilo]+Toneladas;
    end;
  Close(Arch);  
end;

procedure inicializarMatriz(var MatrizTone:TM;N:byte;var M:byte);
var 
i,j:byte;
begin
  M:=10;
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        MatrizTone[i,j]:=0;
      end;
   end;
end;

procedure llenarCereales(var Vec:TVCereal;var N:byte);
var 
 arch:text;
begin
  Assign(arch,'cereales.txt');
  reset(Arch);
  while not eof (Arch) do 
   begin
     N:=N+1;
     ReadLn(Arch,Vec[N].tipo,Vec[N].precioTone);
   end;
  close(Arch); 
end;

function ContarSilos(matriz:TM;fila,columnas:byte):byte;
var
j,cont:byte; 
begin
  cont:=0;
  for j:=1 to columnas do 
   begin
     if(matriz[fila,j]<>0)then 
      cont:=cont+1;
   end;
   ContarSilos:=cont;
end;

procedure InformarEnCuantosSilosEsta(MatrizTone:TM;vec:TVCereal;N,M:byte;cerealBuscado:str10);
var 
 posCereal,contSilos:byte;
begin
   posCereal:=buscarPosCereal(Vec,cerealBuscado,N);
   contSilos:=ContarSilos(MatrizTone,posCereal,M);
   if(contSilos=0) then 
    WriteLn('Ningun silo almaceno ',cerealBuscado)
   else 
    WriteLn(contSilos,' silos almacenaron ',cerealBuscado); 
end;


function calcularPrecioFinal(importe:real):real;
begin
  if(importe>=100000000) then 
   importe:=importe*1.25
  else 
   importe:=importe*0.95;
  calcularPrecioFinal:=importe;  
end;

procedure GenerarVector(matriz:TM;VecCereal:TVCereal;N,M:byte;Z:real;var arregloGene:TVR;var K:byte);
var 
cont:byte;
importeTotal:real;
i,j:byte;
begin
  K:=0;
  for j:=1 to M do 
   begin
     cont:=0;
     importeTotal:=0;
     for i:=1 to N do 
      begin
        if(matriz[i,j]>Z) then 
         begin
           cont:=cont+1;
           importeTotal:=importeTotal+(VecCereal[i].precioTone*360);
         end;
      end;
      if(cont = M) then 
        begin
          K:=K+1;
          ArregloGene[K].codigoSilo:=j;
          arregloGene[K].PrecioFinal:=calcularPrecioFinal(importeTotal);
        end;
   end;
end;



var
VectCereal:TVCereal;
MatrizTone:TM;
N,M,K:byte;
Z:real;
cerealBuscado:str10;
ArregloGenerado:TVR;

begin
  llenarCereales(VectCereal,N);
  InicializarMatriz(MatrizTone,N,M);
  llenarMatriz(MatrizTone,VectCereal,N,M);
  mostrarMatriz(MatrizTone,N,M);
  mostrarVecCere(VectCereal,N);
  //a
  WriteLn('Ingrese un cereal');
  ReadLn(cerealBuscado);
  InformarEnCuantosSilosEsta(MatrizTone,VectCereal,N,M,cerealBuscado);
  //b
  WriteLn('Ingrese Z');
  ReadLn(Z);
  GenerarVector(MatrizTone,VectCereal,N,M,Z,ArregloGenerado,K);
  mostrarArregloGenerado(ArregloGenerado,K);
end.




//Recursividad
{type 
  TM = array[1..255, 1..255] of byte;
  TV = array[1..255] of byte;

procedure llenarMatriz(var matriz: TM; n, m: byte);
var
  i, j: byte;
begin
  writeln('Llenado de la matriz:');
  for i := 1 to n do
    for j := 1 to m do
    begin
      write('Ingrese el valor para Matriz[', i, ',', j, ']: ');
      readln(matriz[i, j]);
    end;
end;

procedure llenarVector(var vector: TV; n: byte);
var
  i: byte;
begin
  writeln('Llenado del vector:');
  for i := 1 to n do
  begin
    write('Ingrese el valor para Vector[', i, ']: ');
    readln(vector[i]);
  end;
end;

function SonTodosMultiplos(matriz:TM;vector:TV;i,j:byte):boolean;
begin
  if(j=0) then 
   SonTodosMultiplos:=true
  else 
   begin
     if(matriz[i,j] mod vector[i] = 0) then 
      SonTodosMultiplos:=SonTodosMultiplos(matriz,vector,i,j-1)
     else 
      SonTodosMultiplos:=false; 
   end; 
end;

function CuantasFilasCumplen(matriz:TM;vector:TV;i,j:byte):byte;
begin
  if(i>0) then 
   begin
     if(SonTodosMultiplos(matriz,vector,i,j))then 
      CuantasFilasCumplen:=1+CuantasFilasCumplen(matriz,vector,i-1,j)
     else 
      CuantasFilasCumplen:=CuantasFilasCumplen(matriz,vector,i-1,j); 
   end
  else 
   CuantasFilasCumplen:=0; 
end;



var 
  Matriz: TM;
  Vector: TV;
  N, M: byte;

begin
  write('Ingrese el número de filas de la matriz: ');
  readln(N);
  write('Ingrese el número de columnas de la matriz: ');
  readln(M);
  llenarMatriz(Matriz, N, M);
  llenarVector(Vector, N);
  WriteLn('Cuantas filas cumplen:',CuantasFilasCumplen(matriz,vector,N,M));
end.}