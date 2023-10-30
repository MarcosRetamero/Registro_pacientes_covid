unit Procesos;
{$codepage utf8}
interface

uses
  u_arboles,u_archivo,u_registros,crt;

procedure lee_archivo(var arch:t_archivo; pos:cardinal; var r:t_dato_registro);
procedure lee_archivo_2(var arch_sintomas:t_archivo_sintomas; pos:cardinal; var v:registro_sintomas);
procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato_registro);
procedure guarda_archivo_2(var arch_sintomas:t_archivo_sintomas; var pos:cardinal; v:registro_sintomas);   //para guardar los valores en el archivo
procedure listado (var arch_sintomas:t_archivo_sintomas; var arch:t_archivo;var raiz_dni:t_punt);
procedure pacientes (var arch:t_archivo);
procedure altas (var arch:t_archivo; var arch_sintomas:t_archivo_sintomas; var raiz_nombres:t_punt; var raiz_dni:t_punt);   //para ingresar valores, utiliza procedure carga_r y procedure guarda_r

Procedure muestra_datos(pos:t_punt; var arch:t_archivo);
Procedure consulta(raiz:t_punt; var arch:t_archivo);
Procedure buscar(var raiz_nombres:t_punt; var raiz_dni:t_punt; var arch:t_archivo);
//Procedure listar(raiz:t_punt; var arch:t_archivo);
Function preorden(raiz:t_punt;buscado:t_dato):t_punt;
Procedure inorden_dia_determinado(var raiz:t_punt; var arch:t_archivo; var arch_sintomas:t_archivo_sintomas; fecha_ingresada:string);
procedure inorden_positivos(var raiz:t_punt; var arch:t_archivo; var arch_sintomas:t_archivo_sintomas);
procedure indexar_nombres (var arch:t_archivo; var raiz_nombres:t_punt);
procedure indexar_dni (var arch:t_archivo; var raiz_dni:t_punt);

Procedure editar(var arch:t_archivo; var raiz_dni:t_punt; var r:t_dato_registro);
procedure alta_baja_logica (var arch:t_archivo; var raiz_dni:t_punt);
procedure llamados(var arch_sintomas:t_archivo_sintomas; var arch:t_archivo; var raiz_dni:t_punt);

procedure prueba_dias(var arch_sintomas:t_archivo_sintomas);
Procedure Consulta_Fechas (var arch_sintomas:t_archivo_sintomas;var v:registro_sintomas);
Procedure cantidad_positivos (var arch_sintomas:t_archivo_sintomas);
Procedure porcentajes_positivos (var arch_sintomas:t_archivo_sintomas);
Procedure Menor_25(var arch:t_archivo);
Procedure extranjeros (var arch:t_archivo);

procedure Detectar_covid(var v:registro_sintomas; var diagnostico:byte);
procedure diagnosticar (var arch_sintomas:t_archivo_sintomas; var arch:t_archivo; var raiz_dni:t_punt);
Procedure promedio_consultas_diarias(var arch_sintomas:t_archivo_sintomas);
implementation
procedure prueba_dias(var arch_sintomas:t_archivo_sintomas);
var v:registro_sintomas;
    u:cardinal;
    w:t_vector_sintomas;
    i,k:byte;
    begin
    clrscr;
    lee_archivo_2(arch_sintomas,u,v);
    for i:=1 to 14 do
      begin
        for k:=1 to 10 do
        begin
          writeln(k,': ',w[k]);
        end;
        writeln(i,': ', w[i]);
        readkey;
      end;
    end;
procedure lee_archivo(var arch:t_archivo; pos:cardinal; var r:t_dato_registro);  //para mostrar los valores
begin
     seek(arch, pos);
     read(arch, r);
end;
procedure lee_archivo_2(var arch_sintomas:t_archivo_sintomas; pos:cardinal; var v:registro_sintomas);  //para mostrar los valores
begin
     seek(arch_sintomas, pos);
     read(arch_sintomas, v);
end;

