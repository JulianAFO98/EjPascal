program ultimoParcial1;
Type
 TVB = array[1..20] of byte;
 TVR = array[1..20] of real;
Const
 X=1.0;
Function Costo(Tipo: char; Tam, Cant:byte):real;
Var
Imp:real;
Begin
Imp:= Cant*X;
Case Tipo of
 'A': Imp:= Imp*2;
 'B': Imp:= Imp*3;
 'C': Imp:= Imp*5;
end;
If Tam=2 Then
 Costo:= Imp * 1.5
else
 Costo:= Imp;
end;



Procedure LeeFolletos( var VCosto: TVR; var VMasL, VCant: TVB; var j :byte);
Var
 Arch: Text;
 Car, Tipo: char;
 i, Max, Tam: byte;
Begin
ASSIGN (Arch, 'Folletos.txt'); RESET(Arch); j:=0;
While not eof(Arch) do { analiza cada línea del archivo }
 begin
 j:=j+1;
 VCant[j]:=0; VMasL[j]:=0;
 Read(Arch, Tipo, Tam, Car);
 While Car <> '.' do
 If Car = ' ' then
 Read(Arch, Car) {si es blanco lee otro caracter}
 else
 begin { es el comienzo de palabra}
 VCant[j]:=VCant[j] +1;
 i:=0;
 While (Car <> '.') and (Car <> ' ') do
 begin { cuenta los caracteres de una palabra }
 i:=i+1;
 Read(Arch, Car) ;
 end;
 If i>VMasL[j] then { evalua si es mas larga }
 VMasL[j] := i;
 End;
 VCosto[j]:= Costo(Tipo, Tam, VCant[j]);
 Readln(Arch);
 end;
CLOSE(Arch);
End;
Procedure Escribe(VCosto: TVR; VMasL, VCant: TVB; N:byte);
Var
 I:byte;
Begin
Writeln( 'Cantidad Pal más larga Costo');
For i:= 1 to N do
 Writeln (Vcant[i]:10, VMasL[i]:12, Vcosto[i]:8:2) ;
End;


Function MaxCosto(VCosto: TVR; VMasL: TVB; N:byte):real;
var 
i,cont:byte;
maximo:real;
palMasLarga:byte;
begin
   palMasLarga:=0;
   maximo:=0;
   cont:=0;
   for i:=1 to N do 
    begin
      if(VMasL[i]>palMasLarga) then 
       begin
         maximo:=0;
         cont:=1;
         palMasLarga:=VMasL[i];
         maximo:=VCosto[i];
       end
      else 
        begin
          if(VMasL[i]=palMasLarga) then 
           begin
             maximo:=maximo+VCosto[i];
             cont:=cont+1;
           end;
        end; 
    end;
    MaxCosto:=maximo/cont;
end;



Function Busca(VCant: TVB; M, N:byte):byte;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (VCant[i]<>M) do 
    i:=i+1;
  if(i<=N) then 
   Busca:=i
  else 
   Busca:=0;   
end;

Var
 VCosto: TVR;
 VMasL, VCant: TVB;
 N,K,pos:byte;
Begin
 LeeFolletos(VCosto,VMasL,VCant,N);
 //) Indicar el costo del folleto que contenga la palabra mas larga, si hay mas de uno el costo promedio de los mismos.
 WriteLn('El costo del folleto con longitud mas larga es', MaxCosto(VCosto,VMasL,N):6:2);
 // Para un entero N que ingresa por teclado, buscar el primer folleto que contenga exactamente N palabras y mostrar su costo.
 WriteLn('Ingrese K');
 ReadLn(K);
 pos:=Busca(VCant,K,N);
 if(pos=0) then 
   WriteLn('No existe el valor K')
 else 
   begin
     WriteLn('El costo del folleto con ',K,' palabras es ', vcosto[pos]:6:2);
   end;  
End.