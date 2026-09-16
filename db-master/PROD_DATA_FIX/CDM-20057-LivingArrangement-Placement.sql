/*
   Issue Description: CDM-20057
   Category/ Module  : Placement removal
   Root cause: user wants living arraangement removal and placement 
   Pull request# for code fix: 4781
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update placement set activeflag = 0, updatedby = 'CDM-20057', updatedon = now()
where placementid = 'ce1beaf7-9bd7-4de8-92d2-25a7f81a2c54';

update livingarrangement set activeflag = 0, updatedby = 'CDM-20057', updatedon = now()
where placementid = 'ce1beaf7-9bd7-4de8-92d2-25a7f81a2c54';
