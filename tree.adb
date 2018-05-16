with stack;

package body tree is

type casellapila is record
    node: arbre;
    esquerra: boolean;
end record;

package pilac is new stack (elem => casellapila);
use pilac;

procedure buit(t: out arbre) is
    p: pnodo renames t.arrel;
begin
    p:= null;
end buit;

function esta_buit(t: in arbre) return boolean is
    p: pnodo renames t.arrel;
begin
    return p=null;
end esta_buit;

procedure graf(t: out arbre; lt, rt: in arbre; x: in element) is
    p: pnodo renames t.arrel;
    pl: pnodo renames lt.arrel;
    pr: pnodo renames rt.arrel;
begin
    p:= new nodo;
    p.all:= (x, pl, pr);
exception
    when storage_error => raise espacio_desbordado;
end graf;

procedure arrel(t: in arbre; x: out element) is
    p: pnodo renames t.arrel;
begin
    x:= p.x;
exception
    when constraint_error => raise mal_uso;
end arrel;

procedure atom (t: out arbre; x: in element) is
    p: pnodo renames t.arrel;
begin
    p := new nodo;
    p.all := (x, null, null);
exception
    when storage_error=> raise mal_uso;
end atom;

procedure esq(t: in arbre; lt: out arbre) is
    p: pnodo renames t.arrel;
    pl: pnodo renames lt.arrel;
begin
    pl:= p.l;
exception
    when constraint_error => raise mal_uso;
end esq;

procedure dre(t: in arbre; rt: out arbre) is
    p: pnodo renames t.arrel;
    pr: pnodo renames rt.arrel;
begin
    pr:= p.r;
exception
    when constraint_error => raise mal_uso;
end dre;

function e_dre (t: in arbre) return boolean is
    p: pnodo renames t.arrel;
begin
    return p.r /= null;
end e_dre;

function e_esq (t: in arbre) return boolean is
    p: pnodo renames t.arrel;
begin
    return p.l /= null;
end e_esq;

function successor (t: in arbre; p: in out pila; b: in boolean) return casellapila is
    aux: casellapila;
    auxtree: arbre;
    treedolent: arbre;
    esquerra: boolean;
begin
    treedolent := t;
    esquerra := b;
    aux.node := treedolent;
    aux.esquerra := esquerra;
    ficar(p, aux);
    if e_esq(treedolent) then
        esq(treedolent, auxtree);
        aux.node := auxtree;
        aux.esquerra := true;
        return aux;
    elsif e_dre(treedolent) then
        dre(treedolent, auxtree);
        aux.node := auxtree;
        aux.esquerra := false;
        return aux;
    else
        treure(p);
        aux := cim(p);
        treedolent := aux.node;
        esquerra := aux.esquerra;
        while (esquerra and (e_dre(treedolent) = true)) loop
            treure(p);
            aux := cim(p);
            treedolent := aux.node;
            esquerra := aux.esquerra;
        end loop;
        treure(p);
        dre (aux.node, auxtree);
        aux.node := auxtree;
        aux.esquerra := false;
        return aux;
    end if;
end successor;

function primer (t: in arbre) return element is
    begin
    return t.arrel.x;
end primer;

function darrer (t: in arbre) return arbre is
    auxtree: arbre;
    treedolent: arbre;
begin
    treedolent := t;
    while e_esq(treedolent) or e_dre(treedolent) loop
        if e_dre(treedolent) then
            dre(treedolent, auxtree);
            treedolent := auxtree;
        else
            esq(treedolent, auxtree);
            treedolent := auxtree;            
        end if;
    end loop;
    return treedolent;
end darrer;

procedure preordre (t: in arbre; c: out coa) is
    final: arbre;
    pilap : pila;
    treebo: arbre;
    esquerra : boolean;
    aux: casellapila;
begin
    treebo := t;
    esquerra:= false;
    if not esta_buit(treebo) then
        final := darrer(treebo);
        while treebo /= final loop
            posar(c, primer(treebo));
            aux := successor(treebo, pilap, esquerra);
            treebo := aux.node;
            esquerra := aux.esquerra;
        end loop;
        posar(c, primer(treebo));
    else
        raise arbol_vacio; 
    end if;
end preordre;

procedure amplitud (t: in arbre; c: out coa) is
    package dqueue is new queue(arbre);
    use dqueue;
    aux: dqueue.coa;
    auxtree: arbre;
    treebo: arbre;
begin
    treebo := t;
    if not esta_buit(treebo) then
        posar (aux, treebo);
        while not esbuida(aux) loop
            if e_esq(treebo) then
                esq(treebo, auxtree);
                posar(aux, auxtree);
            end if;
            if e_dre(treebo) then
                dre(treebo, auxtree);
                posar(aux, auxtree);
            end if;
            posar(c, primer(treebo));
            borrar_primer(aux);
            if not esbuida(aux) then
                treebo := agafar_primer(aux);
            end if;
        end loop;
    else
        raise arbol_vacio;
    end if;
end amplitud;

end tree;
