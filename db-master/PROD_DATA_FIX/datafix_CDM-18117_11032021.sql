-- CDM-18117 - GAP start date
/*
-- Issue Description: 
	Worker entered agreement start date and payment start date as 8-3-21 and supervisor approved. 
	Agreement start date and payment start date should be 10-20-21.

-- Case ID: 3195686
-- Client ID: 4229389 (JAYSON GOUGH) - 9b57d533-a23a-4f60-bda0-fafa69b4d3df
-- GAP ID: 1005881  - 2021-08-03  To 2039-04-25 - ae346fe9-98e3-4efb-86fe-cd1c0ae056e1
-- Provider ID: 5003674	(Greta Martin)
-- New Date : 2021-10-20

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 2021-10-20 (old value is 2021-08-03)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2021-10-20 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-18117'
where gapid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1'
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementid = '09f29139-f189-4d47-af8c-92cc6d7e588c'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-10-20 04:00:00',
	enddate = '2022-10-19 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-18117'
where gapagreementid = '09f29139-f189-4d47-af8c-92cc6d7e588c'
	and activeflag = 1 ;
	
select startdate, enddate, approvaldate, updatedby, updatedon, activeflag
	from gapagreementrevision 
where gapid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1' ;	

update gapagreementrevision 
set startdate = '2021-10-20 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-18117'
where gapid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1' ;	

select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where guardiansubsidyid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1' ;

update gapratesrevision
set ratestartdate = '2021-10-20 04:00:00',
	rateenddate = '2022-10-19 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-18117'
where guardiansubsidyid = 'ae346fe9-98e3-4efb-86fe-cd1c0ae056e1' ;
