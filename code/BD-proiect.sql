CREATE TABLE angajati_pr (id_angajat NUMBER(5) CONSTRAINT r1 PRIMARY KEY,
nume_angajat VARCHAR2(30)CONSTRAINT r2 NOT NULL,
prenume_angajat VARCHAR2(30)CONSTRAINT r3 NOT NULL,
data_angajare DATE CONSTRAINT r4 NOT NULL,
email_angajat VARCHAR(30),
telefon_angajat VARCHAR(12) CONSTRAINT r5 NOT NULL,
id_functie VARCHAR(10) CONSTRAINT r6 NOT NULL,
id_departament VARCHAR(10)CONSTRAINT r7 NOT NULL,
id_manager NUMBER(5));

CREATE TABLE departamente_pr(id_departamente VARCHAR(10) CONSTRAINT re1 PRIMARY KEY,
denumire_departament VARCHAR(30) CONSTRAINT re2 NOT NULL,
id_manager NUMBER(5)CONSTRAINT re3 NOT NULL);

DROP TABLE departamente_pr CASCADE CONSTRAINTS;

CREATE TABLE departamente_pr(id_departament VARCHAR(10) CONSTRAINT re1 PRIMARY KEY,
denumire_departament VARCHAR(30) CONSTRAINT re2 NOT NULL,
id_manager NUMBER(5)CONSTRAINT re3 NOT NULL);

ALTER TABLE angajati_pr ADD CONSTRAINT r8 FOREIGN KEY (id_departament) REFERENCES departamente_pr(id_departament);

CREATE TABLE functii_pr(id_functie VARCHAR(10) CONSTRAINT res1 PRIMARY KEY,
denumire_functie VARCHAR(30) CONSTRAINT res2 NOT NULL,
salariu NUMBER(7)CONSTRAINT res3 NOT NULL);

ALTER TABLE angajati_pr ADD CONSTRAINT r9 FOREIGN KEY (id_functie) REFERENCES functii_pr(id_functie);

CREATE TABLE investitii_pr(id_investitie VARCHAR(10) CONSTRAINT rest1 PRIMARY KEY,
id_departament VARCHAR(10) CONSTRAINT rest2 NOT NULL,
descriere VARCHAR(300) CONSTRAINT rest3 NOT NULL);

ALTER TABLE investitii_pr ADD CONSTRAINT rest4 FOREIGN KEY (id_departament) REFERENCES departamente_pr(id_departament);

CREATE TABLE concedii_pr(id_concediu VARCHAR(10) CONSTRAINT rs1 PRIMARY KEY,
id_angajat NUMBER(5) CONSTRAINT rs2 NOT NULL,
data_incepere_concediu DATE CONSTRAINT rs3 NOT NULL,
data_final_concediu DATE CONSTRAINT rs4 NOT NULL,
tip_plata_concediu VARCHAR(20) CONSTRAINT rs5 NOT NULL);

ALTER TABLE concedii_pr ADD(suma_plata VARCHAR(7));

ALTER TABLE functii_pr MODIFY(salariu VARCHAR(7));

CREATE TABLE clienti_pr(id_client NUMBER(13) CONSTRAINT rt1 PRIMARY KEY,
nume_client VARCHAR2(30) CONSTRAINT rt2 NOT NULL,
prenume_client VARCHAR2(30) CONSTRAINT rt3 NOT NULL,
telefon_client VARCHAR2(12) CONSTRAINT rt4 NOT NULL,
email_client VARCHAR2(30),
data_nastere DATE CONSTRAINT rt5 NOT NULL,
sex VARCHAR2(10) NOT NULL);

CREATE TABLE comenzi_pr(id_comanda NUMBER(7) CONSTRAINT restr1 PRIMARY KEY,
id_client NUMBER(13) CONSTRAINT restr2 NOT NULL,
data_comanda DATE CONSTRAINT restr3 NOT NULL,
id_ang NUMBER(5) CONSTRAINT restr4 NOT NULL);

ALTER TABLE comenzi_pr RENAME COLUMN id_ang to id_angajat;

ALTER TABLE comenzi_pr ADD CONSTRAINT restr5 FOREIGN KEY (id_client) REFERENCES clienti_pr(id_client);

CREATE TABLE rand_comenzi_pr(id_comanda NUMBER(7) CONSTRAINT ri1 NOT NULL,
id_produs VARCHAR(10) CONSTRAINT ri2 NOT NULL,
cantitate NUMBER(10) CONSTRAINT ri3 NOT NULL,
pret_vanzare NUMBER(12) CONSTRAINT ri4 NOT NULL);

ALTER TABLE rand_comenzi_pr ADD CONSTRAINT ri5 FOREIGN KEY (id_comanda) REFERENCES comenzi_pr(id_comanda);

CREATE TABLE produse_pr(id_produs VARCHAR(10) CONSTRAINT rin1 PRIMARY KEY,
pret_productie NUMBER(12) CONSTRAINT rin2 NOT NULL,
denumire_produs VARCHAR2(30) CONSTRAINT rin3 NOT NULL,
categorie VARCHAR(20) CONSTRAINT rin4 NOT NULL,
descriere VARCHAR(200));

ALTER TABLE rand_comenzi_pr ADD CONSTRAINT ri6 FOREIGN KEY (id_produs) REFERENCES produse_pr(id_produs);

CREATE TABLE promotii_pr(id_promotie VARCHAR2(10) CONSTRAINT rsi1 PRIMARY KEY,
id_produs VARCHAR(10) CONSTRAINT rsi2 NOT NULL,
procent_promotie NUMBER(3) CONSTRAINT rsi3 NOT NULL,
data_incepere_promotie DATE CONSTRAINT rsi4 NOT NULL,
data_incheiere_promotie DATE CONSTRAINT rsi5 NOT NULL);

ALTER TABLE promotii_pr ADD CONSTRAINT rsi6 FOREIGN KEY (id_produs) REFERENCES produse_pr(id_produs);

CREATE TABLE reclame_pr(id_reclama VARCHAR2(10) CONSTRAINT rint1 PRIMARY KEY,
id_produs VARCHAR2(10) CONSTRAINT rint2 NOT NULL,
cost_productie VARCHAR2(12) CONSTRAINT rint3 NOT NULL,
data_incepere_campanie DATE CONSTRAINT rint4 NOT NULL,
data_incheiere_campanie DATE CONSTRAINT rint5 NOT NULL);

ALTER TABLE reclame_pr ADD CONSTRAINT rint6 FOREIGN KEY (id_produs) REFERENCES produse_pr(id_produs);

ALTER TABLE reclame_pr DISABLE CONSTRAINT rint6;

ALTER TABLE reclame_pr ENABLE CONSTRAINT rint6;

INSERT INTO departamente_pr VALUES('Pr','Productie',100);
INSERT INTO departamente_pr VALUES('Vz','Vanzari',200);
INSERT INTO departamente_pr VALUES('Cd','Cercetare si dezvoltare',300);
INSERT INTO departamente_pr VALUES('Mk','Marketing',400);
INSERT INTO departamente_pr VALUES('Ru','Resurse umane',500);
INSERT INTO departamente_pr VALUES('Mn','Management',600);
INSERT INTO departamente_pr VALUES('It','IT',700);
INSERT INTO departamente_pr VALUES('Rp','Relatii cu publicul',800);
INSERT INTO departamente_pr VALUES('Ac','Achizitii',900);
INSERT INTO departamente_pr VALUES('Co','Contabilitate',910);
INSERT INTO departamente_pr VALUES('Tr','Transport',550);

