/* BDD cinema */
DROP SCHEMA IF EXISTS cinema;
CREATE SCHEMA cinema COLLATE utf8_general_ci ENGINE=InnoDB;
USE cinema;

/* Table film */
DROP TABLE IF EXISTS cinema_film;
CREATE TABLE cinema_film (
    idFilm INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomFilm VARCHAR(50) NOT NULL,
    dateSortie DATE NOT NULL,
    realisateurFilm VARCHAR(100) NOT NULL,
    dureeFilm TIME NOT NULL,
    nationaliteFilm VARCHAR(25) NOT NULL,
    genreFilm VARCHAR(25) NOT NULL,
    synopsisFilm LONGTEXT NOT NULL,
    noteFilm DOUBLE NOT NULL,
    imageFilm VARCHAR(250) NOT NULL,
    idStatut INT(11) NOT NULL,
    FOREIGN KEY (idStatut) REFERENCES cinema_statut (idStatut)
);
CREATE INDEX index_film_idstatut ON cinema_film (idStatut);

/* Table etablissement */
DROP TABLE IF EXISTS cinema_etablissement;
CREATE TABLE cinema_etablissement (
    idEtablissement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nomEtablissement VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    codePostal INT(5) NOT NULL,
    ville VARCHAR(50) NOT NULL
);

/* Table client */
DROP TABLE IF EXISTS cinema_client;
CREATE TABLE IF NOT EXISTS cinema_client (
  idClient INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  emailClient VARCHAR(50) NOT NULL,
  motdepasseClient VARCHAR(250) NOT NULL,
  nomClient VARCHAR(250) NOT NULL,
  prenomClient VARCHAR(250) NOT NULL,
  adresseClient VARCHAR(50) NOT NULL,
  codePostalClient VARCHAR(5) NOT NULL,
  villeClient VARCHAR(50) NOT NULL
);

/* Table ticket */
DROP TABLE IF EXISTS cinema_ticket;
CREATE TABLE cinema_ticket (
    idTicket INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idClient INT NOT NULL,
    idSeance INT NOT NULL,
    dateReservation DATE NOT NULL,
    idTarif INT NOT NULL,
    idPaiement INT NOT NULL,
    idStatut INT NOT NULL,
    FOREIGN KEY (idClient) REFERENCES cinema_client (idClient),
    FOREIGN KEY (idSeance) REFERENCES cinema_seance (idSeance),
    FOREIGN KEY (idTarif) REFERENCES cinema_tarif (idTarif),
    FOREIGN KEY (idPaiement) REFERENCES cinema_paiement (idPaiement),
    FOREIGN KEY (idStatut) REFERENCES cinema_statut (idStatut)
);
CREATE INDEX index_ticket_idclient ON cinema_client (idClient);
CREATE INDEX index_ticket_idseance ON cinema_ticket (idSeance);
CREATE INDEX index_ticket_idtarif ON cinema_ticket (idTarif);
CREATE INDEX index_ticket_idpaiement ON cinema_ticket (idPaiement);
CREATE INDEX index_ticket_idstatut ON cinema_ticket (idStatut);

/* Table role_utilisateur */
DROP TABLE IF EXISTS cinema_role_utilisateur;
CREATE TABLE cinema_role_utilisateur (
    idRole INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeRole VARCHAR(25) NOT NULL
);

/* Table paiement */
DROP TABLE IF EXISTS cinema_paiement;
CREATE TABLE cinema_paiement (
    idPaiement INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typePaiement VARCHAR(25) NOT NULL,
    moyenPaiement VARCHAR(25) NOT NULL
);

/* Table utilisateur */
DROP TABLE IF EXISTS cinema_utilisateur;
CREATE TABLE cinema_utilisateur (
    idUtilisateur INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    emailUtilisateur VARCHAR(50) NOT NULL,
    motdepasseUtilisateur VARCHAR(250) NOT NULL,
    nomUtilisateur VARCHAR(100) NOT NULL,
    prenomUtilisateur VARCHAR(100) NOT NULL,
    idRole INT NOT NULL,
    FOREIGN KEY (idRole) REFERENCES cinema_role_utilisateur (idRole)
);
CREATE INDEX index_utilisateur_idrole ON cinema_utilisateur (idRole);

/* Table salle */
DROP TABLE IF EXISTS cinema_salle;
CREATE TABLE cinema_salle (
    idSalle INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numSalle VARCHAR(50) NOT NULL,
    nombrePlaceSalle INT(11) NOT NULL
);

