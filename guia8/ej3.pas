program ej3;


function confuso(a,b:integer):integer;
begin
 if (b = 0) then
 confuso := 0
 else
 if (b mod 2 = 0) then
 confuso := confuso(a+a, b div 2)
 else
 confuso := confuso(a+a, b div 2) + a;
end;



begin
  write(confuso(2,17));
end.