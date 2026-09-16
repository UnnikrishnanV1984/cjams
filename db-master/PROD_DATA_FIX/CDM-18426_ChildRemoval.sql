/* Issue Description:CDM-18426 Removal in wrong case
   Category/ Module  : Case Child Removal
   Root cause: Multiple cases for child, and entered in wrong case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update cjams.personprogramarea
set activeflag = 0, updatedby = 'CDM-18426', updatedon = now() 
where programkey = 'OOH' and personid = '7694797f-5dde-4afb-831c-eefd65d84578' 
and objectid = 'cda95e07-f6ea-4b54-b592-1add59399fee';

update cjams.routing
set activeflag = 0, updatedby = 'CDM-18426', updatedon = now() 
where objectid = '718ee97e-943c-4e87-a0b3-4cadf11e0cfd' 
and servicerequestnumber = '211030010929' and eventcode ='CHRR';

update cjams.tb_client_eligibility
set delete_sw = 'Y', end_dt = now(), update_user_id = 'CDM-18426', update_ts = now() 
where removal_id = '252800' and client_id = '200806863' and case_id = '211030010929'; 

update cjams.intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-18426', updatedon = now()
where  servicecaseid in ('cda95e07-f6ea-4b54-b592-1add59399fee') and 
intakeservreqchildremovalid ='718ee97e-943c-4e87-a0b3-4cadf11e0cfd' and removalid = '252800';