program final22122023;
const 
 cantPartidos = 5;
type 

TV = array [1..5] of word;
str15=string[15];

RegVotoAcum = record
  numDistrito:integer;
  partidos:TV;
end;

archivoVotoAcum = file of RegVotoAcum;

RegVoto = record 
  numDistrito:integer;
  partido:byte;
  cantVotos:word;
end;

archivoVoto = file of RegVoto;


RegDistrito = record 
  numDistrito:integer;
  nombre:str15;
end;  

archivoDistrito = file of RegDistrito;

TVT = array [1..50] of RegDistrito;

procedure grabarVOTOACUM(var VOTOS_ACUM:archivoVotoAcum);
var 
archivo:text;
votoAcum:RegVotoAcum;
i:byte;
begin
  Rewrite(VOTOS_ACUM);
  Assign(archivo,'VOTOS_ACUM.TXT');
  reset(archivo);
  while not eof(archivo) do 
   begin
     Read(archivo,votoAcum.numDistrito);
     for i:=1 to 5 do 
      begin
        Read(archivo,votoAcum.partidos[i]);
      end; 
     Write(VOTOS_ACUM,votoAcum);
     ReadLn(archivo); 
   end;
  close(archivo); 
  close(VOTOS_ACUM);
end;

procedure mostrarVOTOACUM(var VOTOS_ACUM:archivoVotoAcum);
var 
votoAcum:RegVotoAcum;
i:byte;
begin
  reset(VOTOS_ACUM);
  Read(VOTOS_ACUM,votoAcum);
  while votoAcum.numDistrito<>999 do 
   begin
     Write(votoAcum.numDistrito,' ');
     for i:=1 to 5 do 
      begin
        Write(votoAcum.partidos[i],' ');
      end;
     WriteLn();
     Read(VOTOS_ACUM,votoAcum);
   end;
  close(VOTOS_ACUM); 
end;

procedure grabarVotosParciales(var VOTOS_PARCIAL:archivoVoto);
var
 voto:RegVoto;
 archivo:text; 
begin
  Rewrite(VOTOS_PARCIAL);
  Assign(archivo,'VOTOS_PARCIAL.TXT');
  Reset(archivo);
  while not eof(archivo) do 
   begin
     ReadLn(archivo,voto.numDistrito,voto.partido,voto.cantVotos);
     Write(VOTOS_PARCIAL,voto);
   end;
  close(VOTOS_PARCIAL);
  Close(archivo); 
end;

procedure mostrarVotosParciales(var VOTOS_PARCIAL:archivoVoto);
var
 voto:RegVoto; 
begin
  reset(VOTOS_PARCIAL);
  read(VOTOS_PARCIAL,voto);
  while voto.numDistrito<>999 do 
   begin
     WriteLn(voto.numDistrito,' ',voto.partido,' ',voto.cantVotos);
     Read(VOTOS_PARCIAL,voto);
   end;
  Close(VOTOS_PARCIAL); 
end;

procedure grabarDistritos(var Distritos:archivoDistrito);
var 
 distrito:RegDistrito;
 archivo:text;
 extra:char;
begin
  Assign(archivo,'DISTRITOS.TXT');
  Reset(archivo);
  Rewrite(Distritos);
  while not eof(archivo) do 
   begin
     Readln(archivo,distrito.numDistrito,extra,distrito.nombre);
     Write(Distritos,distrito);
   end;
  Close(archivo);
  Close(Distritos); 
end;

procedure mostrarDistritos(var Distritos:archivoDistrito);
var
 distrito:RegDistrito; 
begin
  reset(Distritos);
  while not eof(Distritos) do
   begin
     Read(distritos,distrito);
     WriteLn(distrito.numDistrito,' ',distrito.nombre);
   end;
   close(Distritos);
end;

procedure grabarTabla(var Distritos:archivoDistrito;var tabla:TVT);
var 
 i:byte;
begin
  Reset(Distritos);
  i:=1;
  while not eof(Distritos) do 
   begin
     Read(Distritos,tabla[i]);
     i:=i+1;
   end;
  Close(Distritos); 
end;


procedure InicializarVec(var VecPartidos:TV);
var 
i:byte;
begin
  for i:=1 to cantPartidos do 
   VecPartidos[i]:=0;
end;

function buscarPartidoGanador(Vector:TV):byte;
var 
i,pos:byte;
max:word;
begin
  max:=0;
  pos:=0;
  for i:=1 to cantPartidos do 
   begin
     if(Vector[i]>max) then 
      begin
        max:=Vector[i];
        pos:=i;
      end;
   end;
   buscarPartidoGanador:=pos;
