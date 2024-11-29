{Bool:=false ;
Sum:=0;
Readln( x );
If x <>0 then
 Repeat
 Sum := Sum + x;
 If Sum > 100 then
 Bool :=true;
 Readln( x );
 Until ( x=0) or Bool;
 Writeln(‘Resultado’, Sum );}

 {b) Reescríbalo reemplazando la estructura Repeat, los dos If y la variable booleana Bool por una
estructura While. }

 program ej14;

 var 

 begin 
   ReadLn(X);
   sum:=0;
   while (X <> 0) and (sum < 100) do
     begin
        Sum := Sum + x;
        Readln( x );
     end;
    Writeln(‘Resultado’, Sum );} 
 end. 