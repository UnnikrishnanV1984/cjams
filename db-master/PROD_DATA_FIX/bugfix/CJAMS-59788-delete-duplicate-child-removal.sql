/*
Issue Description: 3259325:Child removal that is under review is a duplicate and needs to be deleted. Unable to be deleted as caseworker or supervisor
Category/Module: Child Removal 
Root cause: User entry error and duplicate child removal needs to be deleted for the case 3259325
Fix provided: Data fix has been done to delete the duplicate child removal record that is in review
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update intakeservreqchildremoval
set activeflag = 0,
    updatedby = 'CJAMS-59788',
    updatedon = now()
where intakeservreqchildremovalid = '3d133ead-fdba-4e1f-9e53-292d3afa4b00'
and activeflag = 1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedby = 'CJAMS-59788',
    updatedon = now()
where intakeservreqchildremovalid = '3d133ead-fdba-4e1f-9e53-292d3afa4b00'
and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-59788',
    updatedon = now()
where objectid = '3d133ead-fdba-4e1f-9e53-292d3afa4b00'
and activeflag=1;    