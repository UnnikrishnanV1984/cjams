/*
-- Issue Description: 3176165:Subsidy rate begin date should be 6/26/2024. The deceased provider number 5014669 is incorrect. 
                      Thus, the new provider will not receive payment for the begin date of 6/26/23 until the correction is made. 
-- Root cause: Change requested by user.
-- Fix Provided: Updated theadoptioncaseagreementrate table start date and end date as requested by user.
*/


update adoptioncaseagreementrate
set startdate = '2023-06-26', enddate = '2024-06-25', updatedon = now(), updatedby = 'CDM-38787'
where adoptionagreementrateid = 'af90dda2-5604-4bc5-a1cf-3a35427ca3a9';


update adoptioncaseagreementrate
set enddate = '2023-06-25', updatedon = now(), updatedby = 'CDM-38787'
where adoptionagreementrateid = '74782c36-986d-4204-b574-64d9988ad60d';