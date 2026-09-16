/*
   Issue Description: CDM-34712
   Category/ Module  : Person
   Root cause: Last name is not matching with the data in mdm. - is missing in lastname
   Fix Privided: Data fix to update lastname
*/

select cisclientid, * from cjams.person where cjamspid='201279690';

select * from cjams.personidentifier where personid='99e8cee7-3842-44a1-96bd-6823e4b9d256';

--cjamspid=201279690
-- SELECT json_agg(a) from sp_get_person_mdm('99e8cee7-3842-44a1-96bd-6823e4b9d256') a;
delete from cjams.personidentifier where personid='99e8cee7-3842-44a1-96bd-6823e4b9d256' and personidentifiertypekey='MDM_ID'
   and activeflag =1;
   
INSERT INTO cjams.personidentifier
(personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '99e8cee7-3842-44a1-96bd-6823e4b9d256', 'MDM_ID', 'MDT-125776986', 'CDM-34712', now(), 'CDM-34712', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

update cjams.person set cisclientid='459010765', lastname='Luna-Lima', updatedby='CDM-34712', updatedon=now() 
where personid = '99e8cee7-3842-44a1-96bd-6823e4b9d256'and cjamspid =201279690 and activeflag=1;  