procedure guarda_archivo(var arch:t_archivo; var pos:cardinal; r:t_dato_registro);   //para guardar los valores en el archivo
begin
seek(arch, pos);
write(arch, r);
end;
procedure guarda_archivo_2(var arch_sintomas:t_archivo_sintomas; var pos:cardinal; v:registro_sintomas);   //para guardar los valores en el archivo
begin
seek(arch_sintomas, pos);
write(arch_sintomas, v);
end;
procedure altas (var arch:t_archivo; var arch_sintomas:t_archivo_sintomas; var raiz_nombres:t_punt; var raiz_dni:t_punt);              //para ingresar valores, utiliza procedure carga_r y procedure guarda_r
var
r:t_dato_registro;
v:registro_sintomas;
pos:cardinal;
respuesta:string;
begin
     clrscr;
     gotoxy(45,11);
     write('*******ALTAS******') ;
     gotoxy(45,12);
     write('Ingresa? Presione 0 para salir: ') ;
     readln (respuesta);
     while respuesta <> '0' do
     begin
          clrscr;
          //personas
          cargar(r);                                              //procedure carga_r(var r: t_dato);
          r.numero_consulta:=filesize(arch)+1;                    // El numero de consulta es la posicion del archivo
          pos:=filesize(arch);                                    //hace que pos sea la ult posicion disponible
          guarda_archivo(arch, pos,r);
          agregar(raiz_nombres,r.apellido,pos);
          agregar(raiz_dni,r.DNI,pos);                            //procedure guarda_r(var arch:t_archivo; var pos:cardinal; r:t_dato)
          //sintomas
          v.numero_consulta:=r.numero_consulta;
          v.confirmado:=false;
          cargar_2(v);
          guarda_archivo_2(arch_sintomas,pos,v);
          write('Ingresa? Presione 0 para salir: ') ;
          readln (respuesta);
     end;
 end;

procedure llamados(var arch_sintomas:t_archivo_sintomas; var arch:t_archivo; var raiz_dni:t_punt);
Var
   respuesta:t_dato;
   pos:t_punt;
   respuesta2:string[2];
   respuesta3:string;
   i:cardinal;
   v:registro_sintomas;
   u:t_vector_sintomas;
begin
Write('Ingresa? Presione 0 para salir');
Readln(respuesta3);
While respuesta3 <> '0' do
    Begin
         Write('Buscar por DNI: ');
         Readln(respuesta);
         Pos:=preorden(raiz_dni,respuesta);
         If pos = nil then
         begin
           writeln('No se encuentra');
           readkey;
         end
         else
             begin
                 muestra_datos(pos,arch);
                 i:=pos^.pos_arch;
                 Writeln('Son estos los datos que desea modificar?');
                 Readln(respuesta2);
                 If upcase(respuesta2) = 'SI' then
                  begin
                         lee_archivo_2(arch_sintomas,i,v);
                         dias(v);
                         guarda_archivo_2(arch_sintomas,i,v);
                  end;
             end;
    Write('Ingresa? Presione 0 para salir');
    Readln(respuesta3);
    end;
end;

procedure listado (var arch_sintomas:t_archivo_sintomas; var arch:t_archivo;var raiz_dni:t_punt);
var
   v:registro_sintomas;
   u:s_vector;
   i:cardinal;
   a:t_dato_registro;
   respuesta:t_dato;
   pos:t_punt;
   r:t_dato_registro;
begin
     clrscr;
     Writeln('Buscar por DNI: ');
         Readln(respuesta);
         Pos:=preorden(raiz_dni,respuesta);
         If pos = nil then
         begin
           writeln('No se encuentra');
           readkey;
         end
         else
             begin
             i:=pos^.pos_arch;
              lee_archivo_2(arch_sintomas,i,v);                                  //seek(arch,pos); read(arch, r);
              lee_archivo(arch,i,r);
              u:=v.v_seguimiento;
              a:=r;
              mostrar_2(u,a);
              readkey;
              end
end;
procedure pacientes (var arch:t_archivo);
var
   r:t_dato_registro;
   i:cardinal;
