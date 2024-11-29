{ En  un  archivo  de  texto  se  ha  grabado  por  cada  línea,  una  cadena  (es  una  clave  encriptada  que 
puede  contener  letras,  números  y  caracteres  especiales  (&,  $,  #,  etc.),  y  que  siempre  termina  en  letra), 
luego uno o más blancos y tres números separados por blancos, por último uno o más blancos y una letra.  
Ejemplo: mU&1#hT34*A    80   40   30     P 
Se pide, a partir del archivo, cargar tres arreglos paralelos: 
• VClave contendrá las claves sin los caracteres especiales, que registren en su encriptación hasta  
tres caracteres especiales (las claves que tengan más de tres invalidan la información de la línea, 
que no se almacena) 
• VProm almacena el promedio de los tres números. 
• VCar almacena el caracter que está al final de la línea, siempre que no coincida con la última letra 
de la clave, en cuyo caso invalida la información de la línea, que no se almacena) 
Mostrar los arreglos generados, y luego para una letra y una clave que se ingresan por teclado: 
a)  Para la letra ingresada, calcular e informar la clave de máximo promedio. 
b)  Para la clave ingresada, informar el promedio y la letra asociada (puede no existir) }
program ej12;
type 
str15=string[15];
TVS = array [1..255] of str15;
TVP = array [1..255] of real;
TVC = array [1..255] of char;


procedure llenarVectores(var VClave:TVS;var VProm:TVP;var VCar:TVC;var N:byte);
var 
Arch:text;
car,ultimaletra:char;
clave:str15;
contEsp,n1,n2,n3:byte;
prom:real;
begin
  Assign(Arch,'datos.txt');reset(Arch);N:=0;
  while not eof(arch) do
   begin
     contEsp:=0;clave:='';
     Read(arch,car);
     while car <>' ' do
       begin
         if(car in ['A'..'Z','a'..'z','0'..'9']) then
           begin
             clave:=clave+car;
             ultimaletra:=car;
           end
         else 
           contEsp:=contEsp+1;  
         read(arch,car);    
       end;
     Read(arch,n1,n2,n3);
     prom:= (n1+n2+n3)/3;
     while car = ' ' do
       read(Arch,car);
     if(contEsp<=3) and (ultimaletra<>car) then
       begin
         N:=N+1;
         VClave[N]:=clave;
         VProm[N]:=Prom;
         VCar[N]:=car;
       end;  
     ReadLn(Arch);
   end;
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

procedure mostrarVecTVP(vec:TVP;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i]:4:2,' ');
   end;
   WriteLn();
end;
procedure mostrarVecTVC(vec:TVC;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

function buscarPosClave(clave:str15;VClave:TVS;N:byte):byte;
var 
pos:byte;
i:byte;
begin
  pos:=0;
  i:=1;
  while (i<=N) and (pos=0) do
   begin
     if(clave=Vclave[i]) then
       pos:=i;
     i:=i+1;  
   end;
   buscarPosClave:=pos; 
end;

function claveMaxProm(letra:char;VClave:TVS;VProm:TVP;VCar:TVC;N:byte):str15;
var 
i:byte;
claveMax:str15;
promMax:real;
begin
  promMax:=0;claveMax:='';
  for i:=1 to N do 
   begin
     if(letra=VCar[i]) and (VProm[i]>promMax) then
       begin
         promMax:=VProm[i];
         claveMax:=VClave[i];
       end;
   end;
   if claveMax <> '' then
     claveMaxProm:=claveMax
   else 
     WriteLn('No existe');  
end;

procedure promYLetraClave(clave:str15;VClave:TVS;VProm:TVP;VCar:TVC;N:byte);
var 
pos:byte;
begin
  pos:=buscarPosClave(clave,VClave,N);
  if(pos<>0)then
    begin
      WriteLn('La clave es: ',clave);
      WriteLn('Promedio de la clave: ',VProm[pos]:4:2);
      WriteLn('Letra de la clave: ',VCar[pos]);
    end
   else 
    WriteLn('No existe la clave buscada'); 
end;

var 
VClave:TVS;
VProm:TVP;
VCar:TVC;
N:byte;
letra:char;
clave:str15;
begin
llenarVectores(VClave,VProm,VCar,N); 
mostrarVecTVS(VClave,N);
mostrarVecTVP(VProm,N);
mostrarVecTVC(VCar,N);
WriteLn('Ingrese una letra a buscar');
ReadLn(letra);
WriteLn('Clave de max promedio:',claveMaxProm(letra,VClave,VProm,VCar,N));
WriteLn('Ingrese una clave a buscar');
ReadLn(clave);
promYLetraClave(clave,VClave,VProm,VCar,N);
end.