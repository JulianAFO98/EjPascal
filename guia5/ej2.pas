{Dado un archivo de enteros, se pide almacenar en un vector V sólo los elementos impares y en otro 
vector W, los pares, ignorando si hubiese, los ceros}

program ej2;
type
 TV = array [1..255] of integer;

procedure mostrarVector(vec:TV;N:byte);
var 
 i:byte;
begin
  for i:=1 to N do 
   begin
     Write(vec[i],' ');
   end;
   WriteLn();
end; 

var 
 Arch:text;
 num:integer;
 vecImp,vecPar:TV;
 NImp,NPar:byte;
begin
   Assign(Arch,'datos.txt');
   Reset(Arch);
   NPar:=0;
   NImp:=0;
   while not eof(Arch) do 
     begin
       read(Arch,num);
       if(num<>0) then
         begin
           if(num mod 2 = 0) then
             begin
                NPar:=Npar+1;
                vecPar[Npar]:=num;
             end
            else 
             begin
                Nimp:=Nimp+1;
                vecImp[NImp]:=num;
             end; 
         end;
     end;
    mostrarVector(vecImp,NImp);
    mostrarVector(vecPar,NPar); 
end.