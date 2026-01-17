
USE netshine_jewelry;
ALTER TABLE bagues 
ADD CONSTRAINT chk_bague_prix_positif 
CHECK (prix > 0);

ALTER TABLE bracelets
ADD CONSTRAINT chk_bracelet_prix_positif 
CHECK (prix > 0);
ALTER TABLE bagues
ADD CONSTRAINT uq_bague_nom_categorie 
UNIQUE (nom, category_id);
ALTER TABLE bracelets
ADD CONSTRAINT uq_bracelet_nom_categorie 
UNIQUE (nom, category_id);
