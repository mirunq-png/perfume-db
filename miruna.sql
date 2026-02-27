-- debug in caz de necaz --
drop table Oferte cascade constraints;
drop table ParfumuriCategorii cascade constraints;
drop table Parfumuri cascade constraints;
drop table Magazine cascade constraints;
drop table Categorii cascade constraints;
drop table Branduri cascade constraints;
--

-- crearea tabelelor --
create table Branduri (
    brandID number(4),
    numeBrand varchar2(20),
    constraint pk_branduri primary key (brandID)
);

create table Categorii (
    categorieID number(2),
    numeCategorie varchar2(20),
    constraint pk_categorii primary key (categorieID)
);

create table Magazine (
    magazinID number(2),
    numeMagazin varchar2(20),
    constraint pk_magazine primary key (magazinID)
);

create table Parfumuri (
    parfumID number(4),
    numeParfum varchar2(20),
    dataLansare date,
    brandID number(4),
    pretProductie number(3) not null,
    constraint pk_parfumuri primary key (parfumID),
    constraint fk_parfum_brand foreign key (brandID) references Branduri(brandID)
);

create table ParfumuriCategorii (
    parfumID number(4),
    categorieID number(2),
    constraint pk_parf_cat primary key (parfumID, categorieID),
    constraint fk_pc_parfum foreign key (parfumID) references Parfumuri(parfumID),
    constraint fk_pc_cat foreign key (categorieID) references Categorii(categorieID)
);

create table Oferte (
    ofertaID number(2),
    parfumID number(4),
    magazinID number(2),
    adaosComercial number(5,2) not null,
    stoc number(2),
    constraint pk_oferte primary key (ofertaID),
    constraint fk_oferta_parf foreign key (parfumID) references Parfumuri(parfumID),
    constraint fk_oferta_mag foreign key (magazinID) references Magazine(magazinID)
);

-- actualizarea structurii tabelelor si modificarea restrictiilor de integritate --
-- coloana noua website
alter table Branduri 
add website varchar2(50);

-- modificam dimensiunea numeMagazin
alter table Magazine 
modify numeMagazin varchar2(50);

-- adaugam o restrictie
alter table Parfumuri 
add constraint ck_pret_pozitiv check (pretProductie > 0);

-- stergem coloana website
alter table Branduri 
drop column website;
describe Branduri;

-- adaugare inregistrari--

-- inserare in Branduri
insert into Branduri values (10, 'Burberry');
insert into Branduri values (20, 'Dior');
insert into Branduri values (30, 'Lattafa');
insert into Branduri values (40, 'Kayali');
insert into Branduri values (50, 'Tom Ford');
insert into Branduri values (60, 'Kilian');
insert into Branduri values (70, 'Yves Saint Laurent');
insert into Branduri values (80, 'Lancome');
insert into Branduri values (90, 'Montale');
insert into Branduri values (100, 'Paco Rabanne');
insert into Branduri values (110, 'Issey Miyake');
insert into Branduri values (120, 'Versace');

-- inserare in Categorii
insert into Categorii values (1, 'Fructat');
insert into Categorii values (2, 'Dulce');
insert into Categorii values (3, 'Floral');
insert into Categorii values (4, 'Lemnos');
insert into Categorii values (5, 'Citric');
insert into Categorii values (6, 'Picant');

-- inserare in Magazine
insert into Magazine values (1, 'Sephora Vitan');
insert into Magazine values (2, 'Douglas Vitan');
insert into Magazine values (3, 'Vivantis');
insert into Magazine values (4, 'Notino');
insert into Magazine values (5, 'Fragranza');
insert into Magazine values (6, 'Obsentum');
insert into Magazine values (7, 'Duty Free Otopeni');
insert into Magazine values (8, 'Sephora Promenada');
insert into Magazine values (9, 'Douglas Sun Plaza');
insert into Magazine values (10, 'Parfumat');
insert into Magazine values (11, 'Dubai Collection');
insert into Magazine values (12, 'Esente de Lux');

