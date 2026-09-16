
/*
   Issue Description: CDM-18609
   Category/ Module  : Removing the duplicated Removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-18609', updatedon = now() where intakeservreqchildremovalid = '59803b21-290b-418a-813b-83e5b847c6b4';
update personprogramarea set activeflag = 0, updatedby = 'CDM-18609', updatedon = now() where personprogramid = '11e4ed07-0af3-4401-846c-b0287eed146e';