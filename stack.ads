generic
    type elem is private;

package stack is

type pila is limited private;

mal_uso: exception;
espacio_desbordado : exception;

procedure buida(p: out pila);
procedure ficar(p: in out pila; x: in elem );
procedure treure(p: in out pila);
function cim(p: in pila) return elem ;
function esbuida( p: in pila) return boolean;

private

type nodo;

type pnodo is access nodo;

type nodo is record
    x: elem;
    sig: pnodo;
end record;

type pila is record
    top: pnodo;
end record;

end stack;
