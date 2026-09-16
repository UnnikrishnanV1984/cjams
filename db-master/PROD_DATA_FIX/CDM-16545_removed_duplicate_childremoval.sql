/*
   Issue Description: CDM-16545
   Category/ Module  :  
   Root cause: Removing incorrect child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update intakeservreqchildremoval 
set updatedby = 'CDM-16545', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '8dfb1002-7674-4512-a9a0-51b18c3378e9';