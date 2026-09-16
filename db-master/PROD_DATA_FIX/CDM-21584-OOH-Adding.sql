/*
   Issue Description: CDM-21584
   Category/ Module  : Add OOH IN Placement
   Root cause: user wants  add OOH IN placement 
   Pull request# for code fix: 5199
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO personprogramarea (
        personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        'a709d0f8-7e55-4259-b248-f35aaa0010e4', 'OOH', null, 'servicecase', 'b775d11e-3bee-4db0-92d2-d6d19f8c4f5f', 
        '2022-03-24 00:00:00', 'CDM-21584', now(), 'CDM-21584', now(), 
        '221030015070', 1, 'CW'
);

INSERT INTO personprogramarea (
        personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        '79eb60be-5074-4941-822f-3e51b1960e58', 'OOH', null, 'servicecase', 'b775d11e-3bee-4db0-92d2-d6d19f8c4f5f', 
        '2022-03-24 00:00:00', 'CDM-21584', now(), 'CDM-21584', now(), 
        '221030015070', 1, 'CW'
);

INSERT INTO personprogramarea (
        personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        '71a724d7-99f4-41a2-9be7-308e6ada98de', 'OOH', null, 'servicecase', 'b775d11e-3bee-4db0-92d2-d6d19f8c4f5f', 
        '2022-03-24 00:00:00', 'CDM-21584', now(), 'CDM-21584', now(), 
        '221030015070', 1, 'CW'
);