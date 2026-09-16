-- CDM-18423 - GAP date needs to be edited.
/*
-- Issue Description: 
	User request to change the GAP Start date as  9/2/21 (old date 9/15/21)

-- Case ID: 3271184
-- Client ID: 4012238 (ADONIS PARKER) - efacbe8e-b6fe-41f3-aa88-7b5b1c9e767c
-- GAP ID: 1005834 - 2021-09-15 To 2037-10-13 - d32f5f7f-e652-4f1f-b866-f052c17fb932
-- Provider ID: 5078571	(Erica Brooks)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 2021-09-02 (old value is 2021-09-15)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'd32f5f7f-e652-4f1f-b866-f052c17fb932'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-09-02 13:26:47',
	updatedby = 'CDM-18423',
	updatedon = now()
where gapid = 'd32f5f7f-e652-4f1f-b866-f052c17fb932'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'd32f5f7f-e652-4f1f-b866-f052c17fb932' ;

update gapagreementrevision
set startdate = '2021-09-02 13:26:47',
	approvaldate = now(),
	updatedby = 'CDM-18423',
	updatedon = now()
where gapid = 'd32f5f7f-e652-4f1f-b866-f052c17fb932' ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'c2695e37-637e-4cf4-9296-9f56d42c9410'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-09-02 13:26:47',
	enddate = '2022-09-01 13:26:47',
	updatedon = now(), 
	updatedby = 'CDM-18423'
where gapagreementrateid = 'c2695e37-637e-4cf4-9296-9f56d42c9410'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'c2695e37-637e-4cf4-9296-9f56d42c9410';

update gapratesrevision
set ratestartdate = '2021-09-02 13:26:47',
	rateenddate = '2022-09-01 13:26:47',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-18423'
where gaprateid = 'c2695e37-637e-4cf4-9296-9f56d42c9410';

