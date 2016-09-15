:-dynamic pesado/1.
:-dynamic tamanio/2.
:-dynamic mediano/1.
:-dynamic fragil/1.
:-dynamic ligero/1.
:-dynamic plegable/1.
:-dynamic objeto/2.
:-dynamic empaquetado/1.
:-dynamic caja/2.
:-dynamic encaja/2.

objeto(libro1).
objeto(libro2).
objeto(lampara).
objeto(platos).
objeto(abrigo).
objeto(tv).
objeto(pantalones1).
objeto(pantalones2).
objeto(camisa1).
objeto(camisa2).

tamanio(libro1,2).
tamanio(libro2,2).
tamanio(lampara,8).
tamanio(platos,5).
tamanio(tv,10).
tamanio(pantalones1,2).
tamanio(pantalones2,2).
tamanio(abrigo,3).
tamanio(camisa1,1).
tamanio(camisa2,1).

pesado(libro1).
pesado(libro2).
pesado(tv).

mediano(lampara).
mediano(platos).

fragil(lampara).
fragil(platos).
fragil(tv).

ligero(abrigo).
ligero(pantalones1).
ligero(pantalones2).
ligero(camisa1).
ligero(camisa2).

plegable(pantalones1).
plegable(pantalones2).
plegable(camisa1).
plegable(camisa2).


registrarObjeto :-
  write('--REGISTRO DE UN OBJETO--'),nl,
  write('PASO 1: DIGITE EL NOMBRE DEL OBJETO.'),nl,
  read(N),nl,(not(objeto(N)) -> assert(objeto(N)),nl;write('EL OBJETO YA EXISTE.'),nl,registrarObjeto),
  write('PASO 2: EL OBJETO ES FRAGIL ?.'),nl,
  write('1. SI'),nl,
  write('2. NO'),nl,
  read(OP),nl,(OP =:= 1,not(fragil(N)) -> assert(fragil(N)),nl,write('EL OBJETO ES FRAGIL.'),nl;write('EL OBJETO NO ES FRAGIL.'),nl),
  write('PASO 3: EL OBJETO ES PLEGABLE?.'),nl,
  write('1. SI'),nl,
  write('2. NO'),nl,
  read(OP2),nl,(OP2 =:= 1,not(plegable(N)) -> assert(plegable(N)),nl,write('EL OBJETO ES PLEGABLE.'),nl;write('EL OBJETO NO ES PLEGABLE.'),nl),
  write('PASO 4: EL OBJETO ES PESADO O LIGERO ?'),nl,
  write('1. PESADO'),nl,
  write('2. LIGERO'),nl,
  read(OP3),nl,(OP3 =:= 1,not(pesado(N)) -> assert(pesado(N)),nl,write('EL OBJETO ES PESADO.'),nl;write('EL OBJETO NO ES PESADO.'),nl),
  (OP3 =:= 2,not(ligero(N)) -> assert(ligero(N)),nl,write('EL OBJETO ES LIGERO.'),nl;write('EL OBJETO NO ES LIGERO.'),nl).



crearcaja(X):-not(caja(X,_))->assert(caja(X,10));H is X + 1,crearcaja(H).

embalar(X,Y):-((fragil(X),not(empaquetado(X)) )->
                            assert(empaquetado(X)),nl,write('Regla 1 (fragiles): Objeto Empaquetado'),nl,embalar(X,Y)).

embalar(X,Y):-(fragil(X),empaquetado(X),not(caja(Y,_))->
                      crearcaja(Y),caja(Y,Z),tamanio(X,T),H is Z - T,(H > 0 ->retract(caja(Y,Z)),assert(caja(Y,H)),assert(encaja(X,Y))),write('Regla 2 (fragiles): Objeto en caja '),nl).
embalar(X,Y):-((fragil(X),empaquetado(X),caja(Y,_))->
                      (caja(Y,Z),not(encaja(X,Y)),encaja(W,Y),fragil(W),tamanio(X,T),(H is Z - T),(H > 0 ->(retract(caja(Y,Z)),assert(caja(Y,H)),assert(encaja(X,Y)));((C is Y + 1),embalar(X,C),write('Regla 3 (fragiles): Objeto en caja nueva '),nl)))).


menu :-
  write('--MENU--'),nl,
  write('1. Registrar Objeto.'),nl,
  write('2. Embalar Objetos.'),nl,
  read(N),nl,
  N =:=1 -> registrarObjeto ;
  write('Opcion incorrecta.'),nl,menu.
