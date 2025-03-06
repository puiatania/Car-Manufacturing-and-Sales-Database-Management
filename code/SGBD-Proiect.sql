--PROIECT SGBD
--STRUCTURI DE CONTROL
--Structuri alternative
SET SERVEROUTPUT ON
DECLARE
v_id puiatania_produse.id_produs%TYPE:='&id';
v_putere NUMBER;
BEGIN
SELECT TO_NUMBER(RTRIM(putere_dezvoltata,' CP')) INTO v_putere FROM puiatania_produse WHERE id_produs=v_id;
IF v_putere>150 THEN
DBMS_OUTPUT.PUT_LINE('Produsul cu id_ul '||v_id||' are putere mare de tractiune, depasind 150 CP.');
ELSE
DBMS_OUTPUT.PUT_LINE('Produsul cu id_ul '||v_id||' nu depaseste 150 CP.');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Produsul cu id_ul '||v_id||' nu exista!');
END;
/
--
SET SERVEROUTPUT ON
DECLARE
v_id puiatania_investitii.id_investitie%TYPE:='&id';
v_val puiatania_investitii.valoare_investitie%TYPE;
BEGIN
SELECT valoare_investitie INTO v_val FROM puiatania_investitii WHERE id_investitie=v_id;
IF v_val<300000 THEN
DBMS_OUTPUT.PUT_LINE('Investitia cu id_ul '||v_id||' intra in categoria normala.');
ELSIF v_val BETWEEN 300000 AND 900000 THEN
DBMS_OUTPUT.PUT_LINE('Investitia cu id_ul '||v_id||' intra in categoria medie.');
ELSIF v_val BETWEEN 900001 AND 111500000 THEN
DBMS_OUTPUT.PUT_LINE('Investitia cu id_ul '||v_id||' intra in categoria mare.');
ELSE 
DBMS_OUTPUT.PUT_LINE('Investitia cu id_ul '||v_id||' intra in categoria foarte mare!');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN 
DBMS_OUTPUT.PUT_LINE('Investitia cu id_ul '||v_id||' nu exista!');
END;
/
--
SET SERVEROUTPUT On
DECLARE 
v_id puiatania_produse.id_produs%TYPE:='&id';
v_cost puiatania_produse.cost_productie%TYPE;
v_mot puiatania_produse.motorizare%TYPE;
v_nou_cost puiatania_produse.cost_productie%TYPE;
BEGIN
SELECT cost_productie,motorizare INTO v_cost,v_mot FROM puiatania_produse WHERE id_produs=v_id;
v_nou_cost:=
CASE
WHEN v_mot='Motorina' THEN
0.85*v_cost
WHEN v_mot='Benzina' THEN
0.75*v_cost
ELSE
v_cost
END;
DBMS_OUTPUT.PUT_LINE('Produsul cu id_ul '||v_id||' va avea noul cost de productie de '||v_nou_cost);
EXCEPTION
WHEN NO_DATA_FOUND THEN 
DBMS_OUTPUT.PUT_LINE('Produsul cu id_ul '||v_id||' nu exista!');
END;
/
--
SET SERVEROUTPUT ON
DECLARE
v_id puiatania_produse.id_produs%TYPE:='&id';
v_cul puiatania_produse.culoare%TYPE;
BEGIN
SELECT culoare INTO v_cul FROM puiatania_produse WHERE id_produs=v_id;
CASE
WHEN v_cul='Neagra' OR v_cul='Gri inchis' THEN
DBMS_OUTPUT.PUT_LINE('Produsul cu id-ul '||v_id||' are culoarea '||v_cul||', fiind o culoare populara, foarte ceruta.');
WHEN v_cul='Nisipiu' THEN
DBMS_OUTPUT.PUT_LINE('Produsul cu id-ul '||v_id||' are culoarea '||v_cul||', fiind o culoare neutra, de asemenea ceruta.');
ELSE
DBMS_OUTPUT.PUT_LINE('Produsul cu id-ul '||v_id||' are culoarea '||v_cul||', fiind o culoare mai putin ceruta.');
END CASE;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Produsul cu id-ul '||v_id||' nu exista!');
END;
/
--Structuri repetitive
SET SERVEROUTPUT ON
DECLARE
    v_nume puiatania_clienti.nume_client%TYPE;
    v_prenume puiatania_clienti.prenume_client%TYPE;
    v_sex puiatania_clienti.prenume_client%TYPE;
    v_min NUMBER;
    v_max NUMBER;
    v_cliente NUMBER:=0;
