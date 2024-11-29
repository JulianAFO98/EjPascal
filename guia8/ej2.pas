program ej2;


function contPares(i:byte):byte;
begin
  if(i=0) then 
    contPares:=1
  else 
   begin
     if(i mod 2 = 0) then 
      contPares:=1+contPares(i-1)
     else 
      contPares:=contPares(i-1); 
   end;  
end;

begin
  write(contPares(10));
end.
