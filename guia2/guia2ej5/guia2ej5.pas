{) Dados tres números enteros mostrar el mayor de ellos. Plantear tres soluciones:
a) Alternativas secuenciales
b) Alternativas anidadas con expresiones lógicas compuestas
c) Alternativas anidadas con expresiones lógicas simples}


program guia2ej5;
var
n1,n2,n3:Integer;

begin
   n1:=2;n2:=5;n3:=10;
  //a)
  if (n1>n3) and (n1>n2) then
    WriteLn('El mayor numero es n1');
  if (n2>n3) and (n2>n1) then
    WriteLn('El mayor numero es n2');
  if (n3>n1) and (n3>n2) then
    WriteLn('El mayor numero es n3');

  //b)
   if(n1>n3) and (n1>n2) then
      WriteLn('El mayor numero es n1')
    else 
      begin
        if(n2>n3) then
           WriteLn('El mayor numero es n2')
        else 
          WriteLn('El mayor numero es n3');
      end;

   //c)   
     if(n1>n3) then
        begin
           if(n1>n2) then
             WriteLn('El mayor numero es n1')
           else
             WriteLn('El mayor numero es n2');
        end
    else 
      begin
        if(n2>n3) then
           WriteLn('El mayor numero es n2')
        else 
          WriteLn('El mayor numero es n3');
      end;
end.