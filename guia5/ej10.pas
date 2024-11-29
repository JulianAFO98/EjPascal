{Dado  un  arreglo  A,  generar  dos  arreglos  paralelos  B  y  C  donde  B  contiene  la  suma  de  los 
elementos de A que están entre dos negativos y C la cantidad que se sumó. Mostrar B y C. 
Ejemplo: 
A=(3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2)  B=(13, 12, 0, 17)  C=(3, 2, 0, 3) }
program ej10;
type 
TV = array [1..17] of integer;


procedure generarByC(A:TV;NA:byte;var B,C:TV;var N:byte);
var
contN,i,contNums,sum:byte;
begin
  sum:=0;
  contN:=0;
  contNums:=0;
  N:=0;
  for i:=1 to NA do 
   begin
     if(A[i]<0) then
       contN:=contN+1;
     if(contN=1) and (A[i]>0) then 
      begin
        sum:=sum+A[i];
        contNums:=contNums+1;
      end
     else 
       begin
         if(contN=2)then
           begin
             N:=N+1;
             B[N]:=sum;
             C[N]:=contNums;
             sum:=0;
             contNums:=0;
             contN:=1;
           end;
       end; 

   end;
end;


procedure mostrarVec(vec:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end;

const 
A:TV = (3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2);
NA=17;
var 
B,C:TV;
N:byte;
begin
  generarByC(A,NA,B,C,N);
  mostrarVec(B,N);
  mostrarVec(C,N);
end.