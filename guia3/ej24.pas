{) En un archivo se han grabado palabras, separadas por uno o más blancos en una misma línea,
finalizando con un punto. Cada palabra está conformada por letras y dígitos (3ab4c3Hd).
Se pide, a partir del archivo descripto generar otro cambiando las parejas “LetraminusculaDigito” por las
repeticiones de la Letra según indique el digito.
Ejemplos: ab4C3hd 1Ab2c3hD2. => abbbbC3hd 1AbbccchD2.
 Ab0C3hd 1Ab2c0hD2. => AC3hd 1AbbhD2. }

program ej24;

var 
Arch,ArchS:text;
car1,carLetra,i:char;
contrasenia:string[20];
begin
  Assign(Arch,'datos.txt');
  Assign(ArchS,'salida.txt');
  Rewrite(ArchS);
  Reset(Arch);
  while not eof(Arch) do
    begin
       Read(Arch,car1);
       if(car1 in ['1'..'9']) and (carLetra in ['a'..'z']) then
         begin
           for i:=car1 downto '2' do //PONGO 2 YA QUE EN EL ELSE YA SE ESCRIBA LA LETRA 1 VEZ
            begin
              Write(ArchS,carLetra);
            end;
         end
       else 
        begin
          Write(ArchS,car1);
          carLetra:=car1;
        end;  
    end; 
    Close(Arch);
    close(ArchS);  
end.