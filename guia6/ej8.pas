{Sea un conjunto A de enteros y una relación R, se pide
a) Generar la matriz booleana MatR que representa una relación R.
b) Determinar si R es:
 Reflexiva
 Simétrica

Ejemplo :
A = 1,2,3,9,18
R = relación de Divisibilidad
 MatR[ i , j ] =
Respuesta: R es Reflexiva – R no es Simétrica}

program ej8;
const 
MaxElem=5;
type
TM = array [1..255,1..255] of byte;
TV = array [1..MaxElem] of byte;

procedure llenarMatriz(var mat:TM;V:TV;var N:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        if(V[j] mod V[i]=0) then
          mat[i,j]:=1
        else 
          mat[i,j]:=0;  
      end;
   end;
end;

procedure mostrarMatriz(mat:TM;N:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        Write(mat[i,j],' ');
      end;
     WriteLn; 
   end;
end;

function esReflexiva(mat:TM;N:byte):boolean;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (mat[i,i]=1) do 
   i:=i+1;
  esReflexiva:=i>N; 
end;
function esSimetrica(mat:TM;N:byte):Boolean;
var 
i,j:byte;
simetri:boolean;
begin
  i:=1;
  simetri:=true;
  while (i<=N) and simetri do 
   begin
     j:=i;
     while (j<=N) and simetri do 
      begin
        simetri:=mat[i,j]=mat[j,i];
        j:=j+1;
      end;
     i:=i+1;  
   end;
   esSimetrica:=simetri;
end;


const 
V : TV = (1,2,3,9,18);
var 
Matriz:TM;
N:byte;
begin
  N:=MaxElem;
  llenarMatriz(Matriz,V,N);
  mostrarMatriz(matriz,N);
  if(esReflexiva(matriz,N)) then
     WriteLn('Es reflexiva')
  else 
     WriteLn('No es reflexiva');   
  if(esSimetrica(matriz,N)) then
     WriteLn('Es simetrica')
  else 
     WriteLn('No es simetrica'); 
end.