unit u_maneja_archivo;
{$codepage utf8}
interface

uses u_archivo,u_registros, crt;

procedure lee_archivo(var arch:t_archivo; pos:cardinal; var r:t_dato);
procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato);
procedure carga_archivo(var r: t_dato);
procedure listado(var arch:t_archivo);
procedure altas(var arch:t_archivo);

implementation

procedure lee_r(var arch:t_archivo; pos:cardinal; var r:t_dato);  //para mostrar los valores
begin
seek(arch, pos);
read(arch, r);
end;

procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato);   //para guardar los valores en el archivo
begin
seek(arch, pos);
write(arch, r);
end;

procedure carga_archivo(var r: t_dato);                              //para llenar los registros
begin
     cargar(r);
     guarda_archivo(arch,pos,r);
end;

procedure altas (var arch:t_archivo);                           //para ingresar valores, utiliza procedure carga_r y procedure guarda_r
var
r:t_dato;
pos:cardinal;
resp:string[1];
begin
clrscr;
gotoxy(45,10);
write('*******altas******') ;
gotoxy(45,12);
write('ingresa? presione n para salir: ') ;
readln (resp);
while resp <> '0' do
begin
carga_r(r);                                             //procedure carga_r(var r: t_dato);
pos:=filesize(arch);                                    //hace que pos sea la ult posicion disponible
guarda_r(arch, pos,r);                                  //procedure guarda_r(var arch:t_archivo; var pos:cardinal; r:t_dato);
  if filesize(arch)>1 then
   burbuja1(arch);
clrscr;
gotoxy(55,25);
writeln('ingresa? presione 0 para salir: ') ;
readln (resp);
end;
end;

procedure listado (var arch:t_archivo);
var
r:t_dato;
i:cardinal;
begin
clrscr;
gotoxy(45,10);
write('*******listado******') ;
for i:= 0 to filesize(arch)-1 do
begin
lee_r (arch,i,r);                                      //seek(arch,pos); read(arch, r);
gotoxy(45,12);
writeln('nombre: ',r.nombre);
gotoxy(45,14);
write('telefono: ',r.tel);
gotoxy(45,16);
write('numero de consulta: ',r.n_consulta);
readkey;
clrscr;
end;
end;





end.