-- inserare in Parfumuri
insert into Parfumuri values (1001, 'Her Elixir', to_date('2022-09-01', 'YYYY-MM-DD'), 10, 95); -- Burberry
insert into Parfumuri values (1002, 'Yara', to_date('2020-01-01', 'YYYY-MM-DD'), 30, 45); -- Lattafa
insert into Parfumuri values (1003, 'Eclaire', to_date('2024-06-01', 'YYYY-MM-DD'), 30, 50); -- Lattafa
insert into Parfumuri values (1004, 'Yum Boujee Marsh', to_date('2024-10-01', 'YYYY-MM-DD'), 40, 110); -- Kayali
insert into Parfumuri values (1005, 'Tobacco Vanille', to_date('2007-09-01', 'YYYY-MM-DD'), 50, 150); -- Tom Ford
insert into Parfumuri values (1006, 'Lost Cherry', to_date('2018-10-02', 'YYYY-MM-DD'), 50, 190); -- Tom Ford
insert into Parfumuri values (1007, 'Princess', to_date('2018-08-15', 'YYYY-MM-DD'), 60, 105); -- Kilian
insert into Parfumuri values (1008, 'Libre', to_date('2019-09-01', 'YYYY-MM-DD'), 70, 88); -- YSL
insert into Parfumuri values (1009, 'La Vie Est Belle', to_date('2012-08-01', 'YYYY-MM-DD'), 80, 82); -- Lancome
insert into Parfumuri values (1010, 'La Nuit Tresor', to_date('2015-02-01', 'YYYY-MM-DD'), 80, 85); -- Lancome
insert into Parfumuri values (1011, 'Roses Musk', to_date('2009-01-01', 'YYYY-MM-DD'), 90, 90); -- Montale
insert into Parfumuri values (1012, 'Invictus Victory', to_date('2021-01-01', 'YYYY-MM-DD'), 100, 75); -- Paco Rabanne
insert into Parfumuri values (1013, 'L''Eau d''Issey PH', to_date('1994-01-01', 'YYYY-MM-DD'), 110, 60); -- Issey Miyake
insert into Parfumuri values (1014, 'Eros', to_date('2012-08-15', 'YYYY-MM-DD'), 120, 55); -- Versace

-- inserare in ParfumuriCategori
-- fiecare parfum primeste o categorie principala, iar 1006 primeste doua
insert into ParfumuriCategorii values (1001, 1); -- Her Elixir: Fructat
insert into ParfumuriCategorii values (1002, 2); -- Yara: Dulce
insert into ParfumuriCategorii values (1003, 2); -- Eclaire: Dulce
insert into ParfumuriCategorii values (1004, 2); -- Yum Boujee: Dulce
insert into ParfumuriCategorii values (1005, 4); -- Tobacco Vanille: Lemnos
insert into ParfumuriCategorii values (1006, 1); -- Lost Cherry: Fructat
insert into ParfumuriCategorii values (1006, 2); -- Lost Cherry: Dulce (dubla categorisire)
insert into ParfumuriCategorii values (1007, 6); -- Princess: Picant
insert into ParfumuriCategorii values (1008, 3); -- Libre: Floral
insert into ParfumuriCategorii values (1009, 2); -- La Vie Est Belle: Dulce
insert into ParfumuriCategorii values (1010, 1); -- La Nuit Tresor: Fructat
insert into ParfumuriCategorii values (1011, 3); -- Roses Musk: Floral
insert into ParfumuriCategorii values (1012, 5); -- Invictus: Citric
insert into ParfumuriCategorii values (1013, 5); -- Issey PH: Citric
insert into ParfumuriCategorii values (1014, 5); -- Eros: Citric

