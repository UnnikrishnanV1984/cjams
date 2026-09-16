-- CDM-18434 - Investigation Findings Missing
/*
-- Issue Description: 
    I am required to produce this CPS investigation record for court and am unable to view 
	or print the Investigation Findings. 
	This is the most critical part of the record, and it is showing completely blank on my screen. 
	This is a high priority. 

-- CPS-IR : 20200157020402
-- Alleged Maltreator Client ID: 1121027 (PEGGY J PASSMORE) - 93870bd1-f1aa-441d-8789-1ea842cfb76e

-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: User error; the alleged maltreator role was removed by the caseworker. 
		Potentiall candidate for a refinement to add validation on person role changes.    	  
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Bring back the Alleged maltreator person role
-- old values 
-- updatedby: eca6f2d2-e3c6-474c-8c4a-d4ee53381883	& updatedon: 2020-07-29 16:50:00
select personid, activeflag, intakeservicerequestpersontypekey, actorid, updatedby, updatedon 
	from intakeservicerequestactor
where intakeservicerequestactorid = 'afee34ba-ab00-478d-8148-7258659b8871'
	and activeflag = 0 ;

update cjams.intakeservicerequestactor
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-18434'
where intakeservicerequestactorid = 'afee34ba-ab00-478d-8148-7258659b8871'
	and activeflag = 0 ;

