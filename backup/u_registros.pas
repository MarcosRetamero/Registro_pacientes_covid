unit u_registros;
{$codepage utf8}
interface
uses crt,dos;
Const
  c_nombres: array [1..11] of string =('','Fiebre?', 'Tos seca?', 'Cansancio?', 'Dolores musculares?', 'Dolor de garganta?', 'Dolor de cabeza?', 'Conjuntivitis?', 'Pérdida de gusto y olfato?', 'Dificultad para respirar?', 'Dolor o presión en el pecho?');
Type

    t_vector_sintomas = array[1..11] of shortint;          // vector que contiene los sintomas para el seguimiento

    s_vector = array[1..14] of t_vector_sintomas;    // este vector representa los 14 dias donde se almacenan los datos de seguimiento


    registro_sintomas = record                                   // el t_dato del archivo de sintomas
                               numero_consulta:integer;
                               fecha:string[10];                   //Registro
                               hora:string[5];
                               v_seguimiento: s_vector;          // el seguimientoooo
                               confirmado:boolean;
                        end;
    t_fecha=record
                               anio:integer;
                               mes:integer;
                               dia:integer;
    end;

    t_dato_registro= record
                    numero_consulta: integer;
                    apellido: string[40];
                    nombres: string[50];
                    direccion: string[40];
                    ciudad: string[40];
                    DNI: string[10];
                    fecha_nacimiento:t_fecha;
                    telefono: string[15];
                    estado:boolean;
                    end;
Procedure inicializar(var v:t_vector_sintomas);
procedure cargar(var r:t_dato_registro);
procedure mostrar(var r:t_dato_registro);
procedure mostrar_2(var u:s_vector; var r:t_dato_registro);
Procedure cargar_v(var vector:t_vector_sintomas);
procedure cargar_2(var v:registro_sintomas);
procedure dias(var v:registro_sintomas);

implementation
Procedure inicializar(var v:t_vector_sintomas);
Var i: integer;
    begin
         for i:=1 to 11 do
         begin
            v[i]:=-1;
         end;
    end;
procedure cargar_2(var v:registro_sintomas);
var vector: t_vector_sintomas;
    anio,mes,dia,wdia:word;
    anio2,mes2,dia2,wdia2:string;
    i:byte;
begin
  For i:= 1 to 14 do
   begin
     inicializar(v.v_seguimiento[i]);
   end;
     clrscr;
     getdate(anio,mes,dia,wdia);
     str(anio,anio2);
     str(mes,mes2);
     str(dia,dia2);
   v.fecha:=(anio2+'/'+mes2+'/'+dia2);
   {gotoxy(47,16);writeln('Fecha(aaaa/mm/dd): ');
   gotoxy(70,17);readln(v.fecha);}
     clrscr;
     for i:=2 to 11 do
         begin
              Gotoxy(27,4);Write('Ingrese 1 por positivo y 0 por negativo');
              gotoxy(27,6+(i*2));
              Write('¿Posee el síntoma ');
              gotoxy(45,6+(i*2));
              WRITE(c_nombres[i],'  ');
              gotoxy(85,6+(i*2));
              readln(v.v_seguimiento[1,i]);
         end;
     v.v_seguimiento[1,1]:=1;
     //v.v_seguimiento[1]:=vector;
     clrscr;
   end;

procedure cargar(var r:t_dato_registro);
begin
  clrscr;
  Gotoxy(47,12);Writeln('Apellido:');
  Gotoxy(70,12);Readln(r.apellido);
  Gotoxy(47,14);Writeln('Nombre/s:');
  Gotoxy(70,14);readln(r.nombres);
  Gotoxy(47,16);Writeln('Dirección:');
  Gotoxy(70,16);readln(r.direccion);
  Gotoxy(47,18);Writeln('Ciudad:');
  Gotoxy(70,18);readln(r.ciudad);
  Gotoxy(47,20);Writeln('DNI:');
  Gotoxy(70,20);readln(r.DNI);
  Gotoxy(47,22);Writeln('Año de nacimiento:');
  Gotoxy(70,22);readln(r.fecha_nacimiento.anio);
  Gotoxy(47,24);Writeln('Mes de nacimiento:');
  Gotoxy(70,24);readln(r.fecha_nacimiento.mes);
  Gotoxy(47,26);Writeln('Día de nacimiento:');
  Gotoxy(70,26);readln(r.fecha_nacimiento.dia);
  Gotoxy(47,28);Writeln('Teléfono:');
  Gotoxy(70,28);readln(r.telefono);
  r.estado:=true;
  clrscr;