begin
     clrscr;
     gotoxy(45,10);
     write('***LISTADO**') ;
     for i:= 0 to filesize(arch)-1 do
         begin
              lee_archivo(arch,i,r);                                  //seek(arch,pos); read(arch, r);
              mostrar(r);
         end;
     clrscr;
end;
Procedure muestra_datos(pos:t_punt; var arch:t_archivo);
var i:cardinal;
   r:t_dato_registro;
begin
  i:=pos^.pos_arch;
  lee_archivo(arch,i,r);
  mostrar(r);
end;

Procedure consulta(raiz:t_punt; var arch:t_archivo);
Var pos:t_punt;
   respuesta:t_dato;
Begin
  Write('Buscar: ');
  Readln(respuesta);
  Pos:=preorden(raiz,respuesta);
  If pos = nil then writeln('No se encuentra')
     else muestra_datos(pos,arch);
end;
Procedure buscar(var raiz_nombres:t_punt; var raiz_dni:t_punt; var arch:t_archivo);
var respuesta:string;
begin
clrscr;
writeln('Buscar por: 1)Apellido.');
Writeln('            2)DNI.');
readln(respuesta);
case respuesta of
  '1': begin
      if arbol_vacio(raiz_nombres) then write ('SIN DATOS')
      else consulta(raiz_nombres,arch);
      readkey;
     end;

  '2': begin
      if arbol_vacio(raiz_dni) then write ('SIN DATOS')
      else consulta(raiz_dni,arch);
      readkey;
     end;

   end;
 end;
{Procedure listar(raiz:t_punt; var arch:t_archivo);
Begin
  if not arbol_vacio (raiz) then inorden(raiz,arch)
  else writeln('Árbol vacío');
  Readkey;
end; }
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

procedure inorden_positivos(var raiz:t_punt; var arch:t_archivo; var arch_sintomas:t_archivo_sintomas);
var i:cardinal;
   r:t_dato_registro;
   v:registro_sintomas;
Begin
  If raiz<> nil then begin
                     inorden_positivos(raiz^.sai,arch,arch_sintomas);

                     i:=raiz^.pos_arch;
                     lee_archivo(arch,i,r);
                     lee_archivo_2(arch_sintomas,i,v);
                     if v.confirmado = true then
                       begin
                         writeln(r.apellido);
                         writeln(r.nombres);
                       readkey
                       end;
                     inorden_positivos(raiz^.sad,arch,arch_sintomas);
  end;
end;

Procedure inorden_dia_determinado(var raiz:t_punt; var arch:t_archivo; var arch_sintomas:t_archivo_sintomas; fecha_ingresada:string);
var i:cardinal;
   r:t_dato_registro;
   v:registro_sintomas;
Begin
  If raiz<> nil then begin
                     inorden_dia_determinado(raiz^.sai,arch,arch_sintomas,fecha_ingresada);

                     i:=raiz^.pos_arch;
                     lee_archivo(arch,i,r);
                     lee_archivo_2(arch_sintomas,i,v);
                     if v.fecha = fecha_ingresada then
                     writeln(r.apellido);
                     writeln(r.apellido);
                     writeln(r.nombres);
                     readkey;
                     inorden_dia_determinado(raiz^.sad,arch,arch_sintomas,fecha_ingresada);
  end;
end;



procedure indexar_nombres (var arch:t_archivo; var raiz_nombres:t_punt);
var
r:t_dato_registro;
nombre:t_dato;
i:cardinal;
begin
for i:= 0 to filesize(arch)-1 do
begin
lee_archivo(arch,i,r);
nombre:=r.apellido;
agregar(raiz_nombres,nombre,i);
end;
end;

procedure indexar_dni (var arch:t_archivo; var raiz_dni:t_punt);
var
r:t_dato_registro;
dni:t_dato;
i:cardinal;
begin
for i:= 0 to filesize(arch)-1 do
begin
lee_archivo(arch,i,r);
dni:=r.DNI;
agregar(raiz_dni,dni,i);
end;
end;
Procedure editar(var arch:t_archivo; var raiz_dni:t_punt; var r:t_dato_registro);
Var
   respuesta,respuesta2,respuesta3:string;
   pos:t_punt;
   i:cardinal;

