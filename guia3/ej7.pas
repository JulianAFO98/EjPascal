{Dado un conjunto de alumnos, no se sabe cuántos son, de cada uno de ellos se conoce:
- Nombre (‘***’ indica fin de datos)
- Nota1, Nota2 y Nota3
Ingresar la información e informar:
a) El promedio de cada alumno y su condición:
− ‘Aprobado’ si su promedio es mayor o igual a 4
− ‘Desaprobado’ si su promedio es menor a 4.
 b) Porcentaje de alumnos Aprobados }


program ej7;

var
 nota1,nota2,nota3,contApro,contTot:byte;
 promedio:real;
 nombre:string[10];
 resp:char;

begin
   contApro:=0;contTot:=0;
   writeLn('Ingresar Alumno(S/N)');
   readLn(resp);
   resp:=Upcase(resp);
   while (resp = 'S') do
     begin
       contTot:=contTot+1;
       WriteLn('Ingrese el nombre del alumno');
       ReadLn(nombre);
       WriteLn('Ingrese la nota 1');
       ReadLn(nota1);
       WriteLn('Ingrese la nota 2');
       ReadLn(nota2);
       WriteLn('Ingrese la nota 3');
       ReadLn(nota3);
       promedio := (nota1+nota2+nota3)/3;
       if(promedio>=4) then
         begin
           contApro:=contApro+1;
           WriteLn('El alumno esta aprobado');
         end
        else 
          WriteLn('El alumno desaprobo'); 
       writeLn('Ingresar Alumno(S/N)');
       readLn(resp);   
     end;

   WriteLn('Porcentaje de alumnos aprobados:',(contApro/contTot)*100:4:2,'%')  
end.