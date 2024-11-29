program parcial62021;
type 
str10 = string[10];
str3 = string[3];
TipoNoticia = record 
  codNoticia:byte;
  descripcion:str10;
end;
TVNoticia = array [1..255] of TipoNoticia;  
TM = array [1..255,1..255] of byte;
TV = array [1..255]  of str3;
TipoC = record 
 cadena:Str3;
 descripcion:str10;
end;
TVC = array [1..255] of TipoC; 

procedure InsertarOrdenado(var VecNoticias:TVNoticia;var M:byte;desc:str10;codigo:byte);
var 
j:byte;
begin
  j:=M;
  while (j>0) and (VecNoticias[j].codNoticia>codigo) do 
   begin
     VecNoticias[j+1]:=VecNoticias[j];
     j:=j-1;
   end;
   VecNoticias[j+1].codNoticia:=codigo;
   VecNoticias[j+1].descripcion:=desc;
   M:=M+1;
end;


procedure llenarVecNoticias(var VecNoticias:TVNoticia;var M:byte);
var
 arch:text;
 desc:str10;
 codigo:byte;
 extra:char;
begin
  Assign(Arch,'tipoNoticia.txt');
  reset(arch);
  M:=0;
  while  not eof(Arch) do
    begin
      ReadLn(arch,codigo,extra,desc);
      InsertarOrdenado(VecNoticias,M,desc,codigo);
    end;
   close(arch); 
end;


procedure mostrarVectorNoticias(VecNoticias:TVNoticia;M:byte);
var
i:byte; 
begin
  for i:=1 to M do 
   begin
     Writeln(VecNoticias[i].codNoticia,' ',VecNoticias[i].descripcion);
   end;
end;

function buscarPosCodigo(Vec:TV;N:byte;cod:str3):byte;
var 
 i:byte;
begin
  i:=1;
  while (i<=N) and (vec[i]<>cod) do 
   i:=i+1;
  buscarPosCodigo:=i;  
end;

procedure llenarVecCanales(var VecCanales:TV;var N:byte);
var 
arch:text;
begin
  Assign(arch,'codNoticias.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     ReadLn(arch,VecCanales[N]);
   end;
  close(arch); 
end;

procedure InicializarMatriz(var Matriz:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         Matriz[i,j]:=0;
       end;
   end;
end;

procedure LlenarDatos(var matriz:TM;Vec:TV;N:byte;M:byte);
var 
arch:text;
i,j,cantNotas:byte;
cod:str3;
begin
  Assign(arch,'coberturas.txt');
  Reset(arch);
  InicializarMatriz(matriz,N,M);
  while not eof(arch) do 
   begin
     ReadLn(arch,cod,j,cantNotas);
     i:=buscarPosCodigo(Vec,N,cod);
     matriz[i,j]:=matriz[i,j]+cantNotas;
   end;
  close(arch); 
end;

procedure mostrarVecCanal(VecCanales:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(VecCanales[i],' ');
   end;
   WriteLn;
end;
procedure mostrarMatriz(matriz:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        Write(matriz[i,j],' ');
      end;
     WriteLn; 
   end;
end;

function SumFila(matriz:TM;fila,columnas:byte):byte;
var 
j,acum:byte;

begin
  acum:=0;
  for j:=1 to columnas do 
   begin
     acum:=acum+matriz[fila,j];
   end;
   SumFila:=acum;
end;

function buscarPosirecu(matriz:TM;i,M:byte):byte;
var 
posMin:byte;
begin
  if(i>1) then 
    begin
      posMin:=buscarPosirecu(matriz,i-1,M);
      if(SumFila(matriz,posMin,M)<SumFila(matriz,i,M)) then 
       buscarPosirecu:=posMin
      else 
       buscarPosirecu:=i; 
    end
  else 
    buscarPosirecu:=i;  
end;

function buscarPosMinimo(matriz:TM;i,j:byte):byte;
var 
posMin:byte;
begin
  if(j>1)then 
    begin
      posMin:=buscarPosMinimo(matriz,i,j-1);
      if(matriz[i,posMin]=0) or (matriz[i,j]<matriz[i,posMin]) then 
        buscarPosMinimo:=j
      else 
        buscarPosMinimo:=posMin;  
    end
  else 
    buscarPosMinimo:=j; 
end;

procedure InformarMenorCantNotas(matriz:TM;VecNoticias:TVNoticia;VecCanal:TV;N,M:byte);
var 
i,j:byte;
begin
    i:=buscarPosirecu(matriz,N,M);
    WriteLn(i);
    j:=buscarPosMinimo(matriz,i,M);
    WriteLn(j);
    WriteLn(VecCanal[i],VecNoticias[j].descripcion);
end;

function SumarColumnaX(matriz:TM;i,X:byte):byte;
begin
  if(i>1) then 
    SumarColumnaX:=matriz[i,X]+SumarColumnaX(matriz,i-1,X)
  else 
    SumarColumnaX:=matriz[i,X];  
end;

procedure InformarPorcentajesDeNotaX(matriz:TM;VecCanales:TV;N,M:byte);
var 
 X,i,TotalNotasX:byte;

begin
  WriteLn('Ingrese X');
  ReadLn(X);
  TotalNotasX:=SumarColumnaX(matriz,N,X);
  WriteLn('Porcentajes');
  for i:=1 to N do 
   begin
     WriteLn(VecCanales[i],' ',(matriz[i,X]/TotalNotasX)*100:5:2);
   end;
end;

procedure GenerarVector(MatrizNotas:TM;N,M:byte;vecCanales:TV;VecNoticias:TVNoticia;var ArregloGenerado:TVC;var K:byte);
var 
 i,j:byte;
begin
  K:=0;
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        if(MatrizNotas[i,j]<>0) then 
         begin
           K:=K+1;
           ArregloGenerado[K].cadena:=vecCanales[i];
           ArregloGenerado[K].descripcion:=VecNoticias[j].descripcion;
         end;
      end;
   end;
end;


procedure MostrarVector(Arreglo:TVC;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     Write(Arreglo[i].cadena,' ',Arreglo[i].descripcion);
     WriteLn;
   end;
end;

var 
VecNoticias:TVNoticia;
MatrizNotas:TM;
VecCanales:TV;
ArregloGenerado:TVC;
N,M,K:byte;
begin
  llenarVecNoticias(VecNoticias,M);
  mostrarVectorNoticias(VecNoticias,M);
  llenarVecCanales(VecCanales,N);
  LlenarDatos(MatrizNotas,VecCanales,N,M);
  mostrarVecCanal(VecCanales,N);
  mostrarMatriz(MatrizNotas,N,M);
  InformarMenorCantNotas(MatrizNotas,VecNoticias,VecCanales,N,M);
  InformarPorcentajesDeNotaX(MatrizNotas,VecCanales,N,M);
  GenerarVector(MatrizNotas,N,M,vecCanales,VecNoticias,ArregloGenerado,K);
  MostrarVector(ArregloGenerado,K);
end.