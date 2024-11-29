program parcial2024;
//RECURSIVIDAD VER 1
{type 
TM = array [1..255,1..255] of integer;
TipoRegPosicion = record 
  Posi,posj:byte;
end;
TV = array [1..255] of TipoRegPosicion;  

procedure llenarMatriz(var mat:TM;var N,M:byte);
var
i,j:byte; 
begin
  ReadLn(N,M);
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        ReadLn(mat[i,j]);
      end;
   end;
end;


function sumaFila(mat:TM;i,j:byte):integer;
begin
  if(j>1) then 
    sumaFila:=mat[i,j]+sumaFila(mat,i,j-1)
  else 
   sumaFila:=mat[i,j];
end;

function buscarPosMinimo(mat:TM;i,j:byte):byte;
var 
minimo:integer;
posMin:byte;
begin
  if(j=1) then 
    buscarPosMinimo:=j
  else 
   begin
     posMin:=buscarPosMinimo(mat,i,j-1);
     minimo:=mat[i,posMin];
     if(minimo>mat[i,j]) then 
        buscarPosMinimo:=j
     else 
        buscarPosMinimo:=posMin; 
   end;  
end;

procedure GenerarVector(mat:TM;i,j,M:byte;var vec:TV;var K:byte);
var 
RegPos:TipoRegPosicion;
begin
  if(i>0) then 
   begin
     if(sumaFila(mat,i,M)>0) then 
       begin
         RegPos.Posi:=i;
         RegPos.posj:=buscarPosMinimo(mat,i,M);
         K:=K+1;
         vec[K]:=RegPos;
       end;
     GenerarVector(mat,i-1,M,M,vec,K);  
   end;
end;

procedure mostrarVec(vec:TV;N:byte);
var
i:byte;
begin
  for i:=1 to N do 
   begin
     Writeln(vec[i].Posi,' ',vec[i].posj);
   end;
end;

procedure mostrarMatriz(mat:TM;N,M:byte);
var
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        Write(mat[i,j],' ');
      end;
     WriteLn; 
   end;
end;

var
Mat:TM;
N,M,K:byte;
Vector:TV;

begin
  llenarMatriz(mat,N,M);
  mostrarMatriz(mat,N,M);
  K:=0;
  GenerarVector(mat,N,M,M,Vector,K);
  MostrarVec(vector,K);
end.}

//RECURSIVIDAD v2

type 
TM = array [1..255,1..255] of integer;
TipoReg = record 
  Posi,posj:byte;
  suma,minimo:integer;
end;
TV = array [1..255] of TipoReg;
 



procedure llenarMatriz(var mat:TM;var N,M:byte);
var
i,j:byte; 
begin
  ReadLn(N,M);
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        ReadLn(mat[i,j]);
      end;
   end;
end;



procedure GenerarVector(mat:TM;i,j,M:byte;var vec:TV;var K:byte);
begin
 if(i>0) then 
  begin
    if(j>0) then 
     begin
          if(j=M) then 
           begin
             K:=K+1;
             vec[K].minimo:=mat[i,j];
             vec[K].Posi:=i;
             vec[K].posj:=j;
             vec[K].suma:=mat[i,j];
           end
          else 
           begin
             if(vec[K].minimo>mat[i,j])then 
              begin
                vec[K].minimo:=mat[i,j];
                vec[K].posj:=j;
                vec[K].Posi:=i;
              end;
              vec[K].suma:=vec[K].suma+mat[i,j]; 
           end; 
          if(j=1)then
            begin
              if(vec[K].suma<0) then 
                K:=K-1;
              GenerarVector(mat,i-1,M,M,vec,K)  
            end
          else 
             GenerarVector(mat,i,j-1,M,vec,K);
     end;
  end;
end;

procedure mostrarVec(vec:TV;N:byte);
var
i:byte;
begin
  for i:=1 to N do 
   begin
     Writeln(vec[i].posi,' ',vec[i].posj);
   end;
end;

procedure mostrarMatriz(mat:TM;N,M:byte);
var
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        Write(mat[i,j],' ');
      end;
     WriteLn; 
   end;
end;

var
Mat:TM;
N,M,K:byte;
Vector:TV;

begin
  llenarMatriz(mat,N,M);
  mostrarMatriz(mat,N,M);
  K:=0;
  GenerarVector(mat,N,M,M,Vector,K);
  MostrarVec(vector,K);
end.

