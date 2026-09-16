/*
   Issue Description : CDM-30730
   Category/ Module : Program assignment
   Root cause: User asked to remove Wrong Program Assignment
*/

update
    personprogramarea
set
    enddate =  null,
    updatedon = now(),
    updatedby = 'CDM-30730'
where
    personprogramid = '2d329a59-e969-49b5-907f-65dca4da36b4';