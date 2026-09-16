/*
   Issue Description: CDM-41478
   Category/ Module  : Create Service case for Intake #I241012971760.
   Root cause: User requested to create a service case linked to existing intake request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select activeflag,sstastatustypekey,* from intakedastaging where intakenumber = 'I241012971760' and activeflag = 1;
select servicecaseid,servicerequestnumber,actiontype,intakeserreqstatustypeid,* from intakeservicerequest where intakenumber= 'I241012971760' --moment it is apporved by supervisor either screen in or out the intakenumber will come into this table
*/

--241022844587 servicerequestnumber
--b47b7ab6-e133-4b4c-8342-c7d14c7dfde9: intakeserviceid
-- userID: cdd629c8-d393-4388-88ee-fa654b2aed85
-- servicecaseid: 4f58ac4a-3376-49bc-bd04-530ac1fdca07

select * from cjams.createservicecase('b47b7ab6-e133-4b4c-8342-c7d14c7dfde9', null, 1, 'cdd629c8-d393-4388-88ee-fa654b2aed85', 'intake', '');
