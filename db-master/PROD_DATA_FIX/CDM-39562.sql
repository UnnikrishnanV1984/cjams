/*
 * CDM-39562 - caseplan
 * Customer Email ID:kathleen.chaney@maryland.gov
 * Description - 3145789:I am trying to do a new caseplan but the information pulling from the permanency plan screen is old. 
 * The pp has been updated so I am not sure why that information is being pulled. 
 * Update the Permanency plan Established date from 04/24/2023 to '04/01/2024'. 
 * 
 */

--select fromdate, todate, * from snapshothist 
--where objectid::UUID = '9abee997-99ec-40fa-8b1b-9534f315958e' and activeflag = 1;
-- UPDATE cjams.snapshothist
-- SET fromdate='2023-04-24', todate='2024-04-01', updatedby='CDM-39562', updatedon=now() 
-- WHERE id='068315f1-405f-49a0-a2b3-a2a26e4b9fcd'::uuid;

--select establisheddate, enddate, * from permanencyplan where permanencyplanid='80507829-38c5-4610-9f99-ba35cadce5f7';
UPDATE cjams.permanencyplan
SET establisheddate='2024-04-01 00:00:00.000', enddate=NULL, updatedby='CDM-39562', updatedon=now() 
WHERE permanencyplanid='80507829-38c5-4610-9f99-ba35cadce5f7';

