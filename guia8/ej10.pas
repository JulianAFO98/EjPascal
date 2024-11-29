{Dado dos arreglos de enteros A y B ordenados ascendentemente, realizar un algoritmo
recursivo que mezcle ambos arreglos en otro C manteniendo el orden. Cada arreglo no tiene valores
repetidos. Si un valor aparece en ambos arreglos, debe pasar a C uno solo. }
program ej10;
type
TV = array[1..5] of byte;
TV2 = array[1..255] of byte;

procedure FusionRecursiva(VecA:TV;i,A:byte;VecB:TV;j,B:byte;var VecC:TV2;var C:byte);
begin
  
  if(i<A) and (j<B) then 
    begin
      C:=C+1;
      if(VecA[i]=VecB[j]) then 
        begin
         VecC[C]:=VecA[i];
         FusionRecursiva(VecA,i+1,A,VecB,j+1,B,VecC,C);
        end
      else 
        begin
          if(VecA[i]<VecB[j]) then 
           begin
             VecC[C]:=VecA[i];
             FusionRecursiva(VecA,i+1,A,VecB,j,B,VecC,C);
           end
          else 
            begin
              VecC[C]:=VecB[j];
              FusionRecursiva(VecA,i,A,VecB,j+1,B,VecC,C);
            end;  
        end;  
    end
    else 
     begin
       if (i=A) and (j<=B) then
        begin
            C:=C+1;
            VecC[C]:=VecB[j];
            FusionRecursiva(VecA,i,A,VecB,j+1,B,VecC,C);
        end
       else 
        if (j=B) and (i<=A) then 
          begin
             C:=C+1;
             VecC[C]:=VecA[i];
             FusionRecursiva(VecA,i+1,A,VecB,j,B,VecC,C);
         end;
     end;
end;

procedure mostrarVec(Vec:TV2;C:byte);
var 
i:byte;
begin
  for i:=1 to C do 
   begin
     Write(Vec[i],' ');
   end;
end;


const 
VecA :TV = (1,5,6,7,8);
VecB :TV = (3,4,5,10,11);
A = 5;
B = 5;
var 
VecC:TV2;
C:byte;
begin
  C:=0;
  FusionRecursiva(VecA,1,A,VecB,1,B,VecC,C);
  mostrarVec(VecC,C);
end.