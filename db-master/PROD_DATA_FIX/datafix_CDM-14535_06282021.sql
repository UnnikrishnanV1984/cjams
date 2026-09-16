-- CDM-14535 - Wrong GAP begin date
/*
-- Issue Description: 
   The Worker entered wrong GAP start date on the agreement for ISAIAH R JENKINS as 9/22/2020
   actual GAP start date is 10/14/2020.

-- Case ID: 3227287
-- Client ID: 3682800 (ISAIAH R	JENKINS) - 26a37054-b064-4fa7-9d0e-fe0f28a351a7
-- GAP ID: 1005579 - 2020-09-22 To 2028-11-06 - 5183a51f-581f-4387-afc8-a7f7064563a1
-- Provider ID: 5012369	(Patricia Duckett) 

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 10/14/2020 (old value is 09/22/2020)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapid = '5183a51f-581f-4387-afc8-a7f7064563a1'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2020-10-14 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-14535'
where gapid = '5183a51f-581f-4387-afc8-a7f7064563a1'
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementid = '89520ef4-5b3d-415c-a60e-8ccb01095b40'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2020-10-14 04:00:00',
	enddate = '2021-10-13 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-14535'
where gapagreementid = '89520ef4-5b3d-415c-a60e-8ccb01095b40'
	and activeflag = 1 ;
	
select startdate, enddate, approvaldate, updatedby, updatedon, activeflag
	from gapagreementrevision 
where gapid = '5183a51f-581f-4387-afc8-a7f7064563a1' ;	

update gapagreementrevision 
set startdate = '2020-10-14 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-14535'
where gapid = '5183a51f-581f-4387-afc8-a7f7064563a1' ;	

select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where guardiansubsidyid = '5183a51f-581f-4387-afc8-a7f7064563a1' ;

update gapratesrevision
set ratestartdate = '2020-10-14 04:00:00',
	rateenddate = '2021-10-13 04:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-14535'
where guardiansubsidyid = '5183a51f-581f-4387-afc8-a7f7064563a1' ;
