{La cajera de un supermercado ha registrado varias ventas, de cada una sabe:
 Nombre del cliente ( “ ***** “ indica fin de datos )
 Cantidad de artículos que compró el cliente y por cada uno se conoce:
- Precio base del artículo
- Si está o no en promoción ( ‘S’ ó ‘N’ )
En el caso de estar en promoción, se realiza un descuento del 10% sobre el precio base.
Se pide ingresar los datos e informar:
a) Monto total de cada venta, el total del descuento y el precio final a pagar.
b) Nombre del cliente que compró la mayor cantidad de artículos en oferta.
c) Cuántos clientes compraron solo artículos en oferta. 
}
Program ej17;
const 
DESCUENTO = 0.10;
var 
nombreCliente,clienteOferta:string[10];
cantP,i,contOferta,MayorOferta,contSoloOferta,cantCSoloOferta:byte;
promocion:char;
precioB,precioTotal,totalDes:real;
begin
  WriteLn('Ingrese el nombre del cliente(***** para fin de datos)');
  ReadLn(nombreCliente);
  MayorOferta:=0;
  cantCSoloOferta:=0;
  while nombreCliente<>'*****' do
    begin
     WriteLn('Ingrese cuentos articulos compro');
     ReadLn(cantP);
     precioTotal:=0;
     totalDes:=0;
     contOferta:=0;
     contSoloOferta:=0;
     for i:=1 to cantP do
       begin
          WriteLn('Ingrese precio base del articulo');
          ReadLn(precioB);
          repeat
            WriteLn('Esta en oferta?');
            ReadLn(promocion);
            if (promocion <> 'S') and (promocion <> 'N') then
              WriteLn('Ingreso una opcion erronea');
          until (promocion = 'S') or (promocion = 'N');
          precioTotal:=precioTotal+precioB;
          if(promocion = 'S') then
            begin
              contSoloOferta:=contSoloOferta+1;
              contOferta:=contOferta+1;
              totalDes:=totalDes+(precioB*DESCUENTO);
            end; 
        end;
     if(contOferta>MayorOferta) then
       begin
         MayorOferta:=contOferta; 
         clienteOferta:=nombreCliente;
       end;
     if(contSoloOferta=cantP) then
       cantCSoloOferta:=cantCSoloOferta+1;
     WriteLn('Precio total: ',precioTotal:4:2);
     WriteLn('Cant descuento: ',totalDes:4:2);
     WriteLn('Precio final: ',(precioTotal-totalDes):4:2); 
     WriteLn('Ingrese el nombre del cliente(***** para fin de datos)');
     ReadLn(nombreCliente);
    end;
   WriteLn('El cliente que compro la mayor cantidad de ofertas fue: ',clienteOferta);
   WriteLn('Cantidad clientes que compraron solo ofertas: ', cantCSoloOferta);
end.