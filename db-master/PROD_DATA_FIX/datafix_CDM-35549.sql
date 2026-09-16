/*
 * CDM-35549
 * Customer Email ID:charlenem.hearne@maryland.gov
 * Focus Area:Child Removal
 * Description -the Provider placement has been voided that's why the provider information is
 * not coming to the Break the Link window. 
 *  Worker need to create a new Provider placement to resolve the issue..
 * Data Fix to Remove OOH PA end date so they can create a new placement
 */

UPDATE intakeservreqchildremoval 
SET exitdate = null, removalexitreason = null, returntransts = null
	, updatedby ='CDM-35549'
	, updatedon = now()
WHERE intakeservreqchildremovalid = '6d9b2929-15b8-49c0-bd42-d748a27b4f32';

UPDATE tb_client_eligibility 
SET  end_dt = null
	, update_user_id = 'CDM-35549'
	, update_ts = now()
WHERE removal_id ='193295';

UPDATE personprogramarea 
SET enddate = null
	, updatedby ='CDM-35549'
	, updatedon = now() 
WHERE personprogramid  ='af08ad18-62f3-4b32-8e2d-ba648c094291' and programkey = 'OOH';
