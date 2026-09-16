/* 
   Issue Description: CDM-40359 Guardian ID Missing/ Relationship Missing
   Category/ Module  : Title IVE GAP
   Root cause: The GAP case is not linked with case number due as it is chessie data and it has not been mapped correctly in services actors table.
               User requested to update the relationship as Foster Parent in IV-E screen as well as Service Case GAP screen
   Fix Provided : Data fix has been provided to servicecaseid in actors table and also relationship of primary guardian.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update permanencyplan
set intakeservicerequestactorid = '926bad4f-ae4d-4c1d-9b8e-606b731ab5a9',
    updatedby = 'CDM-40435',
    updatedon = now()
where intakeservicerequestactorid ='6874fab2-4e8a-4167-a40b-4b6937945e0e'
  and servicecaseid = '56705f30-8493-4c5b-8a88-9b45fd891ced'
  and permanencyplanid = '78d8a2d2-9f07-4fa0-a567-0265682d2df7';                                    

update guardianship 
set primaryrelationshipkey = 'FOSPARNT', updatedby = 'CDM-40435', updatedon =  now()
where gapid = '2da96cfc-d4d4-4e51-ba67-7817d598d197';
