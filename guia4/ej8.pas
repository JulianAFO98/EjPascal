{En un archivo de texto se registraron las compras de N titulares de tarjetas de crédito de la siguiente 
forma: 
- Código de Cliente y a continuación sus compras: no se sabe cuántas son, por cada una: 
• Tipo de compra: (C=combustible, S=supermercado, O=otros, F=fin de datos)  
• Día  (1..31) 
• Monto 
El banco ofrece un descuento de: 
- 5% los días 10, 20 y 30 para el tipo Otros si el monto supera los $300. 
- 10% para Combustible en la 2º quincena. 
- 15% para Supermercado en la 1º quincena. 
Se pide: 
a)  Código del cliente y total abonado, por cada cliente que no se benefició con ningún descuento. 
b)  Cuántos clientes obtuvieron descuento en los tres rubros. 
c)  Informar cuánto ahorró cada cliente. 
En  la  solución  debe  desarrollar  la  función  Descuento,  que  a  partir  del  tipo  de  compra,  día  y  monto 
devuelva el correspondiente descuento.}


Program ej8;

function Descuento(monto:real;tipo:char;dia:byte):real;
begin
  if(tipo='C') and (dia in [16..31]) then
    Descuento:=monto*0.1
  else 
    if(tipo='O') and (dia in[10,20,30]) then
      Descuento:=monto*0.05
    else 
      if(tipo='S') and (dia in[1..15]) then
        Descuento:=monto*0.15
      else 
        Descuento:=0;      
end;

var 
N,i,cont3D:word;
Arch:text;
dia:byte;
tipo,extra:char;
codigo:String[10];
monto,totalAbonado,totalDescuento:real;
BC,BO,BS:Boolean;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  WriteLn('Ingrese la cantidad de titulares de tarjeta');
  ReadLn(N);cont3D:=0;
  for i:=1 to N do
    begin
      totalAbonado:=0;
      totalDescuento:=0;
      BC:=FALSE;BO:=false;BS:=false;
      Read(Arch,codigo);
      Read(Arch,extra,tipo);
      while tipo <> 'F' do
       begin
         Read(Arch,dia,monto);
         read(Arch,extra,tipo);
         Case tipo of 
          'C':BC:=true;
          'O':BO:=true;
          'S':BS:=true;
         end; 
         totalAbonado:=totalAbonado+monto;
         totalDescuento:=totalDescuento+Descuento(monto,tipo,dia);
       end;
       //A
        if(totalDescuento = 0) then
          begin
            WriteLn('Sin descuento => ',codigo,' ',totalAbonado:4:2);
          end
        else 
             WriteLn('Con descuento => ',codigo,' Total Abonado:',(totalAbonado-totalDescuento):4:2,' Descuento: ',totalDescuento:4:2);
        if BS and BO and BC then
            cont3D:=cont3D+1;
       ReadLn(Arch);
    end;
   WriteLn('Cantidad de usuarios con los 3 descuentos: ',cont3D); 
end.