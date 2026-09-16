-- CDM-27238 - AGREEMENT START DATE
/*
-- Issue Description: 
   AGREEMENT START DATE
-- Case ID: 3272612   
-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Star Date as 11/12/2019 (old value is 12/03/2019)



select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapid = '4d06e92f-7564-4043-aee7-72d306011a94'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2019-11-12 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-27238'
where gapid = '4d06e92f-7564-4043-aee7-72d306011a94'
	and activeflag = 1 ;
	


select startdate, enddate, approvaldate, updatedby, updatedon, activeflag
	from gapagreementrevision 
where gapid = '4d06e92f-7564-4043-aee7-72d306011a94' ;	

update gapagreementrevision 
set startdate = '2019-11-12 00:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-27238'
where gapid = '4d06e92f-7564-4043-aee7-72d306011a94';	