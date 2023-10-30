unit U_menu_principal;
interface
uses
  crt,u_menu;
Var
   nombre_usuario:string;
   DNI_usuario:integer;
Procedure menu_principal;
implementation
Procedure menu_principal;
Var
   i,respuesta:integer;
Begin
textcolor(white);
for i:=8 to 21 do                                                {columnas de |}
    begin
    gotoxy(64,i); write('|');
    gotoxy(95,i); write('|');
    end;
for i:=65 to 94 do                                                  {filas de _}
    begin
    gotoxy(i,7);write('_');
    gotoxy(i,19);write('_');
    gotoxy(i,9); write('-');
    gotoxy(i,21); Write('_');
    end;
textcolor(green);
     gotoxy(2,1); Write('Datos del usuario actual:');
     gotoxy(2,2); Write('      -', nombre_usuario);
     gotoxy(2,3); Write('      -', DNI_usuario);
textcolor(yellow);
     gotoxy(70,8);  Write('***MENÚ PRINCIPAL***');           {Opciones a elegir}
     gotoxy(66,10); Write('1)Recolección de datos.');
     gotoxy(66,11); Write('2)Listado de pacientes.');
     gotoxy(66,12); Write('3)Consulta entre dos fechas.');
     gotoxy(66,13); Write('4)Porcentajes.');
     gotoxy(66,14); Write('5)Curva de contagios.');
     gotoxy(66,17); Write('6)Cambiar de usuario.');
     gotoxy(66,18); Write('0)Salir.');
     gotoxy(66,20); Write('Respuesta:');
     gotoxy(76,20); Read(respuesta);
while respuesta <> 0 do
  begin
       Case respuesta of
       {1: Begin
               inicializar(r);
          end;
       2: cargar(r);
       3: mostrar(r);}
       6: usuario;
       end;
       menu_principal;
  end;
end;
end.
