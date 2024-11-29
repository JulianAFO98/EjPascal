program recursivo;

const
  MAX = 10;  { Tamaño máximo permitido para la matriz }

type
  Matriz = array[1..MAX, 1..MAX] of Integer;





function sumaPositivos(A:Matriz;i,j,N:byte):integer;
begin
  if(i>0) then 
   begin
     if(j>i) then 
      begin
        if(A[i,j]>0) and (A[i,j]=A[j,i]) then 
         sumaPositivos:=A[i,j]+sumaPositivos(A,i,j-1,N)
        else 
         sumaPositivos:=sumaPositivos(A,i,j-1,N); 
      end
     else 
      sumaPositivos:=sumaPositivos(A,i-1,N,N);  
   end
  else 
    sumaPositivos:=0; 
end;

var
  A: Matriz;
  N, i, j: Integer;

begin
  Write('Ingrese el tamaño N de la matriz (N <= ', MAX, '): ');
  Readln(N);

  { Verificar que N sea válido }
  if (N < 1) or (N > MAX) then
  begin
    Writeln('Tamaño no válido. Debe estar entre 1 y ', MAX, '.');
    Halt;
  end;

  { Lectura de la matriz }
  Writeln('Ingrese los elementos de la matriz:');
  for i := 1 to N do
    for j := 1 to N do
    begin
      Write('Elemento [', i, ', ', j, ']: ');
      Readln(A[i, j]);
    end;

  { Mostrar la matriz }
  Writeln('Matriz ingresada:');
  for i := 1 to N do
  begin
    for j := 1 to N do
      Write(A[i, j]:4);  { :4 para alinear los valores }
    Writeln;
  end;

  WriteLn('La suma de los valores es',sumaPositivos(A,N-1,N,N));
end.