unit u_menu;
{$codepage utf8}
Interface
         Uses crt,u_arboles,u_archivo,procesos,u_registros;
         procedure controlador;
         procedure menu1;
         Procedure usuario;
         Procedure menu_principal;
         Procedure estadisticas(var arch_sintomas:t_archivo_sintomas;var arch:t_archivo);
         Procedure listados(var arch_sintomas:t_archivo_sintomas;var arch:t_archivo;var raiz_nombres:t_punt);
Implementation
var
   nombre_usuario:string[50];
   DNI_usuario:string[15];
procedure controlador;

begin
     menu1;
     usuario;
     menu_principal;
end;
Procedure menu1;
Var
   i:integer;

Begin

     for i:=65 to 95 do
         begin
              gotoxy(i,13); Write('_');
              gotoxy(i,11); Write('_');
         end;
     for i:=8 to 14 do
         begin
              gotoxy(64,12); Write('|');
              gotoxy(64,13); Write('|');
              gotoxy(96,12); Write('|');
              gotoxy(96,13); Write('|');
         end;
     textcolor(yellow);
     gotoxy(50,8); Write('¡Bienvenido al programa de consultas telefónicas por COVID-19!');
     gotoxy(65,12); Write('Cargando');
     For i:=74 to 95 do
         begin
              gotoxy(i,12); Write('-');
              delay(150);
         end;
     For i:=45 to 90 do
         begin
              gotoxy(i,7);Write('_');
         end;
     clrscr;
end;
Procedure usuario;
begin
clrscr;
gotoxy(50,9);Write('Nombre y apellido: ');
Readln(nombre_usuario);
gotoxy(50,10);Write('Número de documento: ');
Readln(DNI_usuario);
clrscr;
end;
Procedure listados(var arch_sintomas:t_archivo_sintomas;var arch:t_archivo;var raiz_nombres:t_punt);
Var
   i:byte;
   respuesta:integer;
   fecha_ingresada:string;
   begin
   respuesta:=100;
   while (respuesta <> 0) do
   begin
   clrscr;
   textcolor(white);
   for i:=8 to 20 do                                                {columnas de |}
       begin
       gotoxy(64,i); Write('|');
       gotoxy(99,i); Write('|');
       end;
   for i:=65 to 98 do                                                  {filas de }
       begin
       gotoxy(i,7); Write('');
       gotoxy(i,18);Write('');
       gotoxy(i,9); Write('-');
       gotoxy(i,20); Write('');
       end;
   textcolor(green);
        gotoxy(2,1); Write('Datos del usuario actual:');
        gotoxy(2,2); Write('      -', nombre_usuario);
        gotoxy(2,3); Write('      -', DNI_usuario);
   textcolor(yellow);
        gotoxy(70,8);  Write('MENÚ LISTADOS');           {Opciones a elegir}
        gotoxy(66,10); Write('1)Pacientes positivos.');
        gotoxy(66,11); Write('2)Por fecha de consulta.');
        gotoxy(66,12); Write('3)De un dia determinado.');

        gotoxy(66,17); Write('0)Menú principal.');
        gotoxy(66,19); Write('Respuesta:');
        gotoxy(76,19); Readln(respuesta);
   case respuesta of
        1:begin
               inorden_positivos(raiz_nombres,arch,arch_sintomas);
          end;

        2:begin
               pacientes(arch);
          end;
        3:begin
           clrscr;
           writeln('Ingrese fecha: [aaaa/m/d]');
           readln(fecha_ingresada);
           inorden_dia_determinado(raiz_nombres,arch,arch_sintomas,fecha_ingresada);
          end;

   end;
