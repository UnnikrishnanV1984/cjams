UPDATE intakeservreqchildremoval 
SET exitdate = null, 
    updatedby = 'CDM-13888',
    updatedon = now()
WHERE intakeservreqchildremovalid = '06fa6ee5-7d82-47f2-bbeb-28f42c8a2fb4';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-13888', 
    updatedon = now() 
WHERE personprogramid = '04169f18-9726-46ec-b258-dc3a352a7a9b';

UPDATE placement 
SET enddatetime = null, 
    endtime = null,
    updatedby = 'CDM-13888',
    updatedon = now()
WHERE placementid = '7703902e-534e-4c69-8d4d-3121bb74fe30';

UPDATE placementrevision 
SET exittime = null, 
    exitdate = null,
    updatedby = 'CDM-13888',
    updatedon = now()
WHERE placementid = '7703902e-534e-4c69-8d4d-3121bb74fe30' ;