BEGIN
    SELECT MIN(id_client), MAX(id_client) 
    INTO v_min, v_max
    FROM puiatania_clienti;

    FOR i IN v_min..v_max LOOP
        SELECT nume_client, prenume_client, sex
        INTO v_nume, v_prenume,v_sex
        FROM puiatania_clienti WHERE id_client=i;
        IF v_sex LIKE 'Femeie' THEN
        DBMS_OUTPUT.PUT_LINE ('Clientul '||i|| ' cu numele '|| v_nume||' '||v_prenume||' este '||v_sex);
        v_cliente:=v_cliente+1;
        END IF;
    END LOOP;
     DBMS_OUTPUT.PUT_LINE ('Compania are '||v_cliente||' cliente.');
END;
--
SET SERVEROUTPUT ON
DECLARE
    v_id puiatania_comenzi.id_comanda%TYPE;
    v_data puiatania_comenzi.data_comanda%TYPE;
    v_min NUMBER;
    v_max NUMBER;
    i NUMBER;
BEGIN
    SELECT MIN(id_comanda), MAX(id_comanda) 
    INTO v_min, v_max
    FROM puiatania_comenzi;

    i:=v_min;
    WHILE i<=v_max LOOP
        SELECT id_comanda,data_comanda
        INTO v_id, v_data
        FROM puiatania_comenzi WHERE id_comanda=i;
        DBMS_OUTPUT.PUT_LINE ('Comanda '||i|| ' a fost realizata la data de '|| v_data||' .');
        CASE
        WHEN EXTRACT (YEAR FROM v_data)=2022 THEN 
        DBMS_OUTPUT.PUT_LINE ('Comanda '||i|| ' este recenta.');
        WHEN EXTRACT (YEAR FROM v_data)=2021 THEN 
        DBMS_OUTPUT.PUT_LINE ('Comanda '||i|| ' este relativ recenta.');
        ELSE
        DBMS_OUTPUT.PUT_LINE ('Comanda '||i|| ' este veche.');
        END CASE;
    i:=i+1;
    END LOOP;
END;
--
SET SERVEROUTPUT ON
DECLARE
 v_nume puiatania_clienti.nume_client%TYPE;
    v_prenume puiatania_clienti.prenume_client%TYPE;
    v_data puiatania_clienti.data_nastere%TYPE;
    v_min NUMBER;
    v_max NUMBER;
    i NUMBER;
BEGIN
    SELECT MIN(id_client), MAX(id_client) 
    INTO v_min, v_max
    FROM puiatania_clienti;

    i:=v_min;
    LOOP
        SELECT nume_client,prenume_client,data_nastere
        INTO v_nume, v_prenume,v_data
        FROM puiatania_clienti WHERE id_client=i;
        DBMS_OUTPUT.PUT_LINE ('Clientul '||i|| ' cu numele '|| v_nume||v_prenume||' nascut la data de '||v_data||' .');
        CASE
        WHEN EXTRACT(YEAR FROM v_data) BETWEEN 1981 AND 1995 THEN 
         DBMS_OUTPUT.PUT_LINE ('Clientul '||i|| ' cu numele '|| v_nume||v_prenume||' este milenial .');
         WHEN EXTRACT(YEAR FROM v_data) BETWEEN 1965 AND 1980 THEN 
         DBMS_OUTPUT.PUT_LINE ('Clientul '||i|| ' cu numele '|| v_nume||v_prenume||' face parte din generatia X .');
         ELSE
         DBMS_OUTPUT.PUT_LINE ('Clientul '||i|| ' cu numele '|| v_nume||v_prenume||' face parte din alte generatie .');
         END CASE;
    i:=i+1;
    EXIT WHEN i>v_max;
    END LOOP;
    END;
 --   
SET SERVEROUTPUT ON
DECLARE
    v_id puiatania_comenzi.id_comanda%TYPE;
    v_data puiatania_comenzi.data_comanda%TYPE;
    v_min NUMBER;
    v_max NUMBER;
    v_nr2022 NUMBER:=0;
    v_nr2021 NUMBER:=0;
    v_nr2020 NUMBER:=0;
    v_nr2019 NUMBER:=0;
    v_nr2018 NUMBER:=0;