-- inserare in Oferte
insert into Oferte values (1, 1001, 1, 35.00, 20); -- Her Elixir - Sephora Vitan
insert into Oferte values (2, 1002, 11, 20.00, 50); -- Yara - Dubai Collection
insert into Oferte values (3, 1003, 11, 25.00, 30); -- Eclaire - Dubai Collection
insert into Oferte values (4, 1004, 8, 45.00, 10); -- Yum Boujee - Sephora Promenada
insert into Oferte values (5, 1005, 6, 60.00, 5); -- Tobacco Vanille - Obsentum
insert into Oferte values (6, 1006, 6, 65.00, 6); -- Lost Cherry - Obsentum
insert into Oferte values (7, 1007, 12, 50.00, 5); -- Princess - Esente de Lux
insert into Oferte values (8, 1008, 2, 35.00, 18); -- Libre - Douglas Vitan
insert into Oferte values (9, 1008, 1, 35.00, 12); -- Libre - Sephora Vitan 
insert into Oferte values (10, 1009, 4, 28.00, 30); -- La Vie Est Belle - Notino
insert into Oferte values (11, 1010, 5, 32.00, 10); -- La Nuit Tresor - Fragranza
insert into Oferte values (12, 1011, 12, 45.00, 10); -- Roses Musk - Esente de Lux
insert into Oferte values (13, 1012, 9, 30.00, 18); -- Invictus Victory - Douglas Sun Plaza
insert into Oferte values (14, 1013, 3, 25.00, 12); -- Issey PH - Vivantis
insert into Oferte values (15, 1014, 10, 22.00, 35); -- Eros - Parfumat

select * from Branduri;
select * from Categorii;
select * from Magazine;
select * from Parfumuri;
select * from ParfumuriCategorii;
select * from Oferte;
commit;

-- actualizare date --
-- insert
insert into Branduri (brandID, numeBrand) 
values (999, 'Miruna Fragrance');
insert into Parfumuri (parfumID, numeParfum, dataLansare, brandID, pretProductie) 
values (9999, 'Parfum Miru', sysdate, 999, 150);

-- update
update Parfumuri 
set pretProductie = 200 
where parfumID = 9999;

-- delete
delete from Parfumuri 
where parfumID = 9999;
delete from Branduri 
where brandID = 999;
select * from Parfumuri;

-- stergere/recuperare tabela --
drop table Oferte;
select * from Oferte; -- tb sa dea err
flashback table Oferte to before drop;
alter table Oferte drop primary key;
alter table Oferte
add constraint pk_oferte primary key (ofertaID);
alter table Oferte
add constraint fk_oferta_parf foreign key (parfumID) references Parfumuri(parfumID);
alter table Oferte
add constraint fk_oferta_mag foreign key (magazinID) references Magazine(magazinID);
alter table Oferte drop constraint "BIN$Tp6kIFC8TIKzWBVuivgi6g==$0";
alter table Oferte 
modify adaosComercial constraint nn_adaos_comercial not null;
-- verificam ca totul e ok
select constraint_name, constraint_type 
from user_constraints 
where table_name = 'OFERTE';

-- interogari --
--1 sa se afiseze numele parfumului, anul lansarii si brandul
select p.numeParfum, p.dataLansare, b.numeBrand
from Parfumuri p, Branduri b
where p.brandID = b.brandID;

--2 sa se afiseze numele parfumurilor cu un pret intre 60 si 80
select p.numeParfum, (p.pretProductie + o.adaosComercial) as pretFinal
from Parfumuri p, Oferte o
where p.parfumID = o.parfumID
and (p.pretProductie + o.adaosComercial) between 60 and 80;

--3 sa se afiseze toate parfumurile+categoriile, ordonate alfabetic
select p.numeParfum, c.numeCategorie
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
order by p.numeParfum, c.numeCategorie;

--4 sa se afiseze magazinele care au in denumire cuvantul sephora
select magazinID, numeMagazin
from Magazine
where numeMagazin like '%Sephora%';

--5 sa se afiseze ofertele din douglas
select p.numeParfum, m.numeMagazin, o.stoc, (p.pretProductie + o.adaosComercial) as pretFinal
from Parfumuri p, Oferte o, Magazine m
where p.parfumID = o.parfumID
and o.magazinID = m.magazinID
and m.numeMagazin like '%Douglas%';

