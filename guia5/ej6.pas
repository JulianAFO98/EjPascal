{Escriba un programa que lea una frase (secuencia de caracteres separada por espacio, coma, punto)
y mediante un menú de opciones calcule e informe:
a) El número de palabras que contiene.
b) La longitud de la palabra más larga.
c) De todas las palabras, la que aparece antes en el diccionario. Analizar las alternativas de
almacenar dicha palabra en un arreglo de caracteres o en un string.
d) la frecuencia de cada letra (mayúscula o minúscula) que aparece en la frase.
No es necesario almacenar toda la frase en un arreglo. }

program ej6;
type 
letra = string[1];
TV = array [1..255] of letra;

procedure leerFrase(var vec:TV;var N:byte);
var 
frase:string;
i:byte;
begin
  WriteLn('Ingrese una frase');
  ReadLn(frase);
  N:=Length(Frase);
  for i:=1 to N do 
    begin
      vec[i]:=Copy(frase,i,1);
    end;
end;

procedure mostrarFrase(vec:TV;N:byte);
var 
i:byte;
begin
  for i:= to N do 
    begin
      Write(vec[i]);
    end;
    WriteLn();
end;


var 
VecFrase:TV;
N:byte;
begin
  leerFrase(VecFrase,N);
  mostrarFrase(VecFrase,N);
end.