 /*
  Issue Description: CDM-16524
   Category/ Module  :  Child Removal
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


 update intakeservreqchildremoval set activeflag = 0, updatedon = now(), updatedby = 'CDM-16524' where intakeservreqchildremovalid = 'd1647685-b690-428d-890c-4c02d1289bb8';

 update personprogramarea set activeflag = 0, updatedby = 'CDM-16524', updatedon = now() where personprogramid = '11552008-bb35-48cf-b7b0-4a3c079d1ded';
