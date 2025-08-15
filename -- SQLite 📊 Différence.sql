-- SQLite
--10 📊 Différence en % du prix au m² entre un appartement 2 pièces et 3 pièces
WITH moyennes AS (
  SELECT
    AVG(CASE WHEN CAST(b.Total_piece AS INTEGER) = 2 THEN 1.0 * v.Valeur / b.Surface_carrez END) AS prix_m2_2p,
    AVG(CASE WHEN CAST(b.Total_piece AS INTEGER) = 3 THEN 1.0 * v.Valeur / b.Surface_carrez END) AS prix_m2_3p
  FROM Vente v
  JOIN Bien b ON v.Id_bien = b.Id_bien
  WHERE b.Type_local = 'Appartement'
    AND CAST(b.Total_piece AS INTEGER) IN (2, 3)
    AND b.Surface_carrez > 0
)
SELECT 
  ROUND(((prix_m2_3p - prix_m2_2p) * 100.0 / prix_m2_2p), 2) AS diff_pourcent
FROM moyennes;

---11
WITH moyennes AS (
    SELECT 
        c.Code_departement,
        c.Nom_commune,
        ROUND(AVG(v.Valeur), 2) AS valeur_moyenne
    FROM Vente v
    JOIN Bien b ON v.Id_bien = b.Id_bien
    JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
    WHERE c.Code_departement IN ('06', '13', '33', '59', '69')
      AND v.Valeur > 0
    GROUP BY c.Code_departement, c.Nom_commune
),
classement AS (
    SELECT 
        m.*,
        RANK() OVER (PARTITION BY m.Code_departement ORDER BY m.valeur_moyenne DESC) AS rang
    FROM moyennes m
)
SELECT 
    Code_departement,
    Nom_commune,
    valeur_moyenne
FROM classement
WHERE rang <= 3
ORDER BY Code_departement, valeur_moyenne DESC;

