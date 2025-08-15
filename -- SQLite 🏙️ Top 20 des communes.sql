-- SQLite
--12 🏙️ Top 20 des communes de plus de 10 000 habitants avec le plus de transactions pour 1000 habitants
WITH ventes_par_commune AS (
    SELECT 
        c.Nom_commune,
        c.Nbre_habitant_2019 AS nb_habitants,
        COUNT(v.Id_vente) AS nb_ventes,
        ROUND(COUNT(v.Id_vente) * 1000.0 / c.Nbre_habitant_2019, 2) AS ventes_pour_1000
    FROM Vente v
    JOIN Bien b ON v.Id_bien = b.Id_bien
    JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
    WHERE c.Nbre_habitant_2019 > 10000
    GROUP BY c.Nom_commune, c.Nbre_habitant_2019
)
SELECT 
    Nom_commune,
    nb_habitants,
    nb_ventes,
    ventes_pour_1000
FROM ventes_par_commune
ORDER BY ventes_pour_1000 DESC
LIMIT 20;
