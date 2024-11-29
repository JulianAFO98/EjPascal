program parcialRepaso;
type 
str3 = string[3];
TipoRegCompetidor = record 
   codigo:str3;
   cantTiros:byte;
end;
TVR = array [1..255] of TipoRegCompetidor;
TM  = array [1..255,1..255] of byte;
TVC = array [1..255] of str3;


function buscarPosCod(vecComp:TVR;N:byte;cod:str3):byte;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (cod<>vecComp[i].codigo) do 
   i:=i+1;
  if(i<=N) then 
    buscarPosCod:=i
  else 
    buscarPosCod:=0;   
end;

procedure inicializarFilaMatriz(matriz:TM;fila,M:byte);
var 
i:byte;
begin
  for i:=1 to M do 
   begin
     matriz[fila,i]:=0;
   end;
end;

procedure llenarDatos(var MatrizTiros:TM;var vecComp:TVR;var N,M:byte);
var
 arch:text; 
 cod:str3;
 lanzamiento,i:byte;
begin
  Assign(arch,'tiros.txt');
  reset(arch);
  N:=0;M:=10;
  while not eof(arch) do 
    begin
        ReadLn(arch,cod,lanzamiento);
        i:=buscarPosCod(vecComp,N,cod);
        if(i=0) then 
          begin
            N:=N+1;
            inicializarFilaMatriz(MatrizTiros,N,M);
            vecComp[N].codigo:=cod;
            vecComp[N].cantTiros:=1;
            MatrizTiros[N,1]:=lanzamiento;
          end
        else 
          begin
             vecComp[i].cantTiros:=vecComp[i].cantTiros+1;
             MatrizTiros[i,vecComp[i].cantTiros]:=lanzamiento;
          end;
    end;
    close(arch);
end;


function BuscarPosConMasTiros(VecComp:TVR;N:byte):byte;
var 
i,pos,maxTiros:byte;
begin
  maxTiros:=0;
  for i:=1 to N do  
    begin
      if(VecComp[i].cantTiros>maxTiros) then 
       begin
         maxTiros:=VecComp[i].cantTiros;
         pos:=i;
       end;
    end;
   BuscarPosConMasTiros:=pos; 
end;

function calcularPromedioRecursivo(Matriz:TM;i,j,CantTiros:byte):real;
begin
  if(j=1) then 
    calcularPromedioRecursivo:=matriz[i,j]/CantTiros
  else 
    calcularPromedioRecursivo:=(Matriz[i,j]/CantTiros)+calcularPromedioRecursivo(Matriz,i,j-1,CantTiros);  
end;


function buscarPosMinimaDistRecur(Matriz:TM;i,col:byte):byte;
var 
posMin:byte;
begin
  if(i>1) then 
    begin
       posMin:=buscarPosMinimaDistRecur(matriz,i-1,col);
       if(matriz[i,col]<matriz[posMin,col]) then 
         buscarPosMinimaDistRecur:=i
       else 
         buscarPosMinimaDistRecur:=posMin;
    end
  else 
    buscarPosMinimaDistRecur:=i;  
end;

procedure mostrarMatriz(MatrizTiros:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        Write(MatrizTiros[i,j],' ');
      end;
     WriteLn; 
   end;
end;

procedure GenerarArreglo(MatrizTiros:TM;VecComp:TVR;N,X:byte;var arreglo:TVC;var K:byte);
var
i,j,M:byte; 
begin
  K:=0;
  for i:=1 to N do 
   begin
     M:=VecComp[i].cantTiros;
     j:=1;
     while (j<=M) and (X>MatrizTiros[i,j]) do
      j:=j+1;
     if(j<=M) then 
       begin
         K:=K+1;
         arreglo[K]:=VecComp[i].codigo;
       end;
   end;
end;

procedure mostrarArreglo(arreglo:TVC;K:byte);
var 
i:byte;
begin
  for i:=1 to K do 
   begin
     WriteLn(arreglo[i]);
   end;
end;

var 
MatrizTiros:TM;
VecComp:TVR;
N,M,K,posMaxTiros,posMinimaDist,X:byte;
ArregloGenerado:TVC;

begin
  llenarDatos(MatrizTiros,VecComp,N,M);
  mostrarMatriz(MatrizTiros,N,M);
  //a) Promedio de distancia del competidor con mayor cantidad de lanzamientos realizados (suponer único).
  posMaxTiros:=BuscarPosConMasTiros(VecComp,N);
  WriteLn('El promedio del jugador con mas tiros es: ',calcularPromedioRecursivo(MatrizTiros,posMaxTiros,VecComp[posMaxTiros].cantTiros,VecComp[posMaxTiros].cantTiros):6:2);
  //b) Menor marca obtenida en el primer lanzamiento
  posMinimaDist:=buscarPosMinimaDistRecur(MatrizTiros,N,1);
  WriteLn('La menor marca obtenida en el primer lanzamiento fue: ',MatrizTiros[posMinimaDist,1]);
  //) Generar un arreglo con los competidores que superaron la distancia X (ingresada por teclado) en algún lanzamiento. Mostrar el arreglo generado.
  WriteLn('Ingrese la distancia a superar');
  ReadLn(X);
  GenerarArreglo(MatrizTiros,VecComp,N,X,ArregloGenerado,K);
  mostrarArreglo(ArregloGenerado,K);
end.