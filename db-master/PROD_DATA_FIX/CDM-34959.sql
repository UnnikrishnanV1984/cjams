/*
 * CDM-34959 - Delete Program Assignment
 * Customer Email ID:stacie.parker@maryland.gov
 * Customer Name:Stacie Parker
 * Focus Area:Persons: Household
 * Description - 2020016401472:Program assignment "In-Home Services/Family Preservation, Services to Families with Children - Intake" from 10/2/23 to 10/20/23 entered in error. 
 * This program assignment should be deleted. Correct program assignment (Auxiliary Services - ROA 10/2/23 to 10/20/23) was entered and should remain.
 * 
*/

select activeflag, * from personprogramarea where personprogramid = '8cd277ad-03ec-4c5a-b254-797ad3787ebc';
UPDATE cjams.personprogramarea
SET activeflag=0, updatedby = 'CDM-34959', updatedon = now() 
where personprogramid='8cd277ad-03ec-4c5a-b254-797ad3787ebc'::uuid;
