{ Se pide compactar un arreglo, como en el ejercicio 4, pero sin usar estructura auxiliar.}
program ej16;
type 
TV = array [1..255] of byte;

procedure llenarArreglo(var arr:TV;var N:byte);
var 
i:byte;
begin
  WriteLn('Ingrese cuantos valores quiere agregar al arr');
  readln(N);
  for i:=1 to N do 
   begin
     ReadLn(arr[i]);
   end;
end;

procedure mostrarArreglo(arr:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do
    begin
      Write(arr[i],' ');
    end;
   WriteLn(); 
end;
{procedure compartarArreglo(var arr:TV;var N:byte);
var 
i,j,K,aux:byte;
begin
 K:=N;
 for i:=1 to K do 
   begin
     if(arr[i]<>0) then
        begin
          j:=i;
          while (j<>1) and (arr[j-1]=0) do
            begin
              aux:=arr[j-1];
              arr[j-1]:=arr[j];
              arr[j]:=aux;
              j:=j-1;
            end;
        end
      else 
       N:=N-1;  
   end;}
  
procedure compartarArreglo(var arr: TV; var N: byte);
var
  i, j: byte;
begin
  i := 1;
  while i <= N do
  begin
    if arr[i] = 0 then
    begin
      // Mover todos los elementos hacia la izquierda
      for j := i to N - 1 do
        arr[j] := arr[j + 1];
      // Reducir N, ya que hemos quitado un elemento
      N := N - 1;
    end
    else
      i := i + 1; // Solo avanzar si no hubo un cero
  end;
end;


var 
arr:TV;
N:byte;
begin
  llenarArreglo(arr,N);
  mostrarArreglo(arr,N);
  compartarArreglo(arr,N);
  mostrarArreglo(arr,N);
end.