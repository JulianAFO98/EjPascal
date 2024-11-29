Program primeraParte;
type
str15=string[15];
var 
Arch:text;
N,i,dia,cont,contX:byte;
nombre:str15;
litros,diaMax,maxLitros,sum,X,sumTotal:word;
begin
  Assign(Arch,'tambos.txt');
  Reset(Arch);
  readln(Arch,N);
  WriteLn('Ingrese X');
  ReadLn(X);
  contX:=0;
  sumTotal:=0;
  for i:=1 to N do 
   begin
     maxLitros:=0;
     diaMax:=0;
     sum:=0;
     cont:=0;
     readln(Arch,nombre);
     Read(Arch,dia);
     WriteLn(dia,nombre);
     while dia <> 0 do 
      begin
        readln(Arch,litros);
        cont:=cont+1;
        sum:=sum+litros;
        if(litros>maxLitros) then
          begin
            maxLitros:=litros;
            diaMax:=dia;
          end;
         read(Arch,dia);  
      end;
      ReadLn(Arch);
     sumTotal:=sumTotal+sum;
     if(sum>X)then
        contX:=contX+1;
     WriteLn('El dia que mas leche entrego el tambo',nombre,' fue ',diaMax);  
   end;
   if(N<>0)then
        WriteLn('El promedio de leche por tambo ',nombre,' fue ',(sumTotal/N):4:2);
    WriteLn('cantidad que superaron X: ',contX);
   close(Arch);
end.