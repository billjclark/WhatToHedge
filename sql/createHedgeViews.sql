/*
 * What To Hedge Views - Each of the main contract types have a view for contact month, scenario, commodity neam, etc 
 */
USE hedge;

DROP VIEW IF EXISTS option_contract_vw;
  
CREATE VIEW option_contract_vw AS
SELECT o.*, MONTHNAME(contract_month) AS contract_month_name, c.commodity_Name, c.commodity_desc, c.commodity_Units, c.commodity_Units_abr, 
sc.Scenario_Name, sc.Scenario_Desc, sc.Nbr_of_Months, p.project_name, p.project_id, p.project_desc
FROM option_contract o, commodity c, scenario sc, project p
WHERE o.commodity_id = c.commodity_id
  AND o.scenario_id = sc.scenario_id
  AND sc.project_id = p.project_id;
  
 DROP VIEW IF EXISTS swap_contract_vw;
 
CREATE VIEW swap_contract_vw AS
SELECT s.*, MONTHNAME(contract_month) AS contract_month_name, c.commodity_Name, c.commodity_desc, c.commodity_Units, c.commodity_Units_abr, 
sc.Scenario_Name, sc.Scenario_Desc, sc.Nbr_of_Months, p.project_name, p.project_id, p.project_desc
FROM swap_contract s, commodity c, scenario sc, project p
WHERE s.commodity_id = c.commodity_id
  AND s.scenario_id = sc.scenario_id
  AND sc.project_id = p.project_id;
  
DROP VIEW IF EXISTS future_contract_vw;
  
CREATE VIEW future_contract_vw AS
SELECT f.*, MONTHNAME(contract_month) AS contract_month_name, c.commodity_Name, c.commodity_desc, c.commodity_Units, c.commodity_Units_abr, 
sc.Scenario_Name, sc.Scenario_Desc, sc.Nbr_of_Months, p.project_name, p.project_id, p.project_desc
FROM future_contract f, commodity c, scenario sc, project p
WHERE f.commodity_id = c.commodity_id
  AND f.scenario_id = sc.scenario_id
  AND sc.project_id = p.project_id;
   
DROP VIEW IF EXISTS forcast_month_vw;
  
CREATE VIEW forcast_month_vw AS
SELECT fm.*, MONTHNAME(forcast_month) AS forcast_month_name, f.forcast_name, f.forcast_desc, c.commodity_id, c.commodity_Name, c.commodity_desc, c.commodity_Units, c.commodity_Units_abr
FROM forcast_month fm, forcast f, commodity c
WHERE f.commodity_id = c.commodity_id
  AND fm.forcast_id = f.forcast_id;
  