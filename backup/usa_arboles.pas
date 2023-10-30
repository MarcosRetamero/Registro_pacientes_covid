unit usa_arboles;
{$codepage utf8}
interface
uses crt,u_arboles;
Procedure agregar_nodo(var raiz:t_punt);
Procedure muestra_datos(pos:t_punt);
Procedure cargar_arbol(var raiz:t_punt);
Procedure consulta(raiz:t_punt);
Procedure buscar(raiz:t_punt);
Procedure listar(raiz:t_punt);
Function preorden(raiz:t_punt;buscado:t_dato):t_punt;
Procedure inorden(var raiz:t_punt);
implementation

Procedure agregar_nodo(var raiz:t_punt);
Var
   Car:char;
   x:t_dato;
Begin
  clrscr;
  Write('Ingrese dato: ');
  Readln(car);
  agregar(raiz,car);
end;

Procedure muestra_datos(pos:t_punt);
begin
  writeln(pos^.info);
end;

Procedure consulta(raiz:t_punt);
Var pos:t_punt;
   respuesta:t_dato;
Begin
  Write('Buscar: ');
  Readln(respuesta);
  Pos:=preorden(raiz,respuesta);
  If pos = nil then writeln('No se encuentra')
     else muestra_datos(pos);
end;
Procedure buscar(raiz:t_punt);
begin
  if arbol_vacio(raiz) then write ('arbol vacío')
  else consulta(raiz);
  readkey;
end;
Procedure listar(raiz:t_punt);
Begin
  if not arbol_vacio (raiz) then inorden (raiz)
  else writeln('Árbol vacío');
  Readkey;
end;
Function preorden(raiz:t_punt;buscado:t_dato):t_punt;
Begin
  if (raiz = nil) then preorden:=nil
     else
       if (raiz^.info = buscado) then
                        preorden:=raiz
                        else if raiz^.info > buscado then
                             preorden:=preorden(raiz^.sai,buscado)
                             else
                               preorden:=preorden(raiz^.sad,buscado);
end;
Procedure inorden(var raiz:t_punt);
Begin
  If raiz<> nil then begin
                     inorden(raiz^.sai);
                     Writeln(raiz^.info);
                     inorden(raiz^.sad);
  end;
end;


end.