begin
Write('Ingresa? Presione 0 para salir');
Readln(respuesta3);
While respuesta3 <> '0' do
Begin
     Write('Buscar por DNI: ');
     Readln(respuesta);
     Pos:=preorden(raiz_dni,respuesta);
     If pos = nil then writeln('No se encuentra')
        else
        begin
             muestra_datos(pos,arch);
             Writeln('Son estos los datos que desea modificar?');
             Readln(respuesta2);
             If upcase(respuesta2) = 'SI' then
             i:=pos^.pos_arch;
             lee_archivo(arch,i,r);
                Writeln('Indique el campo que desea modificar');
                readln(respuesta);
                Case respuesta of
                  '1':Begin
                         Writeln('Apellido.');
                         Readln(r.apellido);
                  end;
                  '2':Begin
                         Writeln('Nombre/s.');
                         Readln(r.nombres);
                  end;
                  '3':Begin
                         Writeln('Dirección.');
                         Readln(r.direccion);
                  end;
                  '4':Begin
                         Writeln('Ciudad.');
                         Readln(r.ciudad);
                  end;
                  '5':Begin
                         Writeln('DNI.');
                         Readln(r.dni);
                  end;
                  '6':Begin
                         Writeln('Año de nacimiento.');
                         Readln(r.fecha_nacimiento.anio);
                         Writeln('Mes de nacimiento.');
                         Readln(r.fecha_nacimiento.mes);
                         Writeln('Día de nacimiento.');
                         Readln(r.fecha_nacimiento.dia);
                  end;
                  '7':Begin
                         Writeln('Teléfono.');
                         Readln(r.telefono);
                  end;
                end;

                guarda_archivo(arch,i,r);
             end;
     clrscr;
     Write('Ingresa? Presione 0 para salir.');
     Readln(respuesta3);
end;
end;
procedure alta_baja_logica (var arch:t_archivo; var raiz_dni:t_punt);
var respuesta,respuesta2,respuesta3:string;
    r:t_dato_registro;
    pos:t_punt;
    i:cardinal;
begin
Write('Ingresa? Presione 0 para salir');
Readln(respuesta3);
While respuesta3 <> '0' do
Begin
  Write('Buscar por DNI: ');
  Readln(respuesta);
  Pos:=preorden(raiz_dni,respuesta);
  If pos = nil then writeln('No se encuentra')
     else
     begin
          muestra_datos(pos,arch);
          Writeln('Son estos los datos que desea modificar?');
          Readln(respuesta2);
          If upcase(respuesta2) = 'SI' then
             i:=pos^.pos_arch;
             lee_archivo(arch,i,r);
                              if r.estado=true then
                               begin
                                Writeln('Desea dar de baja? ');
                                  readln(respuesta);
                                  If upcase(respuesta) = 'SI' then
                                   begin
                                   r.estado:=false;
                                   end;
                                  end
                               else
                                   Writeln('Desea dar de alta? ');
                                   readln(respuesta);
                                   respuesta:=upcase(respuesta);
                                     If respuesta = 'SI' then
                                     begin
                                      r.estado:=true;
                                     end;



                             guarda_archivo(arch,i,r);
          end;
  clrscr;
  Write('Ingresa? Presione 0 para salir.');
  Readln(respuesta3);
end;
end;
Procedure Consulta_Fechas (var arch_sintomas:t_archivo_sintomas;var v:registro_sintomas);
var
    fecha1,fecha2:string[10];
    cont:byte;
begin
     cont:=0;
     clrscr;
     Writeln('Ingrese la primera fecha (aaaa/mm/dd)');
     readln(fecha1);
     Writeln('Ingrese la segunda fecha (aaaa/mm/dd)');
     readln(fecha2);
     clrscr;
     seek(arch_sintomas,0);
     while not EOF(arch_sintomas) do
           begin
                read(arch_sintomas,v);
                if ((fecha1<=v.fecha) AND (v.fecha<=fecha2)) then cont:=cont+1;
           end;
     writeln('La cantidad de consultas entre las fechas: ',fecha1, ' y ',fecha2,' es de: ',cont);
     readkey;
