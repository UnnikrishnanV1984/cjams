/*
 * CDM-34227 - Removal end date needs to be deleted
 * Customer Email ID:shawntese.charles1@maryland.gov
 * Customer Name:Shawntese Charles
 * Focus Area:Placement
 * Description - 3293517:We are unable to add the pre-adoptive placement because we end dated the removal. 
 * Delete this end date so that we can close this case properly.
 */

select removalid, exitdate,returntransts,* from intakeservreqchildremoval where intakeservreqchildremovalid = 'cb8a99a4-1b3d-4d6d-8c19-fd7173e81b37';
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL, updatedby='CDM-34227', updatedon=now() 
WHERE intakeservreqchildremovalid='cb8a99a4-1b3d-4d6d-8c19-fd7173e81b37';

select enddate, * from personprogramarea where personprogramid = '093b0757-6fd4-4318-bcc5-5d55138fb453';
UPDATE cjams.personprogramarea
SET enddate=NULL, updatedby='CDM-34227', updatedon=now() 
WHERE personprogramid='093b0757-6fd4-4318-bcc5-5d55138fb453'; 

select  * from tb_client_eligibility where removal_id = '196516';
UPDATE cjams.tb_client_eligibility
SET end_dt=NULL, update_user_id='CDM-34227', update_ts=now() 
WHERE removal_id = '196516';