ALTER TABLE functii_pr MODIFY(salariu VARCHAR2(20));
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Vz_Ag','Agent de vanzari','1200,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Tr_s','Sofer','700,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Vz_mg','Manager de vanzari','2400,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('It_mg','IT Manager','3000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('It_ing','Inginer de sistem','2990,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Co_mg','Contabil sef','1200,00$');
DELETE FROM functii_pr WHERE id_functie LIKE '%Co_mg%';
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Co_mg','Contabil sef','1500,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Co','Contabil','1300,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('It_prg','Programator','2750,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Mk_mg','Manager publicitate','3100,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Mk_ag','Agent de publicitate','2350,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Tr_mg','Manager de transport','1200,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Rp_mg','Manager relatii publice','1200,00$');
DELETE FROM functii_pr WHERE id_functie LIKE '%Rp_mg%';
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Rp_mg','Manager relatii publice','2100,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Rp_ag','Agent relatii publice','1885,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Ac_mg','Manager achizitii','2350,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Ac_ag','Agent de achizitii','1994,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Pr_mg','Manager de productie','3000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Pr_ag','Agent de productie','2000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Cd_mg','Manager cercetare','4000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Cd_cc','Cercetator','3500,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Ru_mg','Manager resurse umane','3650,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Ru_sc','Secretara','1000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Mg_g','Manager general','6000,00$');
INSERT INTO functii_pr(id_functie,denumire_functie,salariu) VALUES('Mg_d','Director general','8000,00$');

INSERT INTO angajati_pr(id_angajat,nume_angajat,prenume_angajat,data_angajare,email_angajat,telefon_angajat,id_functie,id_departament) 
VALUES(1,'Puia','Tania',TO_DATE('12.12.2015','DD.MM.YYYY'),'puiatania@yahoo.com','0726036785','Mg_d','Mn');

SELECT * FROM angajati_pr WHERE INITCAP(nume_angajat)='Puia';

ALTER TABLE produse_pr RENAME COLUMN pret_productie TO cost_productie;
ALTER TABLE produse_pr DROP COLUMN descriere;
ALTER TABLE produse_pr ADD (capacitate_cilindrica VARCHAR2(30));
ALTER TABLE produse_pr ADD(putere_dezvoltata VARCHAR2(10));
ALTER TABLE produse_pr ADD(motorizare VARCHAR2(30));
ALTER TABLE produse_pr MODIFY(capacitate_cilindrica VARCHAR(20));
ALTER TABLE produse_pr ADD(cutie_de_viteze VARCHAR2(10));
ALTER TABLE produse_pr ADD(culoare VARCHAR2(30));
ALTER TABLE produse_pr ADD(optionale VARCHAR2(300));

UPDATE functii_pr SET denumire_functie='Asistent manager' WHERE INITCAP(denumire_functie) LIKE '%Secretara%';

INSERT INTO departamente_pr VALUES('Ctc','Control tehnic de calitate',315);
INSERT INTO departamente_pr VALUES('Prj','Proiectare',320);
INSERT INTO departamente_pr VALUES('Dsg','Design',425);

ALTER TABLE angajati_pr RENAME TO puiatania_angajati;
ALTER TABLE departamente_pr RENAME TO puiatania_departamente;
ALTER TABLE investitii_pr RENAME TO puiatania_investitii;
ALTER TABLE functii_pr RENAME TO puiatania_functii;
ALTER TABLE concedii_pr RENAME TO puiatania_concedii;
ALTER TABLE comenzi_pr RENAME TO puiatania_comenzi;
ALTER TABLE rand_comenzi_pr RENAME TO puiatania_rand_comenzi;
ALTER TABLE produse_pr RENAME TO puiatania_produse;
ALTER TABLE clienti_pr RENAME TO puiatania_clienti;
ALTER TABLE promotii_pr RENAME TO puiatania_promotii;
ALTER TABLE reclame_pr RENAME TO puiatania_reclame;

ALTER TABLE puiatania_reclame MODIFY(cost_productie NUMBER(8));
ALTER TABLE puiatania_investitii ADD(valoare_investitie NUMBER(13));
ALTER TABLE puiatania_concedii MODIFY(suma_plata NUMBER(7));

ALTER TABLE puiatania_investitii DROP COLUMN valoare_investitie;
ALTER TABLE puiatania_investitii ADD(valoare_investitie NUMBER(13) CONSTRAINT r14 NOT NULL);

DROP TABLE puiatania_functii CASCADE CONSTRAINTS;

CREATE TABLE puiatania_functii(id_functie VARCHAR(10) CONSTRAINT res1 PRIMARY KEY,
denumire_functie VARCHAR(30) CONSTRAINT res2 NOT NULL,
salariu NUMBER(7)CONSTRAINT res3 NOT NULL);

ALTER TABLE puiatania_angajati ADD CONSTRAINT r24 FOREIGN KEY (id_functie) REFERENCES puiatania_functii(id_functie);

ALTER TABLE puiatania_angajati DROP CONSTRAINT r9;

ROLLBACK;
ROLLBACK;
ROLLBACK;

FLASHBACK TABLE puiatania_functii TO BEFORE DROP;
ALTER TABLE puiatania_functii RENAME TO pt_functii;
FLASHBACK TABLE puiatania_functii TO BEFORE DROP;

DROP TABLE pt_functii CASCADE CONSTRAINTS;

ALTER TABLE puiatania_angajati ADD CONSTRAINT r10 FOREIGN KEY (id_functie) REFERENCES puiatania_functii(id_functie);

DELETE FROM puiatania_angajati WHERE 1=1;
DELETE FROM puiatania_functii WHERE 1=1;
ALTER TABLE puiatania_functii MODIFY(salariu NUMBER(7));

ALTER TABLE puiatania_concedii ADD CONSTRAINT r100 FOREIGN KEY (id_angajat) REFERENCES puiatania_angajati(id_angajat);
ALTER TABLE puiatania_comenzi ADD CONSTRAINT r200 FOREIGN KEY (id_angajat) REFERENCES puiatania_angajati(id_angajat);
COMMIT;

INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Vz_Ag','Agent de vanzari',1200);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Tr_s','Sofer',700);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Vz_mg','Manager de vanzari',2400);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('It_mg','IT Manager',3000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('It_ing','Inginer de sistem',2990);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Co_mg','Contabil sef',1200);
DELETE FROM puiatania_functii WHERE id_functie LIKE '%Co_mg%';
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Co_mg','Contabil sef',1500);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Co','Contabil',1300);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('It_prg','Programator',2750);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Mk_mg','Manager publicitate',3100);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Mk_ag','Agent de publicitate',2350);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Tr_mg','Manager de transport',1200);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Rp_mg','Manager relatii publice',1200);
DELETE FROM puiatania_functii WHERE id_functie LIKE '%Rp_mg%';
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Rp_mg','Manager relatii publice',2100);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Rp_ag','Agent relatii publice',1885);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Ac_mg','Manager achizitii',2350);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Ac_ag','Agent de achizitii',1994);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Pr_mg','Manager de productie',3000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Pr_ag','Agent de productie',2000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Cd_mg','Manager cercetare',4000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Cd_cc','Cercetator',3500);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Ru_mg','Manager resurse umane',3650);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Ru_sc','Secretara',1000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Mg_g','Manager general',6000);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Mg_d','Director general',8000);

INSERT INTO puiatania_angajati(id_angajat,nume_angajat,prenume_angajat,data_angajare,email_angajat,telefon_angajat,id_functie,id_departament) 
VALUES(1,'Puia','Tania',TO_DATE('12.12.2015','DD.MM.YYYY'),'puiatania@yahoo.com','0726036785','Mg_d','Mn');

SELECT * FROM puiatania_angajati WHERE nume_angajat='Puia';

UPDATE puiatania_departamente set id_manager=(SELECT id_angajat FROM puiatania_angajati WHERE UPPER(nume_angajat)='PUIA') WHERE UPPER(denumire_departament)=
'MANAGEMENT';

INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Cd_s','Pilot de curse',2890);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Pr_ing','Inginer mecanic',2775);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Prj_ing','Inginer proiectant',2920);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Pr_e','Electrician',1745);
INSERT INTO puiatania_functii(id_functie,denumire_functie,salariu) VALUES('Pr_a','Automatist',1780);

ALTER TABLE puiatania_investitii ADD (data_investitie DATE CONSTRAINT r43 NOT NULL);

