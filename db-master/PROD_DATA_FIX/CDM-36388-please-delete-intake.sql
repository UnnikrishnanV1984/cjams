/*
 Issue Description: CDM-36388
 Category/ Module : Intake
 Root cause: I241011893447, It was entered in error as no person added into the case.
 Fix: Deleted the intake from intakedasstaging, intakedastatus, intakesnapshot, intakeservrequest, routing tables, no records are found in intakeservrequestactor table.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

select * from intakedastatus where intakenumber in ('I241011893447') and activeflag = 1;

update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-36388'
	where intakenumber in ('I241011893447') and activeflag = 1;

select * from intakedastaging where intakenumber in ('I241011893447') and activeflag = 1;

update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'CDM-36388'
	where intakenumber in ('I241011893447') and activeflag = 1;

select * from intakesnapshot where intakenumber in ('I241011893447');

update intakesnapshot set activeflag = 0, updatedon = now(), updatedby = 'CDM-36388'
	where intakenumber in ('I241011893447') and activeflag = 1;

select * from intakeservicerequest where intakenumber = 'I241011893447';

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-36388' 
where intakenumber = 'I241011893447' and activeflag = 1;

-- routingid::: 'd8e6303b-4247-4ba1-83c8-7bdb14028187'
select servicerequestnumber ,* from routing where objectid = 'I241011893447';
		
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-36388' where objectid  = 'I241011893447';
	
--No records found in below table
select * from intakeservicerequestactor where intakenumber ='I241011893447' and intakeserviceid = 'b4ffaf2c-e071-45be-ac51-e9bc2d3ad287';