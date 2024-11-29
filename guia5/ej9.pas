{Dado un archivo de números enteros no nulos, almacenar en un arreglo A aquellos que formen una 
secuencia ascendente. A partir de A generar B con la misma cantidad de elementos de A pero poniendo 
ceros  en  aquellas  componentes  simétricas  donde  la  simétrica  derecha  no  sea  múltiplo  de  la  izquierda. 
Escribir ambos arreglos. 
Ejemplo:  Archivo: 5, 7, 1, 12, 15, -10, 10, 24, -25, 26, 50, 13 
A = (5, 7, 12, 15, 24, 26, 50)   B= (5, 0, 12, 15, 24, 0, 50) 
}

program ej9;
type
TV = array [1..255] of integer;

procedure generarA(var A:TV;var NA:byte);
var 
Arch:Text;
num2:integer;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  NA:=1;
  read(Arch,A[NA]);
  while not eof(Arch) do 
    begin
      read(Arch,num2);
      if(num2>A[NA])then 
       begin
         NA:=NA+1;
         A[NA]:=num2;
       end;
    end;
  close(Arch);  
end;

procedure generarB(A:TV;NA:byte;var B:TV;var NB:byte);
var 
i:byte;
begin
  NB:=NA;
  for i:=1 to ((NB div 2)+1)do 
    begin
      if(A[NA-i+1] mod A[i] = 0) then
        begin
          B[NB-i+1]:=A[NA-i+1];
          B[i]:=A[i];
        end
      else 
        begin
           B[NB-i+1]:=0;
           B[i]:=0;
        end;  
    end;
end;

procedure mostrarVec(vec:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

var 
A,B:TV;
NA,NB:byte;
begin
  generarA(A,NA);
  mostrarVec(A,NA);
  generarB(A,NA,B,NB);
  mostrarVec(B,NB);
end.