end;
Procedure cantidad_positivos (var arch_sintomas:t_archivo_sintomas);
var
    contador_positivos,contador_negativos:byte;
    v:registro_sintomas;
begin
     contador_positivos:=0;
     contador_negativos:=0;
     clrscr;
     seek(arch_sintomas,0);
     while not EOF(arch_sintomas) do
           begin
                read(arch_sintomas,v);
                if v.confirmado=true then
                 begin
                  contador_positivos:=contador_positivos+1;
                 end
                else
                 contador_negativos:=contador_negativos+1;
           end;
     writeln('La cantidad de pacientes positivos es: ',contador_positivos);
     writeln('La cantidad de pacientes negativos es: ',contador_negativos);
     readkey;
end;
Procedure porcentajes_positivos (var arch_sintomas:t_archivo_sintomas);
var
    contador_positivos,contador_negativos:byte;
    porcentaje_total,parcial_negativos,parcial_positivos:real;
    v:registro_sintomas;
begin
     contador_positivos:=0;
     contador_negativos:=0;
     clrscr;
     seek(arch_sintomas,0);
     while not EOF(arch_sintomas) do
           begin
                read(arch_sintomas,v);
                if v.confirmado=true then
                 begin
                  contador_positivos:=contador_positivos+1;
                 end
                else
                 contador_negativos:=contador_negativos+1;
           end;
     porcentaje_total:= contador_positivos+contador_negativos;
     parcial_negativos:=((contador_negativos*100)/porcentaje_total);
     parcial_positivos:=((contador_positivos*100)/porcentaje_total);
     writeln('El porcentaje de positivos es: ',parcial_positivos:2:0,'%');
     writeln('El porcentaje de negativos es: ',parcial_negativos:2:0,'%');
     readkey;
end;
Procedure Menor_25(var arch:t_archivo);
var
    fecha1:integer;
    fecha2:integer;
    fecha3:integer;
    fecha4:integer;
    fecha_total,porcentaje:real;
    pos:cardinal;
    contador_menor_25,contador_personas:integer;
    r:t_dato_registro;
    Begin
         fecha1:=0;
         fecha2:=0;
         fecha3:=0;
         fecha4:=0;
         fecha_total:=0;
         contador_personas:=0;
         contador_menor_25:=0;
         seek(arch,0);
              while not EOF(arch) do
                    begin
                         read(arch,r);
                         fecha1:=((2021-r.fecha_nacimiento.anio)*365);
                         contador_personas:=contador_personas+1;
                         If r.fecha_nacimiento.mes = 1 or 3 or 5 or 7 or 8 or 10 or 12 then
                          begin
                          fecha2:=r.fecha_nacimiento.mes*31;
                          end
                          else
                              if r.fecha_nacimiento.mes = 2 then
                               begin
                               fecha2:=r.fecha_nacimiento.mes*28;
                               end
                         else
                         begin
                         fecha2:=r.fecha_nacimiento.mes*30;
                         end;
                         fecha3:=r.fecha_nacimiento.dia;
                         fecha4:=fecha1+fecha2+fecha3;
                         fecha_total:=fecha4 / 365;
                         If fecha_total <= 25 then
                          contador_menor_25:=contador_menor_25 + 1;
                    end;
              porcentaje:=((contador_menor_25*100)/contador_personas);
         Writeln('El porcentaje de confirmados menores que 25 es: ', porcentaje:2:0,'%');
         readkey;
end;
Procedure extranjeros (var arch:t_archivo);
Var
    ciudades_cercanas,consultas_totales:integer;
    porcentaje:real;
    r:t_dato_registro;
