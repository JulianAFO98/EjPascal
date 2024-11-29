program parcialPropuesto1;

type 
str4 = string[4];
TVS = array [1..255] of str4;
TVR = array [1..255] of real;


procedure inicializarvec(var tot:TVR;N:byte);
var
i:byte;
begin
  for i:=1 to N do 
   begin
     tot[i]:=0;
   end;
end;


procedure llenarDatos(var cod:TVS;var tot,prom:TVR;var N:byte);
var 
arch:text;
i,contDias:byte;
num:real;
begin
Assign(arch,'datos.txt');reset(arch);
WriteLn('Ingrese N');  
ReadLn(N);
inicializarvec(tot,N);
for i:=1 to N do 
 begin
   readln(arch,cod[i]);
   contDias:=0;
   read(arch,num);
   while num <> 0 do 
    begin
      tot[i]:=tot[i]+num;
      contDias:=contDias+1;
      read(arch,num);
    end;
    prom[i]:=tot[i]/contDias;
    ReadLn(arch);
 end;
 close(arch);
end;



procedure mostrarDatos(cod:TVS;tot,prom:TVR;N:byte);
var
i:byte;
begin
   for i:=1 to N do 
    begin
      WriteLn('Cod:',cod[i],' L totales: ',tot[i]:4:2,' prom: ',prom[i]:4:2);
    end;
end;

function EntregoMasLeche(cod:TVS;tot:TVR;N:byte):str4;
var 
i:byte;
CodMax:str4;
litrosMax:real;
begin
  litrosMax:=0;
  for i:=1 to N do 
   begin
     if(tot[i]>litrosMax) then 
      begin
        litrosMax:=tot[i];
        COdMax:=cod[i];
      end;
   end;
   EntregoMasLeche:=CodMax;
end;

function cantSupPromX(X:real;prom:TVR;N:byte):byte;
var 
i:byte;
cont:byte;
begin
   cont:=0;
   for i := 1 to N do 
    begin
      if(prom[i]>X) then
        begin
          cont:=cont+1;
        end;
    end;
   cantSupPromX:=cont; 
end;

function buscarPos(codigo:str4;cod:TVS;N:byte):byte;
var 
i,pos:byte;
begin
  i:=1;
  while (i<=N)  and (codigo<>cod[i]) do 
   i:=i+1;
  if(i<=N) then
    pos:=i
  else 
    pos:=0;  
  buscarPos:=pos;
end;

procedure buscarCodigo(codigo:str4;COD:TVS;TOT,PROM:TVR;N:byte);
var 
pos:byte;
begin
  pos:=buscarPos(codigo,COD,N);
  if(pos=0) then
    WriteLn('No existe el codigo')
  else 
    begin
        WriteLn('El prom del tambo es:',prom[pos]:4:2);
        WriteLn('EL total del tambo es:',TOT[pos]:8:2);
    end;
end;



var 
COD:TVS;
TOT,PROM:TVR;
N:BYTE;
X:real;
codigo:str4;
begin
  llenarDatos(COD,TOT,PROM,N);
  mostrarDatos(cod,tot,prom,N);
  // a) Código del tambo que más leche entregó a la compañía.
  WriteLn('El tambo que mas leche entrego fue: ',EntregoMasLeche(COD,TOT,N));
  //b) Cuántos superaron un promedio de X litros de entrega.
  WriteLn('Ingrese X');
  ReadLn(X);
  WriteLn('La cantidad de tambos que supero el X promedio fue:', cantSupPromX(X,prom,N));
  //c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).
  WriteLn('Ingrese un codigo a buscar');
  ReadLn(codigo);
  buscarCodigo(codigo,COD,TOT,PROM,N);
end.