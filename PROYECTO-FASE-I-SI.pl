% =========================

%pie plano zapato:
zapato('Asics Gel Kayano 28', plano, deportivo, azul, unisex, 230, 'Estabilidad mejorada y gran absorcion de impacto').
zapato('Nike Revolution 5', plano, casual, negro, hombre, 150, 'Comodidad y soporte para uso diario').
zapato('Adidas Adizero Pro', plano, formal, blanco, mujer, 200, 'Ligereza y elegancia para ocasiones formales').
zapato('Salomon X Ultra 4', plano, senderismo, marron, unisex, 250, 'Traccion avanzada para terrenos dificiles').
zapato('Brooks Addiction Walker', plano, casual, gris, mujer, 180, 'Soporte optimo para pie plano').
zapato('Puma Ignite Flash', plano, deportivo, rojo, hombre, 190, 'Amortiguacion avanzada para estabilidad').
zapato('Skechers Arch Fit', plano, casual, azul, unisex, 140, 'Disenado para soporte del arco del pie').
zapato('New Balance 928v3', plano, formal, negro, hombre, 220, 'Elegancia y soporte ideal').
zapato('Hoka One One Arahi 6', plano, senderismo, verde, unisex, 240, 'Comodidad en largas caminatas').
zapato('Reebok Classic Leather', plano, casual, blanco, mujer, 160, 'Estilo clasico y soporte diario').

%pie normal zapato:
zapato('Brooks Ghost 14', normal, deportivo, rojo, hombre, 180, 'Amortiguacion balanceada para cada pisada').
zapato('Puma Smash v2', normal, casual, gris, mujer, 120, 'Estilo clasico con comodidad moderna').
zapato('Clarks Tilden Walk', normal, formal, negro, hombre, 220, 'Diseno elegante con soporte premium').
zapato('Merrell Moab 2', normal, senderismo, verde, unisex, 210, 'Durabilidad y confort en cualquier aventura').
zapato('Nike Air Zoom Pegasus 39', normal, deportivo, amarillo, unisex, 190, 'Ligero y comodo para correr').
zapato('Adidas UltraBoost 22', normal, casual, blanco, mujer, 200, 'Comodidad superior para el dia a dia').
zapato('Ecco St.1 Hybrid', normal, formal, marron, hombre, 270, 'Sofisticacion con amortiguacion avanzada').
zapato('Columbia Newton Ridge', normal, senderismo, gris, unisex, 230, 'Proteccion en cualquier terreno').
zapato('Hoka Clifton 8', normal, deportivo, azul, mujer, 220, 'Amortiguacion suave y ligera').
zapato('Asics GT-2000 9', normal, casual, negro, hombre, 170, 'Soporte y estilo para uso diario').

%pie cavo zapato:
zapato('Hoka Bondi 7', cavo, deportivo, amarillo, mujer, 240, 'Maxima amortiguacion para alto arco').
zapato('Skechers Go Walk 5', cavo, casual, azul, unisex, 130, 'Ligero y flexible para caminar comodamente').
zapato('Ecco Helsinki 2', cavo, formal, marron, hombre, 270, 'Clasico diseno con soporte anatomico').
zapato('Keen Targhee III', cavo, senderismo, gris, mujer, 260, 'Proteccion y estabilidad en terrenos rocosos').
zapato('Brooks Adrenaline GTS 22', cavo, deportivo, rojo, unisex, 210, 'Soporte avanzado para arco elevado').
zapato('New Balance 990v5', cavo, casual, negro, hombre, 220, 'Estilo clasico con soporte especializado').
zapato('Clarks Unstructured', cavo, formal, blanco, mujer, 250, 'Elegancia con soporte anatomico').
zapato('Salomon X Ultra 3 GTX', cavo, senderismo, marron, unisex, 280, 'Robustez para excursiones extremas').
zapato('Puma Velocity Nitro', cavo, deportivo, azul, hombre, 200, 'Rendimiento y soporte para alto impacto').
zapato('Nike Free RN 5.0', cavo, casual, gris, mujer, 170, 'Flexibilidad y soporte adaptable').

