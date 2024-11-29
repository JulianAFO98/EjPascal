{
Reescriba utilizando archivo de texto para ingreso de datos los siguientes ejercicios:
a) Ej 6, considerar en la primera línea del archivo el saldo inicial y en cada una de las líneas siguientes
un movimiento: Tipo, Monto (notar que no es necesario el tipo F).
b) Ej 7, en cada línea del archivo: Nombre (15 caracteres) y las tres notas reales
}


program ej11;

//a)
{var
Arch:text;
montoInicial,monto:real;
tipo:char;
contF:byte;
begin
  contF:=0;
  Assign(Arch,'datos.txt');reset(Arch);
  ReadLn(arch,montoInicial);
  while not eof(Arch) do
     begin
       ReadLn(Arch,tipo,monto);
       tipo:=Upcase(Tipo);
       if(tipo='D') then
         begin
           montoInicial:=montoInicial+monto;
         end
       else 
         begin
           if((montoInicial-monto)<0) then
             begin
               contF:=contF+1;
               WriteLn('No se pudo extraer el dinero');
             end
           else 
             begin
              WriteLn('Se extrajo el dinero');
              montoInicial:=montoInicial-monto;
             end;  
         end; 
     end;
  WriteLn('Cantidad de fallos al extraer:',contF);
 end.}
 //FINAL A
 //b)

var
Arch:text;
nota1,nota2,nota3,contApro,contTot:byte;
nombre:string[15];
promedio:real;

begin
    Assign(Arch,'datos.txt');Reset(Arch);
    contTot:=0;contApro:=0;
    while not eof(arch) do
      begin
        ReadLn(Arch,nombre,nota1,nota2,nota3);
        contTot:=contTot+1;
        promedio:=(nota1+nota2+nota3)/3;
        if(promedio>=4) then
          begin
            WriteLn('El alumno ',nombre,' aprobo');
            contApro:=contApro+1;
          end
        else 
          WriteLn('El alumno ',nombre,' desaprobo');  
      end;

    if(contTot<>0)then
      WriteLn('El porcentaje de aprobados fue:',(contApro/contTot)*100:4:2);  
  
end.