BEGIN
    SELECT MIN(id_comanda), MAX(id_comanda) 
    INTO v_min, v_max
    FROM puiatania_comenzi;

    FOR i IN v_min..v_max LOOP
        SELECT id_comanda, data_comanda
        INTO v_id, v_data
        FROM puiatania_comenzi WHERE id_comanda=i;
    CASE
    WHEN EXTRACT(YEAR FROM v_data)=2022 THEN v_nr2022:=v_nr2022;
    WHEN EXTRACT(YEAR FROM v_data)=2021 THEN v_nr2021:=v_nr2021;
    WHEN EXTRACT(YEAR FROM v_data)=2020 THEN v_nr2020:=v_nr2020;
    WHEN EXTRACT(YEAR FROM v_data)=2019 THEN v_nr2022:=v_nr2019;
    WHEN EXTRACT(YEAR FROM v_data)=2018 THEN v_nr2022:=v_nr2018;
    END CASE;
    END LOOP;
    IF v_nr2022>v_nr2021 AND v_nr2022>v_nr2020 AND v_nr2022>v_nr2019 AND v_nr2022>v_nr2018 
    THEN 
    DBMS_OUTPUT.PUT_LINE ('Cele mai multe comenzi au fost realizate in anul '||EXTRACT(YEAR FROM v_data)|| ' .');
    ELSIF v_nr2021>v_nr2022 AND v_nr2021>v_nr2020 AND v_nr2021>v_nr2019 AND v_nr2021>v_nr2018 
    THEN 
    DBMS_OUTPUT.PUT_LINE ('Cele mai multe comenzi au fost realizate in anul '||EXTRACT(YEAR FROM v_data)|| ' .');
    ELSIF v_nr2020>v_nr2022 AND v_nr2020>v_nr2021 AND v_nr2020>v_nr2019 AND v_nr2020>v_nr2018 
    THEN 
    DBMS_OUTPUT.PUT_LINE ('Cele mai multe comenzi au fost realizate in anul '||EXTRACT(YEAR FROM v_data)|| ' .');
     ELSIF v_nr2019>v_nr2022 AND v_nr2019>v_nr2021 AND v_nr2019>v_nr2020 AND v_nr2019>v_nr2018 
    THEN 
    DBMS_OUTPUT.PUT_LINE ('Cele mai multe comenzi au fost realizate in anul '||EXTRACT(YEAR FROM v_data)|| ' .');
    ELSE 
    DBMS_OUTPUT.PUT_LINE ('Cele mai multe comenzi au fost realizate in anul '||EXTRACT(YEAR FROM v_data)|| ' .');
   END IF;
