block(a).
block(b).
block(c).
pyramid(p).
ball(ball1).
rectangle(rect).
closed_box_cube(cube).

place(1).
place(2).
place(3).
place(4).
place(5).
place(5).
place(6).
place(6).

% Defina o comprimento de cada objeto
object_length(a, 3).
object_length(b, 4).
object_length(c, 2).
object_length(p, 2).
object_length(ball1, 1).
object_length(cube, 2).
object_length(rect, 3).

% Definição dos objetos no mundo dos blocos
object(X) :- block(X) ; pyramid(X) ; ball(X) ; closed_box_cube(X) ; place(X) ; rectangle(X).

%--------------------------------------------------------------------------------------------------
%                                         Inicial State 
%--------------------------------------------------------------------------------------------------


initial_state([clear(2), clear(4), clear(b), clear(c), on(a,1), on(b,3), on(c,a)]).

%--------------------------------------------------------------------------------------------------
%                                         Ações Permitidas
%--------------------------------------------------------------------------------------------------

% Ação de mover um objeto de um local para outro
can(move(Block,From,To),[clear(Block),clear(To),on(Block,From),seguro_de_empilhar(From,To)]) :-
    block(Block),
    object(To),
    To \== Block,
    object(From),
    From \== To,
    Block \== From.

%--------------------------------------------------------------------------------------------------
%                                  Regras de Empilhamento Seguro 
%--------------------------------------------------------------------------------------------------

% Defina a relação para verificar se um objeto é alto o suficiente para empilhar
alto_suficiente(_, 0).  % Altura de um lugar é 0

alto_suficiente(Object, Height) :-
    Object \= place(_),
    length(Object, Length),
    Length >= Height.

% Definição das regras para empilhamento seguro
seguro_de_empilhar(_,block(_)). % Qualquer objeto pode ser empilhado sobre um bloco
seguro_de_empilhar(_,pyramid(_)) :- fail. % Pirâmides não podem ter objetos empilhados sobre elas
seguro_de_empilhar(_,ball(_)) :- fail.  % Bolas não podem ter objetos empilhados sobre elas
seguro_de_empilhar(_,closed_box_cube(_)) . % Qualquer objeto pode ser empilhado sobre uma caixa fechada
seguro_de_empilhar(_,place(_)). % Blocos podem ser empilhados sobre lugares
seguro_de_empilhar(_, rectangle(_)).
seguro_de_empilhar(place(_),_):- fail. % Lugares não podem ser empilhados sobre outros objetos
seguro_de_empilhar(rectangle(_), rectangle(_)).

seguro_de_empilhar(X, Y) :-
  alto_suficiente(X, HeightX),
  alto_suficiente(Y, HeightY),
  HeightX =< HeightY.

%--------------------------------------------------------------------------------------------------
%                          Efeitos das Ações (Adição e Remoção de Relações)
%--------------------------------------------------------------------------------------------------

% Efeitos da ação de mover um objeto
adds(move(X, From, To), [on(X, To), clear(From)]).

% Efeitos da ação de mover um objeto
deletes(move(X, From, To), [on(X, From), clear(To)]).
