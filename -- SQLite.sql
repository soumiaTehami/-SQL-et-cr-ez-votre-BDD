-- SQLite
---Nombre total d’appartements vendus au 1er semestre 2020
SELECT COUNT(*) AS total_appartements_vendus
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
WHERE b.Type_local = 'Appartement'
  AND v.Date BETWEEN '2020-01-01' AND '2020-06-30';

  ----ombre de ventes d’appartements par région au 1er semestre 2020

  SELECT r.Nom_region,
       COUNT(*) AS nombre_ventes_appartements
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
JOIN Region r ON c.Id_region = r.Id_region
WHERE b.Type_local = 'Appartement'
  AND v.Date BETWEEN '2020-01-01' AND '2020-06-30'
GROUP BY r.Nom_region
ORDER BY nombre_ventes_appartements DESC;
----Proportion des ventes d’appartements par nombre de pièces
SELECT 
    b.Total_piece AS nb_pieces,
    COUNT(*) AS nombre_ventes,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM Vente v
            JOIN Bien b2 ON v.Id_bien = b2.Id_bien
            WHERE b2.Type_local = 'Appartement'
        ), 2
    ) AS proportion_pourcentage
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
WHERE b.Type_local = 'Appartement'
GROUP BY b.Total_piece
ORDER BY b.Total_piece;

----Top 10 des départements avec le prix moyen au m² le plus élevé
SELECT 
    c.Code_departement,
    ROUND(AVG(v.Valeur / b.Surface_carrez), 2) AS prix_m2_moyen
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
WHERE b.Surface_carrez > 0  -- éviter division par zéro
GROUP BY c.Code_departement
ORDER BY prix_m2_moyen DESC
LIMIT 10;

UPDATE Region
SET Nom_region = 'Île-de-France'
WHERE Id_region = 11; -- Id fictif, à adapter



  







