/*
   Issue Description: CDM-34119
   Category/ Module  : Prod data fix to remove the pending assignment
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--2023-08-17 04:00:00.000
update gapagreementrate set startdate = '2023-08-24 12:00:00.000', updatedon = now(), updatedby = 'CDM-34655' where gapagreementrateid = '84ea8ea0-a93a-41a4-9355-adf0b51a6788';
update gapratesrevision set ratestartdate = '2023-08-24 12:00:00.000',approvaldate =  now() , updatedon = now(), updatedby = 'CDM-34655' where gaprateid = '84ea8ea0-a93a-41a4-9355-adf0b51a6788' and activeflag = 1;
