/*
   Issue Description: CDM-28411
   Category/ Module  : Intake Error
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010283935' and activeflag = 1;
update intakesnapshot set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010283935' and activeflag = 1;
update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010283935' and activeflag = 1;

update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010343806' and activeflag = 1;
update intakesnapshot set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010343806' and activeflag = 1;
update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-28411' where intakenumber = 'I221010343806' and activeflag = 1;