end;

function buscarNombrePartido(cod:word;tabla:TVT):str15;
var
 i:byte; 
begin
  i:=1;
  while cod<>tabla[i].numDistrito do 
   i:=i+1;
  buscarNombrePartido:=tabla[i].nombre; 
end;

procedure acumularVotos(partidos:TV;var VecAcumPartidos:TV);
var 
i:byte;
begin
  for i:=1 to cantPartidos do 
   begin
     VecAcumPartidos[i]:=VecAcumPartidos[i]+partidos[i];
   end;
end;


procedure Enfrentamiento(var VOTOS_ACUM:archivoVotoAcum;var VOTOS_PARCIAL:archivoVoto; var Distritos:archivoDistrito;tabla:TVT;var VecPartidos:TV;nombre:str15);
var 
 distrito:RegDistrito;
 votoAcum:RegVotoAcum;
 votoParcial:RegVoto;
 temp:archivoVotoAcum;
 i:byte;
begin
  Assign(temp,'Temp.dat');
  Rewrite(temp);
  reset(VOTOS_ACUM);
  Reset(VOTOS_PARCIAL);
  Reset(Distritos);
  Read(VOTOS_ACUM,votoAcum);Read(VOTOS_PARCIAL,votoParcial);
  while (not eof(VOTOS_ACUM)) or (not eof(VOTOS_PARCIAL)) do 
   if(votoAcum.numDistrito = votoParcial.numDistrito) then 
    begin
      while (votoAcum.numDistrito = votoParcial.numDistrito) do 
       begin
         votoAcum.partidos[votoParcial.partido]:=votoAcum.partidos[votoParcial.partido]+votoParcial.cantVotos;
         Read(VOTOS_PARCIAL,votoParcial);
       end;
      acumularVotos(votoAcum.partidos,VecPartidos); 
      i:=buscarPartidoGanador(votoAcum.partidos);
      WriteLn('Ganador del distrito:',buscarNombrePartido(votoAcum.numDistrito,tabla),' ',i);
      Write(temp,votoAcum);
      read(VOTOS_ACUM,votoAcum);
    end
   else 
    begin
      if(votoAcum.numDistrito<votoParcial.numDistrito)then 
       begin
         Write(temp,votoAcum);
         i:=buscarPartidoGanador(votoAcum.partidos);
         if i<>0 then
          WriteLn('Ganador del distrito:',buscarNombrePartido(votoAcum.numDistrito,tabla),' ',i);
         read(VOTOS_ACUM,votoAcum); 
       end; 
    end; 
  Write(temp,votoAcum);  
  Close(temp);Close(VOTOS_ACUM);Close(VOTOS_PARCIAL);Close(Distritos);
  Erase(VOTOS_ACUM);
  Rename(Temp,nombre);
end;

procedure mostrarVecPartidos(VecPartidos:TV;X:word);
var 
i:byte;
begin
  WriteLn('TOTALES GENERALES POR PARTIDO');
  WriteLn('Partido       TOTALES');
  for i:=1 to cantPartidos do 
   begin
     if(VecPartidos[i]>X)then 
      begin
        WriteLn(i,' ',VecPartidos[i]);
      end;
   end;
end;


var
VOTOS_ACUM:archivoVotoAcum;
VOTOS_PARCIAL:archivoVoto;
Distritos:archivoDistrito;
tabla:TVT;
VecPartidos:TV;
X:word;
begin
 Assign(VOTOS_ACUM,'VOTOS_ACUM.DAT');
 grabarVOTOACUM(VOTOS_ACUM);
 //mostrarVOTOACUM(VOTOS_ACUM);
 Assign(VOTOS_PARCIAL,'VOTOS_PARCIAL.DAT');
 grabarVotosParciales(VOTOS_PARCIAL);
 //mostrarVotosParciales(VOTOS_PARCIAL);
 Assign(Distritos,'DISTRITOS.DAT');
 grabarDistritos(Distritos);
 //mostrarDistritos(Distritos);
 grabarTabla(Distritos,tabla);
 InicializarVec(VecPartidos);
 Enfrentamiento(VOTOS_ACUM,VOTOS_PARCIAL,Distritos,tabla,VecPartidos,'VOTOS_ACUM.DAT');
 mostrarVOTOACUM(VOTOS_ACUM);
 WriteLn('Ingrese X');
 ReadLn(X);
 mostrarVecPartidos(VecPartidos,X);
end.