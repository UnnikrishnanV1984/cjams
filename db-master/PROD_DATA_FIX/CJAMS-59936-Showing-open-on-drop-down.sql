/*
   Issue Description: CJAMS-59936
   Category/ Module  :  case assignment
   Root cause: The case assignment records remains active despite of records on the intakeservicerequest was deactive/close for the particular user.
    Which resulting in showing those cases assigned number for the user on the dropdown in this assigning screen.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*select updatedby,updatedon,activeflag,actiontype,intakenumber,servicecaseid,* from intakeservicerequest where intakeserviceid in (
select objectid 
	FROM	caseassignment  
	WHERE 	toworkeridno = 'c078eed8-fab6-490d-b099-47f9b968a5dc'
		and activeflag  = 1 
		and enddate is null
)*/

update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-59936',
	updatedon = now()
where objectid in (
'85f8652e-4e9a-4795-b3da-a8bc491b8766',
'5fb84f03-1dd1-4a92-8b77-72b97abf0d18',
'308ac810-dec8-48fd-9c7c-a6355167530f',
'ba5967d4-f85c-40a2-a967-5419c54c0e75',
'e51d2335-0d87-4cdb-a969-0176829f72af',
'884fbd07-0d69-43bd-a925-a9c50ba20a58',
'f3362e70-baff-4727-a8be-5f6afa8d5102',
'66b6e73e-97a0-4153-b288-3e5217b8bd5d',
'186f2d15-5e0c-44ae-95e6-c83483bf9459',
'c9ddfb87-01ee-485e-a655-ff2ffa3513ea',
'44496c7a-17c3-4cb3-87ea-bb8f20674a59',
'cb9e947a-bcb1-416e-aabf-20cd242bfe19'
)
and activeflag = 1;
	