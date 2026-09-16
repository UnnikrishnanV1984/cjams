-- CDM-27660 - Creating GAP case
/*
-- Issue Description: 
   User request to update GAP start date as 12/21/2022 and remove the GAP suspension

-- Case ID: 3260139
-- Client ID: 3957255 (TAELYN NICOLE MARTIN) - 54d7e593-cc70-4362-8965-4af1a7205f55
-- GAP ID: 1006202 - 2022-09-14 To 2030-03-14 - b50b4706-31f7-4dbe-b038-9e0bdad904bc
-- Provider ID: 6007016	(Latoyia Denay Carroll) 
-- gapagreementid: 06e66e31-eea2-4f9e-b8ea-93c85b280abf
-- gapagreementrateid: 9168a061-8529-488a-bcc6-05ee6aecbca3
-- GAP start date should be 12/21/2022

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 12/21/2022 (old value is 09/14/2022)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2022-12-21 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-27660'
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc'
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementid = '06e66e31-eea2-4f9e-b8ea-93c85b280abf'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-12-21 04:00:00',
	enddate = '2023-12-20 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-27660'
where gapagreementid = '06e66e31-eea2-4f9e-b8ea-93c85b280abf'
	and activeflag = 1 ;
	
select startdate, enddate, approvaldate, updatedby, updatedon, activeflag
	from gapagreementrevision 
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' ;	

update gapagreementrevision 
set startdate = '2022-12-21 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-27660'
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' ;	

select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where guardiansubsidyid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' ;

update gapratesrevision
set ratestartdate = '2022-12-21 04:00:00',
	rateenddate = '2023-12-20 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-27660'
where guardiansubsidyid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' ;

-- Delete GAP suspension
select gapid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspension 
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' 
	and gapsuspensionid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag  = 1 ;

update gapsuspension		
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-27660'
where gapid = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc' 
	and gapsuspensionid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag = 1 ;

select suspensionid, startdate, enddate, activeflag, updatedby, updatedon
from gapsuspensionrevision 
where guardiansubsidyid  = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc'
	and suspensionid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag = 1 ;

update gapsuspensionrevision		
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-27660'
where guardiansubsidyid  = 'b50b4706-31f7-4dbe-b038-9e0bdad904bc'
	and suspensionid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag = 1 ;
	
	
select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
from routing 
where eventcode = 'GASR' 
	and objectid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag = 1 ;
	
update routing		
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-27660'	
where eventcode = 'GASR' 
	and objectid = '5a114b5c-bc41-49bf-92d2-4959904975ab'
	and activeflag = 1 ;
	
-- Update GAP program assignment 
select programkey, startdate, enddate, activeflag, updatedon, updatedby  
	from personprogramarea
where personid = '54d7e593-cc70-4362-8965-4af1a7205f55'
	and personprogramid = 'a1f5cff6-024c-4b90-8dff-1f2558452223'
	and programkey = 'GAP';
	
update personprogramarea
set startdate = '2022-12-21 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-27660'	
where personid = '54d7e593-cc70-4362-8965-4af1a7205f55'
	and personprogramid = 'a1f5cff6-024c-4b90-8dff-1f2558452223'
	and programkey = 'GAP';
