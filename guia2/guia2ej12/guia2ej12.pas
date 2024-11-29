{) Dado un día (entre 1 y 31) y suponiendo que el día 1 es Lunes, determinar a qué día de la semana
corresponde el número ingresado. }
program guia2ej12;
var
dia:byte;
begin
  WriteLn('Ingrese el dia del mes');ReadLn(dia);
  dia := (dia-1) mod 7;
  Case dia of
    0: WriteLn('Lunes');
    1: WriteLn('Martes');
    2: WriteLn('Miércoles');
    3: WriteLn('Jueves');
    4: WriteLn('Viernes');
    5: WriteLn('Sábado');
    6: WriteLn('Domingo');
  end;
end.