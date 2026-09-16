-- CDM-36145- Correction to Start Date needed
/* Issue Description:User not able to submit break the link as there is correction in start date for #3150396

-- Adoptionplanningid: f6313b34-f1c4-4829-b872-06377e68d414
-- AdoptionAgreementID: a71d494f-290d-4f42-82b0-8cd398d81be1, b06c64bb-3bfb-414c-9b4a-04f8d6a82f2e, efdf174e-01c6-46c4-8bff-b5a3f9aedea3, 58d47c76-4e42-47d1-bd0e-207d40a17ba1

-- Category/ Module: Permanency Plan(Break the link)

-- Root cause:User not able to submit break the link as there is correction in start date for #3150396
-- Fix Provided: Datafix has been provided to remove duplicate adoptionagreements
-- Pull request# N/A

*/

select activeflag,* from adoptionagreement where adoptionplanningid='f6313b34-f1c4-4829-b872-06377e68d414';

select activeflag,* from adoptionagreement where adoptionagreementid in ('a71d494f-290d-4f42-82b0-8cd398d81be1','b06c64bb-3bfb-414c-9b4a-04f8d6a82f2e','efdf174e-01c6-46c4-8bff-b5a3f9aedea3','58d47c76-4e42-47d1-bd0e-207d40a17ba1');

update adoptionagreement
set activeflag=0,
updatedon = now(), 	
updatedby = 'CDM-36145'
where adoptionagreementid in ('a71d494f-290d-4f42-82b0-8cd398d81be1','b06c64bb-3bfb-414c-9b4a-04f8d6a82f2e','efdf174e-01c6-46c4-8bff-b5a3f9aedea3','58d47c76-4e42-47d1-bd0e-207d40a17ba1');

select activeflag,* from routing where objectid in ('a71d494f-290d-4f42-82b0-8cd398d81be1','b06c64bb-3bfb-414c-9b4a-04f8d6a82f2e','efdf174e-01c6-46c4-8bff-b5a3f9aedea3','58d47c76-4e42-47d1-bd0e-207d40a17ba1') 
and eventcode='ASAR' and activeflag=1;

update routing
set activeflag=0,
updatedon = now(), 	
updatedby = 'CDM-36145'
where objectid in ('a71d494f-290d-4f42-82b0-8cd398d81be1','b06c64bb-3bfb-414c-9b4a-04f8d6a82f2e','efdf174e-01c6-46c4-8bff-b5a3f9aedea3','58d47c76-4e42-47d1-bd0e-207d40a17ba1')
and eventcode='ASAR' and activeflag=1;
