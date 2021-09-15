-- Creer une base de données 'automobile'

CREATE DATABASE tp2_automobile CHARACTER SET 'utf8';
USE tp2_automobile;

-- Créer une table “voiture” contenant les colonnes suivantes : • id
-- • marque
-- • modèle
-- • couleur
-- • plaque_immatriculation

CREATE TABLE voiture (
    id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    couleur VARCHAR(30) NOT NULL,
    plaque_immatriculation VARCHAR(10) NOT NULL
)
ENGINE=INNODB;

-- Créer une table “employe” contenant les colonnes suivantes : • id
-- • nom
-- • prenom
-- • date_de_naissance • id_voiture
-- • points_permis

CREATE TABLE employe (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    date_naissance DATE NOT NULL,
    id_voiture SMALLINT UNSIGNED,
    points_permis SMALLINT UNSIGNED,
    CONSTRAINT fk_id_voiture
    FOREIGN KEY (id_voiture) REFERENCES voiture(id)
)
ENGINE=INNODB;

-- Insérer les données suivantes dans la table 'voiture' 1 – Peugeot – 508 – noire – XK56767
-- 2 – Citroen – Xantia – beige – RK49575
-- 3 – Ferrari – F12 – rouge – LD94875
-- 4 – Peugeot – 607 – blanche – OD94875

INSERT INTO voiture(marque, modele, couleur, plaque_immatriculation) 
VALUES
('Peugeot', '508','noire','XK56767'),
('Citroen','Xantia','beige','LD94875'),
('Ferrari','F12','rouge','LD94875'),
('Peugeot','607','blanche','OD94875');

-- Insérer les données suivantes dans la table 'employe' 1 – Valjean – Jean – 1989-01-15 – 1 – 12
-- 2 – Lorem – Ipsum – 1984-01-06 – 2 – 6
-- 3 – Labrey – Elodie – 1976-06-06 – 3 – 4

INSERT INTO employe(nom,prenom,date_naissance,id_voiture,points_permis) 
VALUES
('Valjean','Jean','1989-01-15',1,12),
('Lorem','Ipsum','1984-01-06',2,6),
('Labrey','Elodie','1976-06-06',3,4);

-- Effectuer les requêtes suivantes :

-- • Quel est la moyenne des points de permis des employés ?

SELECT ROUND(AVG(points_permis), 1) AS moyenne_points FROM employe;

-- • Combien il y a t-il d'employés ?

SELECT COUNT(*) as nbr_employe FROM employe;

-- • Combien il y a t-il de voitures ?

SELECT COUNT(*) as nbr_voiture FROM voiture;

-- • Quel est l'employé qui a le plus de points ?

SELECT * FROM employe ORDER BY employe.points_permis DESC LIMIT 1;

-- • Quel est l'employé qui a le moins de points ?

SELECT * FROM employe ORDER BY employe.points_permis ASC LIMIT 1;

-- • Faites une requête INNER JOIN pour lier les deux tables

SELECT e.nom, e.prenom, e.date_naissance, e.points_permis, v.marque, v.modele, v.couleur, v.plaque_immatriculation
FROM employe e 
INNER JOIN voiture v 
ON e.id_voiture=v.id;

-- • Faites une requête LEFT JOIN pour lier les deux tables

SELECT e.nom, e.prenom, e.date_naissance, e.points_permis, v.marque, v.modele, v.couleur, v.plaque_immatriculation
FROM voiture v
LEFT JOIN employe e   
ON e.id_voiture=v.id

-- • Faites une requête INNER JOIN pour lier les deux tables et classez les résultats par ordre
-- alphabétique du nom de l'employé

SELECT e.nom, e.prenom, e.date_naissance, e.points_permis, v.marque, v.modele, v.couleur, v.plaque_immatriculation
FROM employe e 
INNER JOIN voiture v 
ON e.id_voiture=v.id
ORDER BY e.nom;

-- • Faites une requête INNER JOIN pour lier les deux tables et classez les résultats par ordre
-- croissant des points

SELECT e.nom, e.prenom, e.date_naissance, e.points_permis, v.marque, v.modele, v.couleur, v.plaque_immatriculation
FROM employe e 
INNER JOIN voiture v 
ON e.id_voiture=v.id
ORDER BY e.points_permis;