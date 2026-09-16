/*
   Issue Description: CDM-29271
   Category/ Module  :  Program Assignment
   Root cause: user wants to add OOH with date
   Pull request# for data fix:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'9b740036-bab2-4fe6-a9d3-296a6304fa1b', 'OOH', null, 'servicecase', 'fd137343-1c06-4ffc-a48b-6d35318bdbc5', 
'2023-02-06 00:00:00', 'CDM-29271', now(), 'CDM-29271', now(), 
'3295673', 1, 'CW'
);
