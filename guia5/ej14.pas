{Una empresa de autos de alquiler grabó en cada línea del archivo la patente del vehículo (cadena 
de 7) y el total recaudado en el día. Se pide leer los datos en dos arreglos paralelos e informar: 
a) El promedio recaudado por auto. 
b) Las patentes de los vehículos que superaron en la recaudación X pesos (X es dato). 
c) La patente del que recaudó menos.}

program ej14;
type 
str7=string[7];
TVS = array [1..255] of str7;
TVR = array [1..255] of real;

procedure llenarDatos(var vecPat:TVS;var VecAcum:TVR;var N:byte);
var 
Arch:text;
patente:str7;
monto:real;
i,pos:byte;
existe:boolean;
begin
  Assign(Arch,'datos.txt');
  reset(Arch);
  N:=0;
  while not eof(Arch) do
    begin
      readln(Arch,patente,monto);
      existe:=false;
      i:=1;
      while (i<=N) and (not existe) do 
        begin
          if(vecPat[i]=patente) then
            begin
              pos:=i;
              existe:=true;
            end;
          i:=i+1;  
        end;
      if(existe) then
        vecAcum[pos]:=VecAcum[pos]+ monto
      else 
       begin
         N:=N+1;
         vecPat[N]:=patente;
         VecAcum[N]:=monto;
       end;   
    end;
   close(Arch); 
end;


procedure mostrarDatosOrdenados(vec:TVS;vec2:TVR;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Writeln('El coche con  patente ',vec[i],' recaudo:',vec2[i]:8:2);
   end;
   WriteLn();
end;

function calcularPromedio(vecMonto:TVR;N:byte):real;
var
i:byte; 
sum:real;
begin
  sum:=0;
  for i:=1 to N do 
    begin
      sum:=sum+vecMonto[i];
    end;
    calcularPromedio:=sum/N;
end;

procedure InformarCuantosSuperanX(vecPat:TVS;vecMonto:TVR;N:byte;X:real);
var 
i:byte;
begin
 
   for i:=1 to N do 
     begin
       if(vecMonto[i]>X)then
         WriteLn(vecPat[i],' supero el monto ',X:4:2);
     end;
end;

function buscarMenorPate(vecPat:TVS;vecMonto:TVR;N:byte):str7;
var 
 i:byte;
 pateMin:str7;
 montoMin:real;
begin
   montoMin:=vecMonto[1];
   pateMin:=vecPat[1];
   for i:=2 to N do 
     begin
       if(vecMonto[i]<montoMin) then
         begin
           montoMin:=vecMonto[i];
           pateMin:=vecPat[i];
         end;
     end;
     buscarMenorPate:=pateMin;
end;

var 
vecPatentes:TVS;
vecMontoAuto:TVR;
N:byte;
X:real;
begin
  llenarDatos(vecPatentes,vecMontoAuto,N);
  mostrarDatosOrdenados(vecPatentes,vecMontoAuto,N);
  WriteLn('El promedio recaudado fue:', calcularPromedio(vecMontoAuto,N):8:2);
  WriteLn('Ingrese X');
  ReadLn(X);
  InformarCuantosSuperanX(vecPatentes,vecMontoAuto,N,X);
  WriteLn('La patente del que recaudo menos fue: ',buscarMenorPate(vecPatentes,vecMontoAuto,N));
end.