END;
--
SET SERVEROUTPUT ON
DECLARE 
v_an NUMBER:=&an;
cifra_de_afaceri NUMBER;
BEGIN
SELECT SUM(pret_vanzare*cantitate) INTO cifra_de_afaceri
FROM puiatania_comenzi c, puiatania_rand_comenzi r
WHERE c.id_comanda=r.id_comanda 
AND EXTRACT(YEAR FROM data_comanda)=v_an;
CASE
WHEN cifra_de_afaceri<100000 THEN
DBMS_OUTPUT.PUT_LINE('In anul '||v_an||' s-a inregistrat o cifra de afaceri mica, de '||cifra_de_afaceri);
WHEN cifra_de_afaceri BETWEEN 100001 AND 500000 THEN 
DBMS_OUTPUT.PUT_LINE('In anul '||v_an||' s-a inregistrat o cifra de afaceri normala, de '||cifra_de_afaceri);
WHEN cifra_de_afaceri BETWEEN 500001 AND 700000 THEN 
DBMS_OUTPUT.PUT_LINE('In anul '||v_an||' s-a inregistrat o cifra de afaceri mare, de '||cifra_de_afaceri);
WHEN cifra_de_afaceri BETWEEN 500001 AND 700000 THEN 
DBMS_OUTPUT.PUT_LINE('In anul '||v_an||' s-a inregistrat o cifra de afaceri foarte mare, de '||cifra_de_afaceri);
ELSE
RAISE NO_DATA_FOUND;
END CASE;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Nu exista comenzi realizate in anul '||v_an||' !');
END;
/
--CURSORI
--Cursor implicit
SET SERVEROUTPUT ON
DECLARE 
v_id puiatania_promotii.id_promotie%TYPE:='&id';
BEGIN 
UPDATE puiatania_promotii 
SET procent_promotie=12 
WHERE id_promotie=v_id;
IF SQL%NOTFOUND THEN 
DBMS_OUTPUT.PUT_LINE('Nu exista promotia cu id-ul '||v_id);
ELSE
DBMS_OUTPUT.PUT_LINE('S-a modificat procentul promotiei pentru '||SQL%ROWCOUNT||' promotii.');
END IF;
END;
/
--Cursor explicit
SET SERVEROUTPUT ON
DECLARE
v_total puiatania_reclame.cost_productie%TYPE:=0;
CURSOR c IS SELECT r.id_reclama, p.denumire_produs, r.cost_productie 
FROM puiatania_produse p,puiatania_reclame r
WHERE p.id_produs=r.id_produs;
v_id puiatania_reclame.id_reclama%type;
v_denumire puiatania_produse.denumire_produs%type;
v_cost puiatania_reclame.cost_productie%type;
BEGIN
OPEN c;
LOOP
FETCH c INTO v_id, v_denumire,v_cost;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Reclama '||v_id||' pentru produsul ' ||v_denumire||', pentru a fi produsa a costat '||v_cost||'.');
v_total:=v_total+v_cost;
END LOOP;
CLOSE c;
DBMS_OUTPUT.PUT_LINE('Costul total de realizare al reclamelor de-a lungul anilor a fost '||v_total);
END;
/
--
SET SERVEROUTPUT ON
DECLARE
CURSOR c IS SELECT i.id_investitie, d.denumire_departament, descriere, valoare_investitie
FROM puiatania_investitii i,puiatania_departamente d
WHERE d.id_departament=i.id_departament
ORDER BY valoare_investitie DESC;
v_id puiatania_investitii.id_investitie%type;
v_dep puiatania_departamente.denumire_departament%type;
v_des puiatania_investitii.descriere%type;
v_val puiatania_investitii.valoare_investitie%type;
BEGIN
OPEN c;
LOOP
FETCH c INTO v_id, v_dep,v_des,v_val;
EXIT WHEN c%ROWCOUNT>2;
DBMS_OUTPUT.PUT_LINE('Investitia '||v_id||' corespunzatoare departamentului '||v_dep||' cu valoarea de '||v_val||' are descrierea: '||v_des||'.');
END LOOP;
CLOSE c;
END;
/
--
SET SERVEROUTPUT ON
DECLARE
CURSOR c IS SELECT id_produs, denumire_produs, cost_productie 
FROM puiatania_produse 
WHERE cost_productie>53000;
BEGIN
FOR v in c LOOP
DBMS_OUTPUT.PUT_LINE('Produsul '||v.id_produs||' cu denumirea ' ||v.denumire_produs||' are costul de productie '||v.cost_productie||'.');
END LOOP;
END;
/
--
DECLARE 
CURSOR c IS SELECT id_concediu, suma_plata FROM puiatania_concedii WHERE tip_plata_concediu='Medical-cu plata';
v c%ROWTYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Concediul cu id-ul '||v.id_concediu||' este in valoare de '||v.suma_plata);
END LOOP;
END;
/
--
SET SERVEROUTPUT ON
BEGIN
FOR v IN (SELECT p.id_produs,denumire_produs,SUM(cantitate) as nr
FROM puiatania_rand_comenzi r,puiatania_produse p
WHERE p.id_produs=r.id_produs(+)
GROUP BY p.id_produs,denumire_produs) LOOP
DBMS_OUTPUT.PUT_LINE('Produsul '||v.denumire_produs||', cu id-ul '||v.id_produs||', s-a vandut in cantitatea de '||NVL(v.nr,0));
END LOOP;
END;
/
--
SET SERVEROUTPUT ON
BEGIN 
FOR v IN (SELECT EXTRACT(YEAR FROM data_incepere_concediu) anul, 
SUM(NVL(suma_plata,0)) suma
FROM puiatania_concedii
GROUP BY EXTRACT(YEAR FROM data_incepere_concediu)
ORDER BY EXTRACT(YEAR FROM data_incepere_concediu)) LOOP
DBMS_OUTPUT.PUT_LINE('In anul '||v.anul||' sunt de plata concedii in valoare de '||v.suma);
END LOOP;
END;
--
SET SERVEROUTPUT ON
BEGIN
DELETE FROM puiatania_concedii 
WHERE tip_plata_concediu='Medical-cu plata';
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' concedii au fost sterse');
ROLLBACK;
END;
--
SET SERVEROUTPUT ON
DECLARE
v_id puiatania_produse.id_produs%TYPE;
v_denumire puiatania_produse.denumire_produs%TYPE;
v_mot puiatania_produse.motorizare%TYPE;
v_put puiatania_produse.putere_dezvoltata%TYPE;
v_cul puiatania_produse.culoare%TYPE;
v_cap puiatania_produse.capacitate_cilindrica%TYPE;
v_cut puiatania_produse.cutie_de_viteze%TYPE;
v_cat puiatania_produse.categorie%TYPE;
CURSOR c IS SELECT id_produs,denumire_produs,motorizare,putere_dezvoltata,culoare,capacitate_cilindrica,cutie_de_viteze,categorie FROM puiatania_produse
ORDER BY cost_productie DESC;
BEGIN
OPEN c;
FOR i IN 1..5 LOOP
FETCH c INTO v_id,v_denumire,v_mot,v_put,v_cul,v_cap,v_cut,v_cat;
DBMS_OUTPUT.PUT_LINE(v_id||' '||v_denumire||' '||v_mot||' '||v_put||' '||v_cul||' '||v_cap||' '||v_cut||' '||v_cat);
END LOOP;
END;
/
--EXCEPTII
--Exceptii implicite predefinite
SET SERVEROUTPUT ON
DECLARE
v_id puiatania_produse.id_produs%type;
v_den puiatania_produse.denumire_produs%type;
v_cost puiatania_produse.cost_productie%type;
BEGIN
SELECT Id_produs,denumire_produs,cost_productie INTO v_id,v_den,v_cost 
FROM puiatania_produse
WHERE culoare LIKE 'galbena';
dbms_output.put_line(v_id||', '||v_den||' ,'||v_cost);
EXCEPTION
WHEN  NO_DATA_FOUND THEN
dbms_output.put_line('Nu exista nici un produs de culoare galbena!');
END;
--
SET SERVEROUTPUT ON
DECLARE
v_p puiatania_produse.putere_dezvoltata%type;
v_cap puiatania_produse.capacitate_cilindrica%type;
v_cul puiatania_produse.culoare%type;
BEGIN
SELECT putere_dezvoltata,capacitate_cilindrica,culoare INTO v_p,v_cap,v_cul 
FROM puiatania_produse WHERE culoare='Neagra';
DBMS_OUTPUT.PUT_LINE(v_p||', '||v_cap||', '||v_cul);
EXCEPTION
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('Exista mai multe produse cu aceeasi culoare');
END;
--Exceptii implicite non-predefinite
SET SERVEROUTPUT ON
DECLARE
insert_exc EXCEPTION;
PRAGMA EXCEPTION_INIT(insert_exc,-1400);
BEGIN
INSERT INTO puiatania_functii(id_functie,denumire_functie) VALUES(NULL,'Marele sef');
EXCEPTION
WHEN insert_exc THEN
DBMS_OUTPUT.PUT_LINE('Nu ati introdus informatii suficiente despre noul departament!');
DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--Exceptii explicite
DECLARE 
invalid_recl EXCEPTION;
BEGIN
UPDATE puiatania_reclame 
SET cost_productie=&c
WHERE id_reclama='&id';
IF SQL%NOTFOUND THEN 
RAISE invalid_recl;
ELSE
DBMS_OUTPUT.PUT_LINE('S-au modificat '||SQL%ROWCOUNT||' reclame.');
END IF;
EXCEPTION
WHEN invalid_recl THEN 
DBMS_OUTPUT.PUT_LINE('Nu exista reclama cu acest id!');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('A aparut eroarea: '||SQLERRM);
END;
ROLLBACK;
--FUNCTII SI PROCEDURI
CREATE OR REPLACE PROCEDURE af_dep_inv(l NUMBER)
AS
CURSOR c IS SELECT denumire_departament, descriere, valoare_investitie
FROM puiatania_investitii i,puiatania_departamente d
WHERE d.id_departament=i.id_departament
AND valoare_investitie>=l;
BEGIN
FOR v IN c LOOP 
DBMS_OUTPUT.PUT_LINE(v.denumire_departament||' are o investitie in valoare de '||v.valoare_investitie||' si cu descrierea '||v.descriere);
END LOOP;
END;
SET SERVEROUTPUT ON
EXECUTE af_dep_inv(250000)
--
CREATE OR REPLACE PROCEDURE val_con_med(tip puiatania_concedii.tip_plata_concediu%type, an NUMBER)
AS
v puiatania_concedii.suma_plata%type;
BEGIN
SELECT SUM(suma_plata) INTO v
FROM puiatania_concedii
WHERE tip_plata_concediu LIKE tip 
AND EXTRACT(YEAR FROM data_incepere_concediu)=an;
DBMS_OUTPUT.PUT_LINE('Concediile medicale cu plata pentru anul '||an||' sunt in valoare de '||v);
END;
SET SERVEROUTPUT ON
BEGIN
 val_con_med('Medical-cu plata',2020);
