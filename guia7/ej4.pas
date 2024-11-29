{En una competencia intervienen N equipos deportivos de los cuales se registró:
 Nombre del Club
 Cantidad de partidos jugados
 El resultado de cada encuentro ( G = ganado, E = empatado, P = perdido)
Se pide almacenar los datos en una estructura adecuada junto con el total del puntaje obtenido. Por cada
partido ganado son 3 puntos, empatado 1 y perdido 0.
A partir de lo almacenado, informar:
a) Listado con los nombres de los clubes junto con el puntaje obtenido.
b) Nombre de el/los punteros de la Tabla.
c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes}
program ej4;
type 
str15=string[15];
TVC = array[1..255] of char;
RegEquipo = record 
 nombre:str15;
 cantPart,puntajeTot:byte;
 ResPart:TVC;
end;
TVEquipos = array [1..255] of RegEquipo;

procedure llenarDatos(var Equipos:TVEquipos; var NEquipo:byte);
var 
arch:text;
Equipo:RegEquipo;
i,j,puntajeFinal:byte;
extra:char;
begin
  Assign(arch,'resultados.txt');
  Reset(arch);
  WriteLn('Ingrese cantidad de equipos');
  ReadLn(NEquipo);
  for i:=1 to NEquipo do 
   begin
     puntajeFinal:=0;
     with Equipo do 
      begin
        Read(arch,Equipo.nombre,Equipo.cantPart,extra);
        for j:=1 to Equipo.cantPart do 
         begin
           Read(arch,Equipo.ResPart[j]);
           if(Equipo.ResPart[j] = 'G') then 
             puntajeFinal:=puntajeFinal+3
           else 
             if(Equipo.ResPart[j]='E') then 
              puntajeFinal:=puntajeFinal+1;  
         end;
        Equipo.puntajeTot:=puntajeFinal;
      end;
      Equipos[i]:=Equipo; 
      ReadLn(arch);
   end;
  close(Arch); 
end;

procedure mostrarDatos(Equipos:TVEquipos;N:byte);
var 
i,j:byte;
begin
   for i:=1 to N do 
    begin
      Writeln('Resultados del equipo ',Equipos[i].nombre);
      for j:=1 to Equipos[i].cantPart do 
       begin
         Write(Equipos[i].ResPart[j],' ');
       end;
      WriteLn;
      WriteLn('Cantidad total de puntos: ',Equipos[i].puntajeTot);
    end;
end;

function BuscarPuntMax(Equipos:TVEquipos;N:byte):byte;
var 
i,puntMax:byte;
begin
  puntMax:=0;
  for i:=1 to N do 
   begin
     if(Equipos[i].puntajeTot>puntMax)then 
      begin
       puntMax:=Equipos[i].puntajeTot;
      end;
   end;
  BuscarPuntMax:=puntMax; 
end;


procedure InformarPunteros(Equipos:TVEquipos;NEquipo:byte);
var
puntMax,i:byte; 
begin
  puntMax:=BuscarPuntMax(Equipos,NEquipo);
  WriteLn('Los punteros son:');
  for i:=1 to NEquipo do 
   begin
     if(Equipos[i].puntajeTot=puntMax) then 
      WriteLn(Equipos[i].nombre);
   end;
end;
function PorcentajeGanadores(Equipos:TVEquipos;N:byte):real;
var 
i,j,contG,contGanadores:byte;
begin
  contGanadores:=0;
  for i:=1 to N do 
   begin
     contG:=0;
     for j:=1 to Equipos[i].cantPart do 
       begin
         if(Equipos[i].ResPart[j]='G') then
            contG:=contG+1;
       end;
      if(contG=Equipos[i].cantPart) then 
        contGanadores:=contGanadores+1; 
   end;
   PorcentajeGanadores:=(contGanadores/N)*100; 
end;


var 
NEquipo:byte;
Equipos:TVEquipos;
begin
  llenarDatos(Equipos,NEquipo);
  mostrarDatos(Equipos,NEquipo);
  InformarPunteros(Equipos,NEquipo);
  WriteLn('Porcentaje de los que no perdieron ningun partido:',PorcentajeGanadores(Equipos,NEquipo):4:2,'%');
end.