begin
consultas_totales:=0;
ciudades_cercanas:=0;
     seek(arch,0);
      while not EOF(arch) do
                    begin
                         read(arch,r);
                         consultas_totales:=consultas_totales+1;
                         If (upcase(r.ciudad)<>'GUALEGUAYCHU') then
                          begin
                            ciudades_cercanas:=ciudades_cercanas+1;
                          end;
      end;
     porcentaje:=((ciudades_cercanas*100)/consultas_totales);
     Writeln('El porcentaje de consultas de lugares vecinos es de: ',trunc(porcentaje),'%');
     readkey;
end;
procedure Detectar_covid(var u:s_vector; var r:t_dato_registro; var diagnostico:byte);
var
  i,k,respuesta,dia_de_diagnostico:byte;
  vector:t_vector_sintomas;
  sintoma_positivo,sintoma_negativo:integer;
begin
     sintoma_positivo:=0;
     sintoma_negativo:=0;
     writeln('Ingrese el dia [1,14] del que desea hacer un diagnostico: ');
     readln(dia_de_diagnostico);
     k:=dia_de_diagnostico;
     vector:=u[k];
     clrscr;
     for i:=2 to 11 do
         begin
           if vector[i] = 1 then
            begin
              sintoma_positivo:=sintoma_positivo+1;
            end
           else
            if vector[i] = 0 then
             begin
              sintoma_negativo:=sintoma_negativo+1;
             end
         end;
      if (sintoma_positivo >= 3) then
       diagnostico:=1;

     end;
procedure Detectar_covid(var v:registro_sintomas; var diagnostico:byte);
var
  i,k,respuesta,dia_de_diagnostico:byte;
  vector:t_vector_sintomas;
  sintoma_positivo,sintoma_negativo:byte;
begin
     sintoma_positivo:=0;
     sintoma_negativo:=0;
     writeln('Ingrese el dia [1,14] del que desea hacer un diagnostico: ');
     readln(dia_de_diagnostico);
     k:=dia_de_diagnostico;
     vector:=v.v_seguimiento[k];
     clrscr;
     for i:=2 to 11 do
         begin
           if vector[i] = 1 then
            begin
              sintoma_positivo:=sintoma_positivo+1
            end
           else
            if vector[i] = 0 then
             begin
              sintoma_negativo:=sintoma_negativo+1
             end
             end;
      if sintoma_positivo >= 3 then
       diagnostico:=1;

     end;
procedure diagnosticar (var arch_sintomas:t_archivo_sintomas; var arch:t_archivo; var raiz_dni:t_punt);
var
   v:registro_sintomas;
   u:s_vector;
   i:cardinal;
   respuesta:string;
   pos:t_punt;
   r:t_dato_registro;
   diagnostico:byte;
begin
     clrscr;
     diagnostico:=0;
     Writeln('Buscar por DNI: ');
     Readln(respuesta);
     Pos:=preorden(raiz_dni,respuesta);
           If pos = nil then
             begin
               writeln('No se encuentra');
               readkey;
             end
           else
             begin
             i:=pos^.pos_arch;
             lee_archivo(arch,i,r);
             lee_archivo_2(arch_sintomas,i,v);                                      //seek(arch,pos); read(arch, r);
             Detectar_covid(v,diagnostico);
             if diagnostico = 1 then
              begin
                v.confirmado:=true;
                guarda_archivo_2(arch_sintomas,i,v);
              end
             else
              v.confirmado:=false;
              guarda_archivo_2(arch_sintomas,i,v);
              end;
writeln('El paciente: ',r.apellido,' tiene diagnostico de Covid-19: ',v.confirmado);
readkey;

end;

Procedure promedio_consultas_diarias(var arch_sintomas:t_archivo_sintomas);
Var
   contador_consulta,n:integer;


   v:registro_sintomas;
   promedio:real;

Begin
writeln('Ingrese el número días del que quiera obtener el promedio');
readln(n);
    contador_consulta:=0;

    promedio:=0;


    seek(arch_sintomas,0);
              while not EOF(arch_sintomas) do
                    begin
                         read(arch_sintomas,v);
                          contador_consulta:=contador_consulta+1;

                    end;
promedio:=((contador_consulta/n));
writeln('promedio de fechas diarias: ',promedio:2:0);
readkey;
end;

end.
