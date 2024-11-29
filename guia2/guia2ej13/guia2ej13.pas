{) Dada una cantidad X de pesos y un tipo de moneda extranjera, ambos ingresados por teclado, se
desea determinar e informar cuánto se puede comprar dada la siguiente tabla de cotizaciones: }
program guia2ej13;
const
DOLAR = 120.80;
EURO = 150.10;
REEAL = 26.50;
var
cantPesos:real;
tipoMoneda:char;
begin
WriteLn('Ingrese la cantidad X de pesos:');ReadLn(cantPesos);
WriteLn('Ingrese a que quiere convertirlos(D/E/R)');ReadLn(tipoMoneda);
if(tipoMoneda='E') or (tipoMoneda='D') or (tipoMoneda='R') then
  begin
     if(tipoMoneda='D') then
       begin
         WriteLn('Convertido a dolares es:',(cantPesos/DOLAR):4:2);
       end
     else 
       begin
          iF(tipoMoneda = 'E') then
             begin
               WriteLn('Convertido a euros es:',(cantPesos/EURO):4:2);
             end
          else 
            begin
              WriteLn('Convertido a reales es:',(cantPesos/REEAL):4:2);
            end;   
       end;  
  end
else 
 WriteLn('Ingreso una moneda erronea');  
  
end.