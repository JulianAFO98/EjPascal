{En una matriz Tablero de 8x8 se almacenó una jugada de ajedrez. Además, se sabe la posición (i,j)
de una de las Torres Negras, y que juegan las negras. Determinar e informar a qué piezas “defiende” la
Torre y a cuáles “amenaza”, sabiendo que las piezas tienen dos atributos:
 Tipo: R = Rey, Q = Reina, A = Alfil, T = Torre, C = Caballo, P = Peón
 Color: 1 = Blanco, 2 = Negro
Nota: armar el Tablero leyendo desde archivo, donde en cada línea viene (fila, col, Tipo, Color)}
program ej2;
type
TRPieza = record 
  tipo:char;
  color:byte;
end; 
TM = array [1..8,1..8] of TRPieza;
TV = array [1..4] of TRPieza;

procedure llenarDatos(var tablero:TM;N:byte);
var 
 arch:text;
 fila,columna:byte;
 extra:char;
 pieza:TRPieza;
begin
  N:=8;
  Assign(arch,'jugada.txt');
  reset(arch);
  while not eof(arch) do 
    begin
      read(arch,fila,columna,extra);
      With pieza do 
      begin
        Read(arch,pieza.tipo);
        Read(arch,pieza.color);
        tablero[fila,columna]:=pieza;
      end;
      ReadLn(arch); 
    end;
   close(arch); 
end;


procedure inicializaTablero(var tablero:TM;var N:byte);
var 
 pieza:TRPieza;
 i,j:byte;
begin
  N:=8;
  pieza.tipo:='%';
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
       tablero[i,j]:=pieza;
      end;
   end;
end;


procedure mostrarTablero(tablero:TM;N:byte);
var 
 i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        if(tablero[i,j].tipo<>'%')then 
          Write(tablero[i,j].tipo,tablero[i,j].color,' ')
        else 
          Write('%  ');    
      end;
     WriteLn; 
   end;
end;

procedure AQuienAmenazaTorreN(tablero: TM; N, filaT, colT: byte);
var 
  Amenaza: TV;
  NA, i, j: byte;
begin
  NA := 0;  // Inicializa el contador de piezas amenazadas

  // Revisar hacia la derecha (misma fila, columna creciente)
  i := filaT; j := colT + 1;
  while (j <= N) and (tablero[i, j].tipo = '%') do
    j := j + 1;
  if (j <= N) and (tablero[i, j].color = 1) then
  begin
    NA := NA + 1;
    Amenaza[NA] := tablero[i, j];
  end;

  // Revisar hacia abajo (misma columna, fila creciente)
  i := filaT + 1; j := colT;
  while (i <= N) and (tablero[i, j].tipo = '%') do
    i := i + 1;
  if (i <= N) and (tablero[i, j].color = 1) then
  begin
    NA := NA + 1;
    Amenaza[NA] := tablero[i, j];
  end;

  // Revisar hacia arriba (misma columna, fila decreciente)
  i := filaT - 1; j := colT;
  while (i >= 1) and (tablero[i, j].tipo = '%') do
    i := i - 1;
  if (i >= 1) and (tablero[i, j].color = 1) then
  begin
    NA := NA + 1;
    Amenaza[NA] := tablero[i, j];
  end;

  // Revisar hacia la izquierda (misma fila, columna decreciente)
  i := filaT; j := colT - 1;
  while (j >= 1) and (tablero[i, j].tipo = '%') do
    j := j - 1;
  if (j >= 1) and (tablero[i, j].color = 1) then
  begin
    NA := NA + 1;
    Amenaza[NA] := tablero[i, j];
  end;

  // Mostrar las piezas amenazadas por la torre
  for i := 1 to NA do
    WriteLn('La torre amenaza a: ', Amenaza[i].tipo, ' de color ', Amenaza[i].color);
end;


procedure AQuienDefiendeTorreN


var 
tablero:TM;
N:byte;
begin
  inicializaTablero(tablero,N);
  llenarDatos(tablero,N);
  mostrarTablero(tablero,N);
  AQuienAmenazaTorreN(tablero,N,6,6);
  AQuienDefiendeTorreN(tablero,N,6,6);
end.