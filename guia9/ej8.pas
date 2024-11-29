{La fábrica de Camperas (descripta en el ejercicio 4) debe satisfacer un pedido de un cliente, y cuenta
con la siguiente información:
# ARTICULO (1er. campo de secuencia, clave secundaria)
# TALLE (2do. campo de secuencia)
# COLOR (3er. campo de secuencia)
# CANTIDAD
 ARTICULO + TALLE + COLOR es Clave primaria
 ARTICULO + TALLE es Clave secundaria
Por cada pedido se pide actualizar el stock, en caso de no poder entregar lo posible e informar la cantidad
adeudada. }

program ej8;
type 
str4 = string[4];
str20=string[20];
str6 = string[6];
TRegPrenda = record 
  codigoArti:str4;
  talle:char;
  color:byte;
  cantidadP:word;
  precioCosto:real;
end;

RegSolicitud = record
  codigoArti:str4;
  talle:char;
  color:byte;
  cantidadP:word;
end;

archivoSolicitud = file of RegSolicitud;
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
  read(prendas,prenda);
  while prenda.codigoArti<>'A999' do 
   begin
      WriteLn(prenda.codigoArti,'  ',prenda.talle,'  ',prenda.color,'  ',prenda.cantidadP,'  ',prenda.precioCosto:6:2);
     Read(prendas,prenda);
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

procedure grabarSolicitudes(var solicitudes:archivoSolicitud);
var
 arch:text;
 solicitud:RegSolicitud;
 extra:char; 
begin
  Assign(arch,'solicitudes.txt');
  reset(arch);
  Rewrite(solicitudes);
  while not eof(arch) do 
   begin
     readln(arch,solicitud.codigoArti,extra,solicitud.talle,solicitud.color,solicitud.cantidadP);
     Write(solicitudes,solicitud);
   end;
  Close(solicitudes);
  close(arch); 
end;

procedure mostrarSolicitudes(var solicitudes:archivoSolicitud);
var 
 solicitud:RegSolicitud;
begin
  reset(solicitudes);
  Read(solicitudes,solicitud);
  while solicitud.codigoArti<>'A999' do 
   begin
     WriteLn(solicitud.codigoArti,' ',solicitud.talle,' ',solicitud.color,' ',solicitud.cantidadP);
     Read(solicitudes,solicitud);
   end;
   close(solicitudes);
end; 

procedure ModificarStock(var prendas:archivoPrendas;var solicitudes:archivoSolicitud;nombre:str20);
var 
 Temp:archivoPrendas;
 prenda:TRegPrenda;
 solicitud:RegSolicitud;
 calculoPrenda:integer;
 codigoPrenda,codigoSolicitud:str6;
 color:string[1];
begin
  Assign(Temp,'temp.dat');
  reset(Temp);
  reset(prendas);
  Reset(solicitudes);
  read(prendas,prenda);
  read(solicitudes,solicitud);
  while (not eof(prendas)) or (not eof(solicitudes)) do 
   begin
     Str(prenda.color,color);
     codigoPrenda:=prenda.codigoArti+prenda.talle+color;
     Str(solicitud.color,color);
     codigoSolicitud:=solicitud.codigoArti+solicitud.talle+color;

     if(codigoSolicitud=codigoPrenda) then 
      begin
        calculoPrenda:=prenda.cantidadP-solicitud.cantidadP;
        if(calculoPrenda<0) then 
          begin
            WriteLn('Se deben ',Abs(calculoPrenda),' prendas de ',codigoSolicitud);
            prenda.cantidadP:=0;
          end
        else 
         begin
           prenda.cantidadP:=calculoPrenda;
         end;  
        Write(Temp,prenda); 
        read(solicitudes,solicitud);read(prendas,prenda);
      end
    else 
      begin
        if(codigoSolicitud<codigoPrenda)then 
            Read(solicitudes,solicitud)
        else 
          begin
            Write(Temp,prenda);
            Read(prendas,prenda);  
          end;
      end;  
   end;
   Write(Temp,prenda);
   close(temp);Close(solicitudes);Close(prendas);
   Erase(prendas);
   Rename(Temp,nombre);
end; 



var 
prendas:archivoPrendas;
solicitudes:archivoSolicitud;
nombre:str20;
begin
  Assign(prendas,'prendas.dat');
  GrabarPrendas(prendas);
  mostrarPrendas(prendas);
  //GenerarInforme(prendas);
  Assign(solicitudes,'solicitudes.dat');
  grabarSolicitudes(solicitudes);
  mostrarSolicitudes(solicitudes);
  ModificarStock(prendas,solicitudes,'prendas.dat');
  mostrarPrendas(prendas);
end.