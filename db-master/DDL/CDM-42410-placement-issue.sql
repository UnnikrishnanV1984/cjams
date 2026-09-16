/*
 * CDM-42410 - User is trying to enter the foster parent Melissa Kelly #3003029 for the child Jonah Malachi #20399031. there is a error banner with Something Went Wrong! Try again! 
 * Customer Email ID: morris.richmond@maryland.gov
 * Description - Placements - User is trying to enter the foster parent Melissa Kelly #3003029 for the child Jonah Malachi #20399031. there is a error banner with Something Went Wrong! Try again! 
 */

-- select row_lock ,vacancy_no ,* from prov.tb_provider tp  where provider_id = 6006029;

UPDATE prov.tb_provider 
SET row_lock=null, updatedby='CDM-42410', updatedon=now() 
WHERE vacancy_no>0 AND provider_id=6006029;