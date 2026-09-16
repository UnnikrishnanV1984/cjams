/*
   Issue Description: CDM-43103
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select * from intakedastaging where intakenumber = 'I241013186405' and activeflag = 1;
select * from routing where objectid = 'I241013186405';
select * from intakedastatus where intakenumber = 'I241013186405' and activeflag = 1;
select * from intakesnapshot where intakenumber = 'I241013186405' and activeflag = 1;
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43103'
where intakenumber in('I241013186405','I241013187689') and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43103'
where intakenumber in('I241013186405','I241013187689') and activeflag = 1;