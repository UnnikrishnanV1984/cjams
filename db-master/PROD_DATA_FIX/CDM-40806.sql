/* 
    Issue Description: CDM-40806
    Category/ Module: CPS Case / Person
    Root cause: A person was accidentally added to a CPS case and the user is requesting to remove them.
                SSA supervisor approval has been recieved to complete this data fix.
    Fix Provided: Data fix to deactivate the person connection with the CPS case.
    Pull request# for code fix: N/A
    Reason why no related code fix: = As per system design override functionality is deisabled after 5 days.
                So, this is rare case scenario that needs SSA approval and can only be handled with data fix.
*/

-- ff118232-5e51-468c-8589-69be3c0863e8 -- intakeserviceid
-- SELECT intakeserviceid, * FROM cjams.intakeservicerequest i 
-- WHERE servicerequestnumber = '241022729268';

-- afb4f93f-ad56-4787-be91-dac78a4394c3 -- personid
-- SELECT personid, * FROM cjams.person 
-- WHERE person.cjamspid = '200211386';

-- 421569af-a6a7-407e-9caa-cddaeb6ff1b3 -- intakeservicerequestactorid
-- SELECT activeflag, updatedby, * FROM intakeservicerequestactor i WHERE 
-- intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

-- SELECT activeflag, updatedby, * FROM cjams.actor a WHERE 
-- intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

-- SELECT * FROM actorrelationship WHERE 
-- intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8'; 

-- SELECT * FROM actorrelationship
-- where intakeservicerequestactorid = '421569af-a6a7-407e-9caa-cddaeb6ff1b3';

-- 9bcd95ec-4294-481d-bb15-cbd9af812921 -- personroleid
-- SELECT * FROM personrole WHERE
-- intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

-- SELECT * FROM personroletype WHERE
-- personroleid = '9bcd95ec-4294-481d-bb15-cbd9af812921';

-- SELECT * FROM personprogramarea WHERE 
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3'
-- AND objectid = 'ff118232-5e51-468c-8589-69be3c0863e8';

--Updating actor
UPDATE cjams.actor
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

--Updating intakeservicerequestactor
UPDATE cjams.intakeservicerequestactor
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

--Updating actorrelationship
--No relationship record exists, person only added as Other

--Updating personrole
UPDATE cjams.personrole
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakeserviceid = 'ff118232-5e51-468c-8589-69be3c0863e8' AND
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

--Updating personroletype
UPDATE cjams.personroletype
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE personroleid = '9bcd95ec-4294-481d-bb15-cbd9af812921'
AND personroletypeid = 'da142dc7-1e79-42c7-a2c5-f167a156a5de';

--Updating personprogramarea
UPDATE cjams.personprogramarea
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3'
AND objectid = 'ff118232-5e51-468c-8589-69be3c0863e8';

--**Update records related to Intake as well (I241012935471)**

-- SELECT * FROM cjams.intakeservicerequest i WHERE 
-- intakenumber = 'I241012935471';

-- actorid => 4fbabd87-aa48-42d9-bacd-bbb82b9f6eaa
-- SELECT activeflag, updatedby, * FROM cjams.actor WHERE 
-- intakenumber = 'I241012935471' AND 
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

-- intakeservicerequestactorid => c9e2c401-7d25-41bb-aad5-31ecd3affa93
-- SELECT intakeserviceid, personid, activeflag, * FROM cjams.intakeservicerequestactor i WHERE
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3' AND
-- intakenumber = 'I241012935471';

-- SELECT activeflag, updatedby, * FROM cjams.actorrelationship
-- where intakeservicerequestactorid = 'c9e2c401-7d25-41bb-aad5-31ecd3affa93';

-- personroleid => 704e6dd7-1ae4-4683-b824-ed770144a98a
-- SELECT activeflag, updatedby, * FROM cjams.personrole
-- WHERE intakenumber = 'I241012935471' AND
-- personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

-- personroletypeid => 637b4dee-a6e5-4441-bc46-ebd0968f10a0
-- SELECT * FROM cjams.personroletype
-- WHERE personroleid = '704e6dd7-1ae4-4683-b824-ed770144a98a'
-- AND personroletypeid = '637b4dee-a6e5-4441-bc46-ebd0968f10a0';

-- SELECT * FROM cjams.personprogramarea
-- WHERE personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

--Updating actor
UPDATE cjams.actor 
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakenumber = 'I241012935471' AND 
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3' AND
actorid = '4fbabd87-aa48-42d9-bacd-bbb82b9f6eaa';

--Updating intakeservicerequestactor
UPDATE cjams.intakeservicerequestactor
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakenumber = 'I241012935471' AND
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3' AND
intakeservicerequestactorid = 'c9e2c401-7d25-41bb-aad5-31ecd3affa93';

--Updating actorrelationship
UPDATE cjams.actorrelationship
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakeservicerequestactorid = 'c9e2c401-7d25-41bb-aad5-31ecd3affa93';

--Updating personrole
UPDATE cjams.personrole
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE intakenumber = 'I241012935471' AND
personid = 'afb4f93f-ad56-4787-be91-dac78a4394c3';

--Updating personroletype
UPDATE cjams.personroletype
SET activeflag=0, updatedon=now(), updatedby='CDM-40806'
WHERE personroleid = '704e6dd7-1ae4-4683-b824-ed770144a98a'
AND personroletypeid = '637b4dee-a6e5-4441-bc46-ebd0968f10a0';

--Updating personprogramarea
--Taken care by the CPS case update