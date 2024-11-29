Program recu2022;

type 
str15=string[15];
RegTrimestre = record 
   menores,mayores:word;
end;
RegEscala = record
  escala:string[15];
  cantidad:real;
end;  
RegAnios = record 
  anio:word;
  menores,mayores:real;
end;   
TM = array [1..255,1..255] of RegTrimestre;
TVA = array [1..255] of word;
TVR =  array [1..255] of RegEscala;
TVanio =  array [1..255] of RegAnios;

procedure llenarMyV(var turistas:TM;var vecAnios:TVA;var N,M:byte);
var 
arch:text;
i,j:byte;
begin
  Assign(arch,'turistas.txt');Reset(arch);
  ReadLn(arch,N);
  m:=4;
  for i:=1 to N do 
   begin
     vecAnios[i]:=2021-i+1;
     for j:=1 to 8 do 
      begin
        if(j<5) then 
         begin
           Read(arch,turistas[i,j].mayores)
         end
        else 
           read(arch,turistas[i,j-4].menores);
      end;
      ReadLn(arch);
   end;
   close(arch);
end;
 
procedure llenarVecEscalas(var escalas:TVR;var N:byte);
var 
arch:text;
begin
  Assign(arch,'escalas.txt');
  Reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     ReadLn(arch,escalas[N].escala,escalas[N].cantidad);
   end;
  close(arch); 
end;

function BuscarEscala(escalas:TVR;V:byte;esc:str15):real;
var 
i:byte;
begin
  i:=1;
  while (i<=V) and (esc<>escalas[i].escala) do 
   i:=i+1;
  BuscarEscala:=escalas[i].cantidad;
end;

procedure GenerarArreglo(turistas:TM;escalas:TVR;anios:TVA;var arr:TVanio;esc:str15;N,M,V:byte;var K:byte);
var 
CantEscala:real;
contTr:byte;
i,j:byte;
acumMen,AcumMay:real;
begin
  K:=0;
  CantEscala:=BuscarEscala(escalas,V,esc);
  for i:=1 to N do 
   begin
     contTr:=0;
     acumMen:=0;
     acumMay:=0;
     for j:=1 to M do 
      begin
        if((turistas[i,j].mayores+turistas[i,j].menores)>(CantEscala/1000))  then 
          contTr:=contTr+1;
        acumMen:=acumMen+(turistas[i,j].menores);
        acumMay:=AcumMay+(turistas[i,j].mayores);
      end;
      if(contTr>=2) then 
       begin
         K:=K+1;
         arr[K].menores:=acumMen;
         arr[K].mayores:=AcumMay;
         arr[K].anio:=anios[i];
       end;
   end;
end;
procedure mostrarArreglo(vec:TVanio;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     WriteLn('anio: ',vec[i].anio,' mayores: ',vec[i].mayores:8:2,' menores: ',vec[i].menores:8:2);
   end;
end;


function contarAsisTrimestreProm(mat:TM;i,j,N:byte):real;
begin
  if(i=1)then 
   contarAsisTrimestreProm:=(mat[i,j].menores+mat[i,j].mayores)/N
  else 
   contarAsisTrimestreProm:=((mat[i,j].menores+mat[i,j].mayores)/N)+contarAsisTrimestreProm(mat,i-1,j,N); 
end;

function CalcularMenorTrimestre(mat:TM;N,M:byte):byte;
var
 i,j,pos:byte;
 asistencias,maxAsistencia:real;
begin
  maxAsistencia:=contarAsisTrimestreProm(mat,N,1,N);
  for j:=2 to M do 
   begin
     asistencias:=contarAsisTrimestreProm(mat,N,j,N); // RECURSIVA
     if(asistencias<maxAsistencia) then 
      begin
        maxAsistencia:=asistencias;
        pos:=j;
      end;
   end;
   CalcularMenorTrimestre:=pos;
end;

function buscarPosAnio(anios:TVA;anio:word;N:byte):byte;
var 
 i:byte;
begin
  i:=1;
  while (i<=N) and (anios[i]<>anio) do 
   i:=i+1;
  if(i<=N) then 
    buscarPosAnio:=i
  else 
    buscarPosAnio:=0;  
end;

function contarRegFam(mat:TM;i,j:byte):real;
var 
cont:byte;
begin
  if(mat[i,j].menores>=mat[i,j].mayores)then 
    cont:=1
  else 
    cont:=0;
  if(j>1) then 
     contarRegFam:=cont+contarRegFam(mat,i,j-1)
  else 
     contarRegFam:=cont;
end;


var 
Turistas:TM;
anios:TVA;
escalas:TVR;
arr:TVanio;
N,M,V,K,posAnio:byte;
anio:word;
esc:string[15];
begin
llenarMyV(turistas,anios,N,M);
llenarVecEscalas(escalas,V);
//a
WriteLn('Ingrese la escala');
ReadLn(esc);
GenerarArreglo(Turistas,escalas,anios,arr,esc,N,M,V,K);
mostrarArreglo(arr,K);
//b
writeln('El trimestre con menor promedio anual fue el ',CalcularMenorTrimestre(turistas,N,M));
//c{Dado un año K ingresado por teclado (puede no existir entre los que estaban en el archivo), calcular el porcentaje de registros de tipo FAMILIAR.}
WriteLn('Ingrese un anio');
readln(anio);
posAnio:=buscarPosAnio(anios,anio,N);
if(posAnio<>0) then 
  WriteLn('El porcentaje de los registro familiar del anio ',anios[posAnio],' es ',(contarRegFam(turistas,posAnio,M)/M)*100:5:2,'%')
else 
  WriteLn('No existe en el registro');  
end.