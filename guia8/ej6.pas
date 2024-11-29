{) Sea A un arreglo de reales y un valor X real ingresado por teclado, se pide determinar en qué
posición se encuentra X, devolver 0 en caso de no encontrarlo. Implementar:
a) considerando el arreglo desordenado, una búsqueda lineal recursiva.
b) para un arreglo ordenado en forma ascendente, una búsqueda binaria recursiva}

program ej6;
type 
TV = array[1..5] of real;


function busquedaBinariaX(V:TV;inicio,fin:byte;X:real):byte;
var
medio:byte;
begin
  medio:=(fin+inicio) div 2;
  if(inicio = fin ) then 
    begin
      if(V[medio] = X) then 
        busquedaBinariaX:=medio
      else 
        busquedaBinariaX:=0;
    end
  else 
   begin
     if(V[medio]=X) then 
       busquedaBinariaX:=medio
     else 
      begin
        if(V[medio]>X) then 
            busquedaBinariaX:=busquedaBinariaX(V,inicio,medio-1,X)
        else 
            busquedaBinariaX:=busquedaBinariaX(V,medio+1,fin,X);
      end;  
     
   end;       
end;


function buscarPosX(V:TV;N:byte;X:real):byte;
begin
  if(N>0)then 
   begin
     if(V[N]=X) then 
      buscarPosX:=N
     else 
      buscarPosX:=buscarPosX(V,N-1,X); 
   end
  else 
   buscarPosX:=0;
end;

const 
V : TV = (1,0,6.4,7,15);
N = 5;
var 
X:real;
pos:byte;
begin
   WriteLn('Ingrese X');
   ReadLn(X);
   //pos:=buscarPosX(V,N,X);
   pos:=busquedaBinariaX(V,1,N,X);
   if(pos=0) then 
    WriteLn('No existe el valor en el arreglo')
   else 
    WriteLn('El valor se encuentra en: ',pos); 
end. 



