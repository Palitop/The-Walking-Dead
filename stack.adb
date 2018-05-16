package body stack is

procedure buida(p: out pila) is
      top: pnodo renames p.top;
begin
      top := null;
end buida;

function esbuida(p: in pila) return boolean is
      top: pnodo renames p.top;
begin
      return top=null;
end esbuida;

function cim(p: in pila) return elem is
      top: pnodo renames p.top;
begin
      return top.x;
exception
      when constraint_error => raise mal_uso;
end cim;

procedure treure(p: in out pila) is
      top: pnodo renames p.top;
begin
      top:= top.sig;
exception
      when constraint_error => raise mal_uso;
end treure;

procedure ficar(p: in out pila; x: in elem) is
      top: pnodo renames p.top;
      r: pnodo;
begin
      r:= new nodo;
      r.all:= (x, top);
      top:= r;
exception
      when storage_error => raise espacio_desbordado;
end ficar;

end stack;
