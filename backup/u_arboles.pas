unit u_arboles;
{$codepage utf8}
Interface
         Uses crt;
         Type
         t_dato = string[50];

         t_punt = ^t_nodo;

         t_nodo = record
                    info:t_dato;
                    pos_arch:integer;
                    sai,sad: t_punt;
                   END;

 procedure crear_arbol(var raiz:t_punt);
 Procedure agregar(var raiz:t_punt; x:t_dato; posicion:cardinal);
 function arbol_vacio(raiz:t_punt): boolean;
 function arbol_lleno(raiz:t_punt):boolean;

var raiz_nombres,raiz_dni:t_punt;

implementation
procedure crear_arbol(var raiz:t_punt);
begin
    raiz:= nil;
end;
Procedure agregar(var raiz:t_punt; x:t_dato; posicion:cardinal);
  begin
        if raiz = nil then
                            begin
                            new (raiz);
                            raiz^.info:= x;
                            raiz^.pos_arch:=posicion;
                            raiz^.sai:= nil;
                            raiz^.sad:= nil;
                            end
                    else   if raiz^.info > x then agregar (raiz^.sai,x,posicion)
                                             else agregar (raiz^.sad,x,posicion)

   end;
function arbol_vacio(raiz:t_punt): boolean;
   begin
        arbol_vacio:=raiz = nil;
   end;

function arbol_lleno(raiz:t_punt):boolean;
    begin
         arbol_lleno:= getheapstatus.totalfree < sizeof (t_nodo);
    end;
end.
