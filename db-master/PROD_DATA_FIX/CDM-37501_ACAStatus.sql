-- CDM-37501 - ACA Review Status
/* Issue Description: ACA previously completed and approved. CJAMS is showing the ACA in "Review Status". Adoption has already been finalized fro #3287452

-- case number: 3287452
-- client id: 4226655, 4044817, 4486176

-- Category/ Module: Permanency Plan 

-- Root cause: ACA previously completed and approved. CJAMS is showing the ACA in "Review Status". Adoption has already been finalized fro #3287452 
-- Fix Provided: Datafix has been provided to update ivestatus for case #3287452
-- Pull request# N/A

*/

select ivestatus,activeflag,* from adoptionapplicabilityinfo where clientid='4226655' and removalid='192533';

update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CDM-37501', updatedon= now()
where adoptionapplicabilityid = 'c7a6add5-d2fa-4b70-8988-7311398c53b9';

select ivestatus,activeflag,* from adoptionapplicabilityinfo where clientid='4044817' and removalid='192537';

update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CDM-37501', updatedon= now()
where adoptionapplicabilityid = 'd6e3271d-f1b6-4d9a-bf21-0c0eee1a32dd';

select ivestatus,activeflag,* from adoptionapplicabilityinfo where clientid='4486176' and removalid='199633';

update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CDM-37501', updatedon= now()
where adoptionapplicabilityid = '5b588521-b391-4f99-9ea6-9b542d1666e2';