END;
--
CREATE OR REPLACE PROCEDURE cauta_produs
(p_id IN puiatania_produse.id_produs%type,
p_denumire OUT puiatania_produse.denumire_produs%type,
p_capacitate OUT puiatania_produse.capacitate_cilindrica%type,
p_mot OUT puiatania_produse.motorizare%type,
p_put OUT puiatania_produse.putere_dezvoltata%type,
p_cul OUT puiatania_produse.culoare%type)
IS
BEGIN
SELECT denumire_produs,capacitate_cilindrica,motorizare,putere_dezvoltata,culoare INTO p_denumire,p_capacitate,p_mot,p_put,p_cul 
FROM puiatania_produse 
WHERE id_produs LIKE p_id;
DBMS_OUTPUT.PUT_LINE(' Produsul '||p_denumire||' are capacitatea cilindrica de '||p_capacitate||', motorizarea '||p_mot||', puterea dezvoltata de '||
p_put||' si culoarea '||p_cul||'.');
END;
SET SERVEROUTPUT ON
DECLARE
v_denumire puiatania_produse.denumire_produs%type;
v_capacitate puiatania_produse.capacitate_cilindrica%type;
v_mot  puiatania_produse.motorizare%type;
v_put puiatania_produse.putere_dezvoltata%type;
v_cul puiatania_produse.culoare%type;
BEGIN
 cauta_produs('ID.3L',v_denumire,v_capacitate,v_mot,v_put,v_cul);
