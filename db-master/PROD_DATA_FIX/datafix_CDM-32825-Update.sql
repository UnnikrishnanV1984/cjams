/*
 * CDM-32825 - Removal
 * Description - 3112284:MAKAYLA PID 3507315 has a removal open for 4/19/2023. This removal was started in error and we need it deleted. 
 * This child left care on 4/19/2023. 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/ac9a26dd-9590-4ce6-92e9-b2e50f31a807/3112284/dsds-action/child-removal/details
 * Data fix is done to remove the Draft removal using the ticket CDM-32773.
 * We need to provide a Data fix to update the OOH Program Assignment End date according to the Child removal end date 04/19/2023 using this ticket.
 * startdate='2022-12-20 00:00:00.000'
 * Customer Email ID:wanda.nolt@maryland.gov
 */

select * from getpersonprogramarea('ac9a26dd-9590-4ce6-92e9-b2e50f31a807','1ae47da1-2647-4e26-abd6-9d7ee2ad1fef');

UPDATE cjams.personprogramarea
SET startdate='2022-12-20 00:00:00.000', enddate='2023-04-19 00:00:00.000', updatedby='CDM-32825', updatedon=now() 
WHERE personprogramid='a1484335-8754-4d7c-995e-e53d8101c595' and 
personid='1ae47da1-2647-4e26-abd6-9d7ee2ad1fef' and 
objectid='ac9a26dd-9590-4ce6-92e9-b2e50f31a807';