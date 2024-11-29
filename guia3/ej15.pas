{ A partir de un archivo de texto que contiene una secuencia de caracteres terminada en punto,
desarrollar un programa para cada item:
a) Cuántas palabras comienzan con una letra que ingresa por teclado.
b) Cuántas palabras contienen una letra que ingresa por teclado.}

program ej15;
//b
{var 
car,letraBuscada:char;
Arch:text;
espacio:boolean;
cont:byte;

begin
  Assign(Arch,'datos.txt');Reset(Arch);
  WriteLn('Ingrese la letra a buscar');
  ReadLn(letraBuscada);
  cont:=0;
  espacio:=true;
  car:=' ';
  while car<>'.' do
    begin
       read(Arch,car);
       if (car=letraBuscada) and espacio then 
        begin
          espacio:=false;
          cont:=cont+1;
        end;
        if(car= ' ') then
          espacio:=true;
    end;
  WriteLn('Cant palabras con letra buscada: ',cont);  
end.}

//a

var 
car1,car2,letraBuscada:char;
Arch:text;
espacio:boolean;
cont:byte;

begin
  Assign(Arch,'datos.txt');Reset(Arch);
  WriteLn('Ingrese la letra a buscar');
  ReadLn(letraBuscada);
  cont:=0;
  espacio:=true;
  car1:= ' ';

  while car1<>'.' do
    begin
       read(Arch,car2);
       if (car2=letraBuscada) and espacio  and (car1=' ') then 
        begin
          espacio:=false;
          cont:=cont+1;
        end;
        if(car2= ' ') or (car2='.') then
          begin
            espacio:=true;
           
          end;
          
      car1:=car2;    
    end;
  WriteLn('Cant palabras que empiezan con la letra buscada: ',cont);  
end.