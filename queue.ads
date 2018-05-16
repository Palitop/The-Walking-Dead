generic
    type element is private;

package Queue is
    type coa is limited private;

    mal_us: exception;
    desbordament: exception;

    procedure buidar (c: out coa);
    procedure posar (c: in out coa; x: in element);
    procedure borrar_primer(c: in out coa);
    procedure copiarcoa (c1: in coa; c2: out coa);
    function agafar_primer (c: in coa) return element;
    function esbuida(c: in coa) return boolean;
    function is_last_item (c: in out coa) return boolean;

private
    type casella;

    type pcasella is access casella;

    type casella is record
        e: element;
        seg: pcasella;
    end record;

    type coa is record
        primer, darrer: pcasella;
    end record;
end Queue;
