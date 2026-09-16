/*
 Issue Description: CDM-29481
 Category/ Module  : Inserting OOH program Assignment
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */



INSERT INTO
        personprogramarea (
                personid,
                startdate,
                insertedon,
                insertedby,
                updatedon,
                updatedby,
                activeflag,
                programkey,
                subprogramkey,
                objecttypekey,
                objectid,
                entityid,
                sourcetype
        )
VALUES
        (
                '5a0252aa-b4d4-434b-bf32-66d5d4a9eb01',
                '2023-03-02 00:00:00',
                now(),
                'CDM-29481',
                now(),
                'CDM-29481',
                1,
                'OOH',
                null,
                'servicecase',
                '1ec7204b-b294-4208-9a3e-9940930d455d',
                '3263576',
                'CW'
        );