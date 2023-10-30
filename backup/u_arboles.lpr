program u_arboles;
Interface

Uses crt;
Type
t_dato = record
           clave:string[40];
           pos_arch:byte;
          end;

t_punt = ^t_nodo;

t_nodo = record
           info:t_dato;
           sai,sad: t_punt;
         END;

 PROCEDURE CREAR_ARBOL (VAR RAIZ:T_PUNT);
 PROCEDURE AGREGAR (VAR RAIZ:T_PUNT; X:T_DATO);
 FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
 FUNCTION ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;

implementation
procedure crear_arbol(var raiz:t_punt);
begin
    raiz:= nil;
end;
Procedure agregar(var raiz:t_punt; x:t_dato);
  begin
        if raiz = nil then
                            begin
                            new (raiz);
                            raiz^.info:= x;
                            raiz^.sai:= nil;
                            raiz^.sad:= nil;
                            end
                    else   IF RAIZ^.INFO > X THEN AGREGAR (RAIZ^.SAI,X)
                                             ELSE AGREGAR (RAIZ^.SAD,X)

   END;

 FUNCTION ARBOL_VACIO (RAIZ:T_PUNT): BOOLEAN;
   BEGIN
        ARBOL_VACIO:= RAIZ  = NIL;
   END;

 FUNCTION ARBOL_LLENO (RAIZ:T_PUNT): BOOLEAN;
    BEGIN
         ARBOL_LLENO:= GETHEAPSTATUS.TOTALFREE < SIZEOF (T_NODO);
    END;
end.

