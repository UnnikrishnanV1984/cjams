-- CDM-14354 - Unable to approve GAP by supervisor
/*
-- Issue Description: 
	Supervisor is unable to approve GAP Agreement rate it shows success message 
	nut the decision stays 'Review' only.
	   
-- Case ID: 3286122 
-- Client ID: 3876022 (ANGEL GONZALEZ) - eba0b472-ec18-4b61-af37-5c410cbf5314
-- GAP ID: 1005754 - 2021-02-12 to 2026-09-13 - be87d269-1c84-44b1-a76e-0a8e1e4b64eb


-- Category/ Module: GAP  (Case Management) 
-- Root cause: This GAP Agreement was approved without Rates.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid = 'be87d269-1c84-44b1-a76e-0a8e1e4b64eb'
	and activeflag  = 1 ;
	
update gapagreement
set activeflag = 0,
	updatedby = 'CDM-14354',
	updatedon =  now()	
where gapid = 'be87d269-1c84-44b1-a76e-0a8e1e4b64eb'
	and activeflag  = 1 ;
	
select gapid, activeflag, updatedby, updatedon
	from gapagreementrevision 
where gapid = 'be87d269-1c84-44b1-a76e-0a8e1e4b64eb'
	and activeflag = 1 ;
		
update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-14354',
	updatedon =  now()	
where gapid = 'be87d269-1c84-44b1-a76e-0a8e1e4b64eb'
	and activeflag = 1 ;

select servicerequestnumber, eventcode, activeflag , updatedby, updatedon 
	from routing
where eventcode::text = 'GAAR'::text
	and objectid = '32ed781d-9722-4298-8eb6-7a6161e7fc21' -- gapagreementid
	and activeflag = 1	;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-14354',
	updatedon =  now()	
where eventcode::text = 'GAAR'::text
	and objectid = '32ed781d-9722-4298-8eb6-7a6161e7fc21'
	and activeflag = 1	;
	
