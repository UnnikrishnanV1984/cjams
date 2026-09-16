-- CDM-26527- Need to delete duplicate referral
/*
   File Name: CDM-26527-intakedastaging-Delete-Duplicatereferral
-- Issue Description: 
    For the Intakenumber I221010329560  - Need to Remove the Duplicate referral.
    Customer Email ID:devan.barker@maryland.gov
  
-- Resolution: Updated the Flag to zero in the intakedastaging and intakedastatus table for the intakenumber = 'I221010329560'

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*select * from intakedastaging where intakenumber = 'I221010329560' and activeflag = '1';
select * from intakedastatus where intakenumber = 'I221010329560' and activeflag = '1' and intakedastatusid = 'ecf498d5-4e54-4d3d-b366-6b90d9d7b661';
select * from routing where objectid = 'I221010329560';
select * from intakesnapshot  WHERE intakenumber = 'I221010329560';
select * from intakeservicerequest  WHERE intakenumber = 'I221010329560';
*/


update
	intakedastaging
set
	activeflag = 0,
	updatedby = 'CDM-26527',
	updatedon = now()
where
	intakenumber = 'I221010329560'
	and activeflag = '1';

update
	intakedastatus
set
	activeflag = 0,
	updatedby = 'CDM-26527',
	updatedon = now()
where
	intakenumber = 'I221010329560'
	and activeflag = '1'
	and intakedastatusid = 'ecf498d5-4e54-4d3d-b366-6b90d9d7b661';