end;
end;
Procedure estadisticas(var arch_sintomas:t_archivo_sintomas;var arch:t_archivo);
Var
   i:byte;
   respuesta:integer;
   r:registro_sintomas;
   begin
   respuesta:=100;
   while (respuesta <> 0) do
   begin
   clrscr;
   textcolor(white);
   for i:=8 to 20 do                                                {columnas de |}
       begin
       gotoxy(64,i); Write('|');
       gotoxy(99,i); Write('|');
       end;
   for i:=65 to 98 do                                                  {filas de }
       begin
       gotoxy(i,7); Write('');
       gotoxy(i,18);Write('');
       gotoxy(i,9); Write('-');
       gotoxy(i,20); Write('_');
       end;
   textcolor(green);
        gotoxy(2,1); Write('Datos del usuario actual:');
        gotoxy(2,2); Write('      -', nombre_usuario);
        gotoxy(2,3); Write('      -', DNI_usuario);
   textcolor(yellow);
        gotoxy(70,8);  Write('MENÚ ESTADÍSTICAS');           {Opciones a elegir}
        gotoxy(66,10); Write('1)Consulta entre fechas.');
        gotoxy(66,11); Write('2)Cantidad positivos y negativos.');
        gotoxy(66,12); Write('3)Porcentaje positivos y negativos.');
        gotoxy(66,13); Write('4)Porcentaje menores de 25.');
        gotoxy(66,14); Write('5)Porcentaje de no gualeguaychuenses.');
        gotoxy(66,15); Write('6)Promedio de consultas diarias.');
        gotoxy(66,17); Write('0)Menú principal.');
        gotoxy(66,19); Write('Respuesta:');
        gotoxy(76,19); Readln(respuesta);
   case respuesta of
        1:begin
               consulta_fechas(arch_sintomas,r);
          end;

        2:begin
               cantidad_positivos(arch_sintomas);
          end;
        3:begin
               porcentajes_positivos(arch_sintomas);
          end;
        4:begin
               menor_25(arch);
        end;
        5:begin
               extranjeros(arch);
        end;
        6:begin
        promedio_consultas_diarias(arch_sintomas);
        end;
   end;
end;
end;
Procedure menu_principal;
Var
   i,respuesta:integer;
   a:t_punt;
   arch:t_archivo;
   arch_sintomas:t_archivo_sintomas;
   raiz_nombres,raiz_dni:t_punt;
   r:t_dato_registro;
   fecha_ingresada:string;
Begin
    abrir(arch);
    abrir(arch_sintomas);
    crear_arbol(raiz_nombres);
    crear_arbol(raiz_dni);
    if filesize(arch)<>0 then
    begin
    indexar_nombres(arch,raiz_nombres);
    indexar_dni(arch,raiz_dni);
    end;

respuesta:=100;
while (respuesta <> 0) do
begin
clrscr;
textcolor(white);
for i:=8 to 26 do                                                {columnas de |}
    begin
    gotoxy(64,i); Write('|');
    gotoxy(95,i); Write('|');
    end;
for i:=65 to 94 do                                                  {filas de _}
    begin
    gotoxy(i,7); Write('_');
    gotoxy(i,24);Write('_');
    gotoxy(i,9); Write('-');
    gotoxy(i,26); Write('_');
    end;
textcolor(green);
     gotoxy(2,1); Write('Datos del usuario actual:');
     gotoxy(2,2); Write('      -', nombre_usuario);
     gotoxy(2,3); Write('      -', DNI_usuario);
textcolor(yellow);
     gotoxy(70,8);  Write('***MENÚ PRINCIPAL***');           {Opciones a elegir}
     gotoxy(66,10); Write('1)Recolección de datos.');
     gotoxy(66,11); Write('2)Listado de pacientes.');
     gotoxy(66,12); Write('3)Consulta.');
     gotoxy(66,13); Write('4)Modificar listado.');
     gotoxy(66,14); Write('5)Control de sintomas.');
     gotoxy(66,15); Write('6)Dar de alta o baja.');
     gotoxy(66,16); Write('7)Seguimiento día a día.');
     gotoxy(66,17); Write('8)Estadísticas.');
     gotoxy(66,18); Write('9)Diagnosticar.');
     gotoxy(66,19); Write('10)Listados.');
     gotoxy(66,22); Write('11)Cambio de usuario.');
     gotoxy(66,23); Write('0)Salir.');
     gotoxy(66,25); Write('Respuesta:');
     gotoxy(76,25); Readln(respuesta);
     Case respuesta of
       1:begin
              altas(arch,arch_sintomas,raiz_nombres,raiz_dni);
         end;

       2:begin
              pacientes(arch);
         end;
       3:begin
              buscar(raiz_nombres,raiz_dni,arch);
       end;

       4:begin
              editar(arch,raiz_dni,r);
         end;

       5:begin
              listado(arch_sintomas,arch,raiz_dni);
         end;

       6:begin
              alta_baja_logica(arch,raiz_dni);
         end;
       7:begin
              llamados(arch_sintomas,arch,raiz_dni);
         end;

       8:estadisticas(arch_sintomas,arch);
       9:begin
              diagnosticar(arch_sintomas,arch,raiz_dni);
       end;
       10:listados(arch_sintomas,arch,raiz_nombres);

       11:usuario;

       12:begin
       clrscr;
       writeln('Ingrese fecha: [aaaa/m/d]');
       readln(fecha_ingresada);
       inorden_dia_determinado(raiz_dni,arch,arch_sintomas,fecha_ingresada);
       end;

     end;
  end;
end;

END.

