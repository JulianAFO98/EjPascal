{Un negocio vende camisas, éstas pueden ser de hombre o de mujer. Los talles que fabrican son: S,
M, L y X. El precio base unitario es de $1000 para hombres y $1200 para mujer, se debe agregar el IVA
del 21%. Hay una promoción en los talles S de hombre y X de mujer con un 5% de descuento. Además, si
la compra supera la docena se considera venta mayorista y obtiene un descuento extra del 7% del total.
Determinar cuáles son los datos necesarios para calcular el importe a facturar en una venta. }



program guia2ej7;
const 
  IVA = 1.21;
  PrecioHombre = 1000;
  PrecioMujer = 1200;
var

talle,HoM:char;
cantCompras:byte;
precio:real;
begin
 WriteLn('Ingrese la cantidad de compras');
 ReadLn(cantCompras);
 WriteLn('Ingrese el tipo de prenda(H para hombre o M para mujer)');
 ReadLn(HoM);
 WriteLn('Ingrese el talle de las prendas(S,M,L,X)');
 ReadLn(talle);
 HoM := Upcase(HoM);
 if(HoM = 'M') or (HoM = 'H') then
   if(HoM = 'M') then
     begin
       precio:=PrecioMujer*cantCompras*IVA;
       if(talle='X') then
        precio:=precio*0.95;
       if(cantCompras>12) then
        precio:=precio * 0.93;
     end
   else  
     begin
       precio:=PrecioHombre*cantCompras*IVA;
       if(talle='S') then
        precio:=precio*0.95;
       if(cantCompras>12) then
        precio:=precio * 0.93;
     end
 else  
   WriteLn('Ingreso un caracter erroneo');

 WriteLn('El precio total es',precio:4:2); 
end.