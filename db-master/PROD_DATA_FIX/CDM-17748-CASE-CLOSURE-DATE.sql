/*
   Issue Description: CDM-17448
   Category/ Module  :  user asked to update case closure date
   Root cause: User asked to update 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing r set insertedon = '2021-08-30 10:00:00', updatedon = now(), updatedby = 'CDM-17748'
	WHERE r.routingid = 'f1c3dfc9-ff89-477f-9511-6ee99e5c103f';
				
	update intakeservicerequestdispositioncode 
	set statusdate = '2021-08-30 10:00:00', updatedby = 'CDM-17748', updatedon = now()
	where intakeservicerequestdispositioncodeid = 'd308acf2-b765-4297-8196-a8b056f15970';

	update caseassignment set enddate = '2021-08-30 10:00:00', updatedby = 'CDM-17748',updatedon = now() 
	where caseassignmentid in ('419122f2-f14b-4cf3-8ab3-2390e9b4c8d3', '6591a2f0-9c28-4166-89d3-98271cb6d01b', '34c769df-dccb-41c9-a778-764343c9f51d');
