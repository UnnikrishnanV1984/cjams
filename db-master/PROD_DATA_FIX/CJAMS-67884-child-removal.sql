/*
  
  
   Issue Description: CJAMS-67884-Datafix
   Category/ Module  : Delete person
   Root cause:We have received following ticket, 1664414 client it appears we had an issue with duplicate removal entries in cjams application db.
Two removals were added for this client one is on 12-17-2021 and another removal added on 2026-05-15 13:54:57, Eventhough same removal date 2021-12-16 00:00:00
IVE eligibility records also added new removal IVE Eligibility is pending old one Eligible Reimbursable.
Looks like we have to clean up IVE eligible record aswell.
Vineet/Feby,
Please look into this data issue.
   Pull request# for code fix:
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CJAMS-67884',
	updatedon = now()
where intakeservreqchildremovalid = '3ea0ae79-7ace-4478-a8a7-881048818098'
	and activeflag = 1 ;
	


update cjams.tb_client_eligibility
set delete_sw  = 'Y',
	update_user_id = 'CJAMS-67884',
	update_ts = now()
where eligibility_id='10004034'
	and delete_sw = 'N' ;



update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CJAMS-67884',
	updatedon = now()
where intakeservreqchildremovalid = '3ea0ae79-7ace-4478-a8a7-881048818098'
and activeflag = 1 ;


update cjams.routing
set activeflag = 0,
	updatedby = 'CJAMS-67884',
	updatedon = now()
where objectid = '3ea0ae79-7ace-4478-a8a7-881048818098'
and activeflag = 1 ;


--Deactivating in placement
update placement
set intakeservreqchildremovalid='fc743b9b-c21d-4fb4-adcf-dc92c0809923', updatedby = 'CJAMS-67884', updatedon = now()
WHERE intakeservreqchildremovalid = '3ea0ae79-7ace-4478-a8a7-881048818098'
 and activeflag = 1;



