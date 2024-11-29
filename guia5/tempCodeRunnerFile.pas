 program ej17;
 Type 
 TVC = array [1..30] of  char;
 TVV = array [1..255] of TVC;

procedure llenarDatos(var vecNombres:TVV;var N:byte);
var 
Arch:text;
numCli,i:byte;
car,extra:char;
begin
  N:=0;
  Assign(arch,'datos.txt');reset(arch);
  while not eof(arch) do
    begin
      Read(arch,numCli,extra);
      N:=N+1;
      for i:=1 to 30 do 
       begin
         read(Arch,vecNombres[N][i]);
       end;
       ReadLn(arch);
    end;
   close(Arch); 
end;

procedure mostrarNombres(vecNombres:TVV;N:byte);
var 
i,j:byte;
pal:string[30];
begin
  for i:=1 to N do 
    begin
      pal:='';
      for j:=1 to 30 do 
       begin
         pal:=pal+vecNombres[i][j];
       end;
       Write('El paciente ',i,' es ',pal);
    end;
end;

 var 
 vecNombres:TVV;
 N:byte;
 begin
   llenarDatos(vecNombres,N);
   mostrarNombres(vecNombres,N);
 end.