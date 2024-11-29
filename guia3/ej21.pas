{) Leer un conjunto de números enteros, la presencia de ceros intermedios indica fin de un
subconjunto y comienzo del siguiente, dos ceros consecutivos es fin de datos. Se pide calcular e informar
el máximo en cada subconjunto y el orden del subconjunto más numeroso.
Ejemplo: 3,5,2,0,6,7,4,7,0,2,1,0,0
Respuesta: subconjunto Máximo
 1 5
 2 7
 3 2
El subconjunto con más elementos es: 2}

Program ej21;

var 
cont0,contS,orden,maxOrden,subMasLargo:byte;
num,max:integer;
begin
   cont0:=0;
   orden:=1;
   max:=-9999;
   subMasLargo:=0;
   contS:=0;
   repeat
     WriteLn('Ingrese un numero,0 para terminar un subconjunto(Ingresar 2 veces 0 consecutivas termina el programa)');
     ReadLn(num);
     if(num = 0)  then
       begin
         if(contS>subMasLargo) then
           begin
             subMasLargo:=contS;
             maxOrden:=orden;
           end; 
         cont0:=cont0+1;
         if(cont0=1)then
           WriteLn('Orden: ',orden,' Maximo del subConjunto: ',max); 
         orden:=orden+1;
         max:=-9999;
         contS:=0;
       end
     else 
       begin
         contS:=contS+1;
         cont0:=0;
         if(num>max)then
           begin
             max:=num;
           end;
       end; 


   until cont0=2;
   WriteLn('Orden del conjunto mas numeroso:',maxOrden);
end.