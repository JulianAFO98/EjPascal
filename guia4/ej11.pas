program ej11;
type
str15= string[15];

procedure llenarDatos(var a,b,c:Real);
begin
  repeat
     WriteLn('Ingrese a');
     ReadLn(a);
  until a<>0;
  WriteLn('Ingrese b');
  ReadLn(b);
  WriteLn('Ingrese c');
  ReadLn(c);
end;

procedure mostrarOpciones();
begin
  WriteLn('1-Encontrar  el  eje  de  simetría, y  si  presenta  un mínimo  ó  un máximo');
  WriteLn('2-Informar hacia dónde es abierta la parábola');
  WriteLn('3-Calcular  y  mostrar  las  raíces');
  WriteLn('4-Dado un conjunto de valores de x informar su imagen');
  WriteLn('0-salir');
end;

function CalcularEjeSimetria(a,b,c:real):real;
begin
   CalcularEjeSimetria:= -b/(2*a);
end;

function calcularCuadratica(a,b,c,valX:real):real;
begin
  calcularCuadratica:=(a*(Sqr(valX)))+(b*valX)+c;
end;

function MaximoOMinimo(a,b,c:real):str15;
var
 x,xAnt,xPos:real;
begin
   x:=CalcularEjeSimetria(a,b,c);
   xAnt:=calcularCuadratica(a,b,c,x-1);
   xPos:=calcularCuadratica(a,b,c,x+1);
   if(x>xAnt) and (x>xPos) then
     MaximoOMinimo:='Maximo'
   else 
     MaximoOMinimo:='Minimo';  
end;

function haciaDondeAbre(a:real):str15;
begin
  if(a>0)then
    haciaDondeAbre:='Arriba'
  else 
    haciaDondeAbre:='Abajo'; 
end;

procedure calcularRaices(a,b,c:real);
var
 D,x1,x2:real;
begin
  D:= Sqr(b) - (4*a*c);
  if(D<0)then
    WriteLn('No tiene raices reales')
  else 
   begin
     if(D=0) then
       begin
         x1:=CalcularEjeSimetria(a,b,c);
         WriteLn('Las raices son iguales y son:',x1:4:2)
       end
     else 
      begin
        x1:=(-b+Sqrt(D))/(2*a);
        x2:=(-b-Sqrt(D))/(2*a);
        WriteLn('Las raices son:',x1:4:2,' ',x2:4:2);
      end;  
   end;  
end;

procedure calcularImagen(a,b,c:real);
var
 i,N:byte;
 x:real;
begin
  WriteLn('Ingrese cuantos valores quiere ingresar');
  ReadLn(N);
  for i:=1 to N do
     begin
       WriteLn('Ingrese valor de x');
       ReadLn(x);
       WriteLn(calcularCuadratica(a,b,c,x):4:2);
     end;
end;


var 
a,b,c:real;
opc:byte;
begin
  llenarDatos(a,b,c);
  repeat
    mostrarOpciones();
    repeat
      readln(opc);
    until opc in [0..4];
    Case opc of
      1:begin
        WriteLn('El eje de simetria esta en: ',CalcularEjeSimetria(a,b,c):4:2);
        WriteLn('Es un: ',MaximoOMinimo(a,b,c));
      end;
      2:WriteLn('La parabola se abre hacia:',haciaDondeAbre(a));
      3:calcularRaices(a,b,c);
      4:calcularImagen(a,b,c);
    end;  
  until opc = 0;
  WriteLn('Programa finalizado');
end.