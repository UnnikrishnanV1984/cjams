/*
   Issue Description: CDM-38736
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: Unable to Break the link as the system is showing an Alert message as 'there is no Subsidy rate added' but the Subsidy rate is already added.
               Need to check if there is any duplicate agreement in the DB and provide the data fix.
   Fix Provided: Promoted a data fix to delete the pending duplicate agreement from the DB.            

*/


update adoptionagreement 
set activeflag = 0, updatedby = 'CDM-38736', updatedon = now()
where adoptionagreementid in ('0154c428-04ba-49df-bc57-6fa5cc3e828b') and activeflag = 1;