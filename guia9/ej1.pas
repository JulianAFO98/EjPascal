program ej1;
type 
str10 = string[10];
str15 = string[15];
tipoPaquete = record 
  codigo:str10;
  peso,MontoAsegurado:real;
  codigoDestino:byte;
end;
tipoDestino = record 
  codigoDestino:byte;
  descripcion:str15;
end;

TipoArchivoPaquete = file of tipoPaquete;
TipoArchivoDestino = file of tipoDestino;

procedure GrabarArchPaquete(var Arch:TipoArchivoPaquete);
var 
paquete:tipoPaquete;
begin
  Rewrite(Arch);
  WriteLn('Ingrese codigo paquete(XXX para finalizar)');
  ReadLn(paquete.codigo);
  while (paquete.codigo <> 'XXX') do 
    begin
      WriteLn('Ingrese peso paquete');
      ReadLn(paquete.peso);
      WriteLn('Ingrese monto asegurado del paquete');
      ReadLn(paquete.MontoAsegurado);
      WriteLn('Ingrese codigo destino del paquete');
      ReadLn(paquete.codigoDestino);
      Write(arch,paquete);
      WriteLn('Ingrese codigo paquete(XXX para finalizar)');
      ReadLn(paquete.codigo);
    end;
  close(Arch);  
end;

procedure ListarArchPaquete(var Arch:TipoArchivoPaquete);
var 
paquete:tipoPaquete;
begin
  reset(Arch);
  while not eof(arch) do 
   begin
     read(Arch,paquete);
     WriteLn('Info Paquete ',paquete.codigo);
     WriteLn('Peso paquete ',paquete.peso);
     WriteLn('monto asegurado paquete ',paquete.MontoAsegurado);
     WriteLn('codigo destino  ',paquete.codigoDestino);
   end;
  Close(arch); 
end;

procedure GrabarArchDestino(var Arch:TipoArchivoDestino);
var 
destino:tipoDestino;
begin
  Rewrite(Arch);
  WriteLn('Ingrese codigo destino(0 para finalizar)');
  ReadLn(destino.codigoDestino);
  while (destino.codigoDestino <> 0) do 
    begin
      WriteLn('Ingrese descripcion paquete');
      ReadLn(destino.descripcion);
      Write(arch,destino);
      WriteLn('Ingrese codigo destino(0 para finalizar)');
      ReadLn(destino.codigoDestino);
    end;
  close(Arch);  
end;

procedure ListarArchDestino(var Arch:TipoArchivoDestino);
var 
destino:tipoDestino;
begin
  reset(Arch);
  while not eof(arch) do 
   begin
     read(Arch,destino);
     WriteLn('Destino numero ',destino.codigoDestino);
     WriteLn('Descripcion destino ',destino.descripcion);
   end;
  Close(arch); 
end;

function calcularPromPeso(var arch:TipoArchivoPaquete):real;
var
 paquete:tipoPaquete; 
begin
  
end;




var 
ArchPaquete:TipoArchivoPaquete;
ArchDestino:TipoArchivoDestino;

begin
  Assign(ArchPaquete,'paquetes.dat');Reset(ArchPaquete);
  Assign(ArchDestino,'destinos.dat');Reset(ArchDestino);
  GrabarArchPaquete(ArchPaquete);
  ListarArchPaquete(ArchPaquete);
  GrabarArchDestino(ArchDestino);
  ListarArchDestino(ArchDestino);
  //a)El peso promedio de los paquetes. 
  WriteLn('Peso promedio paquetes: ',calcularPromPeso(ArchPaquete));
end.