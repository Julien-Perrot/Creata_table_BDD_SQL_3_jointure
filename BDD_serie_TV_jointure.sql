-- Creer une base de données 'serie_tv'

CREATE DATABASE tp3_serie_tv CHARACTER SET 'utf8';
USE tp3_serie_tv;

-- Créer une table “série” avec les colonnes suivantes :
-- • id
-- • nom
-- • limitation_age 
-- • note

CREATE TABLE serie (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    limitation_age SMALLINT UNSIGNED,
    note SMALLINT UNSIGNED NOT NULL
)
ENGINE=INNODB;

-- Créer une table “utilisateur” avec les colonnes suivantes : 
-- • id
-- • nom

CREATE TABLE utilisateur (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(20) NOT NULL
)
ENGINE=INNODB;

-- Créer une table “utilisateur_série” avec les colonnes suivantes :
-- • id
-- • id_serie
-- • id_utilisateur
-- Cette structure à trois tables permet à un utilisateur 
-- de regarder plusieurs séries et non pas une seule avec 
-- les techniques à deux tables que nous avons vu ces derniers jours et ce matin.

CREATE TABLE utilisateur_serie (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_serie INT UNSIGNED,
    id_utilisateur INT UNSIGNED,
    CONSTRAINT fk_id_serie
        FOREIGN KEY (id_serie) REFERENCES serie(id) ON DELETE CASCADE,
    CONSTRAINT fk_id_utilisateur
        FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id) ON DELETE SET NULL
)
ENGINE=INNODB;

-- Entrez les données suivantes dans la table 'serie' : 1 – Dark – 16 – 19
-- 2 – Devil – 16 – 16
-- 3 – Prison Break – 12 – 14
-- 4 – Tchernobyl – 16 – 20
-- 5 – Breaking Bad – 16 – 20

INSERT INTO serie (nom, limitation_age, note) VALUES
('DARK', 16, 19),
('Devil', 16,16),
('Prison Break', 12,14),
('Tchernobil', 16, 20),
('Breaking Bad', 16, 20);

-- Entrez les données suivantes dans la table 'utilisateur' : 1 – Jean
-- 2 – Elodie
-- 3 – Lola
-- 4 – Virginie 5 – Frank

INSERT INTO utilisateur (nom) VALUES
('Jean'),
('Elodie'),
('Lola'),
('Virginie'),
('Franck');

-- Entrez les données suivantes dans la table 'utilisateur_serie' : 
-- 1 : 1–1
-- 2 : 2–1
-- 3 : 3–1
-- 4 : 5-2 
-- 5 : 4-2 
-- 6 : 3-3 
-- 7 : 5-4 
-- 8 : 1–4

INSERT INTO utilisateur_serie (id_serie, id_utilisateur) VALUES
(1,1),
(2,1),
(3,1),
(5,2),
(4,2),
(3,3),
(5,4),
(1,4);

-- Effectuez les requêtes suivantes :

-- • Quelle est la moyenne des notes des séries ?

SELECT AVG(serie.note) FROM serie 

-- • Quelle est la moyenne des limitations d'âge des séries ?

SELECT AVG(serie.limitation_age) FROM serie

-- • Faites un INNER JOIN sur les trois tables pour lier les données

SELECT s.nom, s.limitation_age, s.note, u.nom
FROM utilisateur_serie us
INNER JOIN serie s
ON us.id_serie=s.id
INNER JOIN utilisateur u 
ON us.id_utilisateur=u.id

-- • Faites un LEFT JOIN sur les trois tables pour lier les données

SELECT s.nom, s.limitation_age, s.note, u.nom
FROM utilisateur u
LEFT JOIN utilisateur_serie us
ON us.id_utilisateur=u.id
LEFT JOIN serie s
ON us.id_serie=s.id

-- • Quelles séries regarde Jean ?

SELECT s.nom, s.limitation_age, s.note, u.nom
FROM utilisateur_serie us
INNER JOIN serie s
ON us.id_serie=s.id
INNER JOIN utilisateur u 
ON us.id_utilisateur=u.id
WHERE u.nom='Jean'

-- • Quelles séries regarde Elodie ?

SELECT s.nom, s.limitation_age, s.note, u.nom
FROM utilisateur_serie us
INNER JOIN serie s
ON us.id_serie=s.id
INNER JOIN utilisateur u 
ON us.id_utilisateur=u.id
WHERE u.nom='Elodie'

-- • Quel est le nombre de série que regarde Jean ?

SELECT COUNT(*) as nbr_serie
FROM utilisateur_serie us
INNER JOIN serie s
ON us.id_serie=s.id
INNER JOIN utilisateur u 
ON us.id_utilisateur=u.id
WHERE u.nom='Jean'

-- • Essayez de vous renseigner sur “GROUP BY” que nous n'avons pas vu en cours. Regardez la
--documentation et essayer de trouver le nombre de séries regardés par chaque utilisateur.

SELECT u.nom, COUNT(*) as nbr_serie
FROM serie s
INNER JOIN utilisateur_serie us
ON us.id_serie=s.id
INNER JOIN utilisateur u 
ON us.id_utilisateur=u.id
GROUP BY u.nom
