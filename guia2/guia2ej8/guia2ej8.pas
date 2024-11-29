{Un club cobra a sus socios una cuota básica por mes que incluye dos deportes, su costo depende de
la edad del socio:
 Si es mayor de 18: $1800
 Si está entre 13 y 18: $1200
 Si tiene entre 5 y 12 años: $750
 En otro caso no paga

Además, se cobra $250 por cada deporte adicional que realiza, excepto pileta escuela que cuesta $800. Si
la cuota se abona después del día 15 tiene un recargo del 5%.
Determinar los datos a ingresar, para calcular e informar cuánto paga un socio}
program guia2ej8;
var
precio:real;
cantDeportes,edad,diaPago:byte;
Resp:char;

begin
  writeln('Ingrese la edad del socio');
  ReadLn(edad);
  WriteLn('Ingrese cuantos deportes realiza el socio');
  ReadLn(cantDeportes);
  WriteLn('Cuando pago el socio');
  ReadLn(diaPago);

  //LOGICA 

  if(edad>18)then
    precio:=1800
  else 
      if(edad>=13) then
        precio:=1200
      else 
        if(edad>=5) then
          precio:=750
        else 
          precio:=0; 
  
  if(cantDeportes>2)then
    begin
      WriteLn('Alguno de esos deportes es pileta?(S/N)');
      ReadLn(Resp);
      if(Resp = 'S') then
        begin
          precio:=precio+800;
          cantDeportes:=cantDeportes-1;
        end;
       precio:=precio+(250*(cantDeportes-2));
    end;
   if(diaPago>15) then
     precio:=precio*1.05;

   WriteLn('El precio a pagar es:',precio:4:2);   
end.