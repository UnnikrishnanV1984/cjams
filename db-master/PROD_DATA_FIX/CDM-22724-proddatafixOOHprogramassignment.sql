/*
   Issue Description: CDM-22724
   Category/ Module  : Inserting OOH program Assignment
   Root cause: user wants to remove the Annual Review
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


INSERT INTO personprogramarea (
        personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        'f50aeacf-f3bd-4b6f-8afc-67ecd16a5df3', 'OOH', null, 'servicecase', '371ddbce-2ddb-4787-ac93-ce6c2fac3fef', 
        '2021-11-08 05:00:00', 'CDM-22724', now(), 'CDM-22724', now(), 
        '211030012191', 1, 'CW'
);
