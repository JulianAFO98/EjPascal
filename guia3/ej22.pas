{A partir de un archivo de texto que contiene palabras separadas entre sí por uno o más blancos
desarrollar un programa para:
a) Mostrar la palabra con más cantidad de vocales del texto.
b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
c) Contar cuántas son palíndromas (capicúas). }

program ej22;

var
car:char;
Arch,ArchS:text;
palabra,palCMV,palM4,mitadPos:string[10];
i,contV,maxVocal,contL,contCapi,pos:byte;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  Assign(ArchS,'Salida.txt');Rewrite(ArchS);
  palabra:='';palM4:='';mitadPos:='';
  contV:=0;maxVocal:=0;contL:=0;contCapi:=0;
  car:=' ';
  while car<>'.' do 
    begin
      read(Arch,car);
      car:=Upcase(car);
      if(car<>' ') and (car<>'.') then
        begin
          contL:=contL+1;
          if (car = 'A') or (car = 'E') or(car = 'I') or(car = 'O') or(car = 'U') then
           contV:=contV+1;
          palabra:=palabra+car;
        end
      else 
        begin
          if(contL>4)then
            begin
              for i:=Length(palabra) downto 1 do
                begin
                  palM4:=palM4+copy(palabra,i,1);
                end;
              Write(ArchS,palM4,' ');  
            end;  
          if(contV>maxVocal)then
            begin
              maxVocal:=contV;
              palCMV:=palabra;
            end;
          //LOGICA CAPI
          pos:=(Length(palabra) div 2) + 1;
          if((Length(palabra) mod 2) = 0) then
           begin
               for i:=Length(palabra) downto pos do
                begin
                  mitadPos:=mitadPos+copy(palabra,i,1);
                end;
              if(Copy(palabra,1,pos-1)=mitadPos) then
                contCapi:=contCapi+1;
           end
          else 
           begin
              for i:=Length(palabra) downto pos+1 do
                begin
                  mitadPos:=mitadPos+copy(palabra,i,1);
                end;
                WriteLn(mitadPos);
              if(Copy(palabra,1,pos-1)=mitadPos) then
                contCapi:=contCapi+1;
           end;    

          contL:=0;  
          contV:=0;  
          palabra:='';
          palM4:='';
          mitadPos:='';
        end;  
    end;
   WriteLn('La palabra con mas vocales es: ',palCMV); 
   WriteLn('Cant capi: ',contCapi);
   Close(Arch);
   Close(ArchS);
end.