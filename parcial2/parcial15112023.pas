program parcial15112023;
{type 
str30=string[30];
str10=string[10];
TRegSalario = record 
   puesto:str10;
   sueldoHora:real;
end;
TregCasilla = record 
    CantEmpleados:byte;
    sueldoAcumulado:real;
end;   

RegistroB =  record
 codigoArea:byte;
 sueldoPromEmple:real;
end;

TVRB = array [1..255] of RegistroB;
TVSalario = array [1..255] of TRegSalario;
TM = array [1..255,1..255] of TregCasilla;


procedure llenarVector(var VectSalarios:TVSalario;var N:byte);
var 
arch:text;
begin
  Assign(arch,'salarios.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     ReadLn(arch,VectSalarios[N].puesto,VectSalarios[N].sueldoHora);
   end;
   close(arch);
end;

procedure InicializarMatriz(var matriz:TM;N:byte;var M:byte); 
var 
i,j:byte;
begin
  M:=10;
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         matriz[i,j].CantEmpleados:=0;
         matriz[i,j].sueldoAcumulado:=0;
       end;
       
       
   end;
end;

function buscarPuesto(VectSalarios:TVSalario;N:byte;puesto:str10):byte;
var 
 i:byte;
begin
  i:=1;
  while (puesto<>VectSalarios[i].puesto) do 
   i:=i+1;
  buscarPuesto:=i; 
end;


procedure llenarMatriz(var MatrizEmpleado:TM;VectSalarios:TVSalario;N,M:byte);
var 
arch:text;
nombre:str30;
codigoArea,pos:byte;
puesto:str10;
horasTrabaja:real;
extra:char;
begin
  Assign(arch,'empleados.txt');
  reset(arch);
  while not eof(arch) do
   begin
     ReadLn(arch,nombre,codigoArea,extra,puesto,horasTrabaja);
     pos:=buscarPuesto(VectSalarios,N,puesto);
     MatrizEmpleado[pos,codigoArea].CantEmpleados:=MatrizEmpleado[pos,codigoArea].CantEmpleados+1;
     MatrizEmpleado[pos,codigoArea].sueldoAcumulado:=MatrizEmpleado[pos,codigoArea].sueldoAcumulado+(horasTrabaja*VectSalarios[pos].sueldoHora); 
   end;
   close(arch);
end;

function superaX(matriz:TM;fila,columnas,X:byte):boolean;
var 
sumaEmp,j:byte;
begin
  sumaEmp:=0;
  for j:=1 to columnas do 
   begin
     sumaEmp:=sumaEmp+matriz[fila,j].CantEmpleados;
   end;
   superaX:=sumaEmp>X;
end;

procedure InformarCuantosSuperanX(Matriz:TM;N,M:byte);
var
X,i,cont:byte;
begin
  WriteLn('Ingrese X');
  ReadLn(X);
  cont:=0;
  for i:=1 to N do 
   begin
     if(superaX(Matriz,i,M,X))then 
      cont:=cont+1;
   end;
   WriteLn('Cantidad de puestos que superan X: ',cont);
end;


procedure GenerarArregloB(MatrizEmpleado:TM;N,M:byte;var ArregloGenerado:TVRB;var K:byte);
var 
i,j,cont:byte;
acumSueldo:real;
begin
   K:=0;
   for j:=1 to M do 
    begin
      i:=1;
      cont:=0;
      acumSueldo:=0;
      while (i<=N) and (MatrizEmpleado[i,j].CantEmpleados<>0) do 
       begin
         cont:=cont+MatrizEmpleado[i,j].CantEmpleados;
         acumSueldo:=acumSueldo+MatrizEmpleado[i,j].sueldoAcumulado;
         i:=i+1;
       end;
       if(i>N) then 
        begin
          K:=K+1;
          ArregloGenerado[K].codigoArea:=j;
          ArregloGenerado[K].sueldoPromEmple:=acumSueldo/cont;
        end;
    end;
end;

procedure MostrarArreglo(ArregloGenerado:TVRB;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     Write(ArregloGenerado[i].codigoArea,' ',ArregloGenerado[i].sueldoPromEmple:6:2);
   end;
end;


var 
VectSalarios:TVSalario;
MatrizEmpleado:TM;
N,M,K:byte;
ArregloGenerado:TVRB;
begin
  llenarVector(VectSalarios,N);
  InicializarMatriz(MatrizEmpleado,N,M);
  llenarMatriz(MatrizEmpleado,VectSalarios,N,M);
  InformarCuantosSuperanX(MatrizEmpleado,N,M);
  GenerarArregloB(MatrizEmpleado,N,M,ArregloGenerado,K);
  MostrarArreglo(ArregloGenerado,K);
end.}

{type 
TM = array [1..255,1..255] of byte;
TV = array [1..255] of byte;


procedure llenarMatriz(var matriz: TM; var N, M: byte);
var
  i, j: byte;
begin
  writeln('Ingrese el número de filas (N): ');
  readln(N);
  writeln('Ingrese el número de columnas (M): ');
  readln(M);

  for i := 1 to N do
  begin
    for j := 1 to M do
    begin
      write('Ingrese el valor para la posición [', i, ', ', j, ']: ');
      readln(matriz[i, j]);
    end;
  end;
end;


function SonTodosPares(matriz:TM;i,j:byte):boolean;
begin
  if(i=0) then 
    SonTodosPares:=true
  else 
    begin
      if(matriz[i,j] mod 2 = 0) then 
        SonTodosPares:=SonTodosPares(matriz,i-1,j)
      else 
       SonTodosPares:=false;  
    end;  
end;

function buscarMaximo(matriz:TM;i,j:byte):byte;
var 
max:byte;
begin
  if(i>1) then 
    begin
      max:=buscarMaximo(matriz,i-1,j);
      if(matriz[i,j]>max) then 
        buscarMaximo:=matriz[i,j]
      else 
        buscarMaximo:=max;  
    end
  else 
    buscarMaximo:=matriz[i,j]; 
end;


procedure GenerarVector(matriz:TM;j,N:byte;var Vector:TV;var K:byte);
begin
  if(j>0) then 
   begin
     if(SonTodosPares(matriz,N,j)) then 
       begin
         K:=K+1;
         Vector[K]:=buscarMaximo(Matriz,N,j);
       end;
     GenerarVector(matriz,j-1,N,Vector,K);  
   end;
end;

procedure MostrarVector(vec:TV;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     Write(vec[i],' ');
   end;
end;


var 
Matriz:TM;
N,M,K:byte;
Vector:TV;
begin
  llenarMatriz(matriz,N,M);
  K:=0;
  GenerarVector(Matriz,M,N,Vector,K);
  MostrarVector(Vector,K);
end.}



Type 
  tm = array[1..3,1..4] Of byte;
  tv = array [1..10] Of byte;

Procedure cargarMatriz(Var matriz:tm; n, m: byte);

Var 
  i, j: byte;
Begin
  For i := 1 To n Do
    Begin
      For j := 1 To m Do
        Begin
          writeln('Ingrese el valor para la posición [', i, ',', j, ']: ');
          readln(matriz[i,j]);
        End;
    End;
End;
Procedure generavector(matriz:tm;i,j,n:byte;Var vector:tv; Var k:byte);
Begin
  If j > 0 Then
    Begin
      If i = 1 Then
        Begin
          If Not odd(matriz[i,j]) Then
            Begin
              generavector(matriz,n,j-1,n,vector,k);
              k := k + 1;
              vector[k] := matriz[i,j];
            End
          Else
            generavector(matriz,n,j-1,n,vector,k);
        End
      Else
        If Not odd(matriz[i,j]) Then
          Begin
            generavector(matriz,i-1,j,n,vector,k);
            If matriz[i,j] > vector[k] Then
              vector[k] := matriz[i,j];
          End
      Else
        generavector(matriz,n,j-1,n,vector,k);
    End;
End;
Procedure muestravec(vector:tv; k:byte);

Var 
  i: byte;
Begin
  For i := 1 To k Do
    write(vector[i]:5);
End;


Var 
  matriz : tm;
  vector: tv;
  n,m,k: byte;
Begin
  n := 3;
  m := 4;
  cargarMatriz(matriz,n,m);
  k := 0;
  generavector(matriz,n,m,n,vector,k);
  muestravec(vector,k);
End.