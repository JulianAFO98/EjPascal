program parcialLote;
type
str2 = string[2];
str4 =string[4];
TVS = array[1..255] of str2;
TVR = array [1..255] of real;
TVC = array [1..255] of char;

procedure llenarDatos(var variedad,lote:TVS;var tons:TVR; var calidad:TVC;var N:byte);
var 
arch:text;
car:char;
begin
  Assign(arch,'datos.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     read(arch,variedad[N],lote[N],tons[N]);
     Read(arch,car);
     while car = ' ' do 
      read(arch,car);
     calidad[N]:=car;
     ReadLn(arch);
   end;
   close(arch);
end;

procedure mostrarDatos(variedad,lote:TVS;tons:TVR;calidad:TVC;N:byte);
var 
i:byte;
begin
   for i:=1 to N do 
    begin
      WriteLn('El codigo ',variedad[i]+lote[i],' tiene ',tons[i]:6:2,' toneladas de calidad ',calidad[i]);
    end;
end;

function codMaxTon(variedad,lote:TVS;tons:TVR;calidad:TVC;N:byte):str4;
var 
i:byte;
codMax:str4;
tonsMax:real;
begin
  tonsMax:=0;
  for i:=1 to N do 
    begin
      if ((calidad[i]='C') or (calidad[i]='B')) and (tons[i]>tonsMax) then
         begin
           tonsMax:=tons[i];
           codMax:=variedad[i]+lote[i];
         end;
    end;
    codMaxTon:=codMax;
end;

function existeCodigo(codigo:Str4;variedad,lote:TVS;N:byte):boolean;
var 
i:byte;
begin
   i:=1;
   while (i<=N) and (codigo<>(variedad[i]+lote[i])) do 
    i:=i+1;
   existeCodigo:=i<=N;
   {if(i<=N) then 
     existeCodigo:=true
   else 
     existeCodigo:=false;}  
end;


Procedure InsertaOrdenado ( Var V: TVR; Var N: Byte; X: Real);
Var
 J: Byte;
Begin
 J:= N;
 While ( J>0 ) and (X < V[J] ) do
 Begin
   V[J+1]:=V [j]; 
   J:=J-1;
 End;
  V[J+1] := X;
  N:= N+1;
End;

procedure mostrarDatosTvr(vec:TVR;N:byte);
var 
i:byte;
begin
   for i:=1 to N do 
    begin
      WriteLn('El lote ',i,' tiene: ',vec[i]:6:2,' toneladas');
    end;
end;


procedure InformarVecCalA(vari:str2;variedad,lote:TVS;tons:TVR;calidad:TVC;N:byte);
var 
 i,Naux:byte;
 vecAuxTons:TVR;
begin
   Naux:=0;
   for i:=1 to N do 
     begin
       if(vari=variedad[i]) and (calidad[i]='A') then 
        begin
          InsertaOrdenado(vecAuxTons,Naux,tons[i]);
        end
       else 
         begin
           vecAuxTons[i]:=0; 
           Naux:=Naux+1;
         end;
         
     end;
   mostrarDatosTvr(vecAuxTons,Naux);  
end;


var 
Variedad,lote:TVS;
tons:TVR;
calidad:TVC;
N:Byte;
codigo:str4;
M,vari:str2;
K:char;
begin
  llenarDatos(variedad,lote,tons,calidad,N);
  mostrarDatos(variedad,lote,tons,calidad,N);
  //a CODIGO DE PARTIDA CON MAX TONS DE TIPO B O C
  WriteLn('El codigo  de max tons de tipo B o C es:', codMaxTon(variedad,lote,tons,calidad,N));
  //Inciso C 
  WriteLn('Ingrese la variedad M');ReadLn(M);
  WriteLn('Ingrese el lote K');ReadLn(K);
  codigo:=M+'0'+K;
  if(existeCodigo(codigo,variedad,lote,N)) then
      WriteLn('Si existe el codigo en los datos ingresados')   
  else 
      WriteLn('No existe el codigo'); 
  //B
  WriteLn('Ingrese una variedad a buscar');
  ReadLn(vari);
  InformarVecCalA(vari,variedad,lote,tons,calidad,N);

end.