% =========================
% Opcion 1: Recomendar zapato
% =========================
% Opcion 1: Recomendar zapato
procesar_opcion(1) :-
    write('=== Recomendacion de Zapatos ==='), nl,
    preguntar_tipo_pie(TipoPie),
    preguntar_tipo_zapato(TipoZapato),
    preguntar_color(Color),
    preguntar_presupuesto(Presupuesto),
    preguntar_genero(Genero),
    leer_dni_registrado(DNI),  % Verifica que el DNI este registrado
    nl,
    write('=== Resultado de recomendacion ==='), nl,
    write('Tipo de pie: '), write(TipoPie), nl,
    write('Tipo de zapato: '), write(TipoZapato), nl,
    write('Color preferido: '), write(Color), nl,
    write('Presupuesto maximo: S/'), write(Presupuesto), nl,
    write('Genero: '), write(Genero), nl,
    recomendar_zapato(DNI, TipoPie, TipoZapato, Color, Genero, Presupuesto),
    menu.
leer_dni_registrado(DNI) :-
    leer_dni(DNI),
    (cliente(DNI)
    -> true
    ;  write('❌ DNI no registrado. Por favor registrese o intente nuevamente.'), nl,
       leer_dni_registrado(DNI)
    ).

recomendar_zapato(DNI, TipoPie, TipoZapato, ColorPref, GeneroPref, Presupuesto) :-
    (nonvar(ColorPref) -> downcase_atom(ColorPref, Color) ; Color = 'cualquiera'),
    (nonvar(GeneroPref) -> downcase_atom(GeneroPref, Genero) ; Genero = 'cualquiera'),
    findall(Modelo, (
        zapato(Modelo, TipoPie, TipoZapato, ColorZapato, GeneroZapato, Precio, Suela),
        Precio =< Presupuesto,
        (Color = 'cualquiera' ; downcase_atom(ColorZapato, Color)),
        (Genero = 'cualquiera' ; downcase_atom(GeneroZapato, Genero)),
        format('✅ Recomendacion especial:~n', []),
        format('Modelo: ~w~n', [Modelo]),
        format('Tipo: ~w - ~w~n', [TipoPie, TipoZapato]),
        format('Color: ~w~n', [ColorZapato]),
        format('Precio: S/ ~w~n', [Precio]),
        format('Genero: ~w~n', [GeneroZapato]),
        format('Suela: ~w~n', [Suela]),
        guardar_historial(DNI, Modelo, TipoPie, TipoZapato, ColorZapato, GeneroZapato, Precio, Suela),
        format('-------------------------------------~n', [])
    ), Resultados),
    (Resultados == [] -> write('❌ No se encontraron recomendaciones con esos parametros.'), nl ; true), !.



% =========================
% Validaciones y preguntas
% =========================

preguntar_tipo_pie(TipoPie) :-
    write('¿Que tipo de pie tiene? (plano, normal, cavo): '),
    leer_respuesta(Respuesta),
    member(Respuesta, [plano, normal, cavo]),
    TipoPie = Respuesta, !.
preguntar_tipo_pie(TipoPie) :-
    write('Respuesta invalida. Intente de nuevo.'), nl,
    preguntar_tipo_pie(TipoPie).

preguntar_tipo_zapato(TipoZapato) :-
    write('¿Que tipo de zapato necesita? (Deportivo/Casual/Formal/Elegante/Senderismo): '),
    leer_respuesta(Respuesta),
    member(Respuesta, [deportivo, casual, formal, elegante, senderismo]),
    TipoZapato = Respuesta, !.
preguntar_tipo_zapato(TipoZapato) :-
    write('Respuesta invalida. Intente de nuevo.'), nl,
    preguntar_tipo_zapato(TipoZapato).

preguntar_color(Color) :-
    write('o¿Color preferido? (Ejemplo: negro, blanco, azul): '),
    leer_respuesta(Colr).

preguntar_presupuesto(Presupuesto) :-
    write('¿Presupuesto maximo? (Debe ser un numero mayor a 0): '),
    leer_numero(Presupuesto).

preguntar_genero(Genero) :-
    write('¿Genero? (hombre/mujer/unisex): '),
    leer_respuesta(Respuesta),
    member(Respuesta, [hombre, mujer, unisex]),
    Genero = Respuesta, !.
preguntar_genero(Genero) :-
    write('Respuesta invalida. Intente nuevamente.'), nl,
    preguntar_genero(Genero).

% Lee una respuesta normalizada (sin distincion de mayusculas/minusculas)
leer_respuesta(Respuesta) :-
    read(Input),
    downcase_atom(Input, Respuesta).

