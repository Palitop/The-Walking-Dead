with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
use Ada.Strings.Unbounded.Text_IO;
with tree;
with queue;

procedure main is

type capitol is record
    nom: Unbounded_String;
end record;

package coa_capitol is new Queue (element => capitol);
use coa_capitol;

package arbol is new tree (element => capitol, dqueue => coa_capitol);
use arbol;

capitolg: capitol;

treebo: arbre;

colaA: coa;
colaP: coa;

indexA: Natural;
indexP: Natural;

usuari: Unbounded_String;

left_tree, right_tree: arbre;
leaf_left, leaf_right: arbre;

-- Construim l'abre des de les fulles fins l'arrel
procedure rellenarArbre is

begin
    capitolg.nom := To_Unbounded_String("No time left");
    atom(leaf_left, capitolg);

    capitolg.nom := To_Unbounded_String("400 days");
    atom(leaf_right, capitolg);

    capitolg.nom := To_Unbounded_String("Around every corner");
    graf(right_tree, leaf_left, leaf_right, capitolg);

    capitolg.nom := To_Unbounded_String("Long road ahead");
    atom(leaf_right, capitolg);

    buit(leaf_left);

    capitolg.nom := To_Unbounded_String("Starved for help");
    graf(left_tree, leaf_left, leaf_right, capitolg); -- L'arbre no te fill esquerra

    capitolg.nom := To_Unbounded_String("A new day");
    graf(treebo, left_tree, right_tree, capitolg);

end rellenarArbre;

-- passada una coa, imprimeix el seu contingut
procedure imprimirResultat (c: in out coa) is
    capitoli: capitol;
begin
    while not esbuida(c) loop
        capitoli := agafar_primer(c);
        borrar_primer(c);
        Put_Line("- " & capitoli.nom);
    end loop;

end imprimirResultat;

-- metode que se li passa una coa i treu la posicio del que vol l'usuari
function posicio(titol: in Unbounded_String; c: in coa) return Natural is
    aux: capitol;
    index: Natural := 1;
    coaaux: coa;
begin
    copiarcoa(c, coaaux); -- metode que copia el contigut d'una a una altra
    while not esbuida(coaaux) loop
        aux := agafar_primer(coaaux);
        if aux.nom = titol then
            return index;
        end if;
        index := index +1;
        borrar_primer(coaaux);
    end loop;
    return 0;
end posicio;

-- imprimeix els capitols del joc
procedure imprimirCapitols is
begin
    Put_Line("- A new day");
    Put_Line("- Starved for help");
    Put_Line("- Long road ahead");
    Put_Line("- Around every corner");
    Put_Line("- 400 days");
    Put_Line("- No time left");
end imprimirCapitols;

-- compara les dues posicions del dos metodes i dona el resultat
procedure comparar(amplitud: in Natural; preordre: in Natural) is
begin
    if amplitud /= 0 and preordre /= 0 then
        if amplitud < preordre then
            Put_Line("El recorregut en amplitud és més ràpid");
            Put_Line(" ");
            Put_Line("Aquest és el recorregut en amplitud:");
            imprimirResultat(colaA);
        elsif amplitud > preordre then
            Put_Line("El recorregut en preodre és més ràpid");
            Put_Line(" ");
            Put_Line("Aquest és el recorregut preordre:");
            imprimirResultat(colaP);
        else
            Put_Line("Els dos recorreguts són iguals");
            Put_Line(" ");
            Put_Line("Els dos recorreguts són:");
            Put_Line(" ");
            Put_Line("Recorregut preordre:");
            imprimirResultat(colaP);
            Put_Line(" ");
            Put_Line("Recorregut amplitud:");
            imprimirResultat(colaA);
        end if;
    else
        Put_Line("El capítol inserit no existeix");
    end if;

end comparar;

begin
    Put_Line("THE WALKING DEAD");
    Put_Line("");
    Put_Line("Els capítols del joc són:");
    imprimirCapitols;
    rellenarArbre;

    Put("Introdueix el nom del capítol: ");
    Get_Line(usuari);

    amplitud(treebo, colaA);
    indexA := posicio(usuari, colaA);

    preordre(treebo, colaP);
    indexP := posicio(usuari, colaP);

    comparar(indexA, indexP);

    exception
        when arbol_vacio => Put_Line("L'abre a tractar és buit");
end main;
