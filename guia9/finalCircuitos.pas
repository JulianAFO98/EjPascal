Program finalCircuitos;
type 
str3=string[3];
str8=string[8];
str20=string[20];

RegCarrera = record
  codCircuito:str3;
  fecha:str8;
  entradasVendidas:word;
end;

archivoCarreras = file of RegCarrera;

RegCircuito = record 
   codCircuito:str3;
   nombrecodigo:str20;
   capacidadMaximaC:word;
   valorEntrada:real;
end;

archivoCircuitos = file of RegCircuito;

TV = array[1..255] of RegCircuito;

RegFecha = record 
  fecha:str8;
  montoRecaudado:real;
end;  

TVF = array[1..255] of RegFecha;

procedure grabarCarreras(var carreras:archivoCarreras);
var 
arch:text;
carrera:RegCarrera;
extra:char;
begin
  Assign(arch,'carreras.txt');
  reset(arch);
  Rewrite(carreras);
  while not eof(arch) do 
   begin
     ReadLn(arch,carrera.codCircuito,extra,carrera.fecha,carrera.entradasVendidas);
     Write(carreras,carrera);
   end;
   Close(arch);
   close(carreras);
end;

procedure mostrarCarreras(var carreras:archivoCarreras);
var
 carrera:RegCarrera;
begin
  Reset(carreras);
  Read(carreras,carrera);
  while carrera.codCircuito<>'ZZZ' do 
   begin
     Writeln(carrera.codCircuito,' ',carrera.fecha,' ',carrera.entradasVendidas);
     Read(carreras,carrera);
   end;
  Close(carreras); 
end; 

procedure grabarCircuitos(var circuitos:archivoCircuitos);
var 
  arch:text;
  circuito:RegCircuito;
  extra:char;
begin
  Assign(arch, 'circuitos.txt');
  Reset(arch); 
  Rewrite(circuitos); 
  while not eof(arch) do 
  begin
    ReadLn(arch, circuito.codCircuito, extra, circuito.nombrecodigo,circuito.capacidadMaximaC,circuito.valorEntrada);
    Write(circuitos, circuito);
  end;
  Close(arch);
  Close(circuitos);
end;

procedure mostrarCircuitos(var circuitos:archivoCircuitos);
var 
  circuito:RegCircuito;
begin
  Reset(circuitos); 
  while not eof(circuitos) do 
  begin
    Read(circuitos, circuito);
    Writeln(circuito.codCircuito, ' ', circuito.nombrecodigo, ' ',circuito.capacidadMaximaC, ' ', circuito.valorEntrada:6:2);
  end;
  Close(circuitos);
end;

procedure llenarVecCircuitos(var circuitos:archivoCircuitos;var VecCircuitos:TV);
var 
i:byte;
circuito:RegCircuito;
begin
  reset(circuitos);
  i:=1;
  Read(circuitos,circuito);
  while circuito.codCircuito<>'ZZZ' do 
   begin
     VecCircuitos[i]:=circuito;
     i:=i+1;
     Read(circuitos,circuito);
   end;
  Close(circuitos);
end;

function buscarPosCircuito(VecCircuitos:TV;cod:str3):byte;
var 
 i:byte;
begin
  i:=1;
  while VecCircuitos[i].codCircuito<>cod do 
   i:=i+1;
  buscarPosCircuito:=i; 
end; 

function buscarPosFecha(VecFechas:TVF;N:byte;fecha:str8):byte;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (VecFechas[i].fecha<>fecha) do 
   i:=i+1;
  if(i<=N) then 
   buscarPosFecha:=i
  else 
   buscarPosFecha:=0;   
end;

function buscarNombreMaxFecha(VecFechas:TVF;N:byte):str8;
var
 fechaMax:str8;
 valorFechaMax:real;
 i:byte;
begin
  valorFechaMax:=VecFechas[1].montoRecaudado;
  fechaMax:=VecFechas[1].fecha;
  for i:=2 to N do 
   begin
     if(VecFechas[i].montoRecaudado>valorFechaMax)then 
      begin
        valorFechaMax:=VecFechas[i].montoRecaudado;
        fechaMax:=VecFechas[i].fecha;
      end;
   end;
  buscarNombreMaxFecha:=fechaMax; 
end;

procedure corteDeControl(VecCircuitos:TV;var carreras:archivoCarreras);
var 
cantEntradasCodigo,cantEntradasTotales:word;
importeTotal:real;
cantCiudades,i,j,N:byte;
codigoActual:str3;
carrera:RegCarrera;
VecFechas:TVF;
begin
  Reset(carreras);
  importeTotal:=0;
  cantCiudades:=0;
  cantEntradasTotales:=0;
  N:=0;
  Read(carreras,carrera);
  while not eof(carreras) do 
   begin
     cantEntradasCodigo:=0;
     cantCiudades:=cantCiudades+1;
     codigoActual:=carrera.codCircuito;
     i:=buscarPosCircuito(VecCircuitos,carrera.codCircuito);
     WriteLn('Nombre ciudad:',VecCircuitos[i].nombrecodigo);
     WriteLn('Fecha carrera      entradas vendidas  % ocupacion');
     while codigoActual=carrera.codCircuito do 
      begin
        WriteLn(carrera.fecha,' ',carrera.entradasVendidas,' ',(carrera.entradasVendidas/VecCircuitos[i].capacidadMaximaC)*100:6:2,'%');
        cantEntradasCodigo:=cantEntradasCodigo+carrera.entradasVendidas;
        j:=buscarPosFecha(VecFechas,N,carrera.fecha);
        if(j=0) then 
         begin
           N:=N+1;
           VecFechas[N].fecha:=carrera.fecha;
           VecFechas[N].montoRecaudado:=carrera.entradasVendidas*VecCircuitos[i].valorEntrada;
         end
        else 
           VecFechas[j].montoRecaudado:=VecFechas[j].montoRecaudado+carrera.entradasVendidas*VecCircuitos[i].valorEntrada;
        Read(carreras,carrera);   
      end;
      importeTotal:=importeTotal+cantEntradasCodigo*VecCircuitos[i].valorEntrada;
      cantEntradasTotales:=cantEntradasTotales+cantEntradasCodigo;
      WriteLn('Total entradas vendidas por ciudad:',cantEntradasCodigo);
   end;
  WriteLn('Importe total recaudado por entradas:',importeTotal:8:2);
  WriteLn('Promedio entradas por ciudad:',cantEntradasTotales/cantCiudades:6:2); 
  WriteLn('Fecha de mayor recaudacion:',buscarNombreMaxFecha(VecFechas,N));
end;


var
 circuitos:archivoCircuitos;
 carreras:archivoCarreras; 
 VecCircuitos:TV; 
begin
  Assign(carreras,'carreras.dat');
  grabarCarreras(carreras);
  //mostrarCarreras(carreras);
  Assign(circuitos,'circuitos.dat');
  grabarCircuitos(circuitos);
  //mostrarCircuitos(circuitos);

  llenarVecCircuitos(circuitos,VecCircuitos);

  corteDeControl(VecCircuitos,carreras);
end.