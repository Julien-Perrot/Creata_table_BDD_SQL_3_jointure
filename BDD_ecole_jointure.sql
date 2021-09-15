-- Creer une base de données 'ecole'

CREATE DATABASE tp1_ecole CHARACTER SET 'utf8';
USE tp1_ecole;

-- Créer une table 'eleve' qui contiendra les colonnes suivantes : • id
-- • nom
-- • prenom
-- • date_naissance • id_classe
-- • moyenne

DROP TABLE IF EXISTS eleve;
CREATE TABLE IF NOT EXISTS eleve (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    id_classe INT(10) UNSIGNED NOT NULL,
    moyenne FLOAT DEFAULT NULL,
    PRIMARY KEY (id),
    KEY eleve_classe (id_classe)
)
ENGINE=INNODB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Créer une table 'classe' qui contiendra les colonnes suivantes : • id
-- • intitulé

DROP TABLE IF EXISTS classe;
CREATE TABLE IF NOT EXISTS classe (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    intitule VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (id)
)
ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Avec des clés étrangère, liez les deux tables. Chaque élève devra forcément appartenir à une classe.
-- Décidez entre ON DELETE SET NULL et ON DELETE CASCADE.

ALTER TABLE eleve
ADD CONSTRAINT eleve_classe FOREIGN KEY (id_classe) REFERENCES classe (id) ON DELETE CASCADE;

-- Entrez les données suivante dans la table 'eleve' :
-- • 1 – 'Valjean' – 'Jean' – '2001-01-16' – 1 – 18.7
-- • 2 – 'Labray' – 'Elodie' - '2001-09-19' – 2 – 14.5
-- • 3 – 'Gerard' – 'Philippe' – '2000-12-31' – 1 – 9.5

INSERT INTO eleve (id, nom, prenom, date_naissance, id_classe, moyenne) 
VALUES
(1, 'Valjean', 'Jean', '2001-09-16', 1, 18.7),
(2, 'Labray', 'Elodie', '2001-09-19', 2, 14.5),
(3, 'Gerard', 'Philippe', '2000-12-31', 1, 9.5);

-- Entrez les données suivante dans la table 'classe' :
-- • 1 – 6ème
-- • 2 – 5ème

INSERT INTO classe (id, intitule) 
VALUES
(1, '6ème'),
(2, '5ème');

-- Ecrire les requêtes suivante :

-- • Sélectionnez tous les élèves avec l'intitulé de leur classe (jointure)

SELECT e.nom, e.prenom, e.date_naissance, e.moyenne, c.intitule
FROM eleve e
INNER JOIN classe c
ON e.id_classe=c.id

-- • Sélectionnez tous les élèves avec l'intitulé de leur classe dans l'ordre alphabétique du nom des
-- élèves

SELECT e.nom, e.prenom, e.date_naissance, e.moyenne, c.intitule
FROM eleve e
INNER JOIN classe c
ON e.id_classe=c.id 
ORDER BY e.nom

-- • Sélectionnez les élèves avec l'intitulé de leur classe qui sont né après le 1er janvier 2001

SELECT e.nom, e.prenom, e.date_naissance, e.moyenne, c.intitule
FROM eleve e
INNER JOIN classe c
ON e.id_classe=c.id 
WHERE e.date_naissance > '2001-01-01'

-- • Sélectionnez les élèves avec l'intitulé de leur classe qui ont la moyenne (10).

SELECT e.nom, e.prenom, e.date_naissance, e.moyenne, c.intitule
FROM eleve e
INNER JOIN classe c
ON e.id_classe=c.id 
WHERE e.moyenne >= 10

-- • Sélectionnez les élèves avec l'intitulé de leur classe qui sont en 6ème.

SELECT e.nom, e.prenom, e.date_naissance, e.moyenne, c.intitule
FROM eleve e
INNER JOIN classe c
ON e.id_classe=c.id 
WHERE c.intitule='6ème'