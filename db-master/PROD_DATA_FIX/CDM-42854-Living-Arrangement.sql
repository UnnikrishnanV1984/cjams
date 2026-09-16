/*
 Issue Description: CDM-42854 Living Arrangement
 Category/ Module  : Placement
 Root cause: User error - entered living arrangement by mistake
 fix: Datafix has been added to soft delete the records.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date:
 */
update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-42854',
    updatedon = now()
where
    placementid = '692b7887-aa97-46ce-b647-5c5c2c393975'
    and personid = 'cc8b8d05-cc2b-4798-a410-6825d295d936'
    and activeflag = '1';

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-42854',
    updatedon = now()
where
    placementid = '692b7887-aa97-46ce-b647-5c5c2c393975'
    and activeflag = '1';

update
    livingarrangement
set
    activeflag = 0,
    updatedby = 'CDM-42854',
    updatedon = now()
where
    placementid = '692b7887-aa97-46ce-b647-5c5c2c393975'
    and activeflag = '1';

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-42854',
    updatedon = now()
where
    objectid = '692b7887-aa97-46ce-b647-5c5c2c393975'
    and activeflag = '1';