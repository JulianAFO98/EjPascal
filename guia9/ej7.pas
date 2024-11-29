{) Una cadena de cines tiene grabados en un archivo binario los siguientes datos de sus salas:
# CODIGO de CINE (cadena de 4, campo de secuencia clave primaria)
# ZONA (1..10) (puede haber más de un cine en la misma zona)
# CAPACIDAD
Además registra en otro archivo binario la venta de localidades de las películas que proyecta:
# CODIGO de CINE (cadena de 4, campo de secuencia, clave secundaria)
# CODIGO de PELICULA (cadena de 3, campo de secuencia, puede repetirse en este u otro cine)
# LOCALIDADES VENDIDAS
Se cuenta, además, con un archivo de texto que contiene los códigos de película, títulos y la duración (en
minutos) de cada película (40 como máximo); una película por línea.
Se pide generar el siguiente listado:
Cine Cant.Películas(1) Cant. funciones Total Loc.Vendidas %Ocup.Promedio // DONE
xxxx 999 999 999 99.99%
. . . . . . . . . . . . . . .
Cantidad de cines que no proyectaron ninguna película: 999 // DONE
Película con menor promedio de localidades vendidas por función: xxx(99 min.)
Total de localidades vendidas por zona
Zona 1 999
. . .
(1) Cantidad de películas diferentes. Una película se puede proyectar en varias
funciones en el mismo cine 
}

Program ej7;
const 
CantZonas = 10;

Type 
str4 = string[4];
str3 = string[3];
str20 = string[20];
RegCine = record 
   codigoCine:str4;
   zona:byte;
   capacidad:word;
end;

archivoCines = file of RegCine;

RegLocalidad = record 
  codigoCine:str4;
  codPeli:str3;
  locVendidas:word;
end;

archivoLocalidades = file of RegLocalidad;

RegPelicula = record 
  codPeli:str3;
  titulo:str20;
  duracion,cantFunciones,localVendidas:word;
end;



TV = array [1..10] of word;
TVR = array [1..40] of RegPelicula;

procedure grabarCines(var Cines:archivoCines);
var 
cine,cineC:RegCine;
arch:text;
begin
  assign(arch,'cines.txt');
  reset(arch);
  Rewrite(Cines);
  while not eof(arch) do 
   begin
     ReadLn(arch,cine.codigoCine,cine.zona,cine.capacidad);
     write(Cines,cine);
   end;
  with cineC do 
   begin
     codigoCine:='ZZZZ';
     zona:=0;
     capacidad:=0;
   end;
  Write(cines,cineC);
  close(arch);
  Close(Cines);
end;

procedure mostrarCines(var Cines:archivoCines);
var 
cine:RegCine;
begin
  Reset(Cines);
  Read(Cines,cine);
  while cine.codigoCine<>'ZZZZ' do 
   begin
     WriteLn(cine.codigoCine,' ',cine.zona,' ',cine.capacidad);
     Read(Cines,cine);
   end;
  Close(Cines);
end;

procedure grabarLocalidades(var localidades:archivoLocalidades);
var 
localidad,localidadC:RegLocalidad;
arch:text;
extra:char;
begin
  Rewrite(localidades);
  Assign(arch,'localidades.txt');
  Reset(arch);
  while  not eof(arch) do
    begin
       ReadLn(arch,localidad.codigoCine,extra,localidad.codPeli,localidad.locVendidas);
       Write(localidades,localidad);
    end;
  with localidadC do 
   begin
     codigoCine:='ZZZZ';
     codPeli:='ZZZ';
     locVendidas:=0;
   end;
  Write(localidades,localidadC); 
  Close(arch);
  close(localidades);  
end;

procedure mostrarLocalidades(var localidades:archivoLocalidades);
var
localidad:RegLocalidad;
begin
  reset(localidades);
  Read(localidades,localidad);
  while localidad.codigoCine<>'ZZZZ' do 
   begin
     WriteLn(localidad.codigoCine,' ',localidad.codPeli,' ',localidad.locVendidas);
     Read(localidades,localidad);
   end;
  close(localidades); 
end;


function buscarPosPeli(VecPeliculas:TVR;cod:str3):byte;
var 
i:byte;
begin
  i:=1; 
  while (VecPeliculas[i].codPeli<>cod) do 
   i:=i+1;
  buscarPosPeli:=i;
end;






