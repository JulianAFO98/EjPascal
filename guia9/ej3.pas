{ Una empresa de turismo ofrece a sus clientes distintas excursiones a los distintos puntos de interés
de la ciudad (paseo a las Sierras, a la Laguna, City Tour, viaje en barco, etc.):
# CODIGO de EXCURSIÓN (cadena de 3, no hay más de 50)
# DESCRIPCION (cadena de 15)
# PRECIO BASE
# PRECIO de la COMIDA
Por otro lado se tiene un archivo BOLETERIA.DAT con el registro de los boletos vendidos con los
siguientes datos:
# CODIGO de EXCURSION (cadena de 3, campo de secuencia, clave secundaria)
# NRO de BOLETO
# INCLUYE COMIDA (S/N)
Se desea realizar el siguiente listado:
Excursión Cantidad de Boletos Cantidad de Comida Monto Total
xxxxxxxxxxxx 99 99 $9999.99
. . . . . . . . . . . .
% de turistas que contrataron excursión con comida: 99.99% }
program ej3;
type 
str3=string[3];
str15=string[15];
TregExcur = record 
  codigoExcu:str3;
  descrip:str15;
  precioBase,precioComida:real;
end;  
TrBoleto = record 
 codigoExcu:str3;
 numBoleto:word;
 incluye:char;
end;

TV = array [0..255] of str3;

ArchivoBoletos = file of TrBoleto;
archivoExcursiones = file of TregExcur;


procedure GrabarExcursiones(var Excursiones:archivoExcursiones);
var
 arch:text;
 excursion,centinela:TregExcur; 
 extra:char;
begin
   Assign(arch,'excursiones.txt');Reset(arch);
   Rewrite(Excursiones);
   while not eof(arch) do 
    begin
      ReadLn(arch,excursion.codigoExcu,extra,excursion.descrip,excursion.precioBase,excursion.precioComida);
      Write(Excursiones,excursion);
    end; 
   Close(Arch);
   Close(Excursiones); 
end;

procedure MostrarExcursiones(var Excursiones:archivoExcursiones);
var 
 excursion:TregExcur;
begin
  Reset(Excursiones);
  while not eof(Excursiones) do
    begin
      Read(Excursiones,excursion);
      WriteLn(excursion.codigoExcu,' ',excursion.descrip,' ',excursion.precioBase:6:2,' ',excursion.precioComida:6:2);
    end;
  close(Excursiones); 
end;

procedure GrabarBoleteria(var Boleteria:ArchivoBoletos);
var 
arch:text;
boleto:TrBoleto;
extra:char;
begin
  Assign(arch,'boleteria.txt');Reset(arch);
  Rewrite(Boleteria);
  while not eof(arch) do 
   begin
     readln(arch,boleto.codigoExcu,boleto.numBoleto,extra,boleto.incluye);
     Write(Boleteria,boleto);
   end;
  Close(arch);
  Close(Boleteria); 
end;

procedure mostrarBoleteria(var Boleteria:ArchivoBoletos);
var 
 boleto:TrBoleto;
begin
  Reset(Boleteria);
  while not eof(Boleteria) do 
   begin
     Read(Boleteria,boleto);
     WriteLn(boleto.codigoExcu,' ',boleto.numBoleto,' ',boleto.incluye);
   end;
  Close(Boleteria); 
end;

procedure CargaTabla(var Excursiones:archivoExcursiones;var tabla:TV);
var 
i:byte;
excursion:TregExcur;
begin
  i:=0;
  Reset(Excursiones);
  while not eof(Excursiones) do 
   begin
     Read(excursiones,excursion);
     tabla[i]:=excursion.codigoExcu;
     i:=i+1;
   end;
  Close(Excursiones); 
end;

// LOGICA FUNCIONAL 

function buscarTabla(cod:str3;tabla:TV):byte;
var 
i:byte;
begin
  i:=0;
  while cod<>tabla[i] do 
  begin
    i:=i+1;
  end;

  buscarTabla:=i; 
end;

procedure GenerarInforme(var Excursiones:archivoExcursiones;var Boleteria:ArchivoBoletos;tabla:TV);
var 
 cantBoletos,cantComida:byte;
 montoTotal:real;
 boleto:TrBoleto;
 codigoActual:str3;
 excursion:TregExcur;
begin
  Reset(Excursiones);
  Reset(Boleteria);
  WriteLn('Excursion // Cantidad de Boletos // Cantidad de Comida // Monto Total');
  read(Boleteria,boleto);
  while not eof(Boleteria) do 
   begin
     cantBoletos:=0;
     cantComida:=0;
     CodigoActual:=boleto.codigoExcu;
     while (codigoActual = boleto.codigoExcu) do 
      begin
        cantBoletos:=cantBoletos+1;
        if(boleto.incluye='S') then 
          cantComida:=cantComida+1;
        Read(Boleteria,boleto);  
      end;
      Seek(Excursiones,buscarTabla(codigoActual,tabla));
      read(Excursiones,excursion);
      montoTotal:=(excursion.precioBase*cantBoletos)+(excursion.precioComida*cantComida);
      Writeln(excursion.descrip,'         ',cantBoletos,'                   ',cantComida,'                ',montoTotal:8:2);
   end;
  Close(Excursiones);
  Close(Boleteria); 
end;





var 
 Excursiones : archivoExcursiones;
 Boleteria:ArchivoBoletos;
 tabla:TV;
begin
  Assign(Excursiones,'excursiones.dat');
  GrabarExcursiones(Excursiones);
  MostrarExcursiones(Excursiones);
  CargaTabla(Excursiones,tabla);
  Assign(Boleteria,'boleteria.dat');
  GrabarBoleteria(Boleteria);
  MostrarBoleteria(Boleteria);
  GenerarInforme(Excursiones,Boleteria,tabla);
end.