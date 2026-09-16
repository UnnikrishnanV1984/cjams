/*
   Issue Description: CDM-22720
   Category/ Module  : Removing person program area
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22314', updatedon = now() 
where intakeservreqchildremovalid = 'a2958428-5a4e-4e0f-a0bf-33bc95943fe5';

update placement set activeflag = 0, updatedby = 'CDM-22314', updatedon = now()
where placementid = '37f3d1fe-34db-49a7-99e4-1b620f4f32a6';

update placementrevision set activeflag = 0, updatedby = 'CDM-22314', updatedon = now()
where placementid = '37f3d1fe-34db-49a7-99e4-1b620f4f32a6';

update servicecase set activeflag = 0, updatedby = 'CDM-22314', updatedon = now() 
where servicecaseid ='4920d2c6-60ed-4e16-b3a5-79d86806bf3e';

update intakeservicerequest set servicerequestnumber = '3049954',
intakeservreqinputtypeid = 'd1d7780d-a31a-4c23-826e-0495a64694bc', intakeservreqtypeid = 'd207bdd4-f281-4ec8-949c-8fd9657227f9',
intakeservreqpurposeid = 'd207bdd4-f281-4ec8-949c-8fd9657227f9',
updatedby = 'CDM-22314', updatedon = now() where intakeserviceid = '357743c1-3964-4c17-8d48-f3514fa2d8d0';

select * from cjams.createservicecase('357743c1-3964-4c17-8d48-f3514fa2d8d0' ,'952aa2e0-ddd1-4da0-a3e7-d3f13c6dc3de', 0,'ef3032b3-2f5a-4b48-8b27-c33cf654abf6');

