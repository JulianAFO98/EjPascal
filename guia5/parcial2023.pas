program parcial2023;
type
  ST15=string[15];
  TVB=array[1..100] of byte;

function especiales(c:char):boolean;
begin
    especiales:=false;
    if not ((upcase(c) in['0'..'9',]) and (upcase(c) in['A'..'Z'])) then
       especiales:=true;
end;

procedure cargaarray(var largo:TVB;var N:byte);
var
  i,contp:byte;
  nombre:ST15;
  c:char;
  arch:text;
  esp:boolean;
begin
  assign(arch,'datos.txt');
  reset(arch);
  read(arch,c);

  N:=0;
  while c<>':' do
  begin
    esp:=false;
    nombre:='';
    contp:=0;
    while c<>'@' do
    begin
      nombre:=nombre+c;
      if especiales(c) then
         esp:=true;
      read(arch,c);
    end;
    WriteLn(nombre);
    read(arch,c);
    while (c<>';') and (c<>':') do
    begin
      if (especiales(c)) and (c<>'.') then
         esp:=true;
      if c='.' then
         contp:=contp+1;
      read(arch,c);


    end;
    if (not esp) and (contp=1) then
       begin
         N:=N+1;
         largo[N]:=length(nombre);

       end;

  end;

end;
function tienenx(largo:TVB;N,X:byte):byte;
var
  i,cont:byte;

begin
  cont:=0;
  for i:=1 to N do
  begin
    if largo[i]=X then
       cont:=cont+1;

  end;
  tienenx:=cont;


end;
procedure pasax(largo:TVB;N:byte);
var
  X:byte;
begin
  writeln('ingrese x');
  readln(X);
  writeln('la cantidad de usuarios q tienen largo ',X,' son ', tienenx(largo,N,X));

end;

procedure inicializarvec(var vec:TVB);
var
  i:byte;
begin
  for i:=1 to 15 do
  begin
    vec[i]:=0;
  end;
end;
function max (frec:TVB):byte;
var
  i,aux,imax:byte;
begin
  aux:=frec[1];
  for i:=2 to 15 do
  begin
    if frec[i]>aux then
       begin
            aux:=frec[i];
            imax:=i;
       end;
  end;
  imax:=aux;

end;
procedure masusada(largo:TVB;N:byte);
var
  cont,i:byte;
  frec:TVB;

begin
  inicializarvec(frec);
  for i:=1 to N do
  begin
    frec[largo[i]]:=frec[largo[i]]+1;
  end;
  writeln('el largo mas frecuente es ',max(frec));
end;

procedure mostrarDatos(largo:TVB;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
    begin
      WriteLn(largo[i]);
    end;
end;


var
  largo:TVB;
  N:byte;
begin
  cargaarray(largo,N);
  mostrarDatos(largo,N);
  pasax(largo,N);
  masusada(largo,N);
  readln;
end.