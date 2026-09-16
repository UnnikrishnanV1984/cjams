/* 
-- CDM-37579 - ACA needs to be Restored
-- Issue Description: Deborah Calhoun-Dorsey Id: 3964465 I received a request to complete ACA on my dashboard for this child. The ACA was already completed. The foster care worker resubmitted ACA in error.
-- Client Id: 3964465
-- Case Number: 3253896
-- Category/ Module: Adoption Applicabilty
-- Root cause: Id: 3964465 I received a request to complete ACA on my dashboard for this child. The ACA was already completed. 
-- Fix Provided: Datafix has been provided.
-- Pull request# N/A
*/

select * from adoptionapplicabilityinfo where clientid = '3964465';

update adoptionapplicabilityinfo 
set ivestatus = 'APPROVED', updatedby = 'CDM-37579', updatedon = now()
where adoptionapplicabilityid = '9ae7fbac-f47b-42dd-96a2-9b1a6e9c6d64';

update routing 
set activeflag = 0, updatedby = 'CDM-37579', updatedon = now()
where objectid = '9ae7fbac-f47b-42dd-96a2-9b1a6e9c6d64' and activeflag = 1;