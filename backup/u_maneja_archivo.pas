unit u_maneja_archivo;
{$codepage utf8}
interface

uses u_archivo,u_registros, crt;

procedure lee_archivo(var arch:t_archivo; pos:cardinal; var r:t_dato_registro);
procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato_registro);
procedure listado(var arch:t_archivo);
procedure altas(var arch:t_archivo);

implementation
procedure lee_archivo(var arch:t_archivo; pos:cardinal; var r:t_dato_registro);  //para mostrar los valores
begin
seek(arch, pos);
read(arch, r);
end;

procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato_registro);   //para guardar los valores en el archivo
begin
seek(arch, pos);
write(arch, r);
end;
procedure altas (var arch:t_archivo);                           //para ingresar valores, utiliza procedure carga_r y procedure guarda_r
var
r:t_dato_registro;
pos:cardinal;
respuesta:integer;
begin
     clrscr;
     gotoxy(45,11);
     write('*******ALTAS******') ;
     gotoxy(45,12);
     write('Ingresa? Presione 0 para salir: ') ;
     readln (respuesta);
     while respuesta <> 0 do
     begin
          cargar(r);                                              //procedure carga_r(var r: t_dato);
          r.numero_consulta:=filesize(arch);
          pos:=filesize(arch);                                    //hace que pos sea la ult posicion disponible
          guarda_archivo(arch, pos,r);                            //procedure guarda_r(var arch:t_archivo; var pos:cardinal; r:t_dato)
          gotoxy(55,25);
          writeln('Ingresa? presione 0 para salir: ') ;
          readln (respuesta);
     end;
     clrscr;
end;

procedure listado (var arch:t_archivo);
var
r:t_dato_registro;
i:cardinal;
begin
clrscr;
gotoxy(45,10);
write('*******listado******') ;
for i:= 0 to filesize(arch)-1 do
begin
lee_archivo(arch,i,r);                                      //seek(arch,pos); read(arch, r);
mostrar(r);
readkey;
clrscr;
end;
end;
end.
