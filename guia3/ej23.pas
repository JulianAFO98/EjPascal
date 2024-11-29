{Un archivo contiene palabras (letras mayúsculas, minúsculas, dígitos, caracteres especiales)
separadas entre sí por uno o más blancos. Se debe verificar para cada una si se trata de una contraseña
válida, y en ese caso grabarla en un archivo de salida. Indicar al final del proceso el porcentaje de
palabras que no son contraseñas válidas y mostrar la contraseña inválida más larga (puede no existir).
 Una contraseña válida debe:
 estar conformada como mínimo por 8 caracteres,
 incluir obligatoriamente, al menos una letra mayúscula y al menos una minúscula
 incluir exactamente cuatro dígitos.
 no contener caracteres diferentes de letras y digitos.

eR68G12a 91jY643ebjp eRty74kLh 24fG92 aj85gT32 eL8j$8215 dGb9357jKoup
La salida del programa sería:
El % de contraseñas inválidas es 57.14
La longitud de la contraseña inválida más larga es de 11 caracteres}

Program ej23;

var 
Arch:text;
contrasenia:string[20];
contCar,contMayus,contMinus,contNum,totalPass,contInvalidas,MaxLongInv:byte;
car:char;
invalida:boolean;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  contrasenia:='';contCar:=0;contMayus:=0;contMinus:=0;contNum:=0;invalida:=false;contInvalidas:=0;totalPass:=0;MaxLongInv:=0;
  while not eof(Arch) do
     begin
       Read(Arch,car);
       if(car<>' ') and (car<>'.') then
         begin
           contrasenia:=contrasenia+car;
           contCar:=contCar+1;
           case car of
            'a'..'z': 
              contMinus := contMinus + 1;  
            'A'..'Z': 
              contMayus := contMayus + 1;   
            '0'..'9': 
              contNum := contNum + 1;      
           else
             invalida:=true;
          end;
         end 
       else
         begin
           if (not invalida) and (contMinus>=1) and ( contMayus>=1) and (contNum=4)  and (Length(contrasenia)>=8) then
               begin
                  WriteLn('La contrasenia ',contrasenia,' es valida.');
               end
           else 
               begin
                 contInvalidas:=contInvalidas+1;
                 if(contCar>MaxLongInv)then 
                   MaxLongInv:=contCar;
                 WriteLn('La contrasenia ',contrasenia,' no es valida.');
               end;
                
           totalPass:=totalPass+1;  
           contrasenia:='';
           contMayus:=0;
           contMinus:=0;
           contNum:=0;
           contCar:=0;
           invalida:=false;
         end;
     end;
    WriteLn('Porcentaje de contrasenias invalidas:',(contInvalidas/totalPass)*100:4:2); 
    WriteLn('La contrasenia invalida mas larga tiene: ',MaxLongInv,' caracteres'); 
end.