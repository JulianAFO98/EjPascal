{ Un Banco registra en TARJETAS.DAT el movimiento de las tarjetas de crédito de sus usuarios.
# NUMERO de TARJETA (1er campo de secuencia, clave primaria)
# NOMBRE del PROPIETARIO
# TOPE
# GASTO del MES (hasta el momento)
Además, se van ingresando (desde teclado ó archivo de texto) las compras con los siguientes datos:
- Número de Tarjeta (puede repetirse)
- Monto
- Código de operación
Procesar los datos, actualizando los gastos del mes, siempre que no supere el monto tope, en caso
contrario, rechazarlo y grabar en un archivo RECHAZADOS.DAT con la siguiente información:
# NUMERO de TARJETA
# CODIGO DE OPERACION
# MONTO
Sugerencia: para obtener la dirección relativa y acceder en forma directa al archivo TARJETAS, descargar
del mismo los números de tarjeta sobre un arreglo (tabla). }

program ej2;
type
str12 = string[12];
str30 = string[30];
str4 = string[4];

TregTarjeta = record
  numeroTarjeta:str12;
  nombreUsuario:str30;
  tope,gastoMes:real;
end;

TregRechazados = record 
  numeroTarjeta:str12;
  codigoOperacion:str4;
  monto:real;
end;  

TipoArch = file of TregTarjeta;
TipoArchRec = file of TregRechazados;

TV = array [0..255] of str12;

procedure CargarArchivo(var archivo:TipoArch);
var 
arch:text;
tarjeta:TregTarjeta;
extra:char;
begin
  Rewrite(archivo);
  Assign(arch,'tarjetas.txt');reset(arch);
  while not eof(arch) do 
   begin
     Readln(arch,tarjeta.numeroTarjeta,extra,extra,tarjeta.nombreUsuario,tarjeta.tope,tarjeta.gastoMes);
     Write(archivo,tarjeta);
   end;
  Close(arch);
  close(archivo); 
end;


procedure mostrarArchivo(var archivo:TipoArch);
var 
tarjeta:TregTarjeta;
begin
  reset(archivo);
  while not eof(archivo) do 
   begin
      Read(archivo,tarjeta);
      WriteLn(tarjeta.numeroTarjeta,' ',tarjeta.nombreUsuario,' ',tarjeta.tope:6:2,' ',tarjeta.gastoMes:6:2);
   end;
  Close(archivo);
end;

function buscaTabla(numTarje:str12;tabla:TV):byte;
var 
i:byte;
begin
  i:=0;
  while tabla[i]<>numTarje do 
   i:=i+1;
  buscaTabla:=i; 
end;

procedure ActualizarMontos(var tarjetas:TipoArch;var rechazados:TipoArchRec;tabla:TV);
var 
arch:text;
numTarje:str12;
amount:real;
codOperacion:str4;
tarjeta:TregTarjeta;
rechazado:TregRechazados;
extra:char;
begin
  Assign(arch,'transacciones.txt');reset(arch);
  Rewrite(rechazados);
  Reset(tarjetas);
  while not eof(arch) do 
   begin
     ReadLn(arch,numTarje,amount,extra,extra,codOperacion);
     Seek(tarjetas,buscaTabla(numTarje,tabla));
     Read(tarjetas,tarjeta);
     if(tarjeta.gastoMes+amount>tarjeta.tope) then 
       begin
         rechazado.numeroTarjeta:=numTarje;
         rechazado.codigoOperacion:=codOperacion;
         rechazado.monto:=amount;
         Write(rechazados,rechazado);
       end
     else 
       begin
         tarjeta.gastoMes:=tarjeta.gastoMes+amount;
         Seek(tarjetas,buscaTabla(numTarje,tabla));
         Write(tarjetas,tarjeta);
       end;  
   end;
   Close(arch);
   close(rechazados);
   close(tarjetas);
end;




procedure GenerarTabla(var tarjetas:TipoArch;var tabla:TV;var N:byte);
var 
tarjeta:TregTarjeta;
begin
  reset(tarjetas);
  N:=0;
  while not eof(tarjetas) do 
   begin
     read(tarjetas,tarjeta);
     tabla[N]:=tarjeta.numeroTarjeta;
     N:=N+1;
   end;
  close(tarjetas); 
end;

procedure mostrarRechazados(var rechazados:TipoArchRec);
var 
 rechazado:TregRechazados;
begin
  Reset(rechazados);
  while not eof(rechazados) do 
   begin
     Read(rechazados,rechazado);
     WriteLn(rechazado.numeroTarjeta,' ',rechazado.codigoOperacion);
   end;
   close(rechazados);
end;


var
archivo:TipoArch; 
archivo2:TipoArchRec;
Tabla:TV;
N:byte;
begin
  Assign(archivo,'tarjetas.dat');
  Assign(archivo2,'rechazados.dat');
  CargarArchivo(Archivo);
  mostrarArchivo(archivo);
  GenerarTabla(archivo,Tabla,N);
  ActualizarMontos(archivo,archivo2,tabla);
  mostrarRechazados(archivo2);
  mostrarArchivo(archivo);
end.



