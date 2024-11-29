Program ej9;
type 
TMC = array [1..255,1..255] of char; 
TMB = array [1..255,1..255] of byte; 

procedure llenarMatrizTMC(var Mat:TMC;N:byte);
var 
arch:text;
i,j:byte;
begin
  Assign(arch,'colores.txt');
  Reset(arch);
  i:=0;
  while not eof(arch) do 
   begin
     i:=i+1;
     for j:=1 to N do 
      begin
        read(arch,mat[i,j]);
      end;
     ReadLn(arch); 
   end;
  close(arch); 
end;

procedure llenarMatrizTMB(var Mat:TMB;N:byte);
var 
arch:text;
i,j:byte;
begin
  Assign(arch,'fichas.txt');
  Reset(arch);
  i:=0;
  while not eof(arch) do 
   begin
     i:=i+1;
     for j:=1 to N do 
      begin
        read(arch,mat[i,j]);
      end;
   end;
  close(arch); 
end;

procedure mostrarMatrizTMB(mat:TMB;N:byte);
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

procedure mostrarMatrizTMC(mat:TMC;N:byte);
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

function colorMasPredo(Mat:TMC;N:byte):char;
var 
 i,j,contR,contA:byte;
begin
  contR:=0;
  contA:=0;
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        if(Mat[i,j]='R') then
          contR:=contR+1
        else 
          contA:=contA+1;  
      end;
   end;
   if(contR>contA)then
     colorMasPredo:='R'
   else 
     colorMasPredo:='A';  
end;

function colorMasFichas(matColor:TMC;MatFichas:TMB;N:byte):char;
var 
 i,j,contR,contA:byte;
begin
  contR:=0;
  contA:=0;
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        if(MatColor[i,j]='R') then
          contR:=contR+MatFichas[i,j]
        else 
          contA:=contA+MatFichas[i,j];  
      end;
   end;
   if(contR>contA)then
     colorMasFichas:='R'
   else 
     colorMasFichas:='A';  
end;

function cantUnSoloColor(mat:TMC;N:byte):byte;
var 
i,j,contCols:byte;
colorF1:char;
begin
  contCols:=0;
  for j:=1 to N do 
   begin
      colorF1:=mat[1,j];
      i:=2;
      while (i<=N) and (colorF1=mat[i,j]) do
       i:=i+1;
      if(i>N) then
        contCols:=contCols+1;
   end;
  cantUnSoloColor:=contCols; 
end;


var 
MatColor:TMC;
MatCantFichas:TMB;
N:byte;
begin
  WriteLn('Ingrese N');
  ReadLn(N);
  llenarMatrizTMC(MatColor,N);
  llenarMatrizTMB(MatCantFichas,N);
  mostrarMatrizTMC(MatColor,N);
  mostrarMatrizTMB(MatCantFichas,N);
  //a) Color predominante (presente en más casillas)
  WriteLn('El color mas predominante es: ',colorMasPredo(MatColor,N));
  //b)
  WriteLn('El color con fichas es: ',colorMasFichas(MatColor,MatCantFichas,N));
  //c) Cantidad de columnas de un solo color
  WriteLn('La cantidad de columnas con un solo color es: ',cantUnSoloColor(MatColor,N));
end.