--6 sa se afiseze parfumurile lattafa, kayali, tf
select p.numeParfum, b.numeBrand, p.pretProductie
from Parfumuri p, Branduri b
where p.brandID = b.brandID
and b.numeBrand in ('Lattafa', 'Kayali', 'Tom Ford')
order by p.numeParfum;

--7 sa se afiseze magazinele si parfumurile unde stocul e mai mic de 10
select m.numeMagazin, p.numeParfum, o.stoc
from Oferte o, Magazine m, Parfumuri p
where o.magazinID = m.magazinID
and o.parfumID = p.parfumID
and o.stoc < 10;

--8 sa se afiseze numele brandurilor cu majuscule si lungimea numelor parfumurilor
select upper(b.numeBrand) as brand, p.numeParfum, length(p.numeParfum) as lungimeParfum
from Branduri b, Parfumuri p
where b.brandID = p.brandID;

--9 sa se afiseze vechimea parfumurilor
select numeParfum, dataLansare, round(months_between(sysdate, dataLansare) / 12, 1) as ani
from Parfumuri;

--10 sa se formateze data lansarii in format "zi luna, an"
select numeParfum, to_char(dataLansare, 'DD Month, YYYY') as data
from Parfumuri;
select dataLansare from Parfumuri;

--11 sa se afiseze valoarea totala a stocului pentru fiecare oferta
select p.numeParfum, (o.stoc * (p.pretProductie + o.adaosComercial)) as val
from Oferte o, Parfumuri p
where o.parfumID = p.parfumID;

--12 sa se afizeze "magazinul x vinde parfumul y"
select m.numeMagazin || ' vinde parfumul ' || p.numeParfum ||'.' as oferta
from Oferte o, Magazine m, Parfumuri p
where o.magazinID = m.magazinID
and o.parfumID = p.parfumID;

--13 sa se clasifice parfumurile in functie de pret (accesibil <80, mediu 80-120, premium altfel)
select numeParfum, pretProductie,
case 
    when pretProductie < 80 then 'accesibil'
    when pretProductie < 120 then 'mediu'
    else 'premium'
end as clasificare
from Parfumuri
order by clasificare, pretProductie;

--14 sa se afiseze o descriere pentru fiecare categorie
select numeCategorie,
decode(categorieID, 
    1, 'categorie populara - fructat',
    2, 'categorie best seller - dulce',
    3, 'categorie clasica - floral',
    'alta categorie') as descriere
from Categorii;

--15 sa se afiseze parfumurile cu id impar
select parfumID, numeParfum
from Parfumuri
where mod(parfumID,2)=1;

--16 sa se afiseze nr de parfumuri lansate de fiecare brand
select b.numeBrand, count(p.parfumID) as nr
from Branduri b, Parfumuri p
where b.brandID = p.brandID
group by b.numeBrand;

--17 sa se afiseze pretul mediu de productie pentru parfumuri, in functie de brand
select b.numeBrand, round(avg(p.pretProductie), 2) as pret
from Branduri b, Parfumuri p
where b.brandID = p.brandID
group by b.numeBrand;

--18 sa se afiseze cel mai mic si cel mai mare adaos comercial in fiecare magazin
select m.numeMagazin, min(o.adaosComercial) as min, max(o.adaosComercial) as max
from Magazine m, Oferte o
where m.magazinID = o.magazinID
group by m.numeMagazin;

--19 sa se afiseze stocul total in fiecare magazin
select m.numeMagazin, sum(o.stoc) as stoc
from Magazine m, Oferte o
where m.magazinID = o.magazinID
group by m.numeMagazin;

--20 sa se afiseze doar brandurile cu minim 2 parfumuri lansate
select b.numeBrand, count(p.parfumID) as nr
from Branduri b, Parfumuri p
where b.brandID = p.brandID
group by b.numeBrand
having count(p.parfumID) >= 2;

--21 sa se afiseze categoriile de parfumuri unde pretul mediu de productie >80
select c.numeCategorie, round(avg(p.pretProductie), 2) as medie
from Categorii c, ParfumuriCategorii pc, Parfumuri p
where c.categorieID = pc.categorieID
and pc.parfumID = p.parfumID
group by c.numeCategorie
having avg(p.pretProductie) > 80;

