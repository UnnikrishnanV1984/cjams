/*
   Issue Description: CDM-20507
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4856
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval i set exitdate = '2021-12-17 00:00:00', updatedby = 'CDM-20507',updatedon = now() 
	where intakeservreqchildremovalid = '873e7975-84d4-4e91-b884-c3ca53c6968b';

	update placement set enddatetime = '2021-12-17 00:00:00', updatedby = 'CDM-20507',updatedon = now()
	where placementid = 'f5b8694f-f031-486c-8607-a18670e0e9c7';

	update livingarrangement set livingenddate = '2021-12-17 00:00:00', updatedby = 'CDM-20507',updatedon = now()
	where placementid = 'f5b8694f-f031-486c-8607-a18670e0e9c7';