/*
   Issue Description: CDM-22806
   Category/ Module  : Removal of CPS IR to service case and assigning OOH
   Root cause: user wants to add OOH
   Pull request# for code fix:5613
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
INSERT INTO personprogramarea (
        personid, programkey, subprogramkey, objecttypekey, objectid, 
        startdate, insertedby, insertedon, updatedby, updatedon, 
        entityid, activeflag, sourcetype
) values(
        'b5b57efa-195c-4e88-960d-5e8f88927123', 'OOH', null, 'servicerequest', 'e329215a-4b73-4025-9989-7ac20d41a388', 
        '2021-12-16 05:00:00', 'CDM-22806', now(), 'CDM-22806', now(), 
        '211020169118', 1, 'CW'
);


UPDATE  personprogramarea  
set activeflag = 0,
	updatedby = 'CDM-22806',
	updatedon = now()
where personprogramid  ='8687deb0-1495-4ab9-8e9d-6580af8a0e85'
	and activeflag = 1;