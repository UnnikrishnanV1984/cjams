
/*
   Issue Description : CDM-23032
   Category/ Module : Program assignment
   Root cause: User asked to remove the incorrect program assignment
*/

update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-23032'
where personprogramid = 'fac25d5d-cd00-4062-87f3-a5a0bb1d1c61';