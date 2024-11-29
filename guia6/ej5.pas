{) Una Tarjeta de Crédito tiene información de las compras de sus N clientes en un archivo y en cada
línea se almacenó:
 Número de cliente (puede repetirse)
 Tipo de compras (1=Supermercado, 2=Combustible, 3=Indumentaria, 4=Otros)
 Monto de la compra.
Nota: Un cliente puede registrar más de una compra del mismo tipo.
Leer los datos en un arreglo NroCli paralelo a la matriz acumulativa Compras de Nx4 donde la 1º
columna corresponde a la compra en Supermercado, la 2º a Combustible, la 3º a Indumentaria y la 4º a
Otros. Calcular e Informar:
a) Total de compras en cada rubro.
b) Listado con los clientes en los cuales el monto en Supermercado superó a Indumentaria
c) Promedio de compra por cliente.
d) Número de cliente que más consumió.
e) Cuántos clientes no registraron compras en algún rubro }
program ej5;
type 
TV = array [1..255] of word;
TM = array [1..255,1..255] of real;

 
procedure inicializarFila(var mat:TM;fila,M:byte);
var 
j:byte;
begin
  for j:=1 to M do 
    begin
      mat[fila,j]:=0;
    end;
end;

procedure llenarDatos(var vecCod:TV;var matCom:TM;var N:byte);
var
arch:text; 
numCli:word;
tipoCom,i:byte;
monto:real;
begin
  Assign(arch,'compras.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     ReadLn(arch,numCli,tipoCom,monto);
     i:=1;
     while (i<=N) and (vecCod[i]<>numCli) do 
       i:=i+1;
     if(i<=N) then 
      matCom[i,tipoCom]:=matCom[i,tipoCom]+monto
     else 
      begin
        N:=N+1;
        vecCod[N]:=numCli;
        inicializarFila(matCom,N,4);
        matCom[N,tipoCom]:=monto;
      end;   
   end;
  close(arch);
end;

procedure mostrarDatos(codigos:TV;matriz:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
    begin
        WriteLn('Codigo cliente:',codigos[i]);
        WriteLn('Montos de compras: Super/Combustible/Indumentaria/Otros');
        for j:=1 to M do 
         Write(matriz[i,j]:6:2,' ');
        WriteLn; 
    end;
end;

procedure listarSupIndu(codigos:TV;mat:TM;N,M:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     if(mat[i,1]>mat[i,3]) then
         Write(codigos[i],' ');
   end;
end;

function calcularPromCli(compras:TM;fila,M:byte):real;
var
j:byte;
acum:real;
begin
  acum:=0;
  for j:=1 to M do 
   begin
     acum:=acum+compras[fila,j];
   end;
  calcularPromCli:=acum/M; 
end;

procedure promCliente(compras:TM;N,M:byte);
var
i:byte; 
begin
  for i:=1 to N do 
   begin
     WriteLn('Promedio del cliente ',i,' es ',calcularPromCli(compras,i,M):6:2);
   end;
end;

function sumarConsumoFila(compras:TM;fila,M:byte):real;
var 
j:byte;
sum:real;
begin
  sum:=0;
  for j:=1 to M do 
   begin
     sum:=sum+compras[fila,j];
   end;
   sumarConsumoFila:=sum;
end;

function PosMaxConsum(compras:TM;N,M:byte):byte;
var 
i:byte;
maxConsumo,sumCli:real;
begin
  maxConsumo:=0;
  for i:=1 to N do 
   begin
     sumCli:=sumarConsumoFila(compras,i,M);
     if(sumCli>maxConsumo)then
        begin
           PosMaxConsum:=i;
           maxConsumo:=sumCli;
        end;
         
   end;
end;

function cantNingunRubro(mat:TM;N,M:byte):byte;
var 
i,cont:byte;

begin
  cont:=0;
  for i:=1  to N do 
   begin
     if (mat[i,1]=0) or (mat[i,2]=0) or (mat[i,3]=0) or (mat[i,4]=0) then
        cont:=cont+1;
   end;
   cantNingunRubro:=cont;
end;


var
codigos:TV;
compras:TM;
N,M,pos:byte; 
begin
  M:=4;
  llenarDatos(codigos,compras,N);
  mostrarDatos(codigos,compras,N,M);
  //B
  listarSupIndu(codigos,compras,N,M);
  //c) Promedio de compra por cliente.
  promCliente(compras,N,M);
  pos:=PosMaxConsum(compras,N,M);
  WriteLn('El numero de cliente que mas consumio fue:', codigos[pos]);
  WriteLn('Cantidad de clientes que no registraron compras en algun rubro:',cantNingunRubro(compras,N,M));
end.