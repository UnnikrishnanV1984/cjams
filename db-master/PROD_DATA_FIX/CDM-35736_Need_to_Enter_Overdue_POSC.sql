/*
 Issue Description: CDM-35736
 Category/ Module  : POSC
 Root cause: Person table is missing substanceexposednewbornflag, substanceclasses and substanceexposednewbornsourcetypekey.
 Pull request# for code fix: Datafix has been added to the person table.
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
UPDATE
    cjams.person
SET
    substanceexposednewbornflag = 1,
    substanceclasses = '["BCOC"]',
    substanceexposednewbornsourcetypekey = 2954,
    substanceexposednewborntimetamp = '2023-09-23 17:00:00',
    senstatusflag = 1,
    updatedby = 'CDM-35376',
    updatedon = now()
WHERE
    personid = '853e4324-25dc-4a6c-98fe-cca03ba9a9f5';