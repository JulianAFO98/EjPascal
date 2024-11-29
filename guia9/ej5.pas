{ Dado un archivo ALUMNOS.DAT con las notas de alumnos cuyo diseño de registro es:
# MATRICULA (campo de secuencia, clave primaria)
# NOTA en MATEMÁTICA (0..10)
# NOTA en FISICA I (0..10)
# NOTA en QUIMICA I (0..10)
y un archivo de inscriptos (INSCRIPTOS.DAT) en QUIMICA II y FISICA II cuyo diseño de registro es:
# MATRICULA (campo de secuencia, clave primaria)
# QUIMICA II (1=inscripto, 0=no inscripto)
# FISICA II (1=inscripto, 0=no inscripto)
Obtener un listado con la matrícula de aquellos alumnos inscriptos que no cumplan con los requisitos de
equivalencia exigidos, que son: para FISICA II, tener aprobados MATEMATICA y FISICA I, y para
QUIMICA II, tener aprobado QUIMICA I. (se aprueba con NOTA >=4) 
}


program ej5;

type 
TregAlumno = record 
  matricula:word;
  notaMate,notaFisi1,notaQca1:byte;
end;


archivoAlumnos = file of TregAlumno;

TregIncriptos = record 
  matricula:word;
  Qca2,Fisi:byte;
end;  

archivoInscriptos = file of TregIncriptos;

procedure grabarAlumnos(var alumnos:archivoAlumnos);
var 
arch:text;
alumno,alumnoC:TregAlumno;
begin
  Assign(arch,'alumnos.txt');
  reset(arch);
  Rewrite(alumnos);
  while not eof(arch) do 
   begin
     ReadLn(arch,alumno.matricula,alumno.notaMate,alumno.notaFisi1,alumno.notaQca1);
     Write(alumnos,alumno);
   end;
   with alumnoC do 
    begin
      matricula:=9999;
      notaMate:=255;
      notaFisi1:=255;
      notaQca1:=255;
    end;
   Write(alumnos,alumnoC); 
   Close(arch);
   Close(alumnos);
end;

procedure mostrarAlumnos(var Alumnos:archivoAlumnos);
var
alumno:TregAlumno; 
begin
  reset(alumnos);
  Read(Alumnos,alumno);
  while alumno.matricula<>9999 do
   begin
     WriteLn(alumno.matricula,' ',alumno.notaMate,' ',alumno.notaFisi1,' ',alumno.notaQca1);
     Read(Alumnos,alumno);
   end;
  Close(Alumnos);
end;

procedure grabarInscriptos(var inscriptos:archivoInscriptos);
var
 inscripto,inscriptoC:TregIncriptos; 
 arch:text;
begin
  Assign(arch,'inscriptos.txt');
  reset(arch);
  Rewrite(inscriptos);
  while not eof(arch) do 
   begin
     ReadLn(arch,inscripto.matricula,inscripto.Qca2,inscripto.Fisi);
     Write(inscriptos,inscripto);
   end;
   with inscriptoC do 
    begin
     matricula:=9999;
     Qca2:=255;
     Fisi:=255; 
    end;
   Write(inscriptos,inscriptoC); 
   Close(arch);
   Close(inscriptos);
end;


procedure mostrarInscriptos(var inscriptos:archivoInscriptos);
var 
 inscripto:TregIncriptos;
begin
  reset(inscriptos);
  Read(inscriptos,inscripto);
  while inscripto.matricula<>9999 do 
   begin
     WriteLn(inscripto.matricula,' ',inscripto.Qca2,' ',inscripto.Fisi);
     Read(inscriptos,inscripto);
   end;
  close(inscriptos); 
end;

//FINALIZACION DE CARGA DE ARCHIVOS 

//LOGICA DEL PROGRAMA 

procedure enfrentamiento(var alumnos:archivoAlumnos;var inscriptos:archivoInscriptos);
var 
 alumno:TregAlumno;
 inscripto:TregIncriptos;
begin
  Reset(inscriptos);
  Reset(alumnos);
  Read(alumnos,alumno);Read(inscriptos,inscripto);
  while (not eof(inscriptos)) or (not eof(alumnos)) do 
    if(alumno.matricula=inscripto.matricula) then 
      begin
        if (inscripto.Qca2 = 1) and (inscripto.Fisi = 1) then 
          begin
             if (alumno.notaMate<4) or (alumno.notaFisi1<4) or (alumno.notaQca1<4) then 
               WriteLn(alumno.matricula);
          end
        else 
         begin
           if(inscripto.Qca2=1) then 
            begin
              if(alumno.notaQca1<4) then 
               WriteLn(alumno.matricula);
            end
          else 
            begin
              if(alumno.notaFisi1<4) or (alumno.notaMate<4) then 
               WriteLn(alumno.matricula);
            end;  
         end; 
        Read(alumnos,alumno); 
      end
    else 
      begin
        if(alumno.matricula<inscripto.matricula) then 
         begin
           Read(alumnos,alumno);
         end
        else 
         begin
           Read(inscriptos,inscripto);
         end; 
      end;  

  Close(alumnos);
  Close(inscriptos);  
end;



var 
alumnos:archivoAlumnos;
inscriptos:archivoInscriptos;
begin
  Assign(alumnos,'alumnos.dat');
  grabarAlumnos(Alumnos);
  {mostrarAlumnos(Alumnos);}
  Assign(inscriptos,'inscriptos.dat');
  grabarInscriptos(inscriptos);
  {mostrarInscriptos(inscriptos);}
  enfrentamiento(alumnos,inscriptos);
end.