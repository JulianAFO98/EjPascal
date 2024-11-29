{10) Una empresa le brinda a sus clientes un servicio de cable con un costo básico de $1350 por mes, el
paquete de películas se cobra $200 adicionales y el de deportes $270. Aparte ofrece internet por $800 con
6MB, si se desea 10MB y WIFI cuesta 20% más. La opción de grabar programas tiene un costo adicional
de $150 por mes. La promoción es que si se contrata ambos servicios (cable e internet), tiene una
bonificación del 25% del total.
Ingresar los datos de un cliente, calcular e informar cuánto debe pagar. }


program guia2ej10;
//DATOS =>  COSTO BASICO / PAQUETEs ADICIONALes / INTERNET / GRABAR
const
COSTOBCABLE = 1350;
COSTOBINTERNET = 800;
var
deseaCable,deseaInternet,resp:char;
precioTotal:real;
begin
  precioTotal:=0;
  WriteLn('Desea el servicio de cable?(S/N)');ReadLn(deseaCable);
  if(deseaCable = 'S') then
    begin
      precioTotal:=precioTotal+COSTOBCABLE;
      WriteLn('Desea el servicio de canales adicionales?(S/N)');ReadLn(resp);
      if(resp='S') then
         precioTotal:=precioTotal+200;
      WriteLn('Desea el servicio de canales de deportes?(S/N)');ReadLn(resp);
      if(resp='S') then
         precioTotal:=precioTotal+270;   
    end;
  WriteLn('Desea el servicio de Internet?(S/N)');ReadLn(deseaInternet);
  if(deseaInternet = 'S') then
    begin
      WriteLn('Desea  10MB y Wifi?(S/N)');ReadLn(resp);
      if(resp='S') then
         precioTotal:=precioTotal+COSTOBINTERNET*1.20
      else 
         precioTotal:=precioTotal+COSTOBINTERNET;
    end;  
    WriteLn('Desea poder grabar programas?(S/N)');ReadLn(resp);
    if(deseaCable='S') and (resp = 'S') then
      precioTotal:=precioTotal+150;
    if(deseaCable='S') and (deseaInternet='S') then
      precioTotal:=precioTotal*0.75;  
   WriteLn('El precio a pagar es:',precioTotal);   
end.