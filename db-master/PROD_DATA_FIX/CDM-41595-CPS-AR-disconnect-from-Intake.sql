/*
Issue Description:241022916508: 241022916508 case was inappropriately created. The referral was recommended screen out therefore nothing on the sdm was clicked however the case still populated. I am unable to override the intake to edit.
Root cause: user could not able to disconnect the CPS-AR from the intake  ,they can only create.
Fix provided: DB queries  update enddate intakeservicerequest tables
Data/Code fix ticket#: CDM-41595
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservicerequest
set actiontype = null ,activeflag=0, updatedby = 'CDM-41595', updatedon = now()
where intakeserviceid = '1571ee32-c5fa-4414-9320-8686aae55071' and activeflag =1;


update intakeservicerequestactor
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where intakeservicerequestactorid in ('6e590a76-c78c-4625-90c0-6de595652166','7cf64075-d5fe-4252-8338-32218ea17a8e','614d7454-ffc3-418e-8c0b-3bcac3d4272c') and activeflag=1;


update actor
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where actorid in ('73a8dcc3-0cf0-41d2-8fa3-a59860cf2b00') and activeflag=1;


update personrole
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where personroleid in ('0aa73f61-99cb-44b1-b858-02ddafd88a36') and activeflag=1;



update personroletype
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where personroletypeid in ('55f38fdc-ed1c-4fdb-aa26-aaf59ba44d84','c07324be-0873-4424-a326-8be98512c83c','df1fff14-a5aa-44d1-b66d-2b78c6c75011') and activeflag=1;


update intakeservicerequestdispositioncode
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where intakeservicerequestdispositioncodeid in ('44a0e266-d3b4-4d9f-9b6d-6316693f6ee4') and activeflag=1;


update caseassignment
set activeflag = 0 , updatedby = 'CDM-41595', updatedon = now()
where caseassignmentid ='787d28bd-9c50-4c30-905d-16da35fb68de' and activeflag=1;


update intakedastaging
set updatedby = '7037411b-2b8a-4297-9a47-e2c2add5e857', status = 'pending', ispreintake = false
where intakenumber = 'I241013135855' and activeflag = 1;

update intakedastatus
set status = 1, updatedby = '7037411b-2b8a-4297-9a47-e2c2add5e857'
where intakenumber = 'I241013135855' and activeflag = 1;

update routing
set routingstatustypeid = 1, updatedby = '7037411b-2b8a-4297-9a47-e2c2add5e857'
where routingid = 'ff6b9dde-c6da-4109-97fe-3e5841bc3d91';