/*
 Issue Description: CDM-24116
 Category/ Module: Adding PA
 Root cause: update OOH
 Pull request# 6095
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/



delete from personprogramarea where personprogramid = 'ee386685-d493-4841-99c0-426fd97f2cc3';
INSERT INTO personprogramarea (
        personprogramid, personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        'ee386685-d493-4841-99c0-426fd97f2cc3', 'c5859b80-6707-41e0-b5f6-362a0786fbb7', 'OOH', null, 'servicecase', '2cd9ece2-14a3-4bd0-87e0-887e4e87ec1d', 
        '2022-05-16 00:00:00', 'CDM-24116', now(), 'CDM-24116', now(), 
        '3296483', 1, 'CW'
);