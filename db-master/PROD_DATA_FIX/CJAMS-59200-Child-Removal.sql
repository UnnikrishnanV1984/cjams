/*
Issue Description: Dashboard:GreetingsPlease close out the folowing case. The alleged victim never came into care as the limited custody had been rescinded. CJAMS Case Number # 202787851 Cjams Case Name for Vicitm : Jaynia Teresa Johnson Screen
Category/Module: Child Removal 
Root cause: User entry error and draft  child removal needs to be deleted for the case 251030460713
Fix provided: Data fix has been done to delete the draft  child removal record that is in review
Data/Code fix ticket#: CJAMS-59200
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update intakeservreqchildremoval
set activeflag = 0,
    updatedby = 'CJAMS-59200',
    updatedon = now()
where intakeservreqchildremovalid = '33be6f23-4831-41b6-b144-fa025a28b038'
and activeflag = 1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedby = 'CJAMS-59200',
    updatedon = now()
where intakeservreqchildremovalhistoryid in ('794d7f49-a008-4c19-9219-a583371bcd4a','aab409d8-e1db-4bd1-9649-c516d8067ae9')
and activeflag = 1;

  