/*
   Issue Description: CDM-37398
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: Unable to Break the link as the system is showing an Alert message as 'there is no Subsidy rate added' but the Subsidy rate is already added.
               Need to check if there is any duplicate agreement in the DB and provide the data fix.
   Fix Provided: Promoted a data fix to delete the pending duplicate agreement from the DB and remove it from approval Dashboard.            

*/


	update adoptionagreement 
   set activeflag = 0, 
       updatedby = 'CDM-37398', 
       updatedon = now()
	where adoptionagreementid in ('eb32bbb2-6a85-4544-b804-1f2b86e9dae5','bd622cc7-e1a5-41cd-bc6a-9d5c9f238ccb','fca80f49-9623-431a-bf20-d031c2106b79') and activeflag = 1;


  update routing
  set activeflag = 0, 	
	updatedby = 'CDM-37398',
	updatedon = now()
  where objectid in ('bd622cc7-e1a5-41cd-bc6a-9d5c9f238ccb','eb32bbb2-6a85-4544-b804-1f2b86e9dae5','fca80f49-9623-431a-bf20-d031c2106b79')
	and eventcode = 'ASAR'
	and activeflag = 1 ;


   update routing 
   set activeflag = 0, 
       updatedby = 'CDM-37398', 
       updatedon = now()
   where routingid='1837de64-ae10-478a-9a60-00036f0a5c39' and activeflag=1;