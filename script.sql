DROP TABLE film;
CREATE TABLE film (
        idFilm INT AUTO_INCREMENT NOT NULL,
        nomFilm VARCHAR(100) NOT NULL,
        dateSortie DATE NOT NULL,
        realisateurFilm VARCHAR(100) NOT NULL,
        dureeFilm TIME NOT NULL,
        nationaliteFilm VARCHAR(30) NOT NULL,
        genreFilm VARCHAR(30) NOT NULL,
        synopsisFilm VARCHAR(1000) NOT NULL,
        noteFilm VARCHAR(10) NOT NULL,
        imageFilm VARCHAR(250) NOT NULL,
        PRIMARY KEY(idFilm)
);

/* Table utilisateur */
DROP TABLE utilisateur;
CREATE TABLE utilisateur (
    idUtilisateur INT AUTO_INCREMENT NOT NULL,
    email VARCHAR(180) NOT NULL,
    roles JSON NOT NULL,
    motdepasse VARCHAR(255) NOT NULL,
    nomUtilisateur VARCHAR(50) NOT NULL,
    prenomUtilisateur VARCHAR(50) NOT NULL
    PRIMARY KEY(idUtilisateur)
);