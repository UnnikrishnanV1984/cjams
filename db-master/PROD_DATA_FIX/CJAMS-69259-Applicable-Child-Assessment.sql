/* 
-- CJAMS-69259 - ACA needs to be Restored
-- CJAMS PID# : 200854325
Case Number : 221030013435
IV-E Specialist - tousha.moses@maryland.gov
IV-E Supervisor - crystal.aye@maryland.gov
-- Category/ Module: Adoption Applicabilty
-- Root cause: Id: 3964465 I received a request to complete ACA on my dashboard for this child. The ACA was already completed. 
-- Fix Provided: Datafix has been provided.
-- Pull request# N/A
*/



update adoptionapplicabilityinfo 
set ivestatus = 'APPROVED', updatedby = 'CJAMS-69259', updatedon = now()
where adoptionapplicabilityid = 'dfd08993-5078-4e04-bad1-3c151dbe5260' and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CJAMS-69259', updatedon = now()
where objectid = 'dfd08993-5078-4e04-bad1-3c151dbe5260' and activeflag = 1;