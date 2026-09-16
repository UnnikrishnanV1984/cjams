
/*
   Issue Description: CDM-23877
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to change end date removal and placement 
   Pull request# for code fix: 5940
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update placement set enddatetime = '2022-05-05 00:00:00', updatedby = 'CDM-23877', updatedon = now() where placementid = 'f9c212a7-b35a-4c8b-aa3d-44b498bd4ccb';

update livingarrangement set livingenddate = '2022-05-05 00:00:00', updatedby = 'CDM-23877', updatedon = now() where placementid = 'f9c212a7-b35a-4c8b-aa3d-44b498bd4ccb';


update intakeservreqchildremoval 
set exitdate = '2022-05-05 00:00:00', 
    updatedby = 'CDM-23877', 
    updatedon = now() 
where intakeservreqchildremovalid = '5bcc2c00-345c-4284-aea6-843132a7b17e';