INSERT INTO puiatania_investitii(id_investitie,id_departament,descriere,valoare_investitie,data_investitie) VALUES 
('Cd_invest','Cd','Compania inevesteste in dezvoltarea de noi motoare ecofriendly, folosind energia electrica.Se dezvolta noi modele de motoare 
hybride sau electrice.',136990000,
TO_DATE('15-03-2016','DD-MM-YYYY'));
INSERT INTO puiatania_investitii(id_investitie,id_departament,descriere,valoare_investitie,data_investitie) VALUES 
('Mk_invest','Mk','Compania inevesteste in promovarea noilor modele lansate cu motorizare electrica Plug_in si cu design futurist',234500,
TO_DATE('12-07-2017','DD-MM-YYYY'));
INSERT INTO puiatania_investitii(id_investitie,id_departament,descriere,valoare_investitie,data_investitie) VALUES 
('Dsg_invest','Dsg','Compania investeste in crearea unui nou design mai atractiv pentru modelele cu motorizare pe benzina',4569000,
TO_DATE('09-12-2017','DD-MM-YYYY'));
INSERT INTO puiatania_investitii(id_investitie,id_departament,descriere,valoare_investitie,data_investitie) VALUES 
('Ctc_invest','Ctc','Compania investeste in noi roboti si utilaje pentru controlul tehnic de calitate al autoturismelor',111500000,
TO_DATE('23-01-2018','DD-MM-YYYY'));
INSERT INTO puiatania_investitii(id_investitie,id_departament,descriere,valoare_investitie,data_investitie) VALUES 
('Prj_invest','Prj','Compania inevesteste in proiectarea de noi masini cu motoare hybride',3748600,
TO_DATE('20-06-2016','DD-MM-YYYY'));

