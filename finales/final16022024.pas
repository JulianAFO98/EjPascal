program final16022024;
const 
MaxPozos = 10;
type
str30=string[30];
str8=string[8];
str3=string[3];

regEmpleado = record 
 legajo:word;
 nombre:str30;
 sueldo:real;
end;

archivoEmpleados = file  of regEmpleado;

regHoraTrabajo = record 
  legajo,cantHoras:word;
  fecha:str8;
  codPozo:str3;
end;


archivoHorasTrabajo = file of regHoraTrabajo;

regPozoPetrolero = record 
 codPozo:str3;
 descripcion:str30;
 valorHora:real;
end;

archivoPozos= file of regPozoPetrolero;

TVP = array [1..10] of regPozoPetrolero;

regDatosQuincena = record 
 cantHoras:word;
 monto:real;
end;

TVQ = array [1..10] of regDatosQuincena;


procedure grabarEmpleados(var empleados:archivoEmpleados);
var 
empleado:regEmpleado;
arch:text;
extra:char;
begin
  Assign(arch,'empleados.txt');
  Reset(arch);
  Rewrite(empleados);
  while not eof(arch) do 
   begin
     ReadLn(arch,empleado.legajo,extra,empleado.nombre);
     empleado.sueldo:=0;
     Write(empleados,empleado);
   end;
  Close(arch);
  Close(empleados); 
end;

procedure mostrarEmpleados(var empleados:archivoEmpleados);
var
 empleado:regEmpleado; 
begin
  reset(empleados);
  Read(empleados,empleado);
  while empleado.legajo<>60000 do 
   begin
     WriteLn(empleado.legajo,' ',empleado.nombre,' ',empleado.sueldo:8:2);
     Read(empleados,empleado);
   end;
  Close(empleados); 
end;

procedure grabarHorasTrabajo(var horasTrabajadas:archivoHorasTrabajo);
var
  horaTrabajo: regHoraTrabajo;
  arch: text;
  extra:char;
begin
  Assign(arch, 'horas-trabajo.txt');
  Reset(arch);
  Rewrite(horasTrabajadas);
  while not eof(arch) do
  begin
    ReadLn(arch, horaTrabajo.legajo,extra,horaTrabajo.fecha,horaTrabajo.cantHoras,extra,horaTrabajo.codPozo);
    Write(horasTrabajadas, horaTrabajo);
  end;
  Close(arch);
  Close(horasTrabajadas);
end;

procedure mostrarHorasTrabajo(var horasTrabajadas:archivoHorasTrabajo);
var
  horaTrabajo: regHoraTrabajo;
begin
  Reset(horasTrabajadas);
  Read(horasTrabajadas,horaTrabajo);
  while horaTrabajo.legajo<>60000 do
  begin
    WriteLn('Legajo: ', horaTrabajo.legajo, 
            ', Horas: ', horaTrabajo.cantHoras, 
            ', Fecha: ', horaTrabajo.fecha, 
            ', Pozo: ', horaTrabajo.codPozo);
    Read(horasTrabajadas, horaTrabajo);        
  end;
  Close(horasTrabajadas);
end;


procedure grabarPozos(var pozos:archivoPozos);
var
  pozo: regPozoPetrolero;
  arch: text;
  extra: char;
begin
  Assign(arch, 'pozo-petrolero.txt');
  Reset(arch);
  Rewrite(pozos);
  while not eof(arch) do
  begin
    ReadLn(arch, pozo.codPozo, extra, pozo.descripcion, pozo.valorHora);
    Write(pozos, pozo);
  end;
  Close(arch);
  Close(pozos);
end;

procedure mostrarPozos(var pozos:archivoPozos);
var
  pozo: regPozoPetrolero;
begin
  Reset(pozos);
 
  while not eof(pozos) do
  begin
    Read(pozos, pozo);
    WriteLn('Codigo Pozo: ', pozo.codPozo,
            ', Valor Hora: ', pozo.valorHora:0:2,
            ', Descripcion: ', pozo.descripcion);
  end;
  Close(pozos);
end;

