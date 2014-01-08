/**
 * WhatToHedge.com Database Creation Script
 * 
 * Assumptions:
 *  - Recurring events are monthly.
 *  - Currency is dollars
 *  - Each scenario is for one commodity only
 *  
 * Companies that use hedging
 *  E & P Companies
 * Mining Companies
 * Large farms
 * Airlines (http://www.airlineriskmanagementforum.com/)
 * 
 * 
	CREATE DATABASE hedge;
 */
	
USE hedge;
	
SET FOREIGN_KEY_CHECKS=0;	

/*
 * Project has the output that has to be hedged.  A project can be an oil well, a field of wheat, an animal, or a refinary.  A project can produce one or more commodities
 * 
 */
	   DROP TABLE IF EXISTS project;

	   CREATE TABLE project (
	   		Project_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Project_Name varchar(100),
	   		Project_Desc VARCHAR(256),
	   		Start_Date DATETIME,
	   		Nbr_of_Months INTEGER,
        PRIMARY KEY  (`Project_ID`)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS commodity;

	   /*
	    * Commody is an end product of a project that is sold on the open maarket.  A project can produce multiple commodities.
	    */
	   CREATE TABLE commodity (
	   		Commodity_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Commodity_Name varchar(100),
	   		Commodity_Desc VARCHAR(256),
	   		Commodity_Units VARCHAR(256),
	   		Commodity_Units_abr VARCHAR(100),
        PRIMARY KEY  (`Commodity_ID`)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
		

	   DROP TABLE IF EXISTS scenario;

	   /*
	    * A scenario is a possible outcome for a project.  A scenario consists of sets of expenses, forcasts, hedges, and commoditeis produced.  If you change any one of the components,
	    * you are really creating a new scenario.
	    */
	   CREATE TABLE scenario (
	   		Scenario_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Scenario_Name varchar(100),
	   		Scenario_Desc varchar(100),
	   		Project_ID bigint(20) unsigned NOT NULL,
	   		Nbr_of_Months INTEGER,
        PRIMARY KEY  (Scenario_ID),
		CONSTRAINT FOREIGN KEY (Project_ID) REFERENCES project(Project_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS expense;

	   /*
	    * An expense is a cost incurred in a project and a scenario to produce a commodity.  Not every scenario will have the expense in a project.  For example, natural gas could be flared an the well head
	    *  in some scenarios and gathering costs would then not be incurred.
	    */
	   CREATE TABLE expense (
	   		Expense_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Scenario_ID bigint(20) unsigned NOT NULL,
	   		Expense_Type_ID bigint NOT NULL,
	   		Expense_Name varchar(100),
	   		Expense_Desc varchar(256),
	   		Expense_Month INTEGER NOT NULL DEFAULT 0,
			Expense_Amount decimal(21,6) DEFAULT NULL,
	   		Recurring CHAR(1) NOT NULL DEFAULT '0',
	   		Create_Date DATETIME,
        PRIMARY KEY  (`Expense_ID`),
		FOREIGN KEY (Scenario_ID) REFERENCES scenario(Scenario_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
		

	   DROP TABLE IF EXISTS expense_type;

	   /*
	    * An expense is a cost incurred in a project and a scenario to produce a commodity.  Not every scenario will have the expense in a project.  For example, natural gas could be flared an the well head
	    *  in some scenarios and gathering costs would then not be incurred. Assume that the Expense Cost is monthly
	    */
	   CREATE TABLE expense_type (
	   		Expense_Type_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Expense_Type_Name varchar(100),
	   		Expense_Type_Desc varchar(256),
	   		Duration INTEGER NOT NULL DEFAULT 0,
	   		Initial_Cost decimal(21,6) DEFAULT NULL,
			Monthly_Cost decimal(21,6) DEFAULT NULL,
			Total_Cost decimal(21,6) DEFAULT NULL,
	   		Recurring CHAR(1) NOT NULL DEFAULT '0',
        PRIMARY KEY  (`Expense_Type_ID`)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS Production;

	   /*
	    * Production is the amount of a commodity produced in a given time period for a given scenario.  The production amount can be hedged.
	    * 
	    * Swap contracts, collars and put options gaurentee a price for the unit of production.  Currently, we only use month time frames.
	    * 
	    */
	   CREATE TABLE production (
	   		Production_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Scenario_ID bigint(20) unsigned NOT NULL,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		Production_Month DATETIME,
			Projected_Production_Amt decimal(21,6) DEFAULT 0,
			Actual_Production_Amt decimal(21,6) DEFAULT 0,
			Market_Price decimal(21,6) DEFAULT 0,
			Production_Price decimal(21,6) DEFAULT 0,
        PRIMARY KEY  (`Production_ID`),
		FOREIGN KEY (Scenario_ID) REFERENCES scenario(Scenario_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
 * Forcast stores what the futures are indicating or possible price moves of a given commodity.  
 * It is used in comparison of scenarios.  We should create contango and backwardization forcasts.  Also, we should use last year's
 * data as a forcast.
 */
	   DROP TABLE IF EXISTS forcast;

	   CREATE TABLE forcast (
	   		Forcast_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		Forcast_Name varchar(100),
	   		Forcast_Desc varchar(100),
	   		Nbr_of_Months INTEGER,
	   		Start_Date DATETIME,
        PRIMARY KEY  (Forcast_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS forcast_month;

	   CREATE TABLE forcast_month (
	   		Forcast_Month_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Forcast_ID bigint(20) unsigned NOT NULL ,
	   		forcast_price Decimal(21,6) NOT NULL DEFAULT 0, 
	   		forcast_month DATETIME,
        PRIMARY KEY  (Forcast_Month_ID),
		FOREIGN KEY (Forcast_ID) REFERENCES Forcast(Forcast_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*
 *  An option is contract which provides the buyer of the contract the right, but not the obligation, to purchase or sell a particular amount of 
 * a specific commodity (such as crude oil or natural gas) on or before a specific date or period of time. There are two primary types of options, 
 * call options (which are often referred to as a ceilings or caps) and put options (which are often referred to as floors).  A call option provides the buyer of the option with a hedge against a potential price increase while a put option provides the buyer of the option with a hedge against a potential price decrease. 

E&P companies often utilize put options to mitigate their exposure to declining crude oil, natural gas and natural gas liquids prices while end-users often use call options to mitigate their exposure against potentially rising prices such as gasoline, diesel fuel, jet fuel and natural gas.

 */
	   DROP TABLE IF EXISTS option_contract;

	   CREATE TABLE option_contract (
	   		option_contract_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Scenario_ID bigint(20) unsigned NOT NULL,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		contract_month DATETIME,
	   		Settlement_Date   DATETIME,
	   		Strike_Price  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Contract_Unit  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Contract_Cost  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Nbr_of_Contracts INTEGER,
        PRIMARY KEY  (option_contract_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS future_contract;

	   CREATE TABLE future_contract (
	   		future_contract_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		Scenario_ID bigint(20) unsigned NOT NULL,
	   		Units varchar(100),
	   		contract_month DATETIME,
	   		futures_Price  Decimal(21,6) NOT NULL DEFAULT 0,
	   		futures_Size  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Nbr_of_Contracts INTEGER,
        PRIMARY KEY  (future_contract_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS swap_contract;

	   CREATE TABLE swap_contract (
	   		swap_contract_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		Scenario_ID bigint(20) unsigned NOT NULL,
	   		contract_month DATETIME,
	   		settlement_Date   DATETIME,
	   		fixed_Price  Decimal(21,6) NOT NULL DEFAULT 0,
	   		floating_Price  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Contract_Unit  Decimal(21,6) NOT NULL DEFAULT 0,
	   		Nbr_of_Contracts INTEGER,
        PRIMARY KEY  (swap_contract_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

	   DROP TABLE IF EXISTS history;

	   CREATE TABLE history (
	   		History_ID  bigint(20) unsigned NOT NULL auto_increment,
	   		Commodity_ID bigint(20) unsigned NOT NULL,
	   		Amount Decimal(21,6) NOT NULL DEFAULT 0, 
	   		Month_Nbr INTEGER,
	   		History_Date DATETIME,
        PRIMARY KEY  (History_ID),
		FOREIGN KEY (Commodity_ID) REFERENCES Commodity(Commodity_ID)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

		
SET FOREIGN_KEY_CHECKS=1;

