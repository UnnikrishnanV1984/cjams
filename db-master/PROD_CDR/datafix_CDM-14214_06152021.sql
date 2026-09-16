-- CDM-14214 - GAP AGREEMENT
/*
-- Issue Description: 
   The Worker entered wrong start date on the agreement for AMORA as 3/3/2021
   actual GAP start date is 5/7/2021.

-- Case ID: 3273232
-- Client ID: 4039900 (AMORA LA'MIYIA SCOTT	) - cb504465-1162-4885-9da6-a6f788e01ce6
-- GAP ID: 1005719 - 2021-03-03 To 2037-12-25 - f831f536-aacf-4480-a3a6-fa01defb5727
-- Provider ID:5038883 (Pearl Michele Nesbeth) 

    
-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Star Date as 05/07/2021 (old value is 03/03/2021)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreement  
where gapid = 'f831f536-aacf-4480-a3a6-fa01defb5727'
	and activeflag = 1 ;
	
update gapagreement  
set startdate = '2021-05-07 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-14214'
where gapid = 'f831f536-aacf-4480-a3a6-fa01defb5727'
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementid = '1e959c8f-635e-4575-94eb-73ebe5a114ad'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-05-07 05:00:00',
	enddate = '2022-05-06 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-14214'
where gapagreementid = '1e959c8f-635e-4575-94eb-73ebe5a114ad'
	and activeflag = 1 ;
	
select startdate, enddate, approvaldate, updatedby, updatedon, activeflag
	from gapagreementrevision 
where gapid = 'f831f536-aacf-4480-a3a6-fa01defb5727' ;	

update gapagreementrevision 
set startdate = '2021-05-07 05:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-14214'
where gapid = 'f831f536-aacf-4480-a3a6-fa01defb5727' ;	

select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where guardiansubsidyid = 'f831f536-aacf-4480-a3a6-fa01defb5727' ;

update gapratesrevision
set ratestartdate = '2021-05-07 05:00:00',
	rateenddate = '2022-05-06 05:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-14214'
where guardiansubsidyid = 'f831f536-aacf-4480-a3a6-fa01defb5727' ;