/* Table seance */
DROP TABLE IF EXISTS cinema_seance;
CREATE TABLE cinema_seance (
    idSeance INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idEtablissement INT NOT NULL,
    idSalle INT NOT NULL,
    idFilm INT(11) NOT NULL,
    dateSeance DATE NOT NULL,
    heureSeance TIME NOT NULL,
    FOREIGN KEY (idEtablissement) REFERENCES cinema_etablissement (idEtablissement),
    FOREIGN KEY (idSalle) REFERENCES cinema_salle (idSalle),
    FOREIGN KEY (idFilm) REFERENCES cinema_film (idFilm)
);
CREATE INDEX index_seance_idetablissement ON cinema_seance (idEtablissement);
CREATE INDEX index_seance_idsalle ON cinema_seance (idSalle);
CREATE INDEX index_seance_idfilm ON cinema_seance (idFilm);

/* Table tarif */
DROP TABLE IF EXISTS cinema_tarif;
CREATE TABLE cinema_tarif (
    idTarif INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeTarif VARCHAR(25) NOT NULL,
    tarif DOUBLE NOT NULL
);

/* Table statut */
DROP TABLE IF EXISTS cinema_statut;
CREATE TABLE cinema_statut (
    idStatut INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    typeStatut VARCHAR(25) NOT NULL,
    statut VARCHAR(50) NOT NULL
);

-- Insertions des données

