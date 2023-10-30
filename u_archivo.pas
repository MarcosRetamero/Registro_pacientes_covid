Unit u_archivo;
{$codepage utf8}
Interface
uses u_registros;
Const
Ruta = 'tp_final_personas.dat';
Ruta2 = 'tp_final_sintomas.dat';

Type
t_archivo = file of t_dato_registro;
t_archivo_sintomas = file of registro_sintomas;


Procedure crear(var arch:t_archivo);
Procedure abrir(var arch:t_archivo);
Procedure cerrar(var arch:t_archivo);

Procedure crear(var arch_sintomas:t_archivo_sintomas);
Procedure abrir(var arch_sintomas:t_archivo_sintomas);
Procedure cerrar(var arch_sintomas:t_archivo_sintomas);

Implementation
Procedure crear(var arch:t_archivo);
begin
  assign(arch,ruta);
  rewrite(arch);
 end;

Procedure abrir(var arch:t_archivo);
 begin
   assign(arch,ruta);
{$I-}
reset(arch);
{$I+}
if IOResult  <> 0 then
  rewrite(arch);
 end;

Procedure cerrar(var arch:t_archivo);
 begin
  close(arch);
 end;

Procedure crear(var arch_sintomas:t_archivo_sintomas);
begin
  assign(arch_sintomas,ruta2);
  rewrite(arch_sintomas);
 end;

Procedure abrir(var arch_sintomas:t_archivo_sintomas);
 begin

  assign(arch_sintomas,ruta2);
  {$I-}
  reset(arch_sintomas);
  {$I+}
  if IOResult  <> 0 then
      rewrite(arch_sintomas);

 end;

Procedure cerrar(var arch_sintomas:t_archivo_sintomas);
 begin
  close(arch_sintomas);
 end;
end.

