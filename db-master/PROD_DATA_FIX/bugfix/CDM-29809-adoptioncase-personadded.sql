
/*
  Issue Description: CDM-29809
   Category/ Module  : Add Person and adoptioncaseactor
   Root cause: user wants to PERSON Latanya Jones 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

INSERT INTO cjams.person
(personid, activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey)
VALUES(gen_random_uuid(), 1, NULL, 'Latanya', 'Jones', '', NULL, '', NULL, NULL, 'CDM-29809', now(), 'CDM-29809', now(), now(), NULL, NULL, NULL, '1976-05-23 00:00:00.000', NULL, NULL, 'F');

INSERT INTO cjams.adoptioncaseactor
( adoptioncaseid, personid, actortypekey, old_id, activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date)
VALUES( '7ae9c372-b38e-4bd3-b4b1-0862f9221df0', (select personid from cjams.person
where insertedby ='CDM-29809'
and insertedon::date = current_date
), 'ADOPTIVEPARENT', '3221454', 1, now(), 'CDM-29809', now(), 'CDM-29809', 'Data Migration', now());

UPDATE adoptioncaseagreement
SET  singleparentadoptioncheck = 0 , parent2providername = 'Rodney  Jones',
parent1providername = 'Latanya  Jones' , updatedby = 'CDM-29809',updatedon = now()
WHERE adoptionagreementid = 'f0c88af6-d06c-408e-a88f-a86d8503da28';