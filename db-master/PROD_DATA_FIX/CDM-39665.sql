/*
 * CDM-39665 - Delete Version
 * Customer Email ID:charles.lanham@maryland.gov
 * Description - 3306487:Please delete the service plan version dated 06/14/2024 3:34 PM. 
 * It was created in error and was incomplete. 
 * 
 */

--select activeflag, * from  snapshothist where id ='288310dd-2d42-41a8-beb0-1ff4f846b6b7';
UPDATE cjams.snapshothist
SET activeflag=0, updatedby='CDM-39665', updatedon=now()  
WHERE id='288310dd-2d42-41a8-beb0-1ff4f846b6b7';
