program parcialPropuesto2;
type 
str4 = string[4];
TVS = array [1..255] of str4;
TVR = array [1..255] of real;
TVB = array [1..255] of byte;


procedure llenarDatos(var COD:TVS;var TOT:TVR;var ENTREGAS:TVB;var N:byte);
var 
arch:text;
i,dia:byte;
codigo:str4;
litros:real;
begin
  Assign(arch,'tambos.txt');reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     readln(arch,codigo,dia,litros);
     i:=1;
     while (i<=N) and (codigo<>COD[i]) do 
       i:=i+1;
     if(i>N) then 
      begin
        N:=N+1;
        COD[N]:=codigo;
        TOT[N]:=litros;
        ENTREGAS[N]:=1;
      end  
     else 
      begin
        TOT[i]:=TOT[i]+litros;
        ENTREGAS[i]:=ENTREGAS[i]+1;
      end;
   end;
   Close(arch); 
end;

procedure mostrarDatos(COD:TVS;TOT:TVR;ENTREGAS:TVB;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     WriteLn('El tambo ',COD[i],' tiene un total de litros ',TOT[i]:6:2,' y realizo ',ENTREGAS[i],' entregas');
   end;
end;

function codMaxEntrego(COD:TVS;TOT:TVR;N:byte):str4;
var
codMax:str4;
totMax:real;
i:byte; 
begin
  totMax:=0;
  for i:=1 to N do 
   begin
     if(TOT[i]>totMax) then
       begin
         totMax:=TOT[i];
         codMax:=COD[i];
       end;
   end;
   codMaxEntrego:=codMax;
end;

function cantSupX(X:real;TOT:TVR;ENTREGAS:TVB;N:byte):byte;
var 
 i,cont:byte;
 prom:real;
begin
  cont:=0;
  for i:=1 to N do 
   begin
     prom:=TOT[i]/ENTREGAS[i];
     if (prom>X) then 
       cont:=cont+1;
   end;
   cantSupX:=cont;
end;

function buscarPosCod(codigo:str4;COD:TVS;N:byte):byte;
var 
i:byte;
begin
  i:=1;
  while (i<=N)  and (codigo<>COD[i]) do 
   i:=i+1;
  if(i>N) then
    buscarPosCod:=0
  else 
   buscarPosCod:=i;   
end;


var 
COD:TVS;
TOT:TVR;
ENTREGAS:TVB;
N,pos:byte;
X:real;
codigo:str4;
begin
  llenarDatos(COD,TOT,ENTREGAS,N);
  mostrarDatos(COD,TOT,ENTREGAS,N);
  //a) Código del tambo que más leche entregó a la compañía.
  WriteLn('El codigo del tambo que mas leche entrego es: ',codMaxEntrego(COD,TOT,N));
  //b) Cuántos superaron un promedio de X litros de entrega.
  WriteLn('Ingrese el valor de X');
  ReadLn(X);
  WriteLn('Cantidad que superaron un promedio X fueron:',cantSupX(X,TOT,ENTREGAS,N));
  //c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).
  WriteLn('Ingrese un codigo a buscar');
  ReadLn(codigo);
  pos:=buscarPosCod(codigo,COD,N);
  if(pos = 0) then
     WriteLn('No existe el codigo')
  else 
    begin
      WriteLn('Total entregado por el codigo ingresado: ',TOT[pos]:6:2);
      WriteLn('Promedio diario entregado por el codigo ingresado: ',(tot[pos]/15):6:2);
    end;   
end.