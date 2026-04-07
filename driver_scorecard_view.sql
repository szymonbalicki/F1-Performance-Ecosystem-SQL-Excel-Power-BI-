-- Tworzenie zoptymalizowanego widoku dla raportów w Excelu
-- Creating an optimized view for Excel reporting automation
CREATE VIEW v_Driver_Scorecard_Final AS
SELECT 
    -- Łączenie imienia i nazwiska w jedną kolumnę (Concatenation)
    d.forename || ' ' || d.surname AS Driver_Name,
    c.name AS Team,
    r.year AS Season,
    r.name AS Race_Name,
    res.grid AS Start_Pos,
    res.positionOrder AS Finish_Pos,
    
    -- Obliczanie różnicy pozycji (kluczowy KPI do analizy Race Pace)
    -- Calculating position delta (Key KPI for Race Pace analysis)
    (res.grid - res.positionOrder) AS Positions_Gained,
    
    res.points AS Points,
    s.status AS Race_Status

FROM results res
-- Konsolidacja 5 tabel relacyjnych (Data Normalization)
JOIN drivers d      ON res.driverId = d.driverId
JOIN races r        ON res.raceId = r.raceId
JOIN constructors c ON res.constructorId = c.constructorId
JOIN status s       ON res.statusId = s.statusId

-- Filtrowanie zakresu danych dla aktualności analizy
-- Filtering for data relevance (modern era of F1)
WHERE r.year BETWEEN 2019 AND 2024

-- Sortowanie dla zachowania przejrzystości raportu końcowego
ORDER BY r.year DESC, r.name;