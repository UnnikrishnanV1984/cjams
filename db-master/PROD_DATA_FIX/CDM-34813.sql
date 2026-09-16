/*
 * CDM-34813 - CPA Entry Date Datafix Needed
 * Customer Email ID:frank.mcgough1@maryland.gov
 * Customer Name:Frank McGough
 * Focus Area:Placement
 * Description - 3175144:Worker entered the CPA entry date and time incorrectly, and this needs to be changed with a datafix. 
 * CPA entry date and time should be changed to match the placement start date and time. See attachment. 
 * This is to correct an error in advance of our AFCARS 2023A resubmission.
 * Please update the CPA Home start date from 01/20/2023 to 12/20/2022
 * Client Name : Rhi'onna Williams
 * CJAMS PID# : 200829849
 */


select * from placementcpahomes where placementcpahomeid = 'b50f7bcb-33f9-4d84-ac40-b2dce755993c';

UPDATE cjams.placementcpahomes
SET entrydt='2022-12-20 11:00:00.000', entrytm='2022-12-20 11:00:00.000', updateuserid = 'CDM-34813', updatets = now() 
WHERE placementcpahomeid='b50f7bcb-33f9-4d84-ac40-b2dce755993c';
