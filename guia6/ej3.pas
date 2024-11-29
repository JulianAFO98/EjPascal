{) En un archivo se almacenaron Y números enteros en cada línea. Cada línea se cargará en una fila
de la matriz si cumple que el primero es divisor del último (el Y-ésimo). Mostrar la matriz generada. La
dimensión será N x Y (N se debe calcular) }
program ej3;
type 
TM = array[1..255,1..255] of integer;

procedure llenarDatos(var matriz:TM;var N,M:byte);
var 
i:byte;
arch:text;
primerNumero,Yesimo:integer;
begin
  Assign(arch,'datos.txt');
  reset(arch);
  N:=0;
  WriteLn('Ingrese Y');
  ReadLn(M);
  while not eof(arch) do 
   begin
     N:=N+1;
     for i:=1 to M do 
      begin
        read(arch,matriz[N,i]);
      end;
     ReadLn(arch);
     if(matriz[N,M] mod matriz[N,1] <> 0 ) then
       begin
         N:=N-1;
       end; 
   end;
 close(arch);
end;

procedure mostrarDatos(matriz:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
    begin
        for j:=1 to M do 
         Write(matriz[i,j],' ');
        WriteLn; 
    end;
end;

var 
 matriz:TM;
 N,M:byte;
begin
 llenarDatos(matriz,N,M);
 mostrarDatos(matriz,N,M);
end.