--22 sa se afiseze cel mai scump pret de productie pentru fiecare an al lansarii
select to_char(dataLansare, 'YYYY') as an, max(pretProductie) as max
from Parfumuri
group by to_char(dataLansare, 'YYYY')
order by an desc;

--23 sa se afiseze in cate magazine se gaseste un brand
select b.numeBrand, count(distinct o.magazinID) as nrMagazine
from Branduri b, Parfumuri p, Oferte o
where b.brandID = p.brandID
  and p.parfumID = o.parfumID
group by b.numeBrand;

--24 sa se afiseze numele si pretul parf care sunt mai scumpe decat media preturilor
select p.numeParfum, (p.pretProductie + o.adaosComercial) as pret
from Parfumuri p, Oferte o
where p.parfumID = o.parfumID
and (p.pretProductie + o.adaosComercial) > (
    select avg(p2.pretProductie + o2.adaosComercial)
    from Parfumuri p2, Oferte o2
    where p2.parfumID = o2.parfumID
);

--25 sa se afiseze ofertele unde stocul este mai mare decat stocul mediu in magazinul curent
select p.numeParfum, o.stoc, m.numeMagazin
from Parfumuri p, Oferte o, Magazine m
where p.parfumID = o.parfumID
and o.magazinID = m.magazinID
and o.stoc > (
    select avg(stoc) 
    from Oferte 
    where magazinID = o.magazinID
);

--26 sa se afiseze numele brandurilor care au parfumuri dupa 2020
select b.numeBrand, p.numeParfum, p.dataLansare
from Branduri b, Parfumuri p
where b.brandID = p.brandID
and p.parfumID in (
    select parfumID 
    from Parfumuri 
    where dataLansare > to_date('01-01-2020', 'DD-MM-YYYY')
);

--27 sa se afiseze parfumurile care sunt fie citrice, fie lemnoase
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Citric'
union
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Lemnos';

--28 sa se afiseze parfumurile dulci, dar nu fructate
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Dulce'
minus
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Fructat'; -- nu apare lost cherry

--29 sa se afiseze parfumurile dulci si fructate
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Dulce'
intersect
select p.numeParfum
from Parfumuri p, ParfumuriCategorii pc, Categorii c
where p.parfumID = pc.parfumID
and pc.categorieID = c.categorieID
and c.numeCategorie = 'Fructat'; -- doar lost cherry

--30 sa se afiseze toate brandurile si parfumurile, inclusiv brandurile care nu au lansat niciun parfum
select b.numeBrand, p.numeParfum
from Branduri b, Parfumuri p
where b.brandID = p.brandID (+)
order by numeBrand;

--obiecte--
--1.1 view cu nume parfum, nume magazin, pret (=pret productie+adaos)
create or replace view v_catalogParfumuri as
select p.numeParfum, m.numeMagazin,(p.pretProductie + o.adaosComercial) as pret
from Parfumuri p, Oferte o, Magazine m
where p.parfumID = o.parfumID
and o.magazinID = m.magazinID;

select * from v_catalogParfumuri;

--1.2 view cu brand si cate parfumuri are
create or replace view v_portofoliuParfumuri as
select b.numeBrand, count(p.parfumID) as total
from Branduri b, Parfumuri p
where b.brandID = p.brandID
group by b.numeBrand;

select * from v_portofoliuParfumuri;

--2 index pentru numeParfum
create index idx_numeParfum on Parfumuri(numeParfum);

select * from user_indexes where table_name='PARFUMURI';

--3 secventa incepand de la 1020 pentru parfumID
create sequence seq_parfumuri
start with 1020
increment by 1
maxvalue 9999
nocycle
nocache;

insert into Parfumuri values (seq_parfumuri.nextval, 'Parfum Nou', sysdate, 10, 100);

select seq_parfumuri.currval from dual;

--4 sinonim
create synonym PC for ParfumuriCategorii;
select * from PC;