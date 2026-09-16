/*
   Issue Description: CDM-29457
   Category/ Module  : Changing the person, intakeservicerequestactor, actor, cjams.assessment  Status 
   Root cause: for the Case ID 221030014064, User added Naushad Sparkman to this case and it added him twice.
   Please remove the client ID # 201164786 from the person tab & SAFE-C assessment
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update
	intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CDM-29457',
	updatedon = now()
where
	personid in ('b0bf7595-2145-468f-8add-066fcdccb62c');

update
	actor
set
	activeflag = 0,
	updatedby = 'CDM-29457',
	updatedon = now()
where
	personid in ('b0bf7595-2145-468f-8add-066fcdccb62c');

update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{childdatagrid}', '[
    {
      "age": "17 Yrs",
      "clientid": "201164785",
      "childname": " Naushad D Sparkman "
    },
    {
      "age": "6 Yrs",
      "clientid": "200866547",
      "childname": " Samina  Sparkman "
    }
  ]') ,
	updatedby = 'CDM-29457' ,
	updatedon = now()
where
	assessmentid = '49870b30-c31d-4f64-9ad1-7e6ecea5b6c5';