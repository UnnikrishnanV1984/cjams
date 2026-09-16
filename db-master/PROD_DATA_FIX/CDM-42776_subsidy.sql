/*
  Issue Description:  CDM-42776
   Category/ Module  :  Payments
   Root cause: Support ticket, the system has created the auto suspension as the client was NOT Eligible Reimbursable when the child removal was created in CJAMS. Working as designed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


/*
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '41126a9b-5cfa-468d-acdc-9acc8c27aeb8'
	and activeflag  = 1 ;
*/
	
update adoptioncasesuspension
set suspensionbegindate = suspensionenddate,
	activeflag = 0,
	updatedby = 'CDM-42776',
	updatedon = now()
where adoptionsuspensionid = '41126a9b-5cfa-468d-acdc-9acc8c27aeb8'
	and activeflag  = 1 ;

/*
select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
	from adoptioncasesuspensionrevision
where adoptionsuspensionid = '41126a9b-5cfa-468d-acdc-9acc8c27aeb8'
	and activeflag = 1 ;	
*/

update adoptioncasesuspensionrevision
set suspensionbegindate = suspensionenddate,
	activeflag = 0,
	updatedby = 'CDM-42776',
	updatedon = now()
where adoptionsuspensionid = '41126a9b-5cfa-468d-acdc-9acc8c27aeb8'
	and activeflag = 1 ;

-- To trigger under/over 
/*select adoptionagreementrateid, startdate, enddate, paymentamout, status, approvaldate, updatedon, updatedby
from adoptioncaseagreementrate
where adoptionagreementid = 'c3c0d4a2-0c55-4737-9d4a-b0aa4763e04c'
and adoptionagreementrateid = '4fbd2433-b155-4675-b349-a51b22bc824b'
and activeflag = 1;*/

update adoptioncaseagreementrate
set updatedby = 'CDM-42776',
updatedon = now()
where adoptionagreementrateid = '4fbd2433-b155-4675-b349-a51b22bc824b'
and activeflag = 1 ;