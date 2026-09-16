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


	update intakeservreqchildremoval
set exitdate ='2026-05-21 11:00:00',intakeserviceid='e329215a-4b73-4025-9989-7ac20d41a388', removalexitreason ='EMANIND', updatedon =now(), updatedby ='CJAMS-67884'
where intakeservreqchildremovalid = 'fc743b9b-c21d-4fb4-adcf-dc92c0809923' and activeflag = 1;

insert into intakeservreqchildremoval_history(           
intakeservreqchildremovalhistoryid,                      
rowtype,                                                 
intakeservreqchildremovalid,                             
intakeserviceid,                                         
activeflag,                                              
insertedby,                                              
insertedon,                                              
updatedby,                                               
updatedon,
exitdate, 
removalexitreason,                                              
intakeservicerequestactorid,                             
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  'fc743b9b-c21d-4fb4-adcf-dc92c0809923',
  'e329215a-4b73-4025-9989-7ac20d41a388',
  '1',
  'CJAMS-67884',
  now(),
  'CJAMS-67884',
  now(),
  '2026-05-21 11:00:00',
  'EMANIND',
  '926d0992-9682-43f0-8066-8aba9e183592',
  '83b7bd37-93e0-4839-8448-2bc99b04cc75',
  'b5b57efa-195c-4e88-960d-5e8f88927123',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-67884.","display_name": "Comments"}]}');


update cjams.tb_client_eligibility
set delete_sw  = 'Y',
	update_user_id = 'CJAMS-67884',
	update_ts = now()
where eligibility_id='10004034'
	and delete_sw = 'N' ;


	update personprogramarea
    set  entityid ='3119015', objectid='83b7bd37-93e0-4839-8448-2bc99b04cc75',updatedby = 'CJAMS-67884',
	updatedon = now()
	where personprogramid='68aa2631-051b-451d-af37-ca4213145f3c' and activeflag = 1;



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



