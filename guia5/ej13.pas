{En una estación de peaje hay N cabinas por donde pasan varios vehículos. Desde un archivo se lee 
la siguiente información: 
•  Número de cabina 
• Tipo de vehículo (1=auto, 2=moto, 3=camioneta, 4=camión, 5=colectivo) 
• Hora (0..23) 
Las tarifas son: moto = $150, auto y camioneta = $300, camión = $470, colectivo = $390. 
Si la hora está entre las 10 y las 18 sufre un incremento del 10%. 
Calcular e informar: 
a)  Cuántos vehículos atendió cada una de las N cabinas.  
b)  Cuál fue la que más importe recaudó.}

program ej13;
type 
TVB = array [1..255] of byte;
TVR = array [1..255] of real;

procedure llenarDatos(var VecCantAte:TVB;var VecImporte:TVR;N:byte);
var 
Arch:text;
cabina,tipoV,hora:byte;
costo:real;
begin
  Assign(Arch,'datos.txt');
  reset(Arch);
  while not eof(Arch) do
    begin
      ReadLn(Arch,cabina,tipoV,hora);
      Case tipoV of 
       1,3:costo:=300;
       2:costo:=150;
       4:costo:=470;
       5:costo:=390;
      end;
      if(hora>=10) and (hora<=18) then
        costo:=costo*1.1;
      VecCantAte[cabina]:=VecCantAte[cabina]+1;  
      VecImporte[cabina]:=VecImporte[cabina]+costo;  
    end;
    close(Arch);
end;
procedure inicializarVectores(var VecCantAte:TVB;var VecImporte:TVR;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     VecCantAte[i]:=0;
     VecImporte[i]:=0;
   end;
end;

procedure mostrarVecTVB(vec:TVB;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

procedure mostrarVecTVR(vec:TVR;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i]:4:2,' ');
   end;
   WriteLn();
end;

procedure mostrarDatosOrdenados(VecCantAte:TVB;VecImporte:TVR;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
    begin
      WriteLn('La cabina ',i,' atendio ',VecCantAte[i],' vehiculos y genero un importe de: ',VecImporte[i]:8:2);
    end;
end;


var 
VecCantAte:TVB;
VecImporte:TVR;
N:byte;
begin
  WriteLn('Ingrese la cantidad de cabinas');
  ReadLn(N);
  inicializarVectores(VecCantAte,VecImporte,N);
  llenarDatos(VecCantAte,VecImporte,N);
  mostrarDatosOrdenados(VecCantAte,VecImporte,N);
end.