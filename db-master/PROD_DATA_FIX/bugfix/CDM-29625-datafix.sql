/*
-- Issue Description: 
	CDM-29625 : Incorrect Allegations
	QA/BA:  : Ms. Ross and Mr. Alston have not been accused of sexual abuse, the sexual abuse allegation needs to be removed for both parents.
	
-- Category/ Module: CPS Case (Case Management)
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	activeflag, * 
from 	investigationallegation 
where 	investigationallegationid in ('14e71f57-ec97-4f13-960a-45ef3b5b446c', '1a205e7a-970a-4cfe-9c86-91be4ad99fb1');

update 	investigationallegation 
set 	activeflag = 0,
		updatedby = 'CDM-29625',
		updatedon = now()
where 	investigationallegationid in ('14e71f57-ec97-4f13-960a-45ef3b5b446c', '1a205e7a-970a-4cfe-9c86-91be4ad99fb1')
		and activeflag = 1;


