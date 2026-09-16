/*
   Issue Description: CDM-29533
   Category/ Module  : Maltreatment Allegation
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.investigationallegation
SET isproviderinvolved=1, updatedby='CDM-29533', updatedon=now()
WHERE investigationallegationid='0a4c2b3c-601f-46a8-84b6-0f9fb51e4045';

INSERT INTO cjams.allegationprovidermaltreatment
(investigationallegationid, providermaltreatmenttypekey, activeflag, insertedby, updatedby, effectivedate, insertedon, updatedon, old_id)
VALUES('0a4c2b3c-601f-46a8-84b6-0f9fb51e4045', 'LAFC', 1, 'CDM-29533', 'CDM-29533', now(), now(), now(), NULL);

UPDATE cjams.investigationmaltreatment
SET providername='Relative/fictive kin home', updatedby='CDM-29533', updatedon=now()
WHERE maltreatmentid='822cb41e-e49b-44a6-80f8-05d6b38428a4';

update intakesnapshot 
set jsondata = replace(jsondata::text, '"providerdetails": null,' , '"providerdetails": "9d9465e1-4597-4ebd-a6d2-77d546db51cf",')::json, 
updatedon = now(),updatedby = 'CDM-29533' where intakeserviceid = '9fa68a06-fe13-4c3f-b6d9-216160be2611';

