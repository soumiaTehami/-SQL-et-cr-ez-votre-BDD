-- SQLite
--5  Prix moyen du mètre carré d’une maison en Île-de-France.

SELECT 
    ROUND(AVG(v.Valeur / b.Surface_carrez), 2) AS Prix_moyen_m2
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
JOIN Region r ON c.Id_region = r.Id_region
WHERE b.Type_local = 'Maison'
  AND r.Nom_Region = 'Île-de-France'
  AND b.Surface_carrez > 0;