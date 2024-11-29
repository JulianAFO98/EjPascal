{ La Secretaría de Transporte quiere evaluar el movimiento de pasajeros en N paradas de colectivo.
En cada una de ellas se detienen M líneas de colectivo. Dispositivos electrónicos han registrado el
movimiento de un día y grabado en un archivo de texto dicha información en tiempo real (desordenada).
En cada registro se expresa:
 Parada (1..N)
 Línea (1..M)
 Cantidad de pasajeros que ascienden
 Cantidad de pasajeros que descienden
Se pide leer la información del archivo, almacenándola de forma adecuada para calcular e informar:
a) Parada con mayor cantidad de pasajeros que bajaron.
b) Línea con menor cantidad de pasajeros que subieron.
c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que
bajaron.
d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.
Los ítems anteriores se refieren al movimiento de todo el día.
¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que ascendió o
descendió cada vez que se detuvo el colectivo? }

program ej7;
type 
TM = array [1..255,1..255] of byte;


procedure InicializarMatriz(var Mat:TM;N,M:byte);
var
i,j:byte; 
begin
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         Mat[i,j]:=0;
       end;
   end;
end;

procedure mostrarMatriz(Mat:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         write(Mat[i,j],' ');
       end;
       WriteLn;
   end;
end;

procedure llenarDatosMatriz(var MatS,MatB:TM;N,M:byte);
var 
 arch:text;
 linea,parada,Sub,baj:byte;
begin
  Assign(arch,'ej7.txt');
  reset(arch);
  while not eof(arch) do 
   begin
     readln(arch,parada,linea,sub,baj);
     matS[parada,linea]:=MatS[parada,linea]+sub;
     matB[parada,linea]:=MatB[parada,linea]+baj;
   end;
  Close(arch); 
end;

function sumFila(mat:TM;fila,M:byte):byte;
var 
j:byte;
sum:byte;
begin
  sum:=0;
  for j:=1 to M do 
   begin
     sum:=sum+mat[fila,j];
   end;
   sumFila:=sum;
end;

function paradaMaxBajadas(mat:TM;N,M:byte):byte;
var 
i,maxBajadas,posMax,sumF:byte;
begin
  maxBajadas:=0;
  for i:=1 to N do 
   begin
     sumF:=sumFila(mat,i,M);
     if(sumF>maxBajadas)then
       begin
         maxBajadas:=sumF;
         posMax:=i;
       end;
   end;
   paradaMaxBajadas:=posMax;
end;



function sumCol(mat:TM;col,N:byte):byte;
var 
i:byte;
sum:byte;
begin
  sum:=0;
  for i:=1 to N do 
   begin
     sum:=sum+mat[i,col];
   end;
   sumCol:=sum;
end;

function lineaMinSub(mat:TM;N,M:byte):byte;
var 
j,MinBajadas,posMin,sum:byte;
begin
  MinBajadas:=sumCol(mat,1,N);
  posMin:=1;
  for j:=2 to M do 
   begin
     sum:=sumCol(mat,j,N);
     if(sum<MinBajadas)then
       begin
         MinBajadas:=sum;
         posMin:=j;
       end;
   end;
   lineaMinSub:=posMin;
end;

function cantParadas(matS,matB:TM;N,M:byte):byte;
var 
i,cantS,cantBaj,cont:byte;
begin
  cont:=0;
  for i:=1 to N do 
   begin
     cantS:=sumFila(matS,i,M);
     cantBaj:=sumFila(matB,i,M);
     if(cantS<(cantBaj*0.4))then
       cont:=cont+1;
   end;
   cantParadas:=cont;
end;

function cantNoRegistraron(matS,MatB:TM;N,M:byte):byte;
var 
 i,j,contNoR:byte;
begin
  contNoR:=0;
  for j:=1 to M do 
   begin
     i:=1;
     while (i<=N) and ((matS[i,j]<>0) or (MatB[i,j]<>0)) do 
      i:=i+1;
     if(i<=M) then 
      contNoR:=contNoR+1; 
   end;
end;

var 
MatSubida,MatBajada:TM;
N,M:byte;
begin
  WriteLn('Ingrese N');
  ReadLn(N);
  WriteLn('Ingrese M');
  ReadLn(M);
  InicializarMatriz(MatSubida,N,M);
  InicializarMatriz(MatBajada,N,M);
  llenarDatosMatriz(MatSubida,MatBajada,N,M);
  //a) Parada con mayor cantidad de pasajeros que bajaron
  WriteLn('La parada con mas cantidad de bajadas es: ',paradaMaxBajadas(MatBajada,N,M));
  //b) Línea con menor cantidad de pasajeros que subieron.
  WriteLn('La linea menor cantidad de subidas es: ',lineaMinSub(MatSubida,N,M));
 // c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que bajaron.
  WriteLn('La cantidad de paradas que cumplne que el total de personas que subieron fue menor al 40% de las que bajaron es:',cantParadas(MatSubida,MatBajada,N,M));
  //Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.
  WriteLn('Cantidad de lineas que no regitraron ni subidas ni bajadas en alguna parada: ',cantNoRegistraron(MatSubida,MatBajada,N,M));
  //¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que ascendió o descendió cada vez que se detuvo el colectivo? 
  WriteLn('Mat sub');
  mostrarMatriz(MatSubida,N,M);
  WriteLn('Mat baj');
  mostrarMatriz(MatBajada,N,M);
end.