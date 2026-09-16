/* 
    Issue Description: CDM-20205
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to delete duplicate case in removal history. 
   Pull request# for code fix: 6496
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-25597', updatedon = now()
where intakeservreqchildremovalid = '0b1a2fb1-c850-4300-84bd-502598c08a76';