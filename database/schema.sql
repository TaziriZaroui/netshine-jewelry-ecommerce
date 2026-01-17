CREATE DATABASE IF NOT EXISTS netshine_jewelry;
USE netshine_jewelry;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*ici on a utiliser ENGINE=InnoDB  comme un type de moteur de stockage pour faire des transactions 
securiseeset  pour meilleurs performlances plus que ca on a choisit specialement  
CHARSET=utf8mb4 pour les caracteres specifiques (amazighienne)*/
CREATE TABLE bagues (
    bague_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT DEFAULT 1,
    nom VARCHAR(150) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    collection VARCHAR(50),
    materiau VARCHAR(50),
    symbole VARCHAR(100),
    en_stock BOOLEAN DEFAULT TRUE,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE bracelets (
    bracelet_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT DEFAULT 2,
    nom VARCHAR(150) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    collection VARCHAR(50),
    materiau VARCHAR(50),
    symbole VARCHAR(100),
    en_stock BOOLEAN DEFAULT TRUE,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE boucles_oreilles (
    boucle_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT DEFAULT 3,
    nom VARCHAR(150) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    collection VARCHAR(50),
    materiau VARCHAR(50),
    symbole VARCHAR(100),
    en_stock BOOLEAN DEFAULT TRUE,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE colliers (
    collier_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT DEFAULT 4,
    nom VARCHAR(150) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    collection VARCHAR(50),
    materiau VARCHAR(50),
    symbole VARCHAR(100),
    en_stock BOOLEAN DEFAULT TRUE,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE parures (
    parure_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT DEFAULT 5,
    nom VARCHAR(150) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    collection VARCHAR(50),
    materiau VARCHAR(50),
    symbole VARCHAR(100),
    en_stock BOOLEAN DEFAULT TRUE,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