INSERT INTO cinema_film (idFilm, nomFilm, dateSortie, realisateurFilm, dureeFilm, nationaliteFilm, genreFilm, synopsisFilm, noteFilm, imageFilm, idStatut)
VALUES
    (1, "Mourir peut attendre", "2021-04-02", "Cary Joji Fukunaga", "02:43:10", "Etats-Unis", "Action", "James Bond n'est plus en service et profite d'une vie tranquille en Jamaïque. Mais son répit est de courte durée car l'agent de la CIA Felix Leiter fait son retour pour lui demander son aide. Sa mission, qui est de secourir un scientifique kidnappé, va se révéler plus traître que prévu, et mener 007 sur la piste d'un méchant possédant une nouvelle technologie particulièrement dangereuse.", "0", "MourirPeutAttendre.jpg", 2),
    (2, "Fast & Furious 9", "2021-03-31", "Justin Lin", "03:08:00", "Etats-Unis", "Action", "Après avoir récupéré son fils des mains de Cipher, Dom vit des jours heureux avec le petit Brian et Letty. Cette paisible existence est vite bouleversée quand il doit faire face à un nouvel adversaire, Jakob, qui n'est autre que son petit frère", "0", "FF9.jpg", 2),
    (3, "Titanic", "1997-12-19", "James Cameron", "03:08:00", "Etats-Unis", "Dramatique", "En 1997, l'épave du Titanic est l'objet d'une exploration fiévreuse, menée par des chercheurs de trésor en quête d'un diamant bleu qui se trouvait à bord. Frappée par un reportage télévisé, l'une des rescapés du naufrage, âgée de 102 ans, Rose DeWitt, se rend sur place et évoque ses souvenirs. 1912. Fiancée à un industriel arrogant, Rose croise sur le bateau un artiste sans le sou.", "4,5", "Titanic.jpg", 2),
    (4, "Avengers", "2012-04-25", "Joss Whedon", "02:23:00", "Etats-Unis", "Fantastique", "Nick Fury, le directeur du S.H.I.E.L.D., l'organisation qui préserve la paix dans le monde, veut former une équipe d'irréductibles pour empêcher la destruction du monde. Iron Man, Hulk, Thor, Captain America, Hawkeye et Black Widow répondent présents. La nouvelle équipe, baptisée Avengers, a beau sembler soudée, il reste encore à ses illustres membres à apprendre à travailler ensemble.", "4", "Avengers.jpg", 2),
    (5, "Avatar", "2009-12-16", "James Cameron", "02:42:00", "États-Unis", "Science-fiction", "Malgré sa paralysie, Jake Sully, un ancien marine immobilisé dans un fauteuil roulant, est resté un combattant au plus profond de son être. Il est recruté pour se rendre à des années-lumière de la Terre, sur Pandora, où de puissants groupes industriels exploitent un minerai rarissime destiné à résoudre la crise énergétique sur Terre.", "4,5", "Avatar.jpg", 2),
    (6, "Le Roi Lion", "2019-07-17", "Jon Favreau", "01:58:00", "États-Unis", "Aventure", "Au fond de la savane africaine, tous les animaux célèbrent la naissance de Simba, leur futur roi. Les mois passent. Simba idolâtre son père, le roi Mufasa, qui prend à cœur de lui faire comprendre les enjeux de sa royale destinée. Mais tout le monde ne semble pas de cet avis. Scar, le frère de Mufasa, l'ancien héritier du trône, a ses propres plans. La bataille pour la prise de contrôle de la Terre des Lions est ravagée par la trahison, la tragédie et le drame, ce qui finit par entraîner l'exil de Simba. Avec l'aide de deux nouveaux amis, Timon et Pumbaa, le jeune lion va devoir trouver comment grandir et reprendre ce qui lui revient de droit…", "4", "LeRoiLion.jpg", 2),
    (7, "Bienvenue chez les Ch'tis", "2008-02-20", "Dany Boon", "01:46:00", "France", "Comédie", "Un directeur de la Poste en Provence est, à son détriment, muté à Bergues, petite ville du Nord. Sa famille refusant de l'accompagner, Philippe ira seul. A sa grande surprise, il découvre un endroit charmant, une équipe chaleureuse et des gens accueillants. Il se lie d'amitié avec Antoine, le facteur et le carillonneur du village, à la mère possessive et aux amours contrariées.\r\n", "3.5", "BienvenueChezLesChtis.jpg", 2),
    (8, "Intouchables", "2011-11-02", "Olivier Nakache / Éric Toledano", "01:53:00", "France", "Comédie", "Tout les oppose et il était peu probable qu'ils se rencontrent un jour, et pourtant. Philippe, un riche aristocrate devenu tétraplégique après un accident de parapente va engager Driss, un jeune homme d'origine sénégalaise tout droit sorti de prison, comme auxiliaire de vie à domicile. Pourquoi lui ? Tout simplement parce qu'il ne regarde pas Philippe avec le même regard de pitié que les autres candidats.", "4.5", "Intouchables.jpg", 2),
    (9, "American Nightmare 5 : Sans limites", "2021-08-04", "Everardo Gout", "01:44:00", "Etats-Unis", "Horreur", "Adela et son mari Juan habitent au Texas, où Juan travaille dans le ranch de la très aisée famille Tucker. Juan gagne l'estime du patriarche Caleb Tucker, ce qui déclenche la jalousie de Dylan, son fils. La matinée suivant le déchainement nocturne de violence annuelle, un groupe masqué attaque la famille Tucker, dont la femme de Dylan, et sa soeur, forçant les deux familles à s'unir et organiser une riposte alors que le pays entier sombre dans la spirale du chaos et que les États-Unis se désagrègent petit à petit autour d'eux.", "3", "AmericanNightmare5.jpg", 2);

INSERT INTO cinema_statut (idStatut, typeStatut, statut) VALUES
    (1, "film", "Non disponible"),
    (2, "film", "A l'affiche"),
    (3, "ticket", "Non utilisé"),
    (4, "ticket", "Utilisé");

INSERT INTO cinema_paiement (idPaiement, typePaiement, moyenPaiement) VALUES
    (1, "En ligne", "Carte bancaire"),
    (2, "Sur place", "Espèce");

INSERT INTO cinema_utilisateur (idUtilisateur, emailUtilisateur, motdepasseUtilisateur, nomUtilisateur, prenomUtilisateur, idRole) VALUES
    (1, "utilisateur@cinema_com", "c66c66bbdcc5936fbe9cddfe72979a1dd7defd381aab56a3d47e51d12746b8c0", "DUPONT", "Thomas", 1), /* Mdp : MotDePasseDupontThomas */
    (2, "administrateur@cinema_com", "33f28858f8318895dea6695575edcc8ef8ac4574933000a618cadd69d0662394", "Admin", "Admin", 2); /* Mdp : MotDePasseAdmin123! */

INSERT INTO cinema_role_utilisateur (idRole, typeRole) VALUES (1, "utilisateur"), (2, "administrateur");

INSERT INTO cinema_tarif (idTarif, typeTarif, tarif) VALUES
    (1, "Plein tarif", 9.20),
    (2, "Étudiant", 7.6),
    (3, "Moins de 14 ans", 5.9);