{Una  planta  de  silos  registra  el  ingreso  de  camiones  de  sus  clientes  con  cereal,  por  cada  uno  se 
tiene: 
• Cliente 
• Patente del camión 
• Tipo de cereal ( 1-trigo, 2-girasol, 3-soja, 4-maiz ) 
• Toneladas 
Se pide que lea los datos desde un archivo y mediante un menú de opciones iterativo calcule e informe: 
a) Porcentaje de toneladas de cada cereal respecto del total. 
b) Dada una patente, si es que existe, decir qué tipo de cereal transporta, las toneladas y a qué cliente 
pertenece. 
c) Generar un arreglo con los clientes que transportaron más de X toneladas, ordenado 
alfabéticamente. }
program ej15;
type
str15 = string[15];
str7 = string[7];
TVstr15 = array [1..255] of str15;
TVstr7 = array [1..255] of str7;
TVB = array [1..255] of byte;
TVR = array [1..255] of real;

procedure llenarDatos(var VClient:TVstr15;var Vpatente:TVstr7;var Vtipo:TVB;var VTonelada:TVR;var N:byte);
var
arch:text;
i,pos:byte; 
cliente:str15;
pat:str7;
tipo:byte;
ton:real;
begin
  assign(arch,'datos.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
    begin
      readln(arch,cliente,pat,tipo,ton);
      i:=1;
      pos:=0;
      while (i<=N) and (pos=0) do 
       begin
         if(pat=Vpatente[i]) then
           pos:=i;
         i:=i+1;  
       end;
       if(pos<>0) then
         begin
           VTonelada[pos]:=VTonelada[pos]+ton;
         end
       else 
         begin
           N:=N+1;
           VClient[N]:=cliente;
           Vtipo[N]:=tipo;
           Vpatente[N]:=pat;
           VTonelada[N]:=ton;
         end; 
       
    end;
    close(arch);    
end;

procedure mostrarDatos(Vcliente:TVstr15;Vpatente:TVstr7;Vtipo:TVB;VTonelada:TVR;N:byte);
var 
i:byte;
tipoCereal:str7;
begin
   for i:=1 to N do
      begin
        Case Vtipo[i] of 
        1:tipoCereal:='trigo';
        2:tipoCereal:='girasol';
        3:tipoCereal:='soja';
        4:tipoCereal:='maiz';
        end;
        WriteLn('El vehiculo ',Vpatente[i],' cuyo duenio es ',Vcliente[i],' transporto ',VTonelada[i]:4:2,' de ',tipoCereal);
      end;
end;

procedure mostrarOpciones();
begin
  WriteLn('1-Porcentaje de toneladas de cada cereal respecto del total');
  WriteLn('2-Dada una patente que tipo de cereal transporta, las toneladas y a que cliente pertenece');
  WriteLn('3-Generar un arreglo con los clientes que transportaron mas de X toneladas, ordenado alfabeticamente');
  WriteLn('0-salir');
end;

procedure informarPorcentajesCereal(tipoC:TVB;tons:TVR;N:byte);
var 
i:byte;
AcumTotal,AcumGir,AcumSoj,AcumMaiz,AcumTrig:real;
begin
  AcumTotal:=0;
  AcumGir:=0;
  AcumSoj:=0;
  AcumMaiz:=0;
  AcumTrig:=0;
  for i:=1 to N do 
   begin
     AcumTotal:=AcumTotal+tons[i];
     Case tipoC[i] of  
      1:AcumTrig:=AcumTrig+tons[i];
      2:AcumGir:=AcumGir+tons[i];
      3:AcumSoj:=AcumSoj+tons[i];
      4:AcumMaiz:=AcumMaiz+tons[i];
     end;
   end;
   WriteLn('Porcentaje de trigo ',(AcumTrig/AcumTotal)*100:4:2);
   WriteLn('Porcentaje de girasol ',(AcumGir/AcumTotal)*100:4:2);
   WriteLn('Porcentaje de soja ',(AcumSoj/AcumTotal)*100:4:2);
   WriteLn('Porcentaje de maiz ',(AcumMaiz/AcumTotal)*100:4:2);
end;

function buscarPosPat(pate:str7;vpate:TVstr7;N:byte):byte;
var 
i,pos:byte;
begin
  pos:=0;
  i:=1;
  while (i<=N) and (pos=0) do 
   begin
     if(pate=vpate[i]) then 
      pos:=i;
   end;
  buscarPosPat:=pos; 
end;


procedure InformarDatosPatente(pat:str7;Vcliente:TVstr15;Vpatente:TVstr7;Vtipo:TVB;VTonelada:TVR;N:byte);
var 
pos:byte;
tipoCereal:str7;
begin
  pos:=buscarPosPat(pat,Vpatente,N);
  if(pos=0) then
    WriteLn('No existe la patente ingresada')
  else 
    Case Vtipo[pos] of 
        1:tipoCereal:='trigo';
        2:tipoCereal:='girasol';
        3:tipoCereal:='soja';
        4:tipoCereal:='maiz';
    end;
  WriteLn('El vehiculo ',pat,' cuyo duenio es ',Vcliente[pos],' transporto ',VTonelada[pos]:4:2,' de ',tipoCereal);
end;

function existeCliente(clie:str15;vx:TVstr15;N:byte):boolean;
var 
i:byte;
existe:boolean;
begin
  i:=1;
  existe:=false;
  while (i<=N) and (not existe) do 
   begin
     if(clie=vx[i]) then 
      existe:=true;
   end;
  WriteLn('Sin error en la func 1'); 
  existeCliente:=existe; 
end;

function buscarPosAColocarCliente(clie:str15;vx:TVstr15;N:byte):byte;
var 
i,pos:byte;
begin
  pos:=N+1;
  i:=1;
  while (i<=N) and (pos=(N+1)) do 
    begin
      if (clie<vx[i]) then 
       pos:=i;
      i:=i+1;
    end;
   WriteLn('Sin error en la func 2');
   buscarPosAColocarCliente:=pos; 
end;

procedure GenerarArregloX(X:real;Vcliente:TVstr15;vecTon:TVR;N:byte);
var
 arrX:TVstr15;
 i,j,NX,pos:byte;
 cliente:str15;
 existe:boolean;
begin
   NX:=0;
   for i := 1 to N do 
    begin
      if(vecTon[i]>X) then 
       begin
         cliente:=Vcliente[i];
         existe:=existeCliente(cliente,arrX,NX);
         WriteLn('A');
         if(not existe) then
          begin
            pos:=buscarPosAColocarCliente(cliente,arrX,NX);
            for j:=NX downto pos do 
             begin
               WriteLn('B-Bucle');
               arrX[NX]:=arrX[NX-1];
             end;
            WriteLn('B');  
            arrX[pos]:=cliente; 
            NX:=NX+1;
         end;
       end;
    end;
   WriteLn('C'); 
   for i:=1 to NX do 
    begin
      WriteLn(arrX[i],' ');
    end; 
end;


var 
Vcliente:TVstr15;
Vpatentes:TVstr7;
Vtipo:TVB;
VTonelada:TVR;
N,opc:byte;
patente:str7;
x:real;
begin
  llenarDatos(Vcliente,Vpatentes,Vtipo,VTonelada,N);
  mostrarDatos(Vcliente,Vpatentes,Vtipo,VTonelada,N);
  repeat
    mostrarOpciones();
    repeat
      ReadLn(opc);
    until (opc>=0) and (opc<=3);

    case opc of 
      1:informarPorcentajesCereal(Vtipo,VTonelada,N);
      2:
       begin
         WriteLn('Ingrese una patente a buscar');
         ReadLn(patente);
         InformarDatosPatente(patente,Vcliente,Vpatentes,Vtipo,VTonelada,N);
       end;
      3:
       begin
         WriteLn('Ingrese X');
         ReadLn(X);
         GenerarArregloX(X,Vcliente,VTonelada,N);
       end;
      else 
       WriteLn('Salio del programa');
    end;
  until opc=0;
end.