end;
procedure mostrar(var r:t_dato_registro);
begin
  clrscr;
  writeln(r.numero_consulta);
  writeln('1)Apellido:             ',r.apellido);
  writeln('2)Nombre/s:             ',r.nombres);
  writeln('3)Dirección:            ',r.direccion);
  writeln('4)Ciudad:               ',r.ciudad);
  writeln('5)DNI:                  ',r.DNI);
  writeln('6)Fecha de nacimiento:  ',r.fecha_nacimiento.dia, '/',r.fecha_nacimiento.mes, '/',r.fecha_nacimiento.anio);
  writeln('7)Teléfono:             ',r.telefono);
  writeln('8)Estado:               ',r.estado);
  readkey;
end;

procedure mostrar_2(var u:s_vector; var r:t_dato_registro);
var
  i,k,respuesta:byte;
  vector:t_vector_sintomas;
begin
     gotoxy(55,8);Write('Escriba el día hasta el que quiera hacer el seguimiento.');
     gotoxy(55,9);Readln(respuesta);
     For k:=1 to respuesta do
     begin
     vector:=u[k];
     clrscr;
     gotoxy(101,10);Write('Día: ',k);
     gotoxy(64,10);Write('Paciente: ',r.apellido);
     gotoxy(64,11);Write('          ',r.nombres);
     gotoxy(64,12);Write('          ',r.DNI);
     Gotoxy(64,16);Write('Fiebre:');
     Gotoxy(64,17);Write('Tos seca:');
     Gotoxy(64,18);Write('Cansancio:');
     Gotoxy(64,19);Write('Dolores musculares:');
     Gotoxy(64,20);Write('Dolor de garganta:');
     Gotoxy(64,21);Write('Dolor de cabeza:');
     Gotoxy(64,22);Write('Conjuntivitis:');
     Gotoxy(64,23);Write('Pérdida de gusto y olfato:');
     Gotoxy(64,24);Write('Dificultad para respirar:');
     Gotoxy(64,25);Write('Dolor o presión en el pecho:');
     for i:=2 to 11 do
         begin
              Gotoxy(107,i+14);Write(vector[i]);
         end;
     readkey;
     end;
end;

Procedure cargar_v(var vector:t_vector_sintomas);                                         //Respuestas
 var
    I:byte;
begin

  FOR I:=2 TO 11 DO
   begin
   Gotoxy(27,4);Write('Ingrese 1 por positivo y 0 por negativo');
   gotoxy(27,6+(i*2));
   Write('¿Posee el síntoma ');
   gotoxy(45,6+(i*2));
   WRITE(c_nombres[i],'  ');
   gotoxy(85,6+(i*2));
   readln(vector[i]);
  end;
  vector[1]:=1;
  clrscr;

end;

{procedure dias(var v:registro_sintomas);
var i,u:byte;

begin
  i:=2;  // i es dias, empieza del 2
  u:=1;  // sintomas
  while (u <> 0) and (i <= 14) do
  begin
  u:=v.v_seguimiento[i,1];                         // V registro
  if (u<>0) and (u<>1) then u:=0;                  // U es el vector de bytes
  if u = 0 then
    begin
     clrscr;
     cargar_v(v.v_seguimiento[i]);
    end
  else
   if u = 1 then
     begin
      i:=i+1;
     end;
 end;
end;           }

procedure dias(var v:registro_sintomas);
var i,u:byte;

begin
  i:=2;  // i es dias, empieza del 2
  while (i <= 14) and (v.v_seguimiento[i,1]<>(-1)) do
        begin
             i:=i+1;
        end;
  If (i<=14) then
      begin
      clrscr;
      cargar_v(v.v_seguimiento[i]);
      end
      else
          Writeln('14 días llenos');
end;
end.

