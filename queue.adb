package body Queue is

procedure buidar (c: out coa) is
    primer: pcasella renames c.primer;
    darrer: pcasella renames c.darrer;
    begin
        primer:= null;
        darrer:= null;
end buidar;

procedure posar (c: in out coa; x: in element) is
    primer: pcasella renames c.primer;
    darrer: pcasella renames c.darrer;
    r: pcasella;
    begin
        r:= new casella;
        r.all:= (x, null);
        if (primer = null) then
            primer:= r;
            darrer:= r;
        else
            primer.seg:= r;
            primer:= r;
        end if ;
        exception
            when storage_error => raise desbordament;
end posar;

procedure borrar_primer(c: in out coa) is
    primer: pcasella renames c.primer;
    darrer: pcasella renames c.darrer;
    begin
        darrer:= darrer.seg;
        if (darrer = null) then 
            primer:= null;
        end if;
        exception
            when constraint_error => raise mal_us;
end borrar_primer;

function agafar_primer (c: in coa) return element is
    darrer: pcasella renames c.darrer;
    begin
        return darrer.e;
    exception
        when constraint_error => raise mal_us;
end agafar_primer;

function esbuida(c: in coa) return boolean is
    darrer: pcasella renames c.darrer;  
    begin
        return darrer = null;
end esbuida;

function is_last_item (c: in out coa) return boolean is
    primer: pcasella renames c.primer;
    darrer: pcasella renames c.darrer;
    begin
        return darrer = primer;
end is_last_item;

procedure copiarcoa (c1: in coa; c2: out coa) is
    primer: pcasella renames c1.primer;
    darrer: pcasella renames c1.darrer;
    aux: pcasella;
begin
    buidar(c2);
    aux := darrer;
    while primer /= aux loop
        posar(c2, aux.e);
        aux := aux.seg;
    end loop;
    posar(c2, aux.e);
end copiarcoa;

end Queue;
