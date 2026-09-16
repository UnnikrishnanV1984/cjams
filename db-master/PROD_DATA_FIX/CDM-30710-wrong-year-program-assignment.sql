
/*
   Issue Description : CDM-30710
   Category/ Module : Program assignment
   Root cause: User asked to remove Wrong Program Assignment
*/

update
    personprogramarea
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30710'
where
    personprogramid in (
        '55b503ce-a0da-4d36-8916-1ede769cdd69',
        '92c224ff-7d24-49b1-9cbc-dc8603d2b549',
        '17ea4706-5a54-44dc-aa64-3d871937fb8a'
    );