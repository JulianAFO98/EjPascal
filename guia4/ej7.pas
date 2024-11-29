{Un estudio contable registró la facturación de varios comercios en los últimos N meses, por cada uno 
se tiene: 
  Nombre 
  Tipo (S/N) si es Responsable Inscripto o No, y luego por cada uno de los N meses: 
- Importe facturado mensual sin IVA 
Se desea saber: 
a)  Listar Nombre, tipo y cuánto pagó de IVA en los N meses. 
b)  El nombre del comercio Responsable Inscripto que menos facturó en total. 
 
Desarrollar la función Impuesto con los parámetros necesarios de modo tal que devuelva el monto de IVA 
que debe pagar. Sabiendo que si es Responsable Inscripto, corresponde el 21% de la compra, si no lo es, 
el 21%+10%.}

Program ej7;

function Impuesto(monto:real):real;
begin
   Impuesto:=monto*0.21;
end;

var 
 N,i:byte;
 tipo,resp:char;
 nombre,nomMenosFactu:String[10];
 impSinIVA,IVAPagado,montototal,MontoMin:real;
begin
  
  WriteLn('Ingrese la cantidad de meses');
  ReadLn(N);
  MontoMin:=999999;
  repeat
     WriteLn('Desea ingresar un comercion(S/N)');
     ReadLn(resp);
     if(resp<>'S') and (resp<>'N') then
       WriteLn('Ingreso una opcion erronea');
  until (resp = 'S') or (resp = 'N');
  while resp = 'S' do 
   begin
     montototal:=0;
     WriteLn('Ingrese nombre del comercio');
     ReadLn(nombre);
     repeat
       WriteLn('Es responsable adscripto?(S/N)');
       ReadLn(tipo);
       if(tipo<>'S') and (tipo<>'N') then
        WriteLn('Ingreso una opcion erronea');
     until (tipo = 'S') or (tipo = 'N');
     for i:=1 to N do 
      begin
        WriteLn('Ingrese el monto del mes:',i);
        ReadLn(impSinIVA);
        WriteLn('El comercio ',nombre,' de tipo ',tipo,' pago de IVA  en el mes ',i,' ',Impuesto(impSinIVA):8:2);
        montototal:=montototal+impSinIVA;
      end;
      if(montototal<MontoMin)then
        begin
          MontoMin:=montototal;
          nomMenosFactu:=nombre;
        end;

     repeat
      WriteLn('Desea ingresar un comercio(S/N)');
      ReadLn(resp);
      if(resp<>'S') and (resp<>'N') then
       WriteLn('Ingreso una opcion erronea');
     until (resp = 'S') or (resp = 'N');
   end;
  if(MontoMin<>999999)then
    WriteLn('El kiosco que menos facturo fue:',nomMenosFactu);
end.