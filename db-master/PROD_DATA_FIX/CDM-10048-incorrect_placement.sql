--intakeservreqchildremoval
update
    intakeservreqchildremoval
set
    activeflag = 1,
    updatedby = 'CDM-10048',
    updatedon = now()
where
    intakeservreqchildremovalid = 'afadaae8-f24d-439c-9d2f-16aa81d77268';

--placement
update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-10048',
    updatedon = now()
where
    placementid = 'b22c65f1-7519-4ef6-9e21-b8ff930ff8f4';

--placementrevision
update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-10048',
    updatedon = now()
where
    placementid = 'b22c65f1-7519-4ef6-9e21-b8ff930ff8f4'
    and placementrevisionid = 'e5b89dfe-27b2-4b54-b589-a1a818609e25'
    and alternateid = '1095078';