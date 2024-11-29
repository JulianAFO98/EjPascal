program ej12;

var
Arch:text;
Cad1: string[8];
Cad2, Cad3 : string[3];
a,b : word;
x: real;
c: char;

begin
 Assign(Arch,'datos.txt');
  //SENTENCIA 1
  Reset(Arch);
  Readln(Arch,Cad2,c,x);
  ReadLn(Arch,a);
  ReadLn(Arch,cad1);
  WriteLn(Cad1,' ',Cad2,' ',a,' ',x:4:2,' ',c);
  

  //Sentencia 2
  Reset(Arch);
  Readln(Arch,Cad3,Cad2);
  ReadLn(Arch,x);
  ReadLn(Arch,a);
  WriteLn(Cad3,' ',Cad2,' ',x:4:2,' ',a);

  //Sentencia 3
  Reset(Arch);
  Readln(Arch,Cad1,Cad3,b);
  ReadLn(Arch,c,cad2);
  WriteLn(Cad1,' ',Cad3,' ',b,' ',c,' ',Cad2);

   //Sentencia 4
  Reset(Arch);
  ReadLn(Arch);
  Readln(Arch,Cad1);
  ReadLn(Arch,x);
  WriteLn(Cad1,' ',x:4:2);
end.