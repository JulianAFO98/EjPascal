{Una empresa paga a fin de mes a sus empleados una comisión del 0.5% sobre las ventas
efectuadas, para ello almacena el acumulado mensual de ventas en un archivo cuyo diseño de registro es:
# LEGAJO (campo de secuencia, clave primaria)
# NOMBRE y APELLIDO
# TOTAL de VENTAS
# NRO de FACTURA de MAYOR VENTA del MES
# IMPORTE de MAYOR VENTA del MES
Al final del día actualiza los registros de ese archivo con las ventas efectuadas almacenadas en otro
archivo cuyo diseño de registro es:
# LEGAJO (campo de secuencia, clave secundaria)
# NRO de FACTURA
# IMPORTE
Se pide actualizar el primer archivo y listar las comisiones que le corresponden hasta el momento a cada
empleado.}

program ej6;
type
str30 = string[30];
str13=string[13];
RegVentasMes = record 
  legajo,numFactu: word;
  nombreApellido:str30;
  totalVentas,mayorVenta:real;
end;

archivoVentas = file of regVentasMes;

RegVentasDia = record 
  legajo,numFactu:word;
  importe:real;
end;  

archivoVentasDia = file of RegVentasDia;

procedure grabarVentasMensuales(var VentasMensuales:archivoVentas);
var
 arch:text;
 ventas,ventasC:RegVentasMes;
 extra:char;
begin
  Rewrite(VentasMensuales);
  Assign(arch,'ventasMes.txt');
  Reset(arch);
  while not eof(arch) do 
   begin
     ReadLn(arch,ventas.legajo,extra,ventas.nombreApellido,ventas.totalVentas,ventas.numFactu,ventas.mayorVenta);
     Write(VentasMensuales,ventas);
   end;
  with ventasC do 
   begin
     legajo:=9999;
     nombreApellido:='';
     totalVentas:=0;
     numFactu:=0;
     mayorVenta:=0;
   end;
   Write(VentasMensuales,ventasC);
   Close(arch);
   Close(VentasMensuales);
end;

procedure mostrarVentasMensuales(var VentasMensuales:archivoVentas);
var 
venta:RegVentasMes;
begin
  reset(VentasMensuales);
  Read(VentasMensuales,venta);
  while venta.legajo<>9999 do 
   begin
     Writeln(venta.legajo,' ',venta.nombreApellido,' ',venta.totalVentas:8:2,' ',venta.numFactu,' ',venta.mayorVenta:8:2);
     read(VentasMensuales,venta);
   end;
   close(VentasMensuales);
end;

procedure grabarVentasDia(var VentasDiarias: archivoVentasDia);
var
  arch: text;
  ventas, ventasC: RegVentasDia;
begin
  Rewrite(VentasDiarias);
  Assign(arch, 'ventasDia.txt');
  Reset(arch);
  while not eof(arch) do 
  begin
    ReadLn(arch, ventas.legajo,ventas.numFactu,ventas.importe);
    Write(VentasDiarias, ventas);
  end;
  
  with ventasC do
  begin
    legajo := 9999;
    numFactu := 0;
    importe := 0.0;
  end;
  Write(VentasDiarias, ventasC);
  
  Close(arch);
  Close(VentasDiarias);
end;

procedure mostrarVentasDia(var VentasDelDia:archivoVentasDia);
var 
venta:RegVentasDia;
begin
  reset(VentasDelDia);
  Read(VentasDelDia,venta);
  while venta.legajo<>9999 do 
   begin
     Writeln(venta.legajo,' ',venta.numFactu,' ',venta.importe:8:2);
     read(VentasDelDia,venta);
   end;
   close(VentasDelDia);
end;

procedure ActualizarVentasMes(var VentasMensuales:archivoVentas;var ventasDia:archivoVentasDia;nombre:str13);
var 
ventaDia:RegVentasDia;
ventaMes:RegVentasMes;
legajoActual:word;
Temp:archivoVentas;
begin
  Assign(temp,'temp.dat');
  Rewrite(temp);
  reset(VentasMensuales);
  Reset(ventasDia);
  read(VentasMensuales,ventaMes);
  read(ventasDia,ventaDia);
  while (not eof(ventasDia)) or (not eof(VentasMensuales)) do 
     if(ventaMes.legajo=ventaDia.legajo) then 
      begin
        legajoActual:=ventaMes.legajo;
        while legajoActual=ventaDia.legajo do 
        begin
              ventaMes.totalVentas:=ventaMes.totalVentas+ventaDia.importe;
              if(ventaMes.mayorVenta<ventaDia.importe) then 
               begin
                  ventaMes.numFactu:=ventaDia.numFactu;
                  ventaMes.mayorVenta:=ventaDia.importe;
               end;
              Read(ventasDia,ventaDia);  
        end; 
        Write(temp,ventaMes);
      end
    else 
     if(ventaDia.legajo<ventaMes.legajo)then 
      begin
        Read(ventasDia,ventaDia);
      end
     else 
      begin
        Read(VentasMensuales,ventaMes);
      end;  
   write(Temp,ventaMes);   
   Close(ventasDia); Close(VentasMensuales);close(Temp);
   Erase(VentasMensuales);
   Rename(Temp,nombre);
end;



var 
VentasMensuales:archivoVentas;
VentasDelDia:archivoVentasDia;
begin
  Assign(VentasMensuales,'ventasMes.dat');
  grabarVentasMensuales(VentasMensuales);
  //mostrarVentasMensuales(VentasMensuales);
  Assign(VentasDelDia,'ventasDia.dat');
  grabarVentasDia(VentasDelDia);
  //mostrarVentasDia(VentasDelDia);
  ActualizarVentasMes(VentasMensuales,VentasDelDia,'ventasMes.dat');
  mostrarVentasMensuales(VentasMensuales);
end.