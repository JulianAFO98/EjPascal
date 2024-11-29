Program finalCarreras;

type 
str20 = string[20];
str5 = string[5];
RegCarrera = record 
 escuderia:str5;
 nombrePiloto:str20;
 tiempo:word;
end; 

archivoCarreras = file of RegCarrera;

RegHistorico = record 
  escuderia:str5;
  cantVictorias:word;
  mejorTiempoProm:real;
end;  

archivoHistorico = file of RegHistorico;


procedure grabarCarreras(var Carreras:archivoCarreras);
var
carrera:RegCarrera;
arch:text; 
extra:char;
begin
  Assign(arch,'carreras.txt');
  Reset(arch);
  Rewrite(Carreras);
  while not eof(arch) do 
   begin
     ReadLn(arch,carrera.escuderia,extra,carrera.nombrePiloto,carrera.tiempo);
     Write(Carreras,carrera);
   end;
  Close(arch);
  Close(Carreras); 
end;

procedure mostrarCarreras(var carreras:archivoCarreras);
var 
carrera:RegCarrera;
begin
  reset(carreras);
  read(carreras,carrera);
  while carrera.escuderia<>'ZZZZZ' do 
   begin
     WriteLn(carrera.escuderia,' ',carrera.nombrePiloto,' ',carrera.tiempo);
     Read(carreras,carrera);
   end;
  Close(carreras); 
end;


procedure grabarHistoricos(var Historicos:archivoHistorico);
var
  arch: text;
  historico: RegHistorico;
begin
  Assign(arch, 'historicos.txt'); 
  Reset(arch);                 
  Rewrite(Historicos);         
  while not eof(arch) do       
  begin
    ReadLn(arch, historico.escuderia, historico.cantVictorias, historico.mejorTiempoProm);
    Write(Historicos, historico); 
  end;
  Close(arch);                   
  Close(Historicos);            
end;

procedure mostrarHistoricos(var Historicos:archivoHistorico);
var
  historico: RegHistorico;
begin
  Reset(Historicos); 
  Read(Historicos,historico);
  while historico.escuderia<>'ZZZZZ' do 
  begin
    WriteLn(historico.escuderia, ' ', historico.cantVictorias, ' ', historico.mejorTiempoProm:6:2);
    Read(Historicos, historico);
  end;
  Close(Historicos); 
end;

procedure Enfrentamiento(var carreras:archivoCarreras;var Historicos:archivoHistorico;nombre:str20);
var
carrera:RegCarrera;
historico,historicoAux:RegHistorico;
temp:archivoHistorico;
acumTiempo,mejorTiempo:real;
contCarreras:word;
nombreMejorTiempo:str20;
begin
  Assign(temp,'temp.dat');
  Reset(Historicos);
  Reset(carreras);
  Rewrite(temp);
  Read(carreras,carrera);read(Historicos,historico);
  mejorTiempo:=99999;
  while (not eof(carreras)) or (not eof(Historicos)) do
   if(carrera.escuderia=historico.escuderia) then 
     begin
       acumTiempo:=0;
       contCarreras:=0;
       while carrera.escuderia=historico.escuderia do 
        begin
          acumTiempo:=acumTiempo+carrera.tiempo;
          contCarreras:=contCarreras+1;
          if(carrera.tiempo<mejorTiempo)then 
           begin
             mejorTiempo:=carrera.tiempo;
             nombreMejorTiempo:=carrera.nombrePiloto;
           end; 
          Read(carreras,carrera);
        end;
        historico.cantVictorias:=historico.cantVictorias+contCarreras;
        if(acumTiempo/contCarreras<historico.mejorTiempoProm)then 
          historico.mejorTiempoProm:=acumTiempo/contCarreras; 
        Write(temp,historico);
        Read(Historicos,historico);  
     end
   else 
      if(carrera.escuderia>historico.escuderia)then 
        begin
         Write(temp,historico);
         WriteLn(historico.escuderia);
         Read(Historicos,historico);
        end
      else 
       begin
        historicoAux.escuderia:=carrera.escuderia;
        acumTiempo:=0;
        contCarreras:=0;
        while carrera.escuderia=historicoAux.escuderia do 
         begin
          acumTiempo:=acumTiempo+carrera.tiempo;
          contCarreras:=contCarreras+1;
          if(carrera.tiempo<mejorTiempo)then 
           begin
             mejorTiempo:=carrera.tiempo;
             nombreMejorTiempo:=carrera.nombrePiloto;
           end; 
          Read(carreras,carrera);
         end;
        historicoAux.cantVictorias:=contCarreras;
        historicoAux.mejorTiempoProm:=acumTiempo/contCarreras; 
        Write(temp,historicoAux); 
       end; 
    WriteLn('Nombre Piloto con mejor tiempo:', nombreMejorTiempo);    
    Write(temp,historico);
    Close(carreras);
    Close(Historicos);
    Close(temp);
    Erase(Historicos);
    Rename(temp,nombre);
end;

var 
Carreras:archivoCarreras;
Historicos:archivoHistorico;
begin
  Assign(Carreras,'carreras.dat');
  grabarCarreras(Carreras);
  //mostrarCarreras(Carreras);
  Assign(Historicos,'historicos.dat');
  grabarHistoricos(Historicos);
  //mostrarHistoricos(Historicos);
  Enfrentamiento(Carreras,Historicos,'historicos.dat');
  mostrarHistoricos(Historicos);
end.