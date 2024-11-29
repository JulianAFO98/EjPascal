(*Ej 3) En un archivo se almacenaron Y números enteros en cada línea. Cada lí
nea se cargará en una fila
de la matriz si cumple que el primero es divisor del último (el Y-ésimo).
Mostrar la matriz generada. La
dimensión será N x Y (N se debe calcular)*)

Program ej3_guia6;

Type 
  tm = array[1..100,1..100] Of integer;

Procedure cargamatriz(Var matriz:tm;Var n,m:byte);

Var 
  arch: text;
  j: byte;
Begin
  assign(arch,'ej3_guia6.txt');
  reset(arch);
  readln(arch,m);
  n := 0;
  While Not eof(arch) Do
    Begin
      n := n + 1;
      For j:= 1 To m Do
        Begin
          read(arch,matriz[n,j]);
        End;
      readln(arch);
    End;
  close(arch);
End;

Function condicion(matriz:tm; n,m:byte): boolean;

Var 
  i: byte;
Begin
  condicion := true;
  i := 1;
  While (i<=n) And (matriz[i,1] <> 0) And ((matriz[i,3] Mod matriz[i,1]) = 0) Do
    i := i +1;
  If i <= n Then
    condicion := false;

End;



Procedure muestramat(matriz:tm; n,m:byte);

Var 
  i,j: byte;
Begin
  If condicion(matriz,n,m) Then
    Begin
      For i:= 1 To n Do
        Begin
          For j:= 1 To m Do
            write(matriz[i,j]:5);
          writeln;
        End;
    End;
End;

Var 
  matriz: tm;
  n,m: byte;
Begin
  cargamatriz(matriz,n,m);
  muestramat(matriz,n,m);
End.