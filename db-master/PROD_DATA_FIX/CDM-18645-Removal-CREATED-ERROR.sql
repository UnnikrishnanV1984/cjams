/*
   Issue Description: CDM-18645
   Category/ Module  : Child removal
   Root cause: user asked to remove the duplicate intakechildremoval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
	set activeflag = 0,
		updatedby = 'CDM-18645', 
		updatedon = now() 
	where intakeservreqchildremovalid = '59803b21-290b-418a-813b-83e5b847c6b4';

	update routing 
	set activeflag = 0,
		updatedby = 'CDM-18645', 
		updatedon = now() 
	where objectid = '59803b21-290b-418a-813b-83e5b847c6b4';
