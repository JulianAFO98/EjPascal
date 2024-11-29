{Dado un conjunto de puntos en el plano, almacenar en un arreglo sus coordenadas junto con la
distancia al centro de coordenadas y a qué cuadrante pertenece.
Usando el arreglo, se pide:
 Informar el más cercano y más lejano al centro.
 Porcentaje de puntos en cada cuadrante (1..4, centro, eje X, eje Y).
Cada punto en el plano P tiene una coordenada X y otra Y. Desarrollar la función Distancia que dados
dos puntos P y Q devuelva la distancia entre ambos}
program ej3;
type 
TRpunto = record 
 x,y,distCent:real;
 cuadrante:char;
end;

TV = array [1..255] of TRpunto;
TVB = array [1..255] of byte;


function distanciaEntrePyQ(X1,Y1,X2,Y2:real):real;
begin
  distanciaEntrePyQ:=Sqrt(Sqr(X1-X2)+Sqr(Y1-Y2));
end;

procedure  llenarPuntos(var vecP:TV; var N:byte);
var 
arch:text;
punto:TRpunto;
valx,valy:real;
begin
  assign(arch,'puntos.txt');
  reset(arch);
  N:=0;
  while not eof(arch) do 
    begin
      ReadLn(arch,valx,valy);
      N:=N+1;
      with punto do 
          begin
             punto.x:=valx;
             punto.y:=valy;
             punto.distCent:= Sqrt(sqr(valx)+Sqr(valy));
             if(valx=0) or (valy=0) then
               begin
                 if(valx=0) and (valy=0) then 
                  punto.cuadrante:='C'
                 else 
                  if(valX=0) then 
                    punto.cuadrante:='X'
                  else 
                    punto.cuadrante:='Y';   
               end
             else 
              if(valx>0) then 
                begin
                 if(valy>0)then
                  punto.cuadrante:='1'
                 else 
                  punto.cuadrante:='4';  
                end
              else 
               begin
                if(valy>0)then
                  punto.cuadrante:='2'
                else 
                  punto.cuadrante:='3'; 
               end; 
           end;
      vecP[N]:=punto;
    end;
   close(arch); 
end;

procedure mostrarDatos(vecP:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     WriteLn('Cordenadas: (',vecP[i].x:4:2,',',vecP[i].y:4:2,') Distancia al centro: ',vecP[i].distCent:4:2,' Cuadrante: ',vecP[i].cuadrante);
   end;
end;


procedure InformarMasCercanoYLejano(vecP:TV;N:byte);
var
i:byte;
MaxLongitud,MinLongitud:real;
posMin,PosMax:byte; 
begin
  MaxLongitud:=vecP[1].distCent;
  PosMax:=1;
  MinLongitud:=vecP[1].distCent;
  posMin:=1;
  for i:=2 to N do 
   begin
     if(vecP[i].distCent>MaxLongitud)then
        begin
          MaxLongitud:=vecP[i].distCent;
          PosMax:=i;
        end
     else 
      begin
        if(vecP[i].distCent<MinLongitud)then
         begin
          MinLongitud:=vecP[i].distCent;
          posMin:=i;
         end;
      end;   
   end;
   WriteLn('El punto mas cercano es el: ',vecP[posMin].x:4:2,',',vecP[posMin].y:4:2);
   WriteLn('El punto mas lejano es el: ',vecP[PosMax].x:4:2,',',vecP[PosMax].y:4:2);
end;

procedure PorcentajeDePuntosEnCCuadrante(VecP:TV;N:byte);
var 
i:byte;
vecAux:TVB;
car:char;
begin
  for i:=1 to 7 do 
   vecAux[i]:=0;

  for i:=1 to N do 
   begin
     Case VecP[i].cuadrante of  
      '1':vecAux[1]:=vecAux[1]+1;
      '2':vecAux[2]:=vecAux[2]+1;
      '3':vecAux[3]:=vecAux[3]+1;
      '4':vecAux[4]:=vecAux[4]+1;
      'X':vecAux[5]:=vecAux[5]+1;
      'Y':vecAux[6]:=vecAux[6]+1;
      'C':vecAux[7]:=vecAux[7]+1;
     end;
   end;
  for i:=1 to 7 do 
   begin
     Case i of 
      1:car:='1';
      2:car:='2';
      3:car:='3';
      4:car:='4';
      5:car:='X';
      6:car:='Y';
      7:car:='C';
      end;
      WriteLn('Porcentaje de ',car,':',vecAux[i]/N*100:4:2,'%');
   end;
end;

var 
vecP :TV;
N:byte;
begin
  llenarPuntos(vecP,N);
  mostrarDatos(vecP,N);
  InformarMasCercanoYLejano(vecP,N);
  PorcentajeDePuntosEnCCuadrante(VecP,N);
end.