{//Parte 1


type 
str5 = string[5];
TV = array [1..255] of str5;
TM = array [1..255,1..255] of real;
RegVentas = record 
  monto:real;
  codigo:str5;
end;
TVR =  array [1..255] of RegVentas;


function buscarPosCodigo(codigo:str5;vecR:TV;N:byte):byte;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (codigo<>vecR[i]) do 
   i:=i+1;
  if(i<=N) then 
   buscarPosCodigo:=i
  else 
   buscarPosCodigo:=0;   
end;


procedure InicializarFila(var MatrizVentas:TM;fila,M:byte);
var 
j:byte;
begin
  for j:=1 to M do 
   begin
     MatrizVentas[fila,j]:=0;
   end;
end;

procedure llenarDatos(var MatrizVentas:TM;var VecRubros:TV;var N,M:byte);
var 
Arch:text;
codigo:str5;
dia,i:byte;
montoVenta:real;
begin
  Assign(arch,'ventas.txt');
  reset(arch);
  N:=0;
  M:=7;
  while not eof(Arch) do
   begin
     Readln(arch,codigo,dia,montoVenta);
     i:=buscarPosCodigo(codigo,VecRubros,N);
     if(i=0) then 
      begin
        N:=N+1;
        InicializarFila(MatrizVentas,N,M);
        MatrizVentas[N,dia]:=montoVenta;
        VecRubros[N]:=codigo;
      end
     else 
      begin
        MatrizVentas[i,dia]:=MatrizVentas[i,dia]+montoVenta;
      end; 
   end;
  close(arch); 
end;

procedure mostrarDatos(MatrizVentas:TM;VecRubros:TV;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     WriteLn('Rubro ',VecRubros[i]);
     for j:=1 to M do 
      begin
        Write('Dia ',j,':',MatrizVentas[i,j]:6:2,' ');
      end;
      WriteLn;
   end;
end;

function PromFila(Matriz:TM;fila,M:byte):real;
var
j:byte;
suma:real;
begin
  suma:=0;
  for j:=1 to M do 
   begin
     suma:=suma+Matriz[fila,j];
   end;
   PromFila:=suma/M;
end;

function MenorVentaPromedio(MatrizVentas:TM;vecR:TV;N,M:byte):str5;
var 
i,pos:byte;
MenorVenta,PromVenta:real;
begin
  MenorVenta:=PromFila(MatrizVentas,1,5);
  pos:=1;
  for i:=2 to N do 
   begin
     PromVenta:=PromFila(MatrizVentas,i,5);
     if(PromVenta<MenorVenta) then 
      begin
        MenorVenta:=PromVenta;
        pos:=i;
      end;
   end;
   MenorVentaPromedio:=vecR[pos];
end;

function CalcularMontodia6y7(matriz:TM;fila:byte):real;
begin
  CalcularMontodia6y7:= matriz[fila,6]+matriz[fila,7];
end;


procedure insertarOrdenadoPorMonto(var VecGenerado:TVR;var K:byte;cod:str5;monto6y7:real);
var 
j:byte;
begin
  j:=K;
  while (j>0) and (VecGenerado[j].monto>monto6y7) do 
   begin
     VecGenerado[j+1]:=VecGenerado[j];
     j:=j-1;
   end;
   VecGenerado[j+1].monto:=monto6y7;
   VecGenerado[j+1].codigo:=cod;
   K:=K+1;
end;

procedure GenerarArreglo(Matriz:TM;VecR:TV;N,M:byte;var VecGenerado:TVR;var K:byte;MontoSup:real);
var 
i,pos:byte;
monto6y7:real;
begin
  K:=0;
  for i:=1 to N do 
   begin
     monto6y7:=CalcularMontodia6y7(matriz,i);
     if(monto6y7>MontoSup) then 
      begin
        insertarOrdenadoPorMonto(VecGenerado,K,VecR[i],monto6y7);
      end;
   end;
end;

procedure mostrarArreglo(vec:TVR;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     WriteLn(vec[i].monto:6:2,' ',vec[i].codigo);
   end;
end;


var 
MatrizVentas:TM;
N,M,K:byte;
VecRubros:TV;
VecGenerado:TVR;
montoS:real;
begin
  llenarDatos(MatrizVentas,VecRubros,N,M);
  mostrarDatos(MatrizVentas,VecRubros,N,M);
  WriteLn('El codigo con menos venta promedio en los primeros 5 dias fue ',MenorVentaPromedio(MatrizVentas,VecRubros,N,M));
  WriteLn('Ingrese el monto a superar');
  ReadLn(montoS);
  GenerarArreglo(MatrizVentas,VecRubros,N,M,VecGenerado,K,montoS);
  mostrarArreglo(VecGenerado,K);
end.}