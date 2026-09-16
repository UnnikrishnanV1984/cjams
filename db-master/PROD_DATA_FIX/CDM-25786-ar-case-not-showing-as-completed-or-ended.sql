/*
   Issue Description: CDM-25786
   Category/ Module  : Child Removal/Placement
   Root cause: AR case not showing as "Completed" or ended
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update
    personprogramarea
set
    enddate = '2022-08-01 00:00:00',
    updatedon = now(),
    updatedby = 'CDM-25786'
where
    personprogramid in (
        'ee3398a3-ab4f-40aa-9716-43f2c2547805',
        '6805ad07-a4af-4c37-beec-de29351f6f07',
        '4f5b68da-fb6d-42e2-bff1-f23369bb44a4',
        '03f363f8-0459-4f9a-a323-7daa96b59e28',
        '18a507ab-b230-49cb-be6a-2ca105aa4584'
    );   


update
    personprogramarea
set
    entityid = '221020223610',
    updatedon = now(),
    updatedby = 'CDM-25786'
where
    personprogramid = 'ee3398a3-ab4f-40aa-9716-43f2c2547805'
    and personid = 'cce1d1b1-1edf-42ac-8e7e-c3045a73c66d';