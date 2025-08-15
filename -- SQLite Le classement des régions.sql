-- SQLite
--8 Le classement des régions par rapport au prix au mètre carré des

SELECT 
    r.Nom_Region AS Region,
    ROUND(AVG(v.Valeur / b.Surface_carrez), 2) AS Prix_m2
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
JOIN Region r ON c.Id_region = r.Id_region
WHERE b.Type_local = 'Appartement'
  AND b.Total_piece > 4
  AND b.Surface_carrez > 0
GROUP BY r.Nom_Region
ORDER BY Prix_m2 DESC;

--9 🏘️ Communes ayant eu au moins 50 ventes au 1er trimestre 🏘️
SELECT 
    c.Nom_commune,
    COUNT(*) AS nb_ventes
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
WHERE strftime('%m', v.Date) IN ('01', '02', '03')
GROUP BY c.Nom_commune
HAVING COUNT(*) >= 50
ORDER BY nb_ventes DESC;