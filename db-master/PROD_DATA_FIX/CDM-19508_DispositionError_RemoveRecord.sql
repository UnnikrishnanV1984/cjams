/*
   Issue Description: CDM-19508
   Category/ Module  : disposition record removed
   Root cause: user wants to remove record 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update investigationallegation set activeflag = 0, updatedon = now(),updatedby = 'CDM-19508' where investigationallegationid = '737ba88f-efdc-4482-94aa-d2a35e20998a';
update Investigationmaltreatment set activeflag = 0, updatedon = now(),updatedby = 'CDM-19508' where maltreatmentid = '3ec95fcb-5e0d-4437-809d-4f7af4023d99';
update Investigationmaltreatmentactor set activeflag = 0, updatedon = now(),updatedby = 'CDM-19508' where maltreatmentid  = '3ec95fcb-5e0d-4437-809d-4f7af4023d99';
