/*
 * CDM-42293 - Inserted record and updating the assigned by user
 * Description - Assigned case to appeal worker (Jeanne Baxter)
 * Fix provided - duplicate record got inserted and fixed by deleting
 */

update routing 
set activeflag = 0, updatedby= 'CDM-42293', updatedon= now()
where routingid = 'a8d2d10d-dcde-456d-8469-c8a8874b16cd';
