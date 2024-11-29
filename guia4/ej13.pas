{Desarrollar  un  procedimiento  que  dada  una  Hora  Inicial  (horas,  minutos,  segundos)  y  unos 
segundos transcurridos, devuelva la Hora Final (en horas, minutos y segundos).}


program ej13;


procedure calcularHora(var hora,min,seg:word;segAgregados:word);
var
minAgregables,horaAgregable,segTotales,minTotales:word;
begin
  segTotales:=seg+segAgregados;
  seg:=(segTotales) mod 60;
  minAgregables := (segTotales) div 60;
  minTotales:=min+minAgregables;
  min := (minTotales) mod 60;
  horaAgregable:= (minTotales) div 60;
  hora := (hora + horaAgregable) mod 24;
end;

var 
hora,minutos,segundos,segundosAgregados:word;
begin
  repeat
    writeln('Ingrese una hora');
    ReadLn(hora);
  until (hora >= 0) and (hora < 24);
  repeat
    writeln('Ingrese la cantidad de minutos');
    ReadLn(minutos);
  until (minutos >=0) and (minutos<60);
  repeat
    writeln('Ingrese la cantidad de segundos');
    ReadLn(segundos);
  until (segundos >=0) and (segundos<60);

  WriteLn('Ingrese la cantidad de segundos a agregar');
  ReadLn(segundosAgregados);
  calcularHora(hora,minutos,segundos,segundosAgregados);
  WriteLn('La hora es: ',hora,':',minutos,':',segundos);
end.