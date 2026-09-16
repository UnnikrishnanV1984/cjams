/*
-- Issue Description: 
	CDM-29569 : Payment
	QA/BA:  221030019163:We are unable to pay for Educational Services for this client because she is not listed as OOH even though her Removal and Placement are approved. 
	Only CPS funding is available.
-- Category/ Module: Child Removal - Program Assignment (Case Management) 
-- Root cause: User Request to add OOH program
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select * from personprogramarea
where personid = 'c729a37d-4ac4-43e4-8dbe-7b3b800a0521' and programkey = 'OOH';

INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'c729a37d-4ac4-43e4-8dbe-7b3b800a0521', 'OOH', null, 'servicecase', '3ced01ef-df39-46b4-92e1-fb368e13a296', 
'2022-10-20 00:00:00', 'CDM-29569', now(), 'CDM-29569', now(), 
'221030019163', 1, 'CW'
);