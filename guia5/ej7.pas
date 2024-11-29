{) Realizar la suma de dos números positivos muy grandes (de 10 cifras, por ejemplo). Implementar el
programa principal que lea ambos números, invoque el subprograma que resuelve la suma y muestre el
resultado. }

program ej7;
type 
TV = array [1..255] of byte;

procedure leerNum(var num:TV;var N:byte);
var 
numeroStr:String[30];
i,numeroByte,error:byte;
begin
  WriteLn('Ingrese un numero positivo muy grande');
  ReadLn(numeroStr);
  N:=Length(NumeroStr);
  for i:=1 to N do 
   begin
     Val(Copy(numeroStr,i,1),numeroByte,error);
     num[255-N+i]:=numeroByte;
   end;
end;

procedure mostrarNum(vec:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
    begin
      Write(vec[255-N+i]);
    end;
    WriteLn();
end;



procedure sumarNumeros(num1,num2:TV;N1,N2:byte);
var 
resultado:TV;
i,NR,seLleva,suma:byte;
begin
  seLleva:=0;
  if(N1>N2) then
    NR:=N1
  else 
    NR:=N2;  
    WriteLn('Aca empieza la suma');
    WriteLn('NR VALE ',NR);
  for i:=255 downto 255-NR do 
   begin
     WriteLn('Datos de i valiendo ',i,' num1 ',num1[i],' num2 ',num2[i]);
     suma:=num1[i]+num2[i]+seLleva;
     resultado[i]:=suma mod 10;
     seLleva:=suma div 10;
   end;
  if seLleva > 0 then
  begin
    resultado[255-NR-1] := seLleva;
    NR := NR + 1; 
  end; 
   mostrarNum(resultado,NR);
end;



var 
num1,num2:TV;
l1,l2:byte;
begin
  leerNum(num1,l1);
  leerNum(num2,l2);
  mostrarNum(num1,l1);
  mostrarNum(num2,l2);
  sumarNumeros(num1,num2,l1,l2);
end.