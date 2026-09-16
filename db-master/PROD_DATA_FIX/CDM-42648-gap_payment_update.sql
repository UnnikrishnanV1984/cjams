-- CDM-42648 - Payment
/*
-- Issue Description: 
  Negotiated amount needs to be $1008, current amount entered it not correct. Intermediate rate for approved monthly rate for $1008 on October 4, 2024. 

-- Client ID: 201871689 (NAYELI KEYS)
-- SSA Approval Date - October 4th 2024
-- Negotiated Date - 10/4/2024
-- Negotiated Amount - 1008$
Rate override check box should be selected
    
-- Category/ Module: GAP (Case Management) 
-- Root cause: User incorrectly entered the subsidy rate amount with per day rate ($33.6) and need to update to $1008.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update GAP Rate & Rate Revision

/*
select paymentamout, startdate, enddate, status, updatedby, updatedon,*
	from gapagreementrate  
where gapagreementrateid = '94add136-40b3-4688-b7b4-d0caadf735f4'
	and gapagreementid = 'f1b7a49e-74c8-40d6-997e-873ce46c316d'
	and activeflag = 1 ;
*/

update gapagreementrate  
set paymentamout = 1008.00,
	ssaapprovaldate = '2024-10-04',
	isoverride  = true,
	updatedon = now(), 
	updatedby = 'CDM-42648'
where gapagreementrateid = '94add136-40b3-4688-b7b4-d0caadf735f4'
	and gapagreementid = 'f1b7a49e-74c8-40d6-997e-873ce46c316d'
	and activeflag = 1 ;

/*
select paymentamt, approvaldate, approvalstatustypekey, activeflag, updatedby, updatedon,*
	from gapratesrevision
where gaprateid = '94add136-40b3-4688-b7b4-d0caadf735f4' ;
*/
/*
select picklist_value_cd , value_tx, *
from cjams.tb_picklist_values tpv where btrim(picklist_value_cd ) in ('3047','3045')
*/
update gapratesrevision
set paymentamt = 1008.00,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-42648'
where gaprateid = '94add136-40b3-4688-b7b4-d0caadf735f4';