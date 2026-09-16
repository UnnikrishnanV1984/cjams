/*
  Issue Description:  CDM-42317
   Category/ Module  :  Approval
   Root cause: User request to  do a data fix to remove the two latest 
   subsidy rate slab and update the subsidy rate end date from 12/13/2024 to 08/31/2024.
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

--End date from 12/13/2024 to 08/31/2024.

   update
    adoptioncaseagreementrate
set
    enddate  = '2024-08-31 00:00:00',
    updatedon = now(), 	
	updatedby = 'CDM-42317'
where
adoptionagreementid = '70d1b223-d178-4696-af98-091558948e26' 
and adoptionagreementrateid = 'b337f768-0c3b-473b-a76c-b0a8c39140be'
and activeflag = 1;

update adoptioncaserevision
set enddate  = '2024-08-31 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-42317'
where adoptionagreementrateid = 'b337f768-0c3b-473b-a76c-b0a8c39140be' and activeflag = 1;

--Removing the two latest subsidy rate

   update
    adoptioncaseagreementrate
set
    activeflag = 0,
    updatedon = now(), 	
	updatedby = 'CDM-42317'
where
adoptionagreementid = '70d1b223-d178-4696-af98-091558948e26'
and adoptionagreementrateid = 'e80622e5-bc2b-4095-b2aa-f230a0c7d5d5'
and activeflag = 1;

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-42317'
where adoptionagreementrateid = 'e80622e5-bc2b-4095-b2aa-f230a0c7d5d5' and activeflag = 1;

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-42317'
where adoptionagreementrateid = 'aef8bce2-44dd-481d-b987-1011b65df5d8' and activeflag = 1;
