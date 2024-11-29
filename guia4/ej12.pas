program ej12;

procedure calcularFibonacci(cota:word);
var
 val1,val2,val3:word;
begin
  val1:=1;
  val2:=1;
  WriteLn(val1);
  WriteLn(val2);
  while (val2+val1) <cota do
    begin
      val3:=val1+val2;
      WriteLn(val3);
      val1:=val2;
      val2:=val3;
    end;
end;

var 
cota:word;
begin
  repeat
    WriteLn('Ingrese una cota a superar con la sucesion de fibonacci');
    ReadLn(cota);
    calcularFibonacci(cota);
  until cota = 0;
  WriteLn('Programa finalizado');
end.