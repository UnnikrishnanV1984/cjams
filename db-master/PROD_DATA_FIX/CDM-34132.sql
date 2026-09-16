/*
 * CDM-34132 - Removal date & IV-E
 * Customer Email ID:rhonda.gardner@maryland.gov
 * Customer Name:Rhonda Gardner
 * Focus Area:Child Removal
 * Description - 231030140610:The start date of the removal should be 7/26/2023 not 7/27/2023. IV-E needs to work on this case.
 * Need to Update the Child Removal Start date as 7/26/2023
 * Also the OOH PA start date needs to be updated as 7/26/2023
 */


select removaldate  , * from intakeservreqchildremoval where intakeservreqchildremovalid = 'e16fa36c-be1c-46aa-811d-446eb0bdaf5e';
UPDATE cjams.intakeservreqchildremoval
SET removaldate='2023-07-26 00:00:00.000', updatedby='CDM-34132', updatedon=now() 
WHERE intakeservreqchildremovalid='e16fa36c-be1c-46aa-811d-446eb0bdaf5e'::uuid;

select  startdate, * from personprogramarea where personprogramid = '0d2e8100-c048-487c-b197-b965415845ff';
UPDATE cjams.personprogramarea
SET startdate='2023-07-26 00:00:00.000', updatedby='CDM-34132', updatedon=now() 
WHERE personprogramid = '0d2e8100-c048-487c-b197-b965415845ff'::uuid;

select removaldate  , * from intakeservreqchildremoval_history where intakeservreqchildremovalid = 'e16fa36c-be1c-46aa-811d-446eb0bdaf5e' and activeflag = 1;
UPDATE cjams.intakeservreqchildremoval_history
SET removaldate='2023-07-26 00:00:00.000', updatedby='CDM-34132', updatedon=now() 
WHERE intakeservreqchildremovalid='e16fa36c-be1c-46aa-811d-446eb0bdaf5e'::uuid and activeflag = 1;