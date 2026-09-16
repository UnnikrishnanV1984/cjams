/*
   Issue Description: CDM-29734
   Category/ Module  :Unable to edit agreement
   Root cause: :Subsidy rate period is  not in between the agreement date
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update gapagreementrate set activeflag =0, updatedby='CDM-29734', updatedon = NOW() where gapagreementrateid ='fdd153d4-4291-48ed-a1b9-e87f36ff1383';
update gapratesrevision set 	activeflag =0, updatedby = 'CDM-29734', updatedon = now() where gaprateid ='fdd153d4-4291-48ed-a1b9-e87f36ff1383';
update routing set 	activeflag =0, updatedby = 'CDM-29734', updatedon = now() where objectid ='fdd153d4-4291-48ed-a1b9-e87f36ff1383';
