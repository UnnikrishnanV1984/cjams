-- CDM-29239 - 2022 CJAMS TICKET
/*
-- Issue Description: 
The issue was the subsidy end date needed to be corrected. 
CJAMS Case #3079590 - Provider did not receive full payment for October and November stipened. 
Rate Begin Date was 11/18/2021, but the end date was incorrect. End date should have been 11/17/2022, not October 2022, 

Please update the subsidy rate end date from 10/12/2022 to 11/17/2022

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'b2eb49bb-dd59-46a6-b179-edbe98303ebf'
	and activeflag = 1 ;
	
update gapagreementrate  
set enddate = '2022-11-17T08:00:00',
	updatedon = now(), 
	updatedby = 'CDM-29239'
where gapagreementrateid = 'b2eb49bb-dd59-46a6-b179-edbe98303ebf'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
from gapratesrevision 
where gaprateid = 'b2eb49bb-dd59-46a6-b179-edbe98303ebf';

update gapratesrevision
set rateenddate = '2022-11-17T08:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-29239'
where gaprateid = 'b2eb49bb-dd59-46a6-b179-edbe98303ebf';

update gapagreementrate
set updatedon = now(),
    updatedby = 'CDM-29239' 
where gapagreementrateid = 'ccc9159c-1221-41d8-9c64-c1455077d38c'
    and activeflag = 1 ;
	
update gapratesrevision
set approvaldate = now(),
	updatedon = now(),
	updatedby = 'CDM-29239'
where gaprateid = 'ccc9159c-1221-41d8-9c64-c1455077d38c'; --Most recent one