procedure Enfrentamiento(var localidades:archivoLocalidades;var Cines:archivoCines;var VecZonas:TV;var VecPeliculas:TVR);
var 
localidad:RegLocalidad;
cine:RegCine; 
cantPeliculas,cantFunciones,cantCines,totalLocVendidas:word;
peliculaActual:str3;
i:byte;
begin
  Reset(localidades);
  reset(Cines);
  read(localidades,localidad);read(cines,cine);
  cantCines:=0;
  WriteLn('Cine Cant.Peliculas Cant. funciones Total Loc.Vendidas %Ocup.Promedio');
  while (not eof(localidades)) or (not eof(cines)) do 
    if(localidad.codigoCine=cine.codigoCine) then 
     begin
       cantPeliculas:=1;
       cantFunciones:=0;
       totalLocVendidas:=0;
       peliculaActual:=localidad.codPeli;
       while localidad.codigoCine=cine.codigoCine do 
        begin
          if(peliculaActual<>localidad.codPeli)then
            begin
              peliculaActual:=localidad.codPeli;
              cantPeliculas:=cantPeliculas+1;
            end;
          i:=buscarPosPeli(VecPeliculas,localidad.codPeli);
          VecPeliculas[i].cantFunciones:=VecPeliculas[i].cantFunciones+1;
          VecPeliculas[i].localVendidas:=VecPeliculas[i].localVendidas+localidad.locVendidas;
          VecZonas[cine.zona]:=VecZonas[cine.zona]+localidad.locVendidas;
          cantFunciones:=cantFunciones+1;
          totalLocVendidas:=totalLocVendidas+localidad.locVendidas;
          Read(localidades,localidad);
        end;
       WriteLn(cine.codigoCine,' ',cantPeliculas,' ',cantFunciones,' ',totalLocVendidas,' ',(totalLocVendidas/(cine.capacidad*cantFunciones))*100:6:2,'%'); 
       Read(cines,cine);
     end
    else 
     begin
       if(localidad.codigoCine>cine.codigoCine)then 
        begin
          Read(cines,cine);
          cantCines:=cantCines+1;
        end
       else 
        begin
          read(localidades,localidad);
        end; 
     end; 
  WriteLn('Cantidad de cines que no proyectaron peliculas ',cantCines);   
end;

procedure InicializarVec(var VecZonas:TV);
var 
i:byte;
begin
  for i:=1 to  CantZonas do 
   begin
     VecZonas[i]:=0;
   end;
end;

procedure mostrarVecZona(VecZonas:TV);
var 
i:byte;
begin
  WriteLn('Total de localidades vendidas por zona');
  for i:=1 to CantZonas do 
   begin
     WriteLn('Zona ',i,' ',VecZonas[i]);
   end;
end;

procedure llenarVecPeliculas(var VecPeliculas:TVR;var N:byte);
var 
 arch:text;
 pelicula:RegPelicula;
 extra:char;
begin
  Assign(arch,'peliculas.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     ReadLn(arch,pelicula.codPeli,extra,pelicula.titulo,pelicula.duracion);
     pelicula.cantFunciones:=0;
     pelicula.localVendidas:=0;
     VecPeliculas[N]:=pelicula;
   end;
  close(arch);
end;

function calcularMenorVentaPromedio(VecPeliculas:TVR;N:byte):str20;
var 
i:byte;
menorVentaProm:real;
tituloMenorVenta:str20;
begin
  menorVentaProm:=99999;
  tituloMenorVenta:='ZZZ';
  for i:=1 to N do 
   begin
     if  (VecPeliculas[i].cantFunciones<>0) and ((VecPeliculas[i].localVendidas/VecPeliculas[i].cantFunciones)<menorVentaProm)  then 
      begin
        menorVentaProm:=VecPeliculas[i].localVendidas/VecPeliculas[i].cantFunciones;
        tituloMenorVenta:=VecPeliculas[i].titulo;
      end;
   end;
  calcularMenorVentaPromedio:=tituloMenorVenta;
end;




var 
Localidades:archivoLocalidades;
Cines:archivoCines;
VecZonas:TV;
VecPeliculas:TVR;
N:byte;
begin
  Assign(Cines,'cines.dat');
  grabarCines(Cines);
  //mostrarCines(Cines);
  Assign(Localidades,'localidades.dat');
  grabarLocalidades(Localidades);
  //mostrarLocalidades(Localidades);
  InicializarVec(VecZonas);
  llenarVecPeliculas(VecPeliculas,N);
  Enfrentamiento(Localidades,Cines,VecZonas,VecPeliculas);
  WriteLn('La pelicula con menor venta promedio por funcion fue: ',calcularMenorVentaPromedio(VecPeliculas,N));
  mostrarVecZona(VecZonas);
end.