{) Una fábrica de camperas tiene organizado su stock de la siguiente manera en un archivo de tipo:
# CODIGO de ARTICULO (cadena de 4) (1er. campo de secuencia, clave secundaria)
# TALLE ( S, M, L, X) (2do. campo de secuencia, clave secundaria)
# COLOR (1=Negro, 2=Marrón, 3=Azul, 4=Rojo) (3er. campo de secuencia, clave secundaria)
# CANTIDAD de PRENDAS
# PRECIO de COSTO
 Clave primaria: CODIGO de ARTICULO + TALLE + COLOR
Se desea obtener el siguiente listado:
Stock de Prendas
Código: XXXX
 Talle Cantidad Precio Costo
 X 999 $ 99999.99
 . . . . . . . . .
Código: XXXX
. . .
Cantidad Total: 9999
Porcentaje de Prendas Negras: 99.99 % }

program ej4;
type 
str4 = string[4];
TRegPrenda = record 
  codigoArti:str4;
  talle:char;
  color:byte;
  cantidadP:word;
  precioCosto:real;
end;

archivoPrendas = file of TRegPrenda;  

procedure GrabarPrendas(var prendas:archivoPrendas);
var 
arch:text;
extra:char;
prenda,prendaCentinela:TRegPrenda;
begin
  Assign(arch,'prendas.txt');
  Reset(arch);
  Rewrite(prendas);
  while not eof(arch) do
   begin
     ReadLn(arch,prenda.codigoArti,extra,prenda.talle,prenda.color,prenda.cantidadP,prenda.precioCosto);
     Write(prendas,prenda);
   end;
  prendaCentinela.codigoArti:='A999';
  Write(prendas,prendaCentinela);
  close(arch);
  Close(prendas); 
end;

procedure mostrarPrendas(var prendas:archivoPrendas);
var
 prenda:TRegPrenda; 
begin
  Reset(prendas);
  while not eof(prendas) do 
   begin
     Read(prendas,prenda);
     WriteLn(prenda.codigoArti,'  ',prenda.talle,'  ',prenda.color,'  ',prenda.cantidadP,'  ',prenda.precioCosto:6:2);
   end;
  close(prendas); 
end;

procedure GenerarInforme(var prendas:archivoPrendas);
var 
 prenda:TRegPrenda;
 codigoActual:str4;
 precioTotal:real;
 cantPrendas:word;
 talleActual:char;
begin
  reset(prendas);
  WriteLn('              Stock de Prendas               ');
  read(prendas,prenda);
  while not eof(prendas) do 
   begin
     codigoActual:=prenda.codigoArti;
     WriteLn('Codigo actual: ',codigoActual);
     while codigoActual = prenda.codigoArti do 
      begin
        WriteLn('Talle      Cantidad        Precio Costo');
        cantPrendas:=0;
        precioTotal:=0;
        talleActual:=prenda.talle;
        while (talleActual=prenda.talle) and (codigoActual=prenda.codigoArti) do 
         begin
           cantPrendas:=cantPrendas+prenda.cantidadP;
           precioTotal:=precioTotal+prenda.cantidadP*prenda.precioCosto;
           Read(prendas,prenda);
         end;
         WriteLn(talleActual,'              ',cantPrendas,'          ',precioTotal:6:2);

      end;  
   end;
   Close(prendas);
end;


var 
prendas:archivoPrendas;
begin
  Assign(prendas,'prendas.dat');
  GrabarPrendas(prendas);
  mostrarPrendas(prendas);
  GenerarInforme(prendas);
end.