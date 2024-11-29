{Reescribir el ejercicio 17, considerando que los datos están grabados en un archivo (con el formato
que considere más adecuado). }

Program ej18;

const 
DESCUENTO = 0.10;
var 
nombreCliente,clienteOferta:string[10];
cantP,i,contOferta,MayorOferta,contSoloOferta,cantCSoloOferta:byte;
promocion,extra:char;
precioB,precioTotal,totalDes:real;
Arch:text;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  MayorOferta:=0;
  cantCSoloOferta:=0;
  while not eof(Arch) do
    begin
     Read(Arch,nombreCliente,cantP);
     precioTotal:=0;
     totalDes:=0;
     contOferta:=0;
     contSoloOferta:=0;
     for i:=1 to cantP do
       begin
          read(Arch,precioB,extra,promocion); 
          precioTotal:=precioTotal+precioB;
          if(promocion = 'S') then
            begin
              contSoloOferta:=contSoloOferta+1;
              contOferta:=contOferta+1;
              totalDes:=totalDes+(precioB*DESCUENTO);
            end; 
        end;
       ReadLn(Arch); 
     if(contOferta>MayorOferta) then
       begin
         MayorOferta:=contOferta; 
         clienteOferta:=nombreCliente;
       end;
     if(contSoloOferta=cantP) then
       cantCSoloOferta:=cantCSoloOferta+1;
     WriteLn('Precio total: ',precioTotal:4:2);
     WriteLn('Cant descuento: ',totalDes:4:2);
     WriteLn('Precio final: ',(precioTotal-totalDes):4:2); 
    end;
   WriteLn('El cliente que compro la mayor cantidad de ofertas fue: ',clienteOferta);
   WriteLn('Cantidad clientes que compraron solo ofertas: ', cantCSoloOferta);
end.