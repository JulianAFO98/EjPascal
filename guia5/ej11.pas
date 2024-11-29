{De una competencia de atletismo se tienen los siguientes datos del lanzamiento de jabalina:  
• Nombre del competidor   (ordenado ascendentemente por este dato) 
• 1º lanzamiento 
• 2º lanzamiento 
Se pide: 
a)  Cuántos competidores superaron con el 2º lanzamiento el 1º. 
b)  Nombre del atleta que registró la mejor marca. 
c)  Dado el Nombre de un atleta, informar la marca que realizó en ambos lanzamientos. 
d)  Generar un nuevo arreglo con los participantes que pasaron a la semifinal (aquellos que superaron 
una marca X establecida en el 1º ó 2º lanzamiento). Mostrar ambos arreglos}

program ej11;
type
str10=string[10];
TVS = array [1..255] of str10;
TVW = array [1..255] of word;

function Trim(const S: string): string;
var
  I, Start, Stop: Integer;
begin
  Start := 1;
  Stop := Length(S);

  while (Start <= Stop) and (S[Start] = ' ') do
    Inc(Start);
  while (Stop >= Start) and (S[Stop] = ' ') do
    Dec(Stop);

  trim := Copy(S, Start, Stop - Start + 1);
end;


procedure llenarVectores(var VecNomb:TVS;var VecL1,vecL2:TVW;var N:byte);
var 
nombre:str10;
lanz1,lanz2:word;
Arch:text;
begin
  Assign(arch,'datos.txt');
  Reset(arch);
  N:=0;
  while not eof(Arch) do
    begin
      ReadLn(Arch,nombre,lanz1,lanz2);
      N:=N+1;
      VecNomb[N]:=trim(nombre);
      VecL1[N]:=lanz1;
      VecL2[N]:=lanz2;
    end;
   Close(Arch); 
end;

procedure mostrarVecTVS(vec:TVS;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

procedure mostrarVecTVW(vec:TVW;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

function SuperarLanzamiento(vec1,vec2:TVW;N:byte):byte;
var 
i,sup1con2:byte;
begin
  sup1con2:=0;
  for i:=1 to N do 
   begin
     if(vec2[i]>vec1[i]) then
       sup1con2:=sup1con2+1;
   end;
   SuperarLanzamiento:=sup1con2;
end;

function NombreMejorMarca(VecNomb:TVS;VecL1,vecL2:TVW;N:byte):str10;
var 
 nombreMax:str10;
 marcaMax,marcaAComparar:word;
 i:byte;
begin
  marcaMax:=0;
  for i:=1 to N do 
   begin
     if(VecL1[i]>vecL2[i]) then
       marcaAComparar:=VecL1[i]
     else 
       marcaAComparar:=vecL2[i];  
    if(marcaAComparar>marcaMax)then
      begin
        marcaMax:=marcaAComparar;
        nombreMax:=VecNomb[i];
      end;
   end;
   NombreMejorMarca:=nombreMax;
end;

function buscarPosicion(nombre:str10;VecNomb:TVS;N:byte):byte;
var 
i,pos:byte;
encontrado:Boolean;
begin
   i:=1;
   encontrado:=false;
    while (i<=N) and (not encontrado) do 
     begin
      if(nombre = VecNomb[i])then 
       begin
        pos:=i;
        encontrado:=true;
       end;
      i:=i+1;
   end;
   if encontrado then
    buscarPosicion:=pos
   else 
    buscarPosicion:=0; 
     
end;

procedure InformarPuntuacion(nombre:str10;VecNomb:TVS;VecL1,vecL2:TVW;N:byte);
var 
pos:byte;
begin
  pos:=buscarPosicion(nombre,VecNomb,N);
  if(pos <> 0) then
    WriteLn('Las puntuaciones del jugador: ',VecNomb[pos],' fueron: ',VecL1[pos],'-',vecL2[pos])
  else 
    WriteLn('No se encontro el jugador');  
end;


procedure generarFinalistas(VecNomb:TVS;VecL1,vecL2:TVW;N:byte;var vecFinal:TVS;var NF:byte);
var 
i:byte;
X:word;
begin
  WriteLn('Ingrese la marca a superar');
  ReadLn(X);
  NF:=0;
  for i:= 1 to N do 
   begin
      if(VecL1[i]>X) or (vecL2[i]>X) then
        begin
          NF:=NF+1;
          vecFinal[NF]:=VecNomb[i];
        end;
   end;
end;

var 
VecNomb,vecFinal:TVS;
VecL1,vecL2:TVW;
N,NF:byte;
nombre:str10;
begin
  llenarVectores(VecNomb,VecL1,vecL2,N);
  mostrarVecTVS(VecNomb,N);
  mostrarVecTVW(VecL1,N);
  mostrarVecTVW(VecL2,N);
  WriteLn('Cantidad de competidores superaron con el 2 lanzamiento el 1: ',SuperarLanzamiento(VecL1,vecL2,N));
  WriteLn('Nombre del atleta que registro la mejor marca:',NombreMejorMarca(VecNomb,VecL1,vecL2,N));
  WriteLn('Ingrese un atleta a buscar');
  ReadLn(nombre);
  InformarPuntuacion(nombre,VecNomb,VecL1,vecL2,N);
  generarFinalistas(VecNomb,VecL1,vecL2,N,vecFinal,NF);
  mostrarVecTVS(vecFinal,NF);
end.