INSERT INTO puiatania_clienti VALUES (1,'Stamanichi','Andrei','0724374444','stamanichi.andrei@gmail.com',TO_DATE('12-12-1989','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (2,'Popescu','Mariana','0724376464','popescu.maria@yahoo.com',TO_DATE('01-05-1986','DD-MM-YYYY'),'Femeie');
INSERT INTO puiatania_clienti VALUES (3,'Ionescu','Stefan','0722668899','ionescustefan@yahoo.com',TO_DATE('30-01-1990','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (4,'Alexe','George','0728368388','alexeeegeorge@gmail.com',TO_DATE('19-12-1988','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (5,'Bobescu','Elena','0744560222','bobescuelenaa@gmail.com',TO_DATE('13-01-1984','DD-MM-YYYY'),'Femeie');
INSERT INTO puiatania_clienti VALUES (6,'Coman','Anastasia','0724224444','anastasia.coman@yahoo.com',TO_DATE('04-03-1987','DD-MM-YYYY'),'Femeie');
INSERT INTO puiatania_clienti VALUES (7,'Bordea','Andrei','0727374454','bordeaandrei@yahoo.com',TO_DATE('26-02-2000','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (8,'Dumitrescu','Ionut','0724373333','ionut.dumitrescu@gmail.com',TO_DATE('11-09-1996','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (9,'Dumitru','Daniela','0796472911','daniela.d.dumitru@gmail.com',TO_DATE('03-06-1995','DD-MM-YYYY'),'Femeie');
INSERT INTO puiatania_clienti VALUES (10,'Popovici','Ana-Maria','0777899981','ana_maria.popovici@yahoo.com',TO_DATE('31-01-1997','DD-MM-YYYY'),'Femeie');

ALTER TABLE puiatania_produse ADD(data_lansare DATE CONSTRAINT r56 NOT NULL);

INSERT INTO puiatania_clienti VALUES (11,'Tanase','Iulian','0767833341','iulian.tanaseee@yahoo.com',TO_DATE('17-04-1994','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (12,'Maticiuc','Codrin','0734999678','maticiuc24codrin@gmail.com',TO_DATE('20-08-1996','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (13,'Brenciu','Matei-Andrei','0729830411','matei_andrei.brenciu@gmail.com',TO_DATE('23-09-1996','DD-MM-YYYY'),'Barbat');
INSERT INTO puiatania_clienti VALUES (14,'Rusu','Mihaela-Maria','0722558899','rusu_mihaela2003@gmail.com',TO_DATE('27-02-1995','DD-MM-YYYY'),'Femeie');
INSERT INTO puiatania_clienti VALUES (15,'Stama','Marian','0733991122','stama_marian1995@yahoo.com',TO_DATE('22-12-1995','DD-MM-YYYY'),'Barbat');

INSERT INTO puiatania_produse VALUES 
('PstA2TDIC1',35000,'Passat Alltrack Comfortline','Break','2000 cm^3','122 CP','Motorina','Manuala','Neagra','Incalzire in scaune,Camera RearView',
TO_DATE('13-03-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('PstA2TDIH2',40000,'Passat Highline','Berlina','2000 cm^3','150 CP','Motorina','Automata','Neagra','Scaune de piele,Incalzire in scaune,
Camera RearView,Autopilot',TO_DATE('15-04-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('Pst1.5sIC3',31000,'Passat Comfortline','Berlina','1500 cm^3','115 CP','Benzina','Manuala','Rosie',NULL,TO_DATE('12-03-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('TigL1.5SI4',33000,'Tiguan Life','Break','1500 cm^3','150 CP','Benzina','Manuala','Gri inchis',NULL,TO_DATE('20-06-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('TigL2.0DI5',41000,'Tiguan Life','SUV','2000 cm^3','150 CP','Motorina','Automata','Nisipiu','Scaune de piele,Incalzire in scaune,Camera RearView,
Autopilot, Digital Cockpit',
TO_DATE('30-06-2017','DD-MM-YYYY'));

UPDATE puiatania_produse SET categorie='SUV' WHERE id_produs='TigL1.5SI4';

INSERT INTO puiatania_produse VALUES 
('TgL1.0SI6',18500,'Taigo Life','SUV','1000 cm^3','95 CP','Benzina','Manuala','Albastra',NULL,TO_DATE('14-05-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('TgS1.0SI7',22000,'Taigo Style','SUV','1000 cm^3','110 CP','Benzina','Manuala','Rosie','Incalzire in scaune,Camera RearView,Oglinzi electrice rabatabile',
TO_DATE('16-05-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('TgR1.5SI8',25000,'Taigo R-Line','SUV','1500 cm^3','150 CP','Motorina','Automata','Neagra','Incalzire in scaune,Camera RearView',TO_DATE('17-05-2021',
'DD-MM-YYYY'));

INSERT INTO puiatania_produse VALUES 
('ID.3L',42000,'ID.3 Life','Break','58 kWh','204 CP','Electrica','Automata','Neagra',NULL,TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.3S',51000,'ID.3 Style','Break','58 kWh','204 CP','Electrica','Automata','Verde','Incalzire pe 3 zone',TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.3T',55500,'ID.3 Tour','Break','58 kWh','204 CP','Electrica','Automata','Rosie','Incalzire in scaune,Incalzire pe 3 zone',TO_DATE('20-07-2021','DD-MM-YYYY'));

INSERT INTO puiatania_produse VALUES 
('ID.4Pc',48000,'ID.4 Pro','Break','80 kWh','174 CP','Electrica','Automata','Albastra','Incalzire in scaune,Camera RearView',TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.4Pd',51000,'ID.4 Pro Performance','Break','80 kWh','204 CP','Electrica','Automata','Verde','Incalzire in scaune,Camera RearView,Incalzire pe 3 zone',
TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.4G',60000,'ID.4 GTX','Break','80 kWh','299 CP','Electrica','Automata','Neagra','Incalzire in scaune,Camera RearView,Navigatie',TO_DATE('20-07-2021',
'DD-MM-YYYY'));

INSERT INTO puiatania_produse VALUES 
('ID.5Pc',53000,'ID.4 Pro','Break','95 kWh','174 CP','Electrica','Automata','Albastra','Incalzire in scaune,Camera RearView',TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.5Pd',54500,'ID.4 Pro Performance','Break','95 kWh','204 CP','Electrica','Automata','Verde','Incalzire in scaune,Camera RearView,Incalzire pe 3 zone',
TO_DATE('20-07-2021','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('ID.5G',64000,'ID.4 GTX','Break','95 kWh','299 CP','Electrica','Automata','Neagra','Incalzire in scaune,Camera RearView,Navigatie',
TO_DATE('20-07-2021','DD-MM-YYYY'));

INSERT INTO puiatania_produse VALUES 
('Jt2.0DIt',30000,'Jetta Trendline','Berlina','2000 cm^3','115 CP','Motorina','Manuala','Neagra',NULL,TO_DATE('15-02-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('Jt2.oDIc',31500,'Jetta Comfortline','Berlina','2000 cm^3','120 CP','Motorina','Manuala','Neagra','Incalzire in scaune',TO_DATE('16-02-2017','DD-MM-YYYY'));
INSERT INTO puiatania_produse VALUES 
('Jt1.5SIh',39000,'Jetta Highline','Berlina','1500 cm^3','135 CP','Benzina','Automata','Neagra','Scaune de piele,Incalzire in scaune,Camera RearView,Autopilot',
TO_DATE('17-02-2017','DD-MM-YYYY'));

SELECT * FROM puiatania_produse;

INSERT INTO puiatania_promotii VALUES ('PsstH','PstA2TDIH2',7,TO_DATE('01-01-2018','DD-MM-YYYY'),TO_DATE('31-03-2018','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('JettaC','Jt2.oDIc',10,TO_DATE('03-03-2018','DD-MM-YYYY'),TO_DATE('30-06-2018','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('ID.5','ID.5Pc',5,TO_DATE('01-12-2021','DD-MM-YYYY'),TO_DATE('31-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('ID.4','ID.4Pc',5,TO_DATE('01-12-2021','DD-MM-YYYY'),TO_DATE('31-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('ID.3','ID.3L',5,TO_DATE('01-12-2021','DD-MM-YYYY'),TO_DATE('31-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('TigL','TigL1.5SI4',7,TO_DATE('01-03-2018','DD-MM-YYYY'),TO_DATE('31-03-2018','DD-MM-YYYY'));
INSERT INTO puiatania_promotii VALUES ('TgL','TgL1.0SI6',7,TO_DATE('01-01-2022','DD-MM-YYYY'),TO_DATE('31-01-2022','DD-MM-YYYY'));

SELECT * FROM puiatania_promotii;

DELETE FROM puiatania_reclame;

UPDATE puiatania_produse SET denumire_produs='ID.5 Pro' WHERE id_produs='ID.5Pc';
UPDATE puiatania_produse SET denumire_produs='ID.5 Pro Performance' WHERE id_produs='ID.5Pd';
UPDATE puiatania_produse SET denumire_produs='ID.5 GTX' WHERE id_produs='ID.5G';
COMMIT;
INSERT INTO puiatania_reclame VALUES ('Psst1','PstA2TDIC1',3450,TO_DATE('28-02-2018','DD-MM-YYYY'),TO_DATE('31-03-2018','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('Tig1','TgS1.0SI7',3600,TO_DATE('06-06-2021','DD-MM-YYYY'),TO_DATE('15-09-2021','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('ID.51','ID.5Pc',4000,TO_DATE('30-08-2021','DD-MM-YYYY'),TO_DATE('10-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('ID.31','ID.3L',4000,TO_DATE('30-08-2021','DD-MM-YYYY'),TO_DATE('10-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('ID.41','ID.4Pc',4000,TO_DATE('30-08-2021','DD-MM-YYYY'),TO_DATE('10-12-2021','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('Jtt1','Jt2.oDIc',3250,TO_DATE('28-02-2019','DD-MM-YYYY'),TO_DATE('31-03-2019','DD-MM-YYYY'));
INSERT INTO puiatania_reclame VALUES ('Tg1','TgS1.0SI7',3550,TO_DATE('01-08-2021','DD-MM-YYYY'),TO_DATE('31-12-2021','DD-MM-YYYY'));
COMMIT;
INSERT INTO puiatania_functii VALUES('Ctc_mg','Manager CTC',3580);
INSERT INTO puiatania_functii VALUES('Ctc_ag','Agent CTC',2950);
INSERT INTO puiatania_functii VALUES('Prj_mg','Manager proiectare',4000);
INSERT INTO puiatania_functii VALUES('Dsg_mg','Manager design',4000);
COMMIT;
INSERT INTO puiatania_angajati VALUES (100,'Pricop','Daniel',TO_DATE('10.10.2016','DD.MM.YYYY'),'pricop01.dan@yahoo.com','0726022285','Pr_mg','Pr',1);
INSERT INTO puiatania_angajati VALUES (200,'Alexe','Cornel',TO_DATE('11.09.2018','DD.MM.YYYY'),'alexe.cornel@gmail.com','0726022211','Vz_mg','Vz',1);
INSERT INTO puiatania_angajati VALUES (300,'Boaba','Gabriel',TO_DATE('10.11.2017','DD.MM.YYYY'),'gabriel.boaba@gmail.com','0723022285','Cd_mg','Cd',1);
INSERT INTO puiatania_angajati VALUES (400,'Cretu','Rares',TO_DATE('09.12.2016','DD.MM.YYYY'),'creturares@yahoo.com','0726022233','Mk_mg','Mk',1);
INSERT INTO puiatania_angajati VALUES (500,'Grasu','Costin',TO_DATE('10.11.2016','DD.MM.YYYY'),'costingrasu20@yahoo.com','0721032285','Ru_mg','Ru',1);
INSERT INTO puiatania_angajati VALUES (550,'Marghideanu','Ionut',TO_DATE('30.01.2017','DD.MM.YYYY'),'marghideanu.ionut@yahoo.com','0726522255','Tr_mg','Tr',1);
INSERT INTO puiatania_angajati VALUES (700,'Negoiu','Cristian',TO_DATE('01.09.2017','DD.MM.YYYY'),'cristi.negoiu@gmail.com','0726033285','It_mg','It',1);
INSERT INTO puiatania_angajati VALUES (800,'Draghici','Alexandru',TO_DATE('17.02.2018','DD.MM.YYYY'),'alexdraghici@gmail.com','0756122285','Rp_mg','Rp',1);
INSERT INTO puiatania_angajati VALUES (900,'Cobza','Dumitru',TO_DATE('05.05.2019','DD.MM.YYYY'),'cobzadumitru@gmail.com','0726222225','Ac_mg','Ac',1);
INSERT INTO puiatania_angajati VALUES (910,'Enache','Marian',TO_DATE('19.06.2019','DD.MM.YYYY'),'marian.enache@gmail.com','0726022267','Co_mg','Co',1);
INSERT INTO puiatania_angajati VALUES (315,'Manea','Iulian',TO_DATE('10.10.2016','DD.MM.YYYY'),'maneaiulian@yahoo.com','0726828285','Ctc_mg','Ctc',1);
INSERT INTO puiatania_angajati VALUES (320,'Ciulea','Andrei',TO_DATE('30.04.2019','DD.MM.YYYY'),'ciulea.andrei@yahoo.com','0726066685','Prj_mg','Prj',1);
INSERT INTO puiatania_angajati VALUES (425,'Popescu','Ion',TO_DATE('01.12.2019','DD.MM.YYYY'),'popescu.ion@yahoo.com','0726034285','Dsg_mg','Dsg',1);
INSERT INTO puiatania_angajati VALUES (2,'Copcea','Matei',TO_DATE('23.05.2017','DD.MM.YYYY'),'mateicopcea@gmail.com','0734686922','Mg_g','Mn',1);
COMMIT;
UPDATE puiatania_angajati SET id_manager=2 WHERE id_angajat IN (100,200,300,400,500,550,700,800,900,910,315,320,425);
UPDATE puiatania_angajati SET id_departament='Mn' WHERE id_angajat IN (100,200,300,400,500,550,700,800,900,910,315,320,425);

UPDATE puiatania_functii SET id_functie='Con' where denumire_functie='Contabil';
COMMIT;
INSERT INTO puiatania_angajati VALUES (3,'Cosman','Calin',TO_DATE('23.04.2017','DD.MM.YYYY'),'calin.cosman@gmail.com','0734646942','It_prg','It',700);
INSERT INTO puiatania_angajati VALUES (4,'Aslan','Kaan',TO_DATE('30.05.2018','DD.MM.YYYY'),'kaanaslan@yahoo.com','0730606902','It_prg','It',3);
UPDATE puiatania_angajati SET id_functie='It_ing' WHERE id_angajat=3;
INSERT INTO puiatania_angajati VALUES (5,'Caraman','George',TO_DATE('20.03.2018','DD.MM.YYYY'),'georgecaraman24@gmail.com','0739646992','It_prg','It',3);
INSERT INTO puiatania_angajati VALUES (6,'Bordea','Cosmin',TO_DATE('21.11.2019','DD.MM.YYYY'),'bordeea.cosmin34@gmail.com','0734646942','Co_mg','Co',910);
INSERT INTO puiatania_angajati VALUES (7,'Sturzoiu','Teofil',TO_DATE('27.07.2020','DD.MM.YYYY'),'teosturzoiu23@gmail.com','0734646999','Con','Co',6);
COMMIT;
INSERT INTO puiatania_angajati VALUES (8,'Sturdea','Mihai',TO_DATE('27.08.2019','DD.MM.YYYY'),'mihaisturdea@gmail.com','0734646888','Con','Co',6);
COMMIt;
INSERT INTO puiatania_angajati VALUES (9,'Martin','George',TO_DATE('29.08.2018','DD.MM.YYYY'),'george.martin@yahoo.com','0734646777','Ctc_ag','Ctc',315);
COMMIT;
INSERT INTO puiatania_angajati VALUES (10,'Neghina','Laurentiu',TO_DATE('30.08.2017','DD.MM.YYYY'),'neghinalaur29@yahoo.com','0734646666','Ctc_ag','Ctc',315);
COMMIT;
INSERT INTO puiatania_angajati VALUES (11,'Neagru','Gabriel',TO_DATE('29.10.2018','DD.MM.YYYY'),'neaguu.gabriel78@gmail.com','0734646555','Ctc_ag','Ctc',315);
COMMIT;
INSERT INTO puiatania_angajati VALUES (12,'Bobescu','Bogdan',TO_DATE('17.11.2016','DD.MM.YYYY'),'bobescu79bogdan@gmail.com','0734646111','Vz_Ag','Vz',200);
COMMIT;
INSERT INTO puiatania_angajati VALUES (13,'Chiriac','Costin',TO_DATE('07.11.2018','DD.MM.YYYY'),'chiriac.costin13@gmail.com','0734646123','Vz_Ag','Vz',12);
COMMIT;
INSERT INTO puiatania_angajati VALUES (14,'Musatescu','Cristian',TO_DATE('17.12.2017','DD.MM.YYYY'),'mateiescucristi@gmail.com','0734696111','Vz_Ag','Vz',12);
COMMIT;
INSERT INTO puiatania_angajati VALUES (15,'Iorgoveanu','Flavius',TO_DATE('17.01.2019','DD.MM.YYYY'),'flaviusiorgoveanu12@gmail.com','0739646111','Vz_Ag','Vz',12);
INSERT INTO puiatania_angajati VALUES (16,'Ionita','Mihnea',TO_DATE('11.02.2019','DD.MM.YYYY'),'mihneaionita56@gmail.com','0799646111','Vz_Ag','Vz',12);
INSERT INTO puiatania_angajati VALUES (17,'Dracovici','Ciprian',TO_DATE('16.03.2018','DD.MM.YYYY'),'dracovici.ciprian@gmail.com','0722646111','Vz_Ag','Vz',12);
INSERT INTO puiatania_angajati VALUES (18,'Gherman','Traian',TO_DATE('18.04.2019','DD.MM.YYYY'),'ghermantraiannn@yahoo.com','0733646111','Vz_Ag','Vz',12);
INSERT INTO puiatania_angajati VALUES (19,'Iordache','Decebal',TO_DATE('20.12.2019','DD.MM.YYYY'),'decebal.iordache88@yahoo.com','0755646111','Vz_Ag','Vz',12);
COMMIT;
INSERT INTO puiatania_functii VALUES('Dsg_prd','Product Designer',3760);
COMMIT;
INSERT INTO puiatania_functii VALUES('Ru_ag','Agent resurse umane',2900);
COMMIT;
INSERT INTO puiatania_angajati VALUES (20,'Vanghelici','Tudor',TO_DATE('04.01.2019','DD.MM.YYYY'),'vanghelici.tudor2@yahoo.com','0739646111','Dsg_prd','Dsg',425);
INSERT INTO puiatania_angajati VALUES (21,'Caramihai','Costa',TO_DATE('03.02.2019','DD.MM.YYYY'),'caramihai.costaa@gmail.com','0799999999','Dsg_prd','Dsg',425);
INSERT INTO puiatania_angajati VALUES (22,'Liuta','Costin',TO_DATE('05.03.2018','DD.MM.YYYY'),'dracovici.ciprian@gmail.com','0788888888','Dsg_prd','Dsg',425);
COMMIT;
INSERT INTO puiatania_angajati VALUES (23,'Gherghina','Cameliu',TO_DATE('05.11.2016','DD.MM.YYYY'),'gherghinacameliu@gmail.com','0777777777','Prj_ing','Prj',320);
INSERT INTO puiatania_angajati VALUES (24,'Dinescu','Mihail',TO_DATE('13.02.2019','DD.MM.YYYY'),'mihail.dinescuuu@yahoo.com','0722222222','Prj_ing','Prj',320);
INSERT INTO puiatania_angajati VALUES (25,'Musat','Fabian',TO_DATE('16.02.2018','DD.MM.YYYY'),'musatflaviannn@gmail.com','0733333333','Prj_ing','Prj',320);
INSERT INTO puiatania_angajati VALUES (26,'Pufleanu','Stere',TO_DATE('27.02.2019','DD.MM.YYYY'),'stere.pufleanu@gmail.com','0744444444','Prj_ing','Prj',320);
COMMIT;
INSERT INTO puiatania_angajati VALUES (27,'Craciun','Catalin',TO_DATE('11.03.2018','DD.MM.YYYY'),'craciuncatalin@gmail.com','0766666666','Ac_ag','Ac',900);
INSERT INTO puiatania_angajati VALUES (28,'Florescu','Ianis',TO_DATE('16.03.2018','DD.MM.YYYY'),'florescu.ianis@gmail.com','0755555555','Ac_ag','Ac',900);
INSERT INTO puiatania_angajati VALUES (29,'Matraguna','Aron',TO_DATE('17.03.2018','DD.MM.YYYY'),'aron.matraguna202@yahoo.com','0700000000','Ac_ag','Ac',900);
COMMIT;
INSERT INTO puiatania_angajati VALUES (30,'Ionescu','Mihnea',TO_DATE('11.02.2017','DD.MM.YYYY'),'ionescumihnea@gmail.com','0709876543','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (31,'Ionescu','Ciprian',TO_DATE('16.03.2017','DD.MM.YYYY'),'ionescuciprian@gmail.com','0712121212','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (32,'Ionescu','Marius',TO_DATE('17.04.2017','DD.MM.YYYY'),'ionescumarius@gmail.com','0734343434','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (33,'Ionita','Mihnea',TO_DATE('11.05.2018','DD.MM.YYYY'),'mihneaionita@yahoo.com','0756565656','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (34,'Dracovici','Adam',TO_DATE('16.06.2018','DD.MM.YYYY'),'adamdracovici@gmail.com','0778787878','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (35,'Iorgoveanu','Valentin',TO_DATE('17.07.2018','DD.MM.YYYY'),'valentin.iorgoveanu@yahoo.com','0790909090','Tr_s','Tr',550);
INSERT INTO puiatania_angajati VALUES (36,'Ionita','George',TO_DATE('11.08.2019','DD.MM.YYYY'),'george.ionitaaa@gmail.com','0701010101','Tr_s','Tr',550);
COMMIT;
INSERT INTO puiatania_angajati VALUES (37,'Mogos','Madalina',TO_DATE('17.08.2018','DD.MM.YYYY'),'mogos.madalina@yahoo.com','0712312312','Rp_ag','Rp',800);
INSERT INTO puiatania_angajati VALUES (38,'Sereper','Alina',TO_DATE('11.08.2018','DD.MM.YYYY'),'sereperalinaaa@yahoo.com','0723423423','Rp_ag','Rp',800);
INSERT INTO puiatania_angajati VALUES (39,'Dragan','Mariana',TO_DATE('16.08.2018','DD.MM.YYYY'),'marianaaadragan@gmail.com','0734534534','Rp_ag','Rp',800);
COMMIT;
INSERT INTO puiatania_angajati VALUES (40,'Prunea','Claudiu',TO_DATE('17.04.2019','DD.MM.YYYY'),'pruneaclaudiu@gmail.com','0745645645','Ru_ag','Ru',500);
INSERT INTO puiatania_angajati VALUES (41,'Maticiuc','Mihnea',TO_DATE('11.04.2019','DD.MM.YYYY'),'maticiucmihnea@yahoo.com','0756756756','Ru_ag','Ru',500);
INSERT INTO puiatania_angajati VALUES (42,'Moraru','Codrin',TO_DATE('16.04.2019','DD.MM.YYYY'),'codrinmararuuu@yahoo.com','0767867867','Ru_ag','Ru',500);
INSERT INTO puiatania_angajati VALUES (43,'Emina','Cornelia',TO_DATE('17.04.2019','DD.MM.YYYY'),'cornelia.emina@gmail.com','0778978978','Ru_sc','Ru',42);
COMMIT;
INSERT INTO puiatania_angajati VALUES (45,'Stama','Marina',TO_DATE('03.02.2016','DD.MM.YYYY'),'marinastama@yahoo.com','0713513513','Mk_ag','Mk',400);
INSERT INTO puiatania_angajati VALUES (46,'Cojocaru','Sorina',TO_DATE('04.03.2016','DD.MM.YYYY'),'cojocarusorina50@yahoo.com','0735735735','Mk_ag','Mk',400);
INSERT INTO puiatania_angajati VALUES (47,'Potcoava','Monica',TO_DATE('05.01.2016','DD.MM.YYYY'),'potcoava.monica@yahoo.com','0757957957','Mk_ag','Mk',400);
INSERT INTO puiatania_angajati VALUES (48,'Iordache','Magdalena',TO_DATE('06.02.2016','DD.MM.YYYY'),'magdalena.iordache@yahoo.com','0724624624','Mk_ag','Mk',400);
INSERT INTO puiatania_angajati VALUES (49,'Casapu','Catalina',TO_DATE('07.03.2016','DD.MM.YYYY'),'casapu.catalinaa23@yahoo.com','0746846846','Mk_ag','Mk',400);
COMMIT;

INSERT INTO puiatania_angajati VALUES (50,'Moldoveanu','Mihail',TO_DATE('08.01.2019','DD.MM.YYYY'),'moldoveanumihail@gmail.com','0710293847','Pr_ing','Cd',53);
INSERT INTO puiatania_angajati VALUES (51,'Capraru','Codrin',TO_DATE('09.02.2019','DD.MM.YYYY'),'caprarucodrin@gmail.com','0723894576','Pr_ing','Cd',53);
INSERT INTO puiatania_angajati VALUES (52,'Diaconu','Cornel',TO_DATE('10.03.2018','DD.MM.YYYY'),'diaconu.cornel@gmail.com','0711122233','Pr_ing','Cd',53);

INSERT INTO puiatania_angajati VALUES (53,'Slavu','Matei',TO_DATE('11.01.2019','DD.MM.YYYY'),'slavumatei@gmail.com','0722233344','Prj_ing','Cd',300);
INSERT INTO puiatania_angajati VALUES (54,'Sarbu','Alexandru',TO_DATE('13.02.2019','DD.MM.YYYY'),'alexandrusarbu@gmail.com','0733344455','Prj_ing','Cd',300);

INSERT INTO puiatania_angajati VALUES (55,'Sarghi','Andrei',TO_DATE('14.03.2018','DD.MM.YYYY'),'andreisarghi@gmail.com','0744455566','Pr_e','Cd',50);
INSERT INTO puiatania_angajati VALUES (56,'Popovici','Traian',TO_DATE('15.01.2019','DD.MM.YYYY'),'popovici.traian@gmail.com','0755566677','Pr_e','Cd',50);

INSERT INTO puiatania_angajati VALUES (57,'Udrea','Decebal',TO_DATE('16.02.2019','DD.MM.YYYY'),'decebal.udreeea@gmail.com','0766677788','Pr_a','Cd',50);
INSERT INTO puiatania_angajati VALUES (58,'Udriste','Fabian',TO_DATE('17.03.2018','DD.MM.YYYY'),'fabian.udriste@gmail.com','0777788899','Pr_a','Cd',50);

INSERT INTO puiatania_angajati VALUES (59,'Rusu','Cosmin',TO_DATE('18.01.2019','DD.MM.YYYY'),'rusucosmin@gmail.com','0788899900','It_ing','Cd',53);

INSERT INTO puiatania_angajati VALUES (60,'Moldav','Bogdan',TO_DATE('19.02.2019','DD.MM.YYYY'),'moldav.bogdan@gmail.com','0799900011','It_prg','Cd',59);
INSERT INTO puiatania_angajati VALUES (61,'Potop','Costin',TO_DATE('20.03.2018','DD.MM.YYYY'),'potopcostin@gmail.com','0700011122','It_prg','Cd',59);

INSERT INTO puiatania_angajati VALUES (62,'Vidrascu','Flavius',TO_DATE('21.01.2019','DD.MM.YYYY'),'vidrascuflavius@gmail.com','0792648788','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (63,'Spanu','Dan',TO_DATE('22.02.2019','DD.MM.YYYY'),'spanudan@gmail.com','0712571113','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (67,'Dinu','Ciprian',TO_DATE('23.03.2018','DD.MM.YYYY'),'dinuciprian@gmail.com','0717192329','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (68,'Marin','Flavius',TO_DATE('24.01.2019','DD.MM.YYYY'),'marin.flavius@gmail.com','0731374143','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (69,'Tufea','Mihnea',TO_DATE('25.02.2019','DD.MM.YYYY'),'tufea.mihnea@gmail.com','0753505989','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (70,'Bunea','Dumitru',TO_DATE('27.03.2018','DD.MM.YYYY'),'dumitru.bunea@gmail.com','0770717374','Cd_cc','Cd',53);
INSERT INTO puiatania_angajati VALUES (71,'Hurdea','Flavius',TO_DATE('28.01.2019','DD.MM.YYYY'),'flavius.hurdea@gmail.com','0775767879','Cd_cc','Cd',53);

INSERT INTO puiatania_angajati VALUES (72,'Hudici','Mihnea',TO_DATE('11.01.2019','DD.MM.YYYY'),'mihnea.hudici6@gmail.com','0701020304','Cd_s','Cd',62);
INSERT INTO puiatania_angajati VALUES (73,'Dracovici','Ciprian',TO_DATE('16.02.2018','DD.MM.YYYY'),'dracoviciciprian36@gmail.com','0710121314','Cd_s','Cd',62);
INSERT INTO puiatania_angajati VALUES (74,'Iordachescu','Laurentiu',TO_DATE('17.03.2019','DD.MM.YYYY'),'iordache.laurentiu90@gmail.com','0715161718','Cd_s','Cd',62);
COMMIT;

INSERT INTO puiatania_angajati VALUES (75,'Jilav','Stelian',TO_DATE('31.01.2019','DD.MM.YYYY'),'jilavstelian@yahoo.com','0799989796','Pr_ing','Pr',89);
INSERT INTO puiatania_angajati VALUES (76,'Cornea','Tase',TO_DATE('28.02.2019','DD.MM.YYYY'),'corneatase@yahoo.com','0706080402','Pr_ing','Pr',89);
INSERT INTO puiatania_angajati VALUES (77,'Popa','Dumitru',TO_DATE('30.03.2018','DD.MM.YYYY'),'popadumitru@yahoo.com','0736936933','Pr_ing','Pr',89);
INSERT INTO puiatania_angajati VALUES (78,'Cornateanu','Mihai',TO_DATE('29.04.2019','DD.MM.YYYY'),'cornateanumihai@yahoo.com','0701012222','Pr_ing','Pr',89);

INSERT INTO puiatania_angajati VALUES (79,'Scarlat','Gheorghe',TO_DATE('27.05.2019','DD.MM.YYYY'),'scarlatgheorghe@yahoo.com','0701013333','Pr_e','Pr',75);
INSERT INTO puiatania_angajati VALUES (80,'Florea','Bogdan',TO_DATE('26.06.2018','DD.MM.YYYY'),'floreabogdan@yahoo.com','0701014444','Pr_e','Pr',79);
INSERT INTO puiatania_angajati VALUES (81,'Ghirdea','Marian',TO_DATE('25.07.2019','DD.MM.YYYY'),'ghirdeamarian@yahoo.com','0702025555','Pr_e','Pr',79);
INSERT INTO puiatania_angajati VALUES (82,'Prodan','Gabriel',TO_DATE('24.08.2019','DD.MM.YYYY'),'prodan.gabriel@yahoo.com','0701016666','Pr_e','Pr',79);
INSERT INTO puiatania_angajati VALUES (83,'Mutu','Mihail',TO_DATE('23.09.2018','DD.MM.YYYY'),'mutumihaail@yahoo.com','0701017777','Pr_e','Pr',79);

INSERT INTO puiatania_angajati VALUES (84,'Slavescu','Costin',TO_DATE('22.10.2019','DD.MM.YYYY'),'slavescucostin@yahoo.com','0701018888','Pr_a','Pr',75);
INSERT INTO puiatania_angajati VALUES (85,'Mateiescu','Alin',TO_DATE('21.11.2019','DD.MM.YYYY'),'mateiescu.alin@yahoo.com','0701019999','Pr_a','Pr',84);
INSERT INTO puiatania_angajati VALUES (86,'Tentea','Paul',TO_DATE('20.12.2018','DD.MM.YYYY'),'paul.tentea@yahoo.com','0701010000','Pr_a','Pr',84);
INSERT INTO puiatania_angajati VALUES (87,'Stanculescu','Ioan',TO_DATE('19.12.2019','DD.MM.YYYY'),'ioan.stanculescu@yahoo.com','0702020000','Pr_a','Pr',84);
INSERT INTO puiatania_angajati VALUES (88,'Stanescu','Ionel',TO_DATE('18.11.2019','DD.MM.YYYY'),'ionel.stanescu@yahoo.com','0702021111','Pr_a','Pr',84);

INSERT INTO puiatania_angajati VALUES (89,'Arpasanu','Darius',TO_DATE('17.10.2018','DD.MM.YYYY'),'arpasanudarius@yahoo.com','0702022222','Prj_ing','Pr',100);

INSERT INTO puiatania_angajati VALUES (91,'Panait','Florian',TO_DATE('16.09.2019','DD.MM.YYYY'),'panaitflorian@yahoo.com','0702023333','It_prg','Pr',89);
INSERT INTO puiatania_angajati VALUES (92,'Istrate','Augustin',TO_DATE('15.08.2019','DD.MM.YYYY'),'istrateaugustin56@yahoo.com','0702024444','It_prg','Pr',89);
COMMIT;

ALTER TABLE puiatania_concedii MODIFY(id_concediu NUMBER(5));

INSERT INTO puiatania_concedii VALUES(1,3,TO_DATE('20.05.2018','DD.MM.YYYY'),TO_DATE('10.06.2018','DD.MM.YYYY'),'Medical-cu plata',235);
INSERT INTO puiatania_concedii VALUES(2,3,TO_DATE('25.09.2019','DD.MM.YYYY'),TO_DATE('03.10.2019','DD.MM.YYYY'),'Odihna-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(3,10,TO_DATE('13.04.2018','DD.MM.YYYY'),TO_DATE('13.05.2018','DD.MM.YYYY'),'Medical-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(4,10,TO_DATE('15.07.2018','DD.MM.YYYY'),TO_DATE('19.07.2018','DD.MM.YYYY'),'Medical-cu plata',260);
INSERT INTO puiatania_concedii VALUES(5,10,TO_DATE('27.06.2020','DD.MM.YYYY'),TO_DATE('30.06.2020','DD.MM.YYYY'),'Odihna-cu plata',50);
COMMIT;
INSERT INTO puiatania_concedii VALUES(6,20,TO_DATE('20.05.2020','DD.MM.YYYY'),TO_DATE('10.06.2020','DD.MM.YYYY'),'Medical-cu plata',220);
INSERT INTO puiatania_concedii VALUES(7,30,TO_DATE('25.09.2020','DD.MM.YYYY'),TO_DATE('03.10.2020','DD.MM.YYYY'),'Medical-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(8,40,TO_DATE('13.04.2020','DD.MM.YYYY'),TO_DATE('13.05.2020','DD.MM.YYYY'),'Medical-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(9,50,TO_DATE('15.07.2020','DD.MM.YYYY'),TO_DATE('19.07.2020','DD.MM.YYYY'),'Medical-cu plata',275);
INSERT INTO puiatania_concedii VALUES(10,60,TO_DATE('27.06.2021','DD.MM.YYYY'),TO_DATE('30.06.2021','DD.MM.YYYY'),'Medical-cu plata',180);
COMMIT;
INSERT INTO puiatania_concedii VALUES(11,70,TO_DATE('10.06.2020','DD.MM.YYYY'),TO_DATE('10.07.2020','DD.MM.YYYY'),'Odihna-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(12,91,TO_DATE('10.07.2020','DD.MM.YYYY'),TO_DATE('20.07.2020','DD.MM.YYYY'),'Odihna-fara plata',NULL);
INSERT INTO puiatania_concedii VALUES(13,80,TO_DATE('20.07.2020','DD.MM.YYYY'),TO_DATE('03.08.2020','DD.MM.YYYY'),'Medical-cu plata',500);
INSERT INTO puiatania_concedii VALUES(14,85,TO_DATE('15.07.2020','DD.MM.YYYY'),TO_DATE('19.07.2020','DD.MM.YYYY'),'Medical-cu plata',260);
INSERT INTO puiatania_concedii VALUES(15,34,TO_DATE('27.06.2021','DD.MM.YYYY'),TO_DATE('30.06.2021','DD.MM.YYYY'),'Odihna-cu plata',80);
COMMIT;
INSERT INTO puiatania_concedii VALUES(16,41,TO_DATE('10.02.2020','DD.MM.YYYY'),TO_DATE('24.02.2020','DD.MM.YYYY'),'Medical-cu plata',335);
INSERT INTO puiatania_concedii VALUES(17,51,TO_DATE('10.03.2020','DD.MM.YYYY'),TO_DATE('24.03.2020','DD.MM.YYYY'),'Medical-cu plata',300);
INSERT INTO puiatania_concedii VALUES(18,61,TO_DATE('10.04.2020','DD.MM.YYYY'),TO_DATE('24.04.2020','DD.MM.YYYY'),'Medical-cu plata',345);
INSERT INTO puiatania_concedii VALUES(19,71,TO_DATE('10.05.2020','DD.MM.YYYY'),TO_DATE('24.05.2020','DD.MM.YYYY'),'Medical-cu plata',600);
INSERT INTO puiatania_concedii VALUES(20,81,TO_DATE('10.06.2020','DD.MM.YYYY'),TO_DATE('24.06.2020','DD.MM.YYYY'),'Medical-cu plata',510);
COMMIT;

INSERT INTO puiatania_concedii VALUES(21,41,TO_DATE('10.02.2021','DD.MM.YYYY'),TO_DATE('24.02.2021','DD.MM.YYYY'),'Odihna-fara plata',NULL);
COMMIT;

DELETE FROM puiatania_concedii WHERE id_concediu=21;

COMMIT;

INSERT INTO puiatania_comenzi VALUES(1,1,TO_DATE('15.03.2018','DD.MM.YYYY'),12);
INSERT INTO puiatania_comenzi VALUES(2,2,TO_DATE('29.03.2018','DD.MM.YYYY'),17);
INSERT INTO puiatania_comenzi VALUES(3,3,TO_DATE('23.03.2018','DD.MM.YYYY'),14);
INSERT INTO puiatania_comenzi VALUES(4,4,TO_DATE('16.03.2018','DD.MM.YYYY'),12);
INSERT INTO puiatania_comenzi VALUES(5,5,TO_DATE('17.03.2018','DD.MM.YYYY'),14);
COMMIT;
INSERT INTO puiatania_comenzi VALUES(6,6,TO_DATE('15.09.2021','DD.MM.YYYY'),13);
INSERT INTO puiatania_comenzi VALUES(7,7,TO_DATE('18.09.2021','DD.MM.YYYY'),15);
INSERT INTO puiatania_comenzi VALUES(8,8,TO_DATE('23.06.2021','DD.MM.YYYY'),16);
INSERT INTO puiatania_comenzi VALUES(9,9,TO_DATE('16.06.2021','DD.MM.YYYY'),18);
INSERT INTO puiatania_comenzi VALUES(10,10,TO_DATE('17.08.2021','DD.MM.YYYY'),19);
COMMIT;
INSERT INTO puiatania_comenzi VALUES(11,11,TO_DATE('15.12.2021','DD.MM.YYYY'),19);
INSERT INTO puiatania_comenzi VALUES(12,12,TO_DATE('29.12.2021','DD.MM.YYYY'),18);
INSERT INTO puiatania_comenzi VALUES(13,13,TO_DATE('23.12.2021','DD.MM.YYYY'),17);
INSERT INTO puiatania_comenzi VALUES(14,14,TO_DATE('16.12.2021','DD.MM.YYYY'),16);
INSERT INTO puiatania_comenzi VALUES(15,15,TO_DATE('17.12.2021','DD.MM.YYYY'),15);
COMMIT;
INSERT INTO puiatania_comenzi VALUES(16,1,TO_DATE('15.03.2018','DD.MM.YYYY'),12);
INSERT INTO puiatania_comenzi VALUES(17,2,TO_DATE('29.03.2019','DD.MM.YYYY'),17);
INSERT INTO puiatania_comenzi VALUES(18,3,TO_DATE('23.03.2019','DD.MM.YYYY'),14);
INSERT INTO puiatania_comenzi VALUES(19,4,TO_DATE('18.01.2022','DD.MM.YYYY'),12);
INSERT INTO puiatania_comenzi VALUES(20,3,TO_DATE('17.03.2019','DD.MM.YYYY'),14);
COMMIT;

INSERT INTO puiatania_rand_comenzi VALUES(1,'PstA2TDIC1',2,38000);
INSERT INTO puiatania_rand_comenzi VALUES(2,'PstA2TDIH2',1,45000);
INSERT INTO puiatania_rand_comenzi VALUES(3,'Pst1.5sIC3',1,34000);
INSERT INTO puiatania_rand_comenzi VALUES(4,'TigL1.5SI4',1,37500);
INSERT INTO puiatania_rand_comenzi VALUES(5,'TigL2.0DI5',1,43700);
COMMIT;
INSERT INTO puiatania_rand_comenzi VALUES(6,'ID.3L',1,46000);
INSERT INTO puiatania_rand_comenzi VALUES(7,'ID.3S',1,57000);
INSERT INTO puiatania_rand_comenzi VALUES(8,'TgL1.0SI6',2,22500);
INSERT INTO puiatania_rand_comenzi VALUES(9,'ID.3T',1,59750);
INSERT INTO puiatania_rand_comenzi VALUES(10,'ID.4Pc',1,52900);
COMMIT;
INSERT INTO puiatania_rand_comenzi VALUES(11,'ID.4Pd',1,56250);
INSERT INTO puiatania_rand_comenzi VALUES(12,'ID.4G',1,67500);
INSERT INTO puiatania_rand_comenzi VALUES(13,'ID.5Pc',1,56900);
INSERT INTO puiatania_rand_comenzi VALUES(14,'ID.5Pd',1,59750);
INSERT INTO puiatania_rand_comenzi VALUES(15,'ID.5G',1,67950);
COMMIT;
INSERT INTO puiatania_rand_comenzi VALUES(16,'Jt2.0DIt',2,36000);
INSERT INTO puiatania_rand_comenzi VALUES(17,'Jt2.oDIc',3,37500);
INSERT INTO puiatania_rand_comenzi VALUES(18,'Jt1.5SIh',3,45000);
INSERT INTO puiatania_rand_comenzi VALUES(19,'ID.5Pd',1,62500);
INSERT INTO puiatania_rand_comenzi VALUES(20,'PstA2TDIH2',2,45000);
COMMIT;

SELECT id_comanda FROM puiatania_comenzi ORDER BY data_comanda;

SELECT id_produs,denumire_produs,motorizare,cost_productie
FROM puiatania_produse
WHERE UPPER(motorizare)!='BENZINA' AND cost_productie>50000;

SELECT data_comanda,denumire_produs
FROM puiatania_comenzi c,puiatania_rand_comenzi r,puiatania_produse p
WHERE c.id_comanda=r.id_comanda AND p.id_produs=r.id_produs;

SELECT denumire_produs,categorie,cost_productie,id_comanda,pret_vanzare
FROM puiatania_produse  LEFT JOIN puiatania_rand_comenzi 
USING (id_produs);

SELECT *
FROM puiatania_produse  INNER JOIN puiatania_rand_comenzi 
USING (id_produs);

SELECT * FROM puiatania_angajati
WHERE id_angajat IN
(SELECT a.id_angajat FROM puiatania_angajati a
INTERSECT
SELECT c.id_angajat FROM puiatania_comenzi c);

SELECT id_produs,data_incepere_campanie,data_incheiere_campanie FROM puiatania_reclame
MINUS
SELECT id_produs,data_incepere_promotie,data_incheiere_promotie FROM puiatania_promotii;

SELECT id_angajat,nume_angajat,LEVEL,
SYS_CONNECT_BY_PATH(id_angajat,'/') id_superori
FROM puiatania_angajati
START WITH id_angajat=1
CONNECT BY PRIOR id_angajat=id_manager;

UPDATE puiatania_produse
SET data_lansare=(SELECT data_lansare 
FROM puiatania_produse 
WHERE lower(denumire_produs)='taigo r-line')
WHERE lower(denumire_produs) LIKE 'taigo%';

SELECT id_produs,denumire_produs,data_lansare 
FROM puiatania_produse
WHERE lower(denumire_produs) LIKE 'taigo%';

SELECT denumire_produs,motorizare,
DECODE(UPPER(motorizare),'MOTORINA','Daunatoare mediului',
'BENZINA','Daunatoare mediului','Mai putin daunatoare')
impact_asupra_mediului
FROM puiatania_produse;

SELECT id_produs,denumire_produs,
TO_CHAR(cost_productie,'99,999$')
FROM puiatania_produse;

SELECT id_produs,denumire_produs,
CASE
WHEN EXTRACT(YEAR FROM data_lansare)<=2020 
THEN 'Vechi'
ELSE 'Nou' END vechime
FROM puiatania_produse;

SELECT COUNT(id_angajat) FROM puiatania_angajati WHERE EXTRACT(YEAR FROM data_angajare)<=2018;

SELECT COUNT(*) FROM puiatania_angajati a,puiatania_concedii c 
WHERE a.id_angajat=c.id_angajat(+);

SELECT SUM(pret_vanzare*cantitate) "Cifra de afaceri"
FROM puiatania_comenzi c, puiatania_rand_comenzi r
WHERE c.id_comanda=r.id_comanda 
AND EXTRACT(YEAR FROM data_comanda)=2021;

SELECT p.id_produs,denumire_produs,SUM(cantitate) "Numar de produse vandute"
FROM puiatania_rand_comenzi r,puiatania_produse p
WHERE p.id_produs=r.id_produs(+)
GROUP BY p.id_produs,denumire_produs;

SELECT denumire_produs,MAX(SUM(cantitate)) "Numar de cereri"
FROM puiatania_rand_comenzi r,puiatania_produse p
WHERE p.id_produs=r.id_produs(+);

SELECT p.id_produs,denumire_produs,SUM(cantitate) "Numar de produse vandute"
FROM puiatania_rand_comenzi r,puiatania_produse p
WHERE p.id_produs=r.id_produs(+)
GROUP BY p.id_produs,denumire_produs
HAVING SUM(cantitate)>=2;

SELECT EXTRACT(YEAR FROM data_incepere_concediu) anul, 
SUM(NVL(suma_plata,0)) suma
FROM puiatania_concedii
GROUP BY EXTRACT(YEAR FROM data_incepere_concediu)
ORDER BY EXTRACT(YEAR FROM data_incepere_concediu);

