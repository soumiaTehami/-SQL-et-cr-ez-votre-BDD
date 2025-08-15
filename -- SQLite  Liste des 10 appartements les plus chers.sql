-- SQLite
---6🏢 Liste des 10 appartements les plus chers avec région et surface (m²)
SELECT 
    v.Valeur AS Prix,
    r.Nom_Region AS Region,
    b.Surface_carrez AS Surface_m2
FROM Vente v
JOIN Bien b ON v.Id_bien = b.Id_bien
JOIN Commune c ON b.id_codedep_codecommune = c.id_codedep_codecommune
JOIN Region r ON c.Id_region = r.Id_region
WHERE b.Type_local = 'Appartement'
ORDER BY v.Valeur DESC
LIMIT 10;


---7 Taux d’évolution du nombre de ventes entre le premier 
WITH ventes_par_trimestre AS (
    SELECT
        CASE
            WHEN strftime('%m', v.Date) IN ('01','02','03') THEN 'T1'
            WHEN strftime('%m', v.Date) IN ('04','05','06') THEN 'T2'
        END AS trimestre,
        COUNT(*) AS nb_ventes
    FROM Vente v
    WHERE strftime('%Y', v.Date) = '2020'
      AND strftime('%m', v.Date) IN ('01','02','03','04','05','06')
    GROUP BY trimestre
)
SELECT 
    ROUND(((t2.nb_ventes - t1.nb_ventes) * 100.0 / t1.nb_ventes), 2) AS taux_evolution_pourcent
FROM ventes_par_trimestre t1
JOIN ventes_par_trimestre t2 ON t1.trimestre = 'T1' AND t2.trimestre = 'T2';


