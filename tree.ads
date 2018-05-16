with queue;

generic
    type element is private;

    with package dqueue is new queue(element);
    use dqueue;

package tree is
    type arbre is limited private;

    mal_uso: exception;
    espacio_desbordado: exception;
    arbol_vacio: exception;

    procedure buit (t: out arbre);
    function esta_buit(t: in arbre) return boolean;
    procedure graf (t: out arbre; lt, rt: in arbre; x: in element);
    procedure atom (t: out arbre; x: in element);
    procedure arrel(t: in arbre; x: out element);
    procedure esq (t: in arbre; lt: out arbre);
    procedure dre (t: in arbre; rt: out arbre);
    function e_dre (t: in arbre) return boolean;
    function e_esq (t: in arbre) return boolean;

    procedure preordre (t: in arbre; c: out coa);
    procedure amplitud (t: in arbre; c: out coa);

private

    type nodo;
    type pnodo is access nodo;

    type nodo is record
        x: element;
        l: pnodo;
        r: pnodo;
    end record;

    type arbre is record
        arrel: pnodo;
    end record;
end tree;
