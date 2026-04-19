# F1-Performance-Analysis-SQL-Excel-Power-BI-



[PL] Kompleksowy projekt analityczny typu End-to-End, obejmujący cały proces: od czystego kodu SQL, przez automatyzację w Excelu, aż po interaktywny dashboard Power BI. [EN] A comprehensive End-to-End data project covering the full pipeline: from raw SQL queries and Excel automation to an interactive Power BI dashboard.



## 🛠️ Tech Stack & Workflow

### 1️⃣ Data Engineering (SQL)
* **PL:** Konsolidacja 5 tabel relacyjnych w zoptymalizowany widok `v_Driver_Scorecard_Final`. Implementacja logiki biznesowej (np. metryka *Positions Gained*).
* **EN:** Consolidating 5 relational tables into an optimized `v_Driver_Scorecard_Final` view. Business logic implementation (e.g., *Positions Gained* metric).
* **Tools:** `SQLite`, `JOINs`, `CTEs`, `Data Cleaning`.
  
* -- Tworzenie zoptymalizowanego widoku dla raportów w Excelu
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

### 2️⃣ Operational Reporting (Excel & VBA)
* **PL:** Automatyzacja generowania raportów "Driver Scorecard". Skrypt VBA umożliwia eksport profesjonalnej karty zawodnika do formatu PDF jednym kliknięciem.
* **EN:** "Driver Scorecard" reporting automation. VBA script enables exporting a professional player card to PDF with a single click.
* **Tools:** `VBA`, `Excel Power Query`, `Automated PDF Export`.

      * ' Skrypt automatyzujący generowanie karty zawodnika do formatu PDF
      ' Script for automated Driver Scorecard export to PDF
      Sub GenerujRaportPDF()
       Dim nazwaPliku As String
       Dim folder As String
       Dim kierowca As String
    
      ' Pobranie nazwiska kierowcy z komórki E5
      ' Retrieving driver's name from cell E5
      kierowca = Range("E5").Value
    
      ' Sanity check: zamiana spacji na podkreślenia dla poprawnej nazwy pliku
      ' Data cleaning: replacing spaces with underscores for valid filename
      kierowca = Replace(kierowca, " ", "_")
    
      ' Definiowanie ścieżki zapisu w folderze skoroszytu
      ' Defining the save path in the workbook's directory
      folder = ThisWorkbook.Path & "\"
      nazwaPliku = folder & "Raport_F1_" & kierowca & ".pdf"
    
      ' Eksport wyznaczonego zakresu (A1:G26) do formatu PDF
      ' Exporting the designated range (A1:G26) to PDF format
      Range("A1:G26").ExportAsFixedFormat Type:=xlTypePDF, _
        Filename:=nazwaPliku, _
        Quality:=xlQualityStandard, _
        OpenAfterPublish:=True
        
      ' Powiadomienie o sukcesie operacji
      ' Success notification
      MsgBox "Raport dla kierowcy " & Replace(kierowca, "_", " ") & " został wygenerowany!", vbInformation, "Sukces"
      End Sub

### 3️⃣ Visual Analytics (Power BI)
* **PL:** Interaktywny dashboard (Vegas Night Theme) analizujący wyniki. Wykorzystanie zaawansowanych technik UX dla lepszej czytelności danych.
* **EN:** Interactive dashboard (Vegas Night Theme) analyzing performance. Advanced UX techniques used for better data storytelling.
* **Tools:** `DAX`, `Bookmarks`, `Selection Pane`, `Conditional Formatting`.

### Power BI Model

 ![PBI 1](./images/ModelPBI.png) 
---

## 📊 Key Insights / Kluczowe Wnioski
[PL] Verstappen i Hamilton razem zdobyli 31% wszystkich punktów sezonu 2019–2024 — przy 20 kierowcach na gridzie. Trzeci w rankingu Leclerc osiągnął zaledwie 59% wyniku lidera. To nie jest dominacja — to statystyczna anomalia.

[EN] Verstappen and Hamilton combined for 31% of all points scored across the 2019–2024 seasons — with 20 drivers on the grid. Third-placed Leclerc reached only 59% of the leader's tally. This isn't dominance — it's a statistical anomaly.

[PL] W erze dominacji Red Bulla (2019–2024) Verstappen osiągnął podium w 70% wyścigów, podczas gdy jego partner teamowy Pérez jedynie w 24,6%. Ten sam samochód, ta sama infrastruktura — różnica 3x. To dowód, że w F1 tego okresu dominował jeden kierowca, nie jeden zespół.

[EN] During Red Bull's dominant era (2019–2024), Verstappen stood on the podium in 70% of races, while teammate Pérez managed just 24.6%. Same car, same infrastructure — a 3x gap. This proves that what dominated this era wasn't a team, but a single driver.

[PL] Zaskakujący wniosek: pomimo powszechnej opinii o dominacji brytyjskiej myśli technicznej w F1, dane z lat 2019–2024 pokazują inaczej — Red Bull (Austria) zdobył 3 350 pkt i wygrał 63 wyścigi, podczas gdy wszystkie zespoły brytyjskie łącznie zebrały 2 500 pkt (~19% całego gridu). To era Verstappena, nie UK.

[EN] Surprising insight: despite the widely held belief that British engineering dominates F1, the 2019–2024 data tells a different story — Red Bull (Austria) scored 3,350 pts and won 63 races, while all British teams combined collected just 2,500 pts (~19% of the total grid. This is Verstappen's era, not the UK's.

---

## 🖼️ Gallery / Galeria

### 📊 Operational Tools & Logic
| Excel Scorecard (PDF) | SQL Logic |
| :---: | :---: |
| ![Excel](./images/ExcelRaport.png) | ![SQL](./images/modelsql.png) |

### 💡 Power BI "Vegas Style" Dashboard
| Overview | Driver Analysis | Races | Team Stats |
| :---: | :---: | :---: | :---: |
| ![PBI 1](./images/Start.png) | ![PBI 2](./images/Drivers.png) | ![PBI 3](./images/Races.png) | ![PBI 4](./images/Constructors.png) |

## 🔗 Live Dashboard

👉 [View Interactive Dashboard](https://app.powerbi.com/view?r=eyJrIjoiY2I2ZmYzNTItZGUzZS00ODJjLTgwZmYtOTFmOGZhNDM4OWViIiwidCI6ImU4MGE2MjdmLWVmOTQtNGFhOS04MmQ2LWM3ZWM5Y2ZjYTMyNCIsImMiOjh9)
---

## 📂 Project Structure
* `/sql/` - SQL scripts & View definitions
* `/excel/` - Automation tool (.xlsm) & sample PDF reports
* `/power-bi/` - Dashboard file (.pbix)
* `/images/` - Screens of all workspace