procedure generarVecPozos(var Pozos:archivoPozos;var vecPozos:TVP);
var 
 i:byte;
begin
  i:=1;
  Reset(Pozos);
  while not eof(Pozos) do 
   begin
     Read(Pozos,vecPozos[i]);
     i:=i+1;
   end;
  close(Pozos); 
end;

procedure InicializarVecQuincena(var VecQuincena:TVQ);
var 
i:byte;
begin
  for i:=1 to MaxPozos do 
   begin
     VecQuincena[i].cantHoras:=0;
     VecQuincena[i].monto:=0;
   end;

end;

function buscarPosPozo(vecPozos:TVP;cod:str3):byte;
var 
i:byte;
begin
  i:=1;
  while (vecPozos[i].codPozo<>cod) do 
   i:=i+1;
  buscarPosPozo:=i; 
end;

procedure Enfrentamiento(var empleados:archivoEmpleados;var horasTrabajadas:archivoHorasTrabajo;vecPozos:TVP;var VecQuincena:TVQ;nombre:str30);
var 
empleado:regEmpleado;
horaTrabajada:regHoraTrabajo;
cantNoTrabajaron,cantErroneos:word;
temp:archivoEmpleados;
dia:string[2];
i:byte;
begin
  Assign(temp,'temp.dat');
  Reset(empleados);
  Reset(horasTrabajadas);
  Rewrite(temp);
  cantNoTrabajaron:=0;
  cantErroneos:=0;
  Read(empleados,empleado);Read(horasTrabajadas,horaTrabajada);
  while (not eof(empleados)) or (not eof(horasTrabajadas)) do 
   if empleado.legajo=horaTrabajada.legajo then
     begin
        while empleado.legajo=horaTrabajada.legajo do 
         begin
           i:=buscarPosPozo(vecPozos,horaTrabajada.codPozo);
           empleado.sueldo:=empleado.sueldo+(horaTrabajada.cantHoras*vecPozos[i].valorHora);
           dia:=Copy(horaTrabajada.fecha,7,2);
           if(dia<='15')then 
            begin
              VecQuincena[i].cantHoras:=VecQuincena[i].cantHoras+horaTrabajada.cantHoras;
              VecQuincena[i].monto:=VecQuincena[i].monto+horaTrabajada.cantHoras*vecPozos[i].valorHora;
            end;
            Read(horasTrabajadas,horaTrabajada);
         end; 
        Write(temp,empleado); 
        Read(empleados,empleado); 
     end
   else
    begin
      if (empleado.legajo<horaTrabajada.legajo) then 
       begin
         Write(temp,empleado);
         cantNoTrabajaron:=cantNoTrabajaron+1;
         Read(empleados,empleado);
       end
      else 
       begin
         WriteLn('Se produjo un error');
         cantErroneos:=cantErroneos+1;
         Read(horasTrabajadas,horaTrabajada);
       end; 
    end; 
  WriteLn('Cantidad no trabajaron:',cantNoTrabajaron);
  WriteLn('Cantidad de errores:',cantErroneos);  
  Write(temp,empleado);
  Close(empleados);
  Close(horasTrabajadas);
  Close(temp);
  Erase(empleados);
  Rename(temp,nombre);
end;


var 
empleados:archivoEmpleados;
horasTrabajadas:archivoHorasTrabajo;
Pozos:archivoPozos;
vecPozos:TVP;
VecQuincena:TVQ;
begin
  Assign(empleados,'empleados.dat');
  grabarEmpleados(empleados);
  mostrarEmpleados(empleados);
  Assign(horasTrabajadas,'horas-trabajo.dat');
  grabarHorasTrabajo(horasTrabajadas);
  //mostrarHorasTrabajo(horasTrabajadas);
  Assign(Pozos,'pozo-petrolero.dat');
  grabarPozos(Pozos);
  //mostrarPozos(Pozos);
  generarVecPozos(Pozos,vecPozos);
  InicializarVecQuincena(VecQuincena);
  Enfrentamiento(empleados,horasTrabajadas,vecPozos,VecQuincena,'empleados.dat');
  mostrarEmpleados(empleados);
end.