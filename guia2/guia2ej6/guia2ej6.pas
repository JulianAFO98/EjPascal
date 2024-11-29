{) Dadas tres letras mostrarlas ordenadas en forma ascendente. Plantear tres soluciones:
a) Alternativas secuenciales
b) Alternativas anidadas con expresiones lógicas compuestas
c) Alternativas anidadas con expresiones lógicas simples 
}


program guia2ej6;

var
l1,l2,l3,aux:char;
begin
  l1:='z';l2:='b';l3:='a';
  //a)
  if  l1>l2 then
   begin
    aux := l1;
    l1:=l2;
    l2:=aux;
   end;
 if  l2>l3 then
   begin
    aux := l2;
    l2:=l3;
    l3:=aux;
   end; 
 if  l1>l2 then
   begin
    aux := l1;
    l1:=l2;
    l2:=aux;
   end;
  WriteLn(l1,l2,l3);

  //b)
   l1:='z';l2:='b';l3:='a';
  if(l1>l2) and (l1>l3) then
    begin
      if(l2>l3)then
        WriteLn(l3,l2,l1)
      else 
        WriteLn(l2,l3,l1); 
    end
  else 
    begin
       if(l2>l3) and (l2>l1) then
         begin
           if(l1>l3)then
             WriteLn(l3,l1,l2)
           else 
             WriteLn(l1,l3,l2); 
         end
        else 
         begin
          if(l2>l1)then
             WriteLn(l1,l2,l3)
           else 
             WriteLn(l2,l1,l3); 
             
         end; 
    end;
   //c)
    l1:='z';l2:='b';l3:='a';
    if(l1>l2) then
      begin
        if(l1>l3) then
          begin
            if(l2>l3)then
        WriteLn(l3,l2,l1)
      else 
        WriteLn(l2,l3,l1); 
          end;
      end
    else 
       begin
            if(l2>l3)  then
             begin
               if (l2>l1) then
               if(l1>l3)then
             WriteLn(l3,l1,l2)
           else 
             WriteLn(l1,l3,l2);  
             end
            else 
              begin
                if(l2>l1)then
             WriteLn(l1,l2,l3)
           else 
             WriteLn(l2,l1,l3);  
             
              end; 
           


       end;  

end.