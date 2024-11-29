program ej13;
var 
tipo:char;
precio:real;
begin
  repeat  // LA DIFERENCIA ES QUE UNO SE EJECUTA MIENTRAS SEA VERDADERA Y EL OTRO BUCLE MIENTRAS SEA FALSO;
    Readln (Tipo); Tipo := Upcase(Tipo);
  until (Tipo='P') or (Tipo='F') or (Tipo='A')
end.


{P=panadería, F=fiambrería, A=almacén}
{Readln( Tipo, Precio); Tipo := Upcase(Tipo);
 While (Tipo<>’P’) and (Tipo<>’F’) and (Tipo<>’A’) do
 Begin
 Readln (Tipo); Tipo := Upcase(Tipo);
 End;}
