/* Création de la base de données 'cinema' */
DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE cinema;

/* Prise en compte des accents dans les requêtes d'insertions de données */
SET NAMES utf8;

/* Table role_utilisateur */
DROP TABLE IF EXISTS role_utilisateur;
CREATE TABLE role_utilisateur (
    idRole INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeRole VARCHAR(25) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_role_utilisateur ON role_utilisateur (typeRole);

INSERT INTO role_utilisateur (idRole, typeRole) VALUES (1, "Utilisateur"), (2, "Administrateur");

/* Table utilisateur */
DROP TABLE IF EXISTS utilisateur;
CREATE TABLE utilisateur (
    idUtilisateur INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    emailUtilisateur VARCHAR(50) NOT NULL,
    motdepasseUtilisateur VARCHAR(255) NOT NULL,
    nomUtilisateur VARCHAR(100) NOT NULL,
    prenomUtilisateur VARCHAR(100) NOT NULL,
    idRole INT(11) NOT NULL,
    FOREIGN KEY (idRole) REFERENCES role_utilisateur (idRole)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_utilisateur ON utilisateur (idRole);

INSERT INTO utilisateur (idUtilisateur, emailUtilisateur, motdepasseUtilisateur, nomUtilisateur, prenomUtilisateur, idRole) VALUES
    (1, "utilisateur@cinema.com", MD5("MotDePasseDupontThomas"), "DUPONT", "Thomas", 1),
    (2, "administrateur@cinema.com", MD5("MotDePasseAdmin123"), "Admin", "Admin", 2);


/* Création de la table genre + insertions */
DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
    idGenre INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomGenre VARCHAR(100) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_genre ON genre (nomGenre);

INSERT INTO genre (idGenre, nomGenre) VALUES (1, "Action, Aventure"), (2, "Drame"), (3, "Animation"), (4, "Science-fiction, Fantastique"), (5, "Horreur"), (6, "Comédie");


/* Création de la table statut + insertions */
DROP TABLE IF EXISTS statut;
CREATE TABLE statut (
    idStatut INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeStatut VARCHAR(50) NOT NULL,
    statut VARCHAR(50) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_statut ON statut (statut);

INSERT INTO statut (idStatut, typeStatut, statut) VALUES (1, "film", "Non disponible"), (2, "film", "A l'affiche"), (3, "ticket", "Non utilisé"), (4, "ticket", "Utilisé");


/* Création de la table film + insertions */
DROP TABLE IF EXISTS film;
CREATE TABLE film (
    idFilm INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomFilm VARCHAR(50) NOT NULL,
    dateSortie DATE NOT NULL,
    dureeFilm TIME NOT NULL,
    realisateurFilm VARCHAR(100) NOT NULL,
    nationaliteFilm VARCHAR(25) NOT NULL,
    idGenre INT(11) NOT NULL,
    synopsisFilm LONGTEXT NOT NULL,
    lienImage VARCHAR(255) NOT NULL,
    lienBandeAnnonce TEXT(1000),
    idStatut INT(11) NOT NULL,
    FOREIGN KEY (idGenre) REFERENCES genre (idGenre),
    FOREIGN KEY (idStatut) REFERENCES statut (idStatut)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_film ON film (idGenre, idStatut);

INSERT INTO film (idFilm, nomFilm, dateSortie, dureeFilm, realisateurFilm, nationaliteFilm, idGenre, synopsisFilm, lienImage, lienBandeAnnonce, idStatut) VALUES
    (1, "Mourir peut attendre", "2021-04-02", "02:43:10", "Cary Joji Fukunaga", "Etats-Unis", 1, "James Bond n'est plus en service et profite d'une vie tranquille en Jamaïque. Mais son répit est de courte durée car l'agent de la CIA Felix Leiter fait son retour pour lui demander son aide. Sa mission, qui est de secourir un scientifique kidnappé, va se révéler plus traître que prévu, et mener 007 sur la piste d'un méchant possédant une nouvelle technologie particulièrement dangereuse.", "Avengers.jpg", "https://www.youtube.com/watch?v=qmpN7h-bAMM", 2),
    (2, "Fast & Furious 9", "2021-03-31", "03:08:00", "Justin Lin", "Etats-Unis", 1, "Après avoir récupéré son fils des mains de Cipher, Dom vit des jours heureux avec le petit Brian et Letty. Cette paisible existence est vite bouleversée quand il doit faire face à un nouvel adversaire, Jakob, qui n'est autre que son petit frère", "FF9.jpg", NULL, 2),
    (3, "Titanic", "1997-12-19", "03:08:00", "James Cameron", "Etats-Unis", 2, "En 1997, l'épave du Titanic est l'objet d'une exploration fiévreuse, menée par des chercheurs de trésor en quête d'un diamant bleu qui se trouvait à bord. Frappée par un reportage télévisé, l'une des rescapés du naufrage, âgée de 102 ans, Rose DeWitt, se rend sur place et évoque ses souvenirs. 1912. Fiancée à un industriel arrogant, Rose croise sur le bateau un artiste sans le sou.", "Titanic.jpg", NULL, 2),
    (4, "Avengers", "2012-04-25", "02:23:00", "Joss Whedon", "Etats-Unis", 4, "Nick Fury, le directeur du S.H.I.E.L.D., l'organisation qui préserve la paix dans le monde, veut former une équipe d'irréductibles pour empêcher la destruction du monde. Iron Man, Hulk, Thor, Captain America, Hawkeye et Black Widow répondent présents. La nouvelle équipe, baptisée Avengers, a beau sembler soudée, il reste encore à ses illustres membres à apprendre à travailler ensemble.", "Intouchables.jpg", "https://www.youtube.com/watch?v=EsaX5kltRcA", 2),
    (5, "Avatar", "2009-12-16", "02:42:00", "James Cameron", "États-Unis", 4, "Malgré sa paralysie, Jake Sully, un ancien marine immobilisé dans un fauteuil roulant, est resté un combattant au plus profond de son être. Il est recruté pour se rendre à des années-lumière de la Terre, sur Pandora, où de puissants groupes industriels exploitent un minerai rarissime destiné à résoudre la crise énergétique sur Terre.", "Avatar.jpg", NULL, 2),
    (6, "Le Roi Lion", "2019-07-17", "01:58:00", "Jon Favreau", "États-Unis", 3, "Au fond de la savane africaine, tous les animaux célèbrent la naissance de Simba, leur futur roi. Les mois passent. Simba idolâtre son père, le roi Mufasa, qui prend à cœur de lui faire comprendre les enjeux de sa royale destinée. Mais tout le monde ne semble pas de cet avis. Scar, le frère de Mufasa, l'ancien héritier du trône, a ses propres plans. La bataille pour la prise de contrôle de la Terre des Lions est ravagée par la trahison, la tragédie et le drame, ce qui finit par entraîner l'exil de Simba. Avec l'aide de deux nouveaux amis, Timon et Pumbaa, le jeune lion va devoir trouver comment grandir et reprendre ce qui lui revient de droit…", "LeRoiLion.jpg", NULL, 2),
    (7, "Bienvenue chez les Ch'tis", "2008-02-20", "01:46:00", "Dany Boon", "France", 6, "Un directeur de la Poste en Provence est, à son détriment, muté à Bergues, petite ville du Nord. Sa famille refusant de l'accompagner, Philippe ira seul. A sa grande surprise, il découvre un endroit charmant, une équipe chaleureuse et des gens accueillants. Il se lie d'amitié avec Antoine, le facteur et le carillonneur du village, à la mère possessive et aux amours contrariées.\r\n", "BienvenueChezLesChtis.jpg", NULL, 2),
    (8, "Intouchables", "2011-11-02", "01:53:00", "Olivier Nakache / Éric Toledano", "France", 6, "Tout les oppose et il était peu probable qu'ils se rencontrent un jour, et pourtant. Philippe, un riche aristocrate devenu tétraplégique après un accident de parapente va engager Driss, un jeune homme d'origine sénégalaise tout droit sorti de prison, comme auxiliaire de vie à domicile. Pourquoi lui ? Tout simplement parce qu'il ne regarde pas Philippe avec le même regard de pitié que les autres candidats.", "MourirPeutAttendre.jpg", "https://www.youtube.com/watch?v=QDMtltHjkDA", 2),
    (9, "American Nightmare 5 : Sans limites", "2021-08-04", "01:44:00", "Everardo Gout", "Etats-Unis", 5, "Adela et son mari Juan habitent au Texas, où Juan travaille dans le ranch de la très aisée famille Tucker. Juan gagne l'estime du patriarche Caleb Tucker, ce qui déclenche la jalousie de Dylan, son fils. La matinée suivant le déchainement nocturne de violence annuelle, un groupe masqué attaque la famille Tucker, dont la femme de Dylan, et sa soeur, forçant les deux familles à s'unir et organiser une riposte alors que le pays entier sombre dans la spirale du chaos et que les États-Unis se désagrègent petit à petit autour d'eux.", "AmericanNightmare6.jpg", NULL, 2);


/* Création de la table etablissement + insertions */
DROP TABLE IF EXISTS etablissement;
CREATE TABLE etablissement (
    idEtablissement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomEtablissement VARCHAR(100) NOT NULL,
    adresseEtablissement VARCHAR(100) NOT NULL,
    codePostalEtablissement INT(5) NOT NULL,
    villeEtablissement VARCHAR(100) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_etablissement ON etablissement (nomEtablissement, adresseEtablissement);

INSERT INTO etablissement (idEtablissement, nomEtablissement, adresseEtablissement, codePostalEtablissement, villeEtablissement) VALUES
    (1, "Pathé Gaumont", "5 rue des Lilas", 75000, "Paris"),
    (2, "CinéVille", "17 rue de l'Arrondissement", 75000, "Paris"),
    (3, "CGR", "48 rue de la Croix Verte", 75000, "Paris");


/* Création de la table client + insertions */
DROP TABLE IF EXISTS client;
CREATE TABLE IF NOT EXISTS client (
  idClient INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  emailClient VARCHAR(50) NOT NULL,
  motdepasseClient VARCHAR(255) NOT NULL,
  nomClient VARCHAR(100) NOT NULL,
  prenomClient VARCHAR(100) NOT NULL,
  adresseClient VARCHAR(100) NOT NULL,
  codePostalClient INT(5) NOT NULL,
  villeClient VARCHAR(100) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_client ON client (emailClient, motdepasseClient, nomClient, prenomClient);

INSERT INTO client (idClient, emailClient, motdepasseClient, nomClient, prenomClient, adresseClient, codePostalClient, villeClient) VALUES
    (1, "client-un@test.com", MD5("MotDePasseClientUn"), "Test", "ClientUn", "1 rue des Clients", 92000, "PARIS"),
    (2, "client-deux@test.com", MD5("MotDePasseClientDeux"), "Test", "ClientDeux", "2 rue des Clients", 92000, "PARIS"),
    (3, "client-trois@test.com", MD5("MotDePasseClientTrois"), "Test", "ClientTrois", "3 rue des Clients", 92000, "PARIS"),
    (4, "client-quatre@test.com", MD5("MotDePasseClientQuatre"), "Test", "ClientQuatre", "4 rue des Clients", 92000, "PARIS"),
    (5, "client-cinq@test.com", MD5("MotDePasseClientCinq"), "Test", "ClientCinq", "5 rue des Clients", 92000, "PARIS"),
    (6, "client-six@test.com", MD5("MotDePasseClientSix"), "Test", "ClientSix", "6 rue des Clients", 92000, "PARIS");


/* Création de la table type_paiement + insertions */
DROP TABLE IF EXISTS type_paiement;
CREATE TABLE type_paiement (
    idTypePaiement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typePaiement VARCHAR(50) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_type_paiement ON type_paiement (typePaiement);

INSERT INTO type_paiement (idTypePaiement, typePaiement) VALUES (1, "En ligne"), (2, "Sur place");


/* Création de la table moyen_paiement + insertions */
DROP TABLE IF EXISTS moyen_paiement;
CREATE TABLE moyen_paiement (
    idMoyenPaiement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    moyenPaiement VARCHAR(50) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_moyen_paiement ON moyen_paiement (moyenPaiement);

INSERT INTO moyen_paiement (idMoyenPaiement, moyenPaiement) VALUES (1, "Carte bancaire"), (2, "Espèce");


/* Création de la table tarif + insertions */
DROP TABLE IF EXISTS tarif;
CREATE TABLE tarif (
    idTarif INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeTarif VARCHAR(50) NOT NULL,
    tarif DOUBLE NOT NULL
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_tarif ON tarif (typeTarif, tarif);

INSERT INTO tarif (idTarif, typeTarif, tarif) VALUES (1, "Plein tarif", 9.20), (2, "Étudiant", 7.6), (3, "Moins de 14 ans", 5.9);


/* Création de la table paiement + insertions */
DROP TABLE IF EXISTS paiement;
CREATE TABLE paiement (
    idPaiement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTypePaiement INT(11) NOT NULL,
    idMoyenPaiement INT(11) NOT NULL,
    FOREIGN KEY (idTypePaiement) REFERENCES type_paiement (idTypePaiement),
    FOREIGN KEY (idMoyenPaiement) REFERENCES moyen_paiement (idMoyenPaiement)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_paiement ON paiement (idTypePaiement, idMoyenPaiement);

INSERT INTO paiement (idPaiement, idTypePaiement, idMoyenPaiement) VALUES
    (1, 2, 1),
    (2, 2, 1),
    (3, 1, 1),
    (4, 2, 1),
    (5, 1, 2),
    (6, 1, 1),
    (7, 1, 2),
    (8, 2, 2),
    (9, 1, 1),
    (10, 2, 2);


/* Création de la table salle + insertions */
DROP TABLE IF EXISTS salle;
CREATE TABLE salle (
    idSalle INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idEtablissement INT(11) NOT NULL,
    numSalle VARCHAR(100) NOT NULL,
    nombrePlaceSalle VARCHAR(1000) NOT NULL,
    FOREIGN KEY (idEtablissement) REFERENCES etablissement (idEtablissement)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_salle ON salle (idEtablissement);

INSERT INTO salle (idSalle, idEtablissement, numSalle, nombrePlaceSalle) VALUES
    (1, 1, "1", "250"),
    (2, 1, "2", "250"),
    (3, 2, "1", "100"),
    (4, 3, "1", "500"),
    (5, 3, "2", "500");


/* Création de la table seance + insertions */
DROP TABLE IF EXISTS seance;
CREATE TABLE seance (
    idSeance INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSalle INT(11) NOT NULL,
    idFilm INT(11) NOT NULL,
    dateSeance DATE NOT NULL,
    heureSeance TIME NOT NULL,
    FOREIGN KEY (idSalle) REFERENCES salle (idSalle),
    FOREIGN KEY (idFilm) REFERENCES film (idFilm)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_seance ON seance (idSalle, idFilm);

INSERT INTO seance (idSeance, idSalle, idFilm, dateSeance, heureSeance) VALUES
    (1, 1, 1, "2022-11-26", "11:00:00"),
    (2, 2, 1, "2022-11-26", "15:00:00"),
    (3, 4, 2, "2022-11-27", "11:00:00"),
    (4, 5, 1, "2022-11-28", "12:00:00"),
    (5, 1, 3, "2022-11-29", "13:30:00"),
    (6, 3, 4, "2022-11-30", "17:45:00"),
    (7, 2, 8, "2022-12-01", "21:00:00"),
    (8, 5, 2, "2022-12-02", "19:15:00");


/* Création de la table ticket + insertions */
DROP TABLE IF EXISTS ticket;
CREATE TABLE ticket (
    idTicket INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idClient INT(11) NOT NULL,
    idSeance INT(11) NOT NULL,
    dateReservation DATE NOT NULL,
    idTarif INT(11) NOT NULL,
    idPaiement INT(11) NOT NULL,
    idStatut INT(11) NOT NULL,
    FOREIGN KEY (idClient) REFERENCES client (idClient),
    FOREIGN KEY (idSeance) REFERENCES seance (idSeance),
    FOREIGN KEY (idTarif) REFERENCES tarif (idTarif),
    FOREIGN KEY (idPaiement) REFERENCES paiement (idPaiement),
    FOREIGN KEY (idStatut) REFERENCES statut (idStatut)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ENGINE=InnoDB;
CREATE INDEX idx_ticket ON ticket (idClient, idSeance, idTarif, idPaiement, idStatut);

INSERT INTO ticket (idTicket, idClient, idSeance, dateReservation, idTarif, idPaiement, idStatut) VALUES
    (1, 6, 1, "2022-11-26", 2, 1, 3),
    (2, 3, 2, "2022-11-26", 1, 2, 3),
    (3, 2, 3, "2022-11-27", 3, 3, 3),
    (4, 5, 4, "2022-11-28", 1, 4, 3),
    (5, 1, 5, "2022-11-29", 1, 5, 3),
    (6, 4, 5, "2022-11-29", 3, 6, 3),
    (7, 2, 5, "2022-11-29", 2, 7, 3),
    (8, 6, 6, "2022-11-30", 3, 8, 3),
    (9, 4, 6, "2022-11-30", 1, 9, 3),
    (10, 2, 7, "2022-12-01", 2, 10, 3);