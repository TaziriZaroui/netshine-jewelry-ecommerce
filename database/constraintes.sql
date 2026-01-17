USE netshine_jewelry;
-- Prix doit être positif
ALTER TABLE bagues 
ADD CONSTRAINT chk_bague_prix_positif 
CHECK (prix > 0);

ALTER TABLE bracelets
ADD CONSTRAINT chk_bracelet_prix_positif 
CHECK (prix > 0);
-- 2. Contraintes UNIQUE
-- Empêcher les noms de produits identiques dans une même catégorie
ALTER TABLE bagues
ADD CONSTRAINT uq_bague_nom_categorie 
UNIQUE (nom, category_id);
ALTER TABLE bracelets
ADD CONSTRAINT uq_bracelet_nom_categorie 
UNIQUE (nom, category_id);

-- 3. Valeurs par défaut améliorées
ALTER TABLE bagues 
ALTER COLUMN en_stock SET DEFAULT TRUE,
ALTER COLUMN date_ajout SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE bracelets 
ALTER COLUMN en_stock SET DEFAULT TRUE,
ALTER COLUMN date_ajout SET DEFAULT CURRENT_TIMESTAMP;

-- 4. Triggers pour la cohérence
DELIMITER //

-- Trigger: Mettre à jour date_ajout automatiquement
CREATE TRIGGER before_bague_insert
BEFORE INSERT ON bagues
FOR EACH ROW
BEGIN
    IF NEW.date_ajout IS NULL THEN
        SET NEW.date_ajout = CURRENT_TIMESTAMP;
    END IF;
END//

CREATE TRIGGER before_bracelet_insert
BEFORE INSERT ON bracelets
FOR EACH ROW
BEGIN
    IF NEW.date_ajout IS NULL THEN
        SET NEW.date_ajout = CURRENT_TIMESTAMP;
    END IF;
END//

-- Trigger: Log des modifications
CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    action VARCHAR(10),
    record_id INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user VARCHAR(50)
);
CREATE TRIGGER after_bague_update
AFTER UPDATE ON bagues
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action, record_id, user)
    VALUES ('bagues', 'UPDATE', NEW.bague_id, CURRENT_USER());
END//
DELIMITER ;
-- 5. Vérification
SELECT ' CONTRAINTES APPLIQUÉES' as message;
SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE 
FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_SCHEMA = 'netshine_jewelry';
