{ Una empresa de autos de alquiler posee N vehículos y ha registrado la siguiente información de los
viajes realizados, por cada uno de ellos:
 Patente
 Total de litros de combustible consumidos
Y por cada viaje realizado
 - Kilómetros recorridos. (0 indica fin de datos).
Se pide ingresar los datos e informar:
a) Por cada vehículo el consumo que tuvo (cantidad de litros por km. recorrido)
b) Patente del vehículo que más viajes hizo.
c) Total de litros consumidos por el auto que hizo la menor cantidad de kms. }

Program ej16;

var 
i,N,contViajes,maxViajes:byte;
nroPate,PateMayor:string[10];
litros,litrosMenorKm,km,totalKm,MenorKm:real;
begin
  WriteLn('Ingrese la cantidad de vehiculos');
  readln(N);
  contViajes:=0;
  maxViajes:=0;
  MenorKm:=9999;
  For i:=1 to N do 
    begin
      WriteLn('Ingrese el numero de patente');
      ReadLn(nroPate);
      WriteLn('Ingrese el total de litros consumidos');
      ReadLn(litros);
      totalKm:=0;
      repeat
        WriteLn('Ingrese cantidad de km en este viaje(0 para finalizar)');
        ReadLn(km);
        if(km<>0)then
          contViajes:=contViajes+1;
        totalKm:=totalKm+km;  
      until km = 0;
      if(totalKm<MenorKm)then
        begin
          MenorKm:=totalKm;
          litrosMenorKm:=litros;
        end;
      if (totalKm<>0) then
       begin
         WriteLn('El vehiculo consumio:',litros/totalKm:4:2,'l/km');
       end
      else 
        WriteLn('No se realizaron viajes');
      if(contViajes>maxViajes) then
         begin
           maxViajes:=contViajes;
           PateMayor := nroPate;
           contViajes:=0;
         end;  

    end;

  WriteLn('La patente con mayor cantidad de viajes fue:',pateMayor);
  WriteLn('Total de litros consumidos por el auto que hizo la menor cantidad de kms:',litrosMenorKm:4:2);
end.