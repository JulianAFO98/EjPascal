{9) A un vendedor le pagan un sueldo básico de $8000 por mes más una comisión del 5% de las ventas;
si superó en ventas un monto X (dato ingresado por teclado) se le agrega un 3%. Por presentismo cobra
$1000 más ó 2% de las ventas, lo que resulte mayor. Si faltó más de 2 días se le descuenta un 7% del
total.
Definir los datos a ingresar. Calcular e informar lo que debe cobrar el vendedor. }
program guia2ej9;
//DATOS => SUELDO BASICO / VENTAS / MONTOX / DIAS
const 
SUELDOBASICO = 8000;
var
ventas,montoSuperar,sueldoTotal:real;
cantDias:byte;

begin
  WriteLn('Ingrese el monto que genero en ventas el empleado');
  ReadLn(ventas);
  WriteLn('Ingrese el monto a superar');
  ReadLn(montoSuperar);
  WriteLn('Cuantos dias falto el empleado?');
  ReadLn(cantDias);
  sueldoTotal:= SUELDOBASICO + ventas*0.05;
  if(ventas>montoSuperar) then
    sueldoTotal:=sueldoTotal+ventas*0.03;
  if(cantDias=0) then
    begin
      if(1000>ventas*0.02) then
        sueldoTotal:=sueldoTotal+1000
      else 
         sueldoTotal:=sueldoTotal+ventas*0.2;
    end
  else 
    begin
      if cantDias>2 then
        sueldoTotal:=sueldoTotal*0.93;
    end;
  
 WriteLn('El sueldo total es:',sueldoTotal:4:2);
end.