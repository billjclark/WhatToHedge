/*
 * Bakken Oil well.  Assume 9 Millillon in total cost.
 */
INSERT INTO commodity (commodity_name, commodity_desc, commodity_units, commodity_units_abr) VALUES ('WTI Oil', 'Light Sweet Crude Oil (WTI)  ', 'barrels', 'bls'); 
INSERT INTO commodity (commodity_name, commodity_desc, commodity_units, commodity_units_abr) VALUES ('BZ Oil', 'Brent Crude Oil Last Day (BZ)', 'barrels', 'bls'); 
INSERT INTO commodity (commodity_name, commodity_desc, commodity_units, commodity_units_abr) VALUES ('DC Oil', 'Dubai Crude Oil (Platts) Fininacial (DC)', 'barrels', 'bls'); 
INSERT INTO commodity (commodity_name, commodity_desc, commodity_units, commodity_units_abr) VALUES ('NG', 'Associated Gas', 'barrels', 'bls'); 
INSERT INTO commodity (commodity_name, commodity_desc, commodity_units, commodity_units_abr) VALUES ('NGLs', 'Natural Gas Condensate', 'barrels', 'bls'); 

/*
 * Bakken Crude Oil well that produces oil and associated Gas
 */
INSERT INTO project (project_name, project_desc, start_date, nbr_of_months) VALUES ('Bakken Oil Well', 'Oil Well that produces oil and associated gas', '2014-01-01', 72);

/*
 *  For the Bakken Oil Well, let's create the following scenarios:
 * 
 * - Prices in Cantango
 * - Price backwardization
 * 
 */
INSERT INTO scenario (Scenario_name, Scenario_desc, project_id, nbr_of_months) SELECT 'Contango Scenario','Contango - Prices Going Up in future', project_id, 60 FROM project WHERE project_name = 'Bakken Oil Well';
INSERT INTO scenario (Scenario_name, Scenario_desc, project_id, nbr_of_months) SELECT 'Backwarization Scenario','Backwardization - Prices Going Down in future', project_id, 60 FROM project WHERE project_name = 'Bakken Oil Well';

/*
 * Expense Types are to help categorize expenses for a project
 */
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Search', 'All costs incurred to find the site', 1, 200000, 200000, 200000, 'N');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Rig Rental', 'Rig Rental For One Month', 2, 200000, 9000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Rig Labor', 'Rig Labor For One Month', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Casing & Cement', 'Run Casing and cement for well', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Casing & Cement', 'Run Casing and cement for well', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Completion', 'Completiont for well', 2, 200000, 1000000, 9200000, 'y');

/*
 * Expense Types are to help categorize expenses for a project
 */
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Search', 'All costs incurred to find the site', 1, 200000, 200000, 200000, 'N');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Rig Rental', 'Rig Rental For One Month', 2, 200000, 9000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Rig Labor', 'Rig Labor For One Month', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Casing & Cement', 'Run Casing and cement for well', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Casing & Cement', 'Run Casing and cement for well', 2, 200000, 1000000, 9200000, 'y');
INSERT INTO expense_type (Expense_Type_Name, Expense_Type_Desc, Duration, Initial_Cost, Monthly_Cost, Total_Cost, Recurring) VALUES ('Completion', 'Completiont for well', 2, 200000, 1000000, 9200000, 'y');

/*
 *  Lynn Energy Investor Graphs
 *  Lynn projects to produce ~500 MMcf/d of NG and 50,000 Bbls/day by 2017.  The goal is to display their NG and oil positions in a graph.
*/

INSERT INTO project (project_name, project_desc, start_date, nbr_of_months) VALUES ('Lynn Energy', 'Lynn Energy Investor Presentation', '2014-01-01', 72);

INSERT INTO scenario (Scenario_Name, Scenario_desc, Project_ID, Nbr_of_Months) SELECT 'Lynn Hedge Positions', 'Lynn Hedge Positions from 2013 to 2017', project_id, 60 FROM project where project_name like "Lynn Energy";

INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-01-01', '2013-12-25', 94.97, 0, 1000, 27 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-02-01', '2014-01-25', 92.92, 0, 1000, 30 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-03-01', '2014-02-25', 96.23, 0, 1000, 30 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-04-01', '2014-03-25', 90.56, 0, 1000, 28 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-05-01', '2014-04-25', 89.02, 0, 1000, 19 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-06-01', '2014-05-25', 95, 0, 1000, 25 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-07-01', '2014-06-25', 95.76, 0, 1000, 25 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-08-01', '2014-07-25', 94.97, 0, 1000, 27 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-09-01', '2014-08-25', 92.92, 0, 1000, 30 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-10-01', '2014-09-25', 96.23, 0, 1000, 30 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-11-01', '2014-10-25', 90.56, 0, 1000, 28 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO swap_contract (Commodity_id, Scenario_id, contract_month, settlement_date, fixed_price, floating_price, contract_unit, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-12-01', '2014-11-25', 95, 0, 1000, 19 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';

INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-01-01', '2013-12-25', 97.86, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-02-01', '2014-01-25', 91.3, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-03-01', '2014-02-25', 90, 1000, .0350, 13 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-04-01', '2014-03-25', 90, 1000, .0350, 13 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-05-01', '2014-04-25', 90, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-06-01', '2014-05-25', 91.55, 1000, .0350, 14 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-07-01', '2014-06-25', 97.86, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-08-01', '2014-07-25', 91.3, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-09-01', '2014-08-25', 90, 1000, .0350, 13 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-10-01', '2014-09-25', 90, 1000, .0350, 13 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-11-01', '2014-10-25', 90, 1000, .0350, 14 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';
INSERT INTO option_contract (Commodity_id, Scenario_id, contract_month, settlement_date, strike_price, contract_unit, contract_cost, nbr_of_contracts) SELECT commodity_id, scenario_id, '2014-12-01', '2014-11-25', 91.55, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';

INSERT INTO forcast (Commodity_id, Forcast_Name, Forcast_Desc, Nbr_of_months, Start_Date) 
SELECT Commodity_id, 'Backwardization Forcast', 'Assume prices going down 10% per month', 12, '2014-01-01'
FROM Commodity c
WHERE c.commodity_name = 'WTI Oil';
  
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 110, '2014-01-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 99, '2014-02-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 89, '2014-03-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 80.1, '2014-04-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 90.5, '2014-05-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 88.54, '2014-06-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 87.95, '2014-07-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 87.6, '2014-08-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 87, '2014-09-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 86.5, '2014-10-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 84, '2014-11-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';
INSERT INTO forcast_month (forcast_id, forcast_price, forcast_month) SELECT forcast_id, 84.5, '2014-12-01' FROM forcast f, commodity c WHERE f.commodity_id = c.commodity_id AND c.commodity_name = 'WTI Oil' AND f.forcast_name = 'Backwardization Forcast';

INSERT INTO production (Commodity_id, Scenario_id, contract_month, Production_Month, Projected_Production_Amt, Actual_Production_Amt, Market_Price, Production_Price)
SELECT commodity_id, scenario_id, '2014-01-01', '2013-12-25', 97.86, 1000, .0350, 16 FROM commodity, scenario WHERE Commodity_name = 'WTI Oil' AND Scenario_Name = 'Lynn Hedge Positions';

