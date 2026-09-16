/*
   Issue Description: CDM-37302
   Category/ Module  : Unable to close case because of review checklist not checked in late contact 
   Root cause: Review Checklist flag 'Required Reporting: Late or Incomplete Initial Contact' not selected though the legislative response has been recorded and approved
   Customer Email: shelley.brown@maryland.go
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select intakeserviceid  from intakeservicerequest where servicerequestnumber in('231021039786','231021265740','231021437057', '231021364204', '231021357334', '231021470009');


select islateinitialcontact ,* from legislative where intakeserviceid in(select intakeserviceid  from intakeservicerequest where servicerequestnumber in('231021039786','231021265740','231021437057', '231021364204', '231021357334', '231021470009'));

update legislative
	set islateinitialcontact = true,
		updatedby ='CDM-37302',
		updatedon =now() 
	where legislativeid in 
    ('b483d261-5ced-4533-a90e-a29991aabc4b',
    'b050e8b5-4cf0-4187-a7d0-8b00bfe22c32',
    '2b2ac8b5-b828-437e-afaf-a77064196775',
    '747fc20f-3f87-4af6-84fe-9f3f6b0023c3',
    '7ec52c65-7db8-4d9d-88b8-047412a9e569');