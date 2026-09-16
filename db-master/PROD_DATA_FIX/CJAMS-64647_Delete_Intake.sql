/*
Issue Description:CJAMS-64647 Delete intake
Category/Module: Intake Dashboard
Root cause: This is not a defect. Intake # I251013516539 was transferred from Baltimore County to Baltimore City on 12/04/2025, and Baltimore City worker created a new Intake # I251013518382 for the same client on 12/04/2025.
			User is requested to remove the Intake # I251013516539 and please add this ticket to the SSA/Product Owner approval sheet for review and approval.
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-64647',
    updatedon = now()
where intakenumber='I251013516539'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-64647',
    updatedon = now()
where intakenumber='I251013516539'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-64647',
    updatedon = now()
where objectid = 'I251013516539'
and activeflag = 1;


update intaketransfers 
set activeflag =0,
    updatedby = 'CJAMS-64647',
    updatedon = now()
where intakenumber = 'I251013516539'
and activeflag = 1;
