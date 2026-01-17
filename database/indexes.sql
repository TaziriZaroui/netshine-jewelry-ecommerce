USE netshine_jewelry;

CREATE INDEX idx_bague_prix ON bagues(prix);
CREATE INDEX idx_bracelet_prix ON bracelets(prix);
CREATE INDEX idx_boucle_prix ON boucles_oreilles(prix);
CREATE INDEX idx_collier_prix ON colliers(prix);
CREATE INDEX idx_parure_prix ON parures(prix);

CREATE INDEX idx_bague_collection ON bagues(collection);
CREATE INDEX idx_bracelet_collection ON bracelets(collection);

CREATE INDEX idx_bague_symbole ON bagues(symbole);
CREATE INDEX idx_collier_symbole ON colliers(symbole);

CREATE INDEX idx_bague_materiau ON bagues(materiau);
CREATE INDEX idx_bracelet_materiau ON bracelets(materiau);

CREATE INDEX idx_bague_stock ON bagues(en_stock);
CREATE INDEX idx_bracelet_stock ON bracelets(en_stock);
