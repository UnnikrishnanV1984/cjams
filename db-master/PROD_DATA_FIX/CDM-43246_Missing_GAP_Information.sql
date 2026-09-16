
/*
   Issue Description: CDM-43246
   Category/ Module  :  Title IV-E
   Root cause: The GAP details for this child is not updated under the permanency plan tab.
   Pull request# for code fix: 
   Reason why no related code fix: user error.
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval
set intakeservicerequestactorid = '006ad949-d469-4a7c-8b77-408ad405f9bb', -- 582f969d-98d7-4501-b2f7-483e6357ed54
	updatedby = 'CDM-43246',
	updatedon = now()
where servicecaseid = '299972ac-a206-4161-9092-2353f262fa01'
and intakeservreqchildremovalid = 'bb645179-1756-4654-aa13-bce76824c438'
and activeflag = 1;