% Lee y valida que sea un numero positivo
leer_numero(Numero) :-
    read(Input),
    number(Input),
    Input > 0,
    Numero = Input, !.
leer_numero(Numero) :-
    write('Numero invalido. Intente nuevamente.'), nl,
    leer_numero(Numero).


guardar_historial(DNI, Modelo, TipoPie, TipoZapato, Color, Genero, Precio, Suela) :-
    atom_concat(DNI, '_historial.txt', NombreArchivo),
    open(NombreArchivo, append, Archivo),
    format(Archivo, 'Modelo: ~w~n', [Modelo]),
    format(Archivo, 'Tipo de pie: ~w~n', [TipoPie]),
    format(Archivo, 'Tipo de zapato: ~w~n', [TipoZapato]),
    format(Archivo, 'Color: ~w~n', [Color]),
    format(Archivo, 'Genero: ~w~n', [Genero]),
    format(Archivo, 'Precio: S/ ~w~n', [Precio]),
    format(Archivo, 'Suela: ~w~n', [Suela]),
    format(Archivo, '==============================~n', []),
    close(Archivo).

% =========================% 22222222222222222=========================
% =========================% =========================

% === OPCION 2: Mostrar historial de recomendaciones por DNI ===
procesar_opcion(2) :-
    write('=== Historial de Preferencias ==='), nl,
    leer_dni(DNI),
    mostrar_historial(DNI),
    menu.

% Mostrar historial desde el archivo del usuario
mostrar_historial(DNI) :-
    atom_concat(DNI, '_historial.txt', NombreArchivo),
    ( exists_file(NombreArchivo)
    -> open(NombreArchivo, read, Archivo),
       write('Mostrando historial de recomendaciones:'), nl, nl,
       leer_historial(Archivo),
       close(Archivo),
       nl
    ;  write('❌ No hay historial de recomendaciones para este DNI.'), nl
    ).

% Leer y mostrar linea por linea del archivo
leer_historial(Archivo) :-
    at_end_of_stream(Archivo), !.
leer_historial(Archivo) :-
    \+ at_end_of_stream(Archivo),
    read_line_to_string(Archivo, Linea),
    write(Linea), nl,
    leer_historial(Archivo).



% ========================= 33333333333333333 % =========================
% Leer tipo de pie con validacion
leer_tipo_pie(TipoPie) :-
    write('Ingrese su tipo de pie (plano, normal, cavo): '),
    read(Input),
    (   member(Input, [plano, normal, cavo])
    ->  TipoPie = Input
    ;   write('Tipo de pie invalido. Intente nuevamente.'), nl,
        leer_tipo_pie(TipoPie)
    ).

% Leer genero con validacion
leer_genero(Genero) :-
    write('Ingrese el genero (hombre, mujer, unisex): '),
    read(Input),
    (   member(Input, [hombre, mujer, unisex])
    ->  Genero = Input
    ;   write('Genero invalido. Intente nuevamente.'), nl,
        leer_genero(Genero)
    ).

% Leer el tipo de pies
leer_precio_maximo(PrecioMax) :-
    write('Ingrese el precio maximo (S/): '),
    leer_numero(Precio),
    number(Precio),
    PrecioMax = Precio.

% Mostrar descuentos segun filtros
mostrar_descuentos :-
    nl, write('=== Descuentos Disponibles ==='), nl,
    leer_tipo_pie(TipoPie),
    leer_genero(Genero),
    leer_precio_maximo(PrecioMax),
    nl,
    write('Zapatos con descuento que cumplen los criterios:'), nl,
    (
        zapato(Modelo, TipoPie, TipoZapato, Color, Genero, Precio, Suela),
        Precio =< PrecioMax,
        Descuento is Precio * 0.10,
        PrecioFinal is Precio - Descuento,
        format('Modelo: ~w (~w)~n', [Modelo, TipoZapato]),
        format('Color: ~w, Genero: ~w~n', [Color, Genero]),
        format('Precio original: S/ ~2f~n', [Precio]),
        format('Descuento: 10%% - Nuevo precio: S/ ~2f~n', [PrecioFinal]),
        format('Descripcion: ~w~n~n', [Suela]),
        fail
    ;   write('--- Fin de descuentos para estos filtros. ---'), nl
    ).

% Opcion 3 del menu
procesar_opcion(3) :-
    mostrar_descuentos,
    menu.


procesar_opcion(4) :- write('¡Gracias por usar el sistema!'), nl.
procesar_opcion(_) :- write('Opcion no valida.'), nl, menu.

% =========================
% =========================

% =========================
% Mostrar menu
% =========================
menu :-
    nl,
    write('===== MENU ====='), nl,
    write('1. Recomendar zapato'), nl,
    write('2. Historial preferencia'), nl,
    write('3. Ver descuentos'), nl,
    write('4. Salir'), nl,
    write('Seleccione una opcion: '),
    read(Opcion),
    procesar_opcion(Opcion).



% =========================
% Inicio del programa
% =========================
:- dynamic cliente/1.  % cliente(DNI)

% ==================== CARGA Y GUARDADO ====================

cargar_clientes :-
    exists_file('clientes.data'),
    consult('clientes.data'), !.
cargar_clientes :-
    write('No se encontro el archivo de clientes. Se iniciara con una base vacia.'), nl.

guardar_clientes :-
    tell('clientes.data'),
    listing(cliente/1),
    told.

% ==================== LECTURA DE DNI ====================

leer_dni(DNI) :-
    write('Ingrese su DNI (8 digitos): '),
    read(Input),
    integer(Input),
    number_chars(Input, Digits),
    length(Digits, 8),
    DNI = Input, !.

leer_dni(DNI) :-
    write('DNI invalido. Debe ser un numero de 8 digitos.'), nl,
    leer_dni(DNI).

% ==================== INICIO ====================

inicio :-
    cargar_clientes,
    nl,
    write('¡Bienvenido!'), nl,
    write('¿Esta registrado? (Si/No): '),
    respuesta_si_o_no(Respuesta),
    (   Respuesta == si
    ->  verificar_cliente
    ;   registrar_cliente
    ).

% ==================== VALIDAR RESPUESTA SI/NO ====================

respuesta_si_o_no(RespuestaNormalizada) :-
    read(Entrada),
    downcase_atom(Entrada, Normalizado),
    (   Normalizado == 'si'
    ->  RespuestaNormalizada = si
    ;   Normalizado == 'no'
    ->  RespuestaNormalizada = no
    ;   write('Respuesta invalida. Por favor, escriba "Si" o "No".'), nl,
        respuesta_si_o_no(RespuestaNormalizada)
    ).

% ==================== VERIFICAR CLIENTE ====================

verificar_cliente :-
    write('Ingrese su numero de DNI: '),
    leer_dni(DNI),
    (   cliente(DNI)
    ->  write('Bienvenido nuevamente.'), nl, menu
    ;   write('DNI no encontrado en el sistema.'), nl,
        menu_dni_no_valido
    ).

% ==================== REGISTRAR CLIENTE ====================

registrar_cliente :-
    write('=== Registro rapido ==='), nl,
    leer_dni(DNI),
    (   cliente(DNI)
    ->  write('Este DNI ya esta registrado.'), nl,
        menu
    ;   assertz(cliente(DNI)),
        guardar_clientes,
        write('Registro exitoso.'), nl,
        menu
    ).

% ==================== MENU SI DNI NO ENCONTRADO ====================

menu_dni_no_valido :-
    nl,
    write('¿Que desea hacer?'), nl,
    write('1. Volver a intentar'), nl,
    write('2. Registrarse'), nl,
    write('3. Salir'), nl,
    write('Seleccione una opcion (1, 2 o 3): '),
    read(Opcion),
    (   Opcion == 1
    ->  verificar_cliente
    ;   Opcion == 2
    ->  registrar_cliente
    ;   Opcion == 3
    ->  write('Saliendo del sistema. ¡Hasta luego!'), nl
    ;   write('Opcion invalida.'), nl,
        menu_dni_no_valido
    ).

% ==================== MENU PRINCIPAL ====================

menu :-
    nl,
    write('==== Menu Principal ===='), nl,
    write('1. Consultar datos'), nl,
    write('2. Salir'), nl,
    write('Seleccione una opcion: '),
    read(Opcion),
    (   Opcion == 1
    ->  write('Funcionalidad de consulta aun no implementada.'), nl,
        menu
    ;   Opcion == 2
    ->  write('Gracias por usar el sistema. ¡Hasta pronto!'), nl
    ;   write('Opcion invalida.'), nl,
        menu
    ).
