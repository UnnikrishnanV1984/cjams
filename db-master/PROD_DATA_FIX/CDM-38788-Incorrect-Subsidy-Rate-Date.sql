/*
Issue Description: 3225455:Subsidy Rate needs to be updated to the New Provider,
 Andrew Masters #6122920. The new provider will not receive subsidy payments for
  the child in his care until the provider number has been changed
 Category/ Module  : Permanency plan( adoption approval Subsidy rate )
Root cause:Data fix to upadted the dates.
Fix provided :yes,write db query
Code fix ticket#:CDM-38788
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Update the subsidy rate end date from 05/31/2024 to 03/10/2024
update adoptioncaseagreementrate 
set
    enddate  = '2024-03-10',
	updatedby = 'CDM-38788',
	updatedon = now()
    WHERE adoptionagreementrateid = '73e096ed-772f-496c-8684-b30a97e5256a'
    and adoptionagreementid = 'c623ca1f-29c4-44cd-9277-56f112ca45de' and activeflag = 1 ;

-- remove record *FIXED*
update
 adoptioncaseagreementrate
set
    activeflag = 0,
    updatedby = 'CDM-38788',
    updatedon = now()
    WHERE adoptionagreementrateid = 'e07772cd-a11b-4e50-89c0-d544bccff582'
    and adoptionagreementid = 'c623ca1f-29c4-44cd-9277-56f112ca45de' and activeflag = 1;
   
--deactivating adoptioncaserevision and routing

update adoptioncaserevision
set
	activeflag = 0,
	updatedby = 'CDM-38788',
	updatedon = now()
	where adoptionagreementrateid = 'e07772cd-a11b-4e50-89c0-d544bccff582' and activeflag = 1;
	
update routing
set
	activeflag = 0,
	updatedby = 'CDM-38788',
	updatedon = now()
	where objectid = 'e07772cd-a11b-4e50-89c0-d544bccff582' and activeflag = 1;