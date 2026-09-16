/*
   Issue Description: CDM-25359
   Category/ Module  : User requested to change the end date on the adoption subsidy for case 221040018667 from 9/27/22 to 8/2/2023
   Root cause: User requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 	enddate, *  
from 	adoptioncaserevision
where 	adoptionagreementid = 'ef2e3086-b1ad-4e10-aa55-60b709d2d59c'
		and adoptionrevisionid = '749574de-cd80-480e-9bbc-e62eed37adbc'
		and activeflag = 1;
	
							
update 	adoptioncaserevision
set 	enddate = '2023-08-02',
		updatedby = 'CDM-25359',
		updatedon = now()
where 	adoptionagreementid = 'ef2e3086-b1ad-4e10-aa55-60b709d2d59c'
		and adoptionrevisionid = '749574de-cd80-480e-9bbc-e62eed37adbc'
		and activeflag = 1;