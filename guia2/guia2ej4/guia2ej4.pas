program guia2ej4;
var
d1,d2:byte;
m1,m2:byte;
anio1,anio2:word;
begin
 WriteLn('Ingrese  dia de la fecha 1');ReadLn(d1);
 WriteLn('Ingrese mes de la fecha 1');ReadLn(m1);
 WriteLn('Ingrese anio de la fecha 1');ReadLn(anio1);
 WriteLn('Ingrese dia de la fecha 2');ReadLn(d2);
 WriteLn('Ingrese  mes de la fecha 2');ReadLn(m2);
 WriteLn('Ingrese  anio de la fecha 2');ReadLn(anio2);

 // ACA VERIFICARIA QUE FUERAN VALIDAS PERO NO LO VOY A HACER

 WriteLn('Fecha ingresada 1 =>', d1,'/',m1,'/',anio1);
 WriteLn('Fecha ingresada 2 =>', d2,'/',m2,'/',anio2);

// LOGICA PARA VERIFICAR CUAL ES MAS ANTIGUA

if(anio1=anio2) then 
     begin
       // LOGICA PARA VERIFICAR MES Y DIA
       if(m1=m2)then
           begin
                if(d1>d2)then
                  begin
                    WriteLn('La fecha 2 es mas antigua que la fecha 1');
                    Case m1 of
                      1..4:
                       WriteLn('Pertenece al trimestre 1');
                      5..8:
                       WriteLn('Pertenece al trimestre 2');
                      9..12:
                       WriteLn('Pertenece al trimestre 3');
                    end;
                  end
                  
                else 
                  begin
                     WriteLn('La fecha 1 es mas antigua que la fecha 2');
                     Case m2 of
                      1..4:
                       WriteLn('Pertenece al trimestre 1');
                      5..8:
                       WriteLn('Pertenece al trimestre 2');
                      9..12:
                       WriteLn('Pertenece al trimestre 3');
                     end; 
                  end;
           end
        else 
           begin
              if(m1>m2)then
                WriteLn('La fecha 2 es mas antigua que la fecha 1')
              else 
                WriteLn('La fecha 1 es mas antigua que la fecha 2');
           end;
     end
else  
   begin
     if(anio1>anio2)then
       WriteLn('La fecha 2 es mas antigua que la fecha 1')
     else 
       WriteLn('La fecha 1 es mas antigua que la fecha 2');
   end;    
end.