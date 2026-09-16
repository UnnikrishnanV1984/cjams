
/*
   Issue Description : CDM-29020
   Category/ Module : Program assignment
   Root cause: User asked to remove Wrong Program Assignment
*/

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-29020'
where personprogramid = '423ea51b-f101-48ce-ae1a-58b56db5eb17';