END;
--
CREATE OR REPLACE FUNCTION vechime_comanda(p_id puiatania_clienti.id_client%TYPE)
RETURN NUMBER 
AS
v_vechime NUMBER;
BEGIN
SELECT ROUND((SYSDATE-data_comanda)/7) INTO v_vechime
FROM puiatania_comenzi
WHERE id_comanda=p_id;
RETURN v_vechime;
EXCEPTION 
WHEN NO_DATA_FOUND THEN RETURN -1;
END;
SET SERVEROUTPUT ON
DECLARE 
v_vechime NUMBER;
BEGIN
v_vechime:=vechime_comanda(13);
IF v_vechime=-1 THEN
DBMS_OUTPUT.PUT_LINE('Comanda nu exista!');
ELSE
DBMS_OUTPUT.PUT_LINE(v_vechime);
END IF;
END;
--
CREATE OR REPLACE PROCEDURE cost_mediu (v_mediu OUT puiatania_produse.cost_productie%type)
IS
BEGIN 
SELECT AVG(cost_productie) INTO v_mediu
FROM puiatania_produse;
DBMS_OUTPUT.PUT_LINE(v_mediu);
END;
SET SERVEROUTPUT ON
DECLARE 
v_mediu puiatania_produse.cost_productie%type; 
BEGIN
cost_mediu(v_mediu);
END;
--
CREATE OR REPLACE FUNCTION verifica_cost 
(p_id_produs IN puiatania_produse.id_produs%type, p_cost_mediu IN NUMBER)
RETURN Boolean 
IS
v_cost puiatania_produse.cost_productie%type;
BEGIN
SELECT cost_productie INTO v_cost FROM puiatania_produse WHERE id_produs=p_id_produs;
IF v_cost > p_cost_mediu THEN
RETURN TRUE;
ELSE
RETURN FALSE;
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN NULL;
END;
SET SERVEROUTPUT ON
DECLARE
v_cost_mediu number;
BEGIN
cost_mediu(v_cost_mediu);
IF (verifica_cost('ID.3T', v_cost_mediu) IS NULL) THEN
dbms_output.put_line('Produs cu ID invalid!');
ELSIF (verifica_cost('ID.3T', v_cost_mediu)) THEN
dbms_output.put_line('Produsul are costul de productie mai mare decat media!');
ELSE
dbms_output.put_line('Produsul are costul de productie mai mic decat media!');
END IF;
IF (verifica_cost('Jt2.0DIt', v_cost_mediu) IS NULL) then
dbms_output.put_line('Produs cu ID invalid!');
elsif (verifica_cost('Jt2.0DIt', v_cost_mediu)) then
dbms_output.put_line('Produsul are costul de productie mai mare decat media!');
else
dbms_output.put_line('Produsul are costul de productie mai mic decat media!');
end if;
IF (verifica_cost('Passat', v_cost_mediu) IS NULL) then
dbms_output.put_line('Produsul cu ID invalid!');
elsif (verifica_cost('Passat', v_cost_mediu)) then
dbms_output.put_line('Produsul are costul de productie mai mare decat media!');
else
dbms_output.put_line('Produsul are costul de productie mai mic decat media!');
end if;
END;
--
CREATE OR REPLACE FUNCTION taxa_concedii( procent IN NUMBER)
RETURN NUMBER IS
valoare puiatania_concedii.suma_plata%type;
BEGIN
SELECT SUM(suma_plata) INTO valoare
FROM puiatania_concedii;
RETURN (valoare*procent/100);
END taxa_concedii;
SELECT taxa_concedii(3) FROM DUAL;
--
DECLARE
CURSOR c IS
SELECT denumire_produs,motorizare,
DECODE(UPPER(motorizare),'MOTORINA','daunatoare mediului',
'BENZINA','Daunatoare mediului','mai putin daunatoare')
impact_asupra_mediului
FROM puiatania_produse;
v c%ROWTYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Produsul cu denumirea '||v.denumire_produs||' este o masina '||v.impact_asupra_mediului);
END LOOP;
END;
--
DECLARE
CURSOR c IS
SELECT denumire_produs,categorie,cost_productie,id_comanda,pret_vanzare
FROM puiatania_produse  LEFT JOIN puiatania_rand_comenzi 
USING (id_produs);
v c%ROWTYPE;
BEGIN 
OPEN c;
LOOP
FETCH c INTO v;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Produsul cu denumirea '||v.denumire_produs||' din categoria '||v.categorie||' are costul de productie de '
||v.cost_productie||', se regaseste in comanda '||v.id_comanda||' si a fost vandut cu pretul '||v.pret_vanzare||'.');
END LOOP;
END;
--
DECLARE CURSOR c IS
SELECT nume_angajat,prenume_angajat,telefon_angajat,email_angajat FROM puiatania_angajati
WHERE id_angajat IN
(SELECT a.id_angajat FROM puiatania_angajati a
INTERSECT
SELECT c.id_angajat FROM puiatania_comenzi c);
v c%ROWTYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Angajatul numit '||v.nume_angajat||' '||v.prenume_angajat||' are datele de contact: '||v.telefon_angajat||' , '||v.email_angajat);
END LOOP;
END;
--
DECLARE CURSOR c IS
SELECT id_produs,data_incepere_campanie,data_incheiere_campanie FROM puiatania_reclame
MINUS
SELECT id_produs,data_incepere_promotie,data_incheiere_promotie FROM puiatania_promotii;
v c%ROWTYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Produsul cu id-ul '||v.id_produs||' a fost promovat in perioada '
||v.data_incepere_campanie||' '||v.data_incheiere_campanie||'.');
END LOOP;
END;
