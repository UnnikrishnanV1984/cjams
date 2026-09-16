/*
   Issue Description: CDM-30452
   Category/ Module  : Subsidary Agreement date 
   Root cause: user wants to change the date for payments 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioncaserevision
set activeflag='0',
	updatedon = now(), 
	updatedby = 'CDM-30452'
where adoptionagreementid = 'a3ae3a02-4405-43dc-8f7e-6f3919dbe498'
	and adoptionagreementrateid = '104e6fc6-58aa-4ba8-b24c-44ce2aa0d11f';