{Desarrollar un procedimiento recursivo para imprimir una media pirámide de dígitos como se
muestra a continuación:
1
2 1
3 2 1
4 3 2 1
5 4 3 2 1
6 5 4 3 2 1
7 6 5 4 3 2 1
8 7 6 5 4 3 2 1
9 8 7 6 5 4 3 2 1 }
program ej11;


procedure GenerarPiramide(numAct,holder,vueltas:byte);
begin
  if(vueltas>0) then 
   begin
     if(numAct>0) then 
      begin
        GenerarPiramide(numAct-1,holder,vueltas);
        Write(numAct);
      end
     else 
      begin
        GenerarPiramide(holder-1,holder-1,vueltas-1);
        WriteLn;
      end;  
   end;
end;



begin
  GenerarPiramide(9,9,9);
end.
