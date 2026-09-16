/*
   Issue Description: CJAMS-59283
   Category/ Module  : Child Account Disbursement
   Root cause: User role setup data issue, user’s primary role is finance supervisor which was incorrectly updated to secondary role case supervisor as a part of CIDM-9944.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update teammember
set roletypekey = 'FNSFS', updatedby = 'CJAMS-59283', updatedon = now()
where teammemberid = 'a0000ccd-2c65-4551-9934-0c00bcb3633f' and activeflag = 1;

update routing 
set tosecurityusersid = 'e4271184-e42a-4639-88a5-4168eb1814f7',--Patricia to Crystal.
	updatedby = '',
	updatedon = now()
where routingid = 'ff848f1e-b2c4-4773-bd01-8eb054597b13'
	and objectid ='1043543' and activeflag =1;