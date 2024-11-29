{ Un médico tiene en un archivo de texto información sobre sus pacientes ordenado por su número 
de historia clínica. En cada línea: 
•  Número Historia Clínica (entero positivo, orden ascendente) 
•  Apellido y Nombre del Paciente (cadena de 30) 
Se desea obtener un listado de los pacientes con apellidos que comienzan entre ‘A’ y ‘F’ ordenados 
alfabéticamente. 
 }

 program ej17;
 Type 
 TVC = array [1..28] of  char;
 TVV = array [1..255] of TVC;

procedure llenarDatos(var vecNombres: TVV; var N: byte);
var 
  Arch: text;
  numCli: byte;  
  i: byte;
  car: char;
begin
  N := 0;
  Assign(arch, 'datos.txt');
  reset(arch);
  while not eof(arch) do
  begin
    read(arch, numCli,car);       
    N := N + 1;
    for i := 1 to 28 do 
    begin
      read(Arch, vecNombres[N][i]);              
    end;                
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
      for j:=1 to 28 do 
       begin
         pal:=pal+vecNombres[i][j];
       end;
       Writeln(pal);
    end;
end;

function buscarPos(nombre:TVC;listaAF:TVV;N:byte):byte;
var 
i,j,pos:byte;
encontroPos:boolean;
begin
  i:=N;pos:=N+1;encontroPos:=false;
  while (i>=1)  and (not encontroPos) do 
    begin
      if(nombre[1]<listaAF[i][1]) then
        begin
          pos:=i;
        end
      else 
       if(nombre[1]=listaAF[i][1]) then
         begin
           j:=2;
           while (j<=28) and (not encontroPos) do 
            begin
              if(nombre[j]<listaAF[i][j])then
                begin
                  pos:=i;
                  encontroPos:=true;
                end
              else 
               begin
                 if(nombre[j]>listaAF[i][j])then
                   begin
                     pos:=i+1;
                     encontroPos:=true;
                   end;
               end; 
               j:=j+1; 
            end;
         end;  
        i:=i-1;
    end;
    buscarPos:=pos;
end;

procedure crearListaAF(vecNombres:TVV;N:byte);
var
i,j:byte; 
listaAF:TVV;
NL,pos:byte;
begin
  NL:=0;
  for i:=1 to N do 
   begin
     if(vecNombres[i][1] in ['A'..'F']) then 
       begin
         pos:=buscarPos(vecNombres[i],listaAF,NL);
         for j:=NL downto pos do
           begin
             listaAF[j+1]:=listaAF[j];
           end;
         listaAF[pos]:=vecNombres[i];
         NL:=NL+1;
       end;
   end;
   WriteLn('Los nombres ordenados entre A y F son:');
   mostrarNombres(listaAF,NL);
end;

 var 
 vecNombres:TVV;
 N:byte;
 begin
   llenarDatos(vecNombres,N);
   //mostrarNombres(vecNombres,N);
   crearListaAF(vecNombres,N);
 end.