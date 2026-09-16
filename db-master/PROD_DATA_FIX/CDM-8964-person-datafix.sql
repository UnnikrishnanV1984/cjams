update person set ssnno = '577194739', updatedon = now(), updatedby = 'CDM-8964' where personid = '48554758-0da0-4813-a0fb-ff3ed5637917';

insert into personidentifier (personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, old_id)
select personid, 'SSN', '577194739', 'CDM-8964', now(), 'CDM-8964', now(), 1, now(), old_id from personidentifier where personidentifierid = 'abccd88e-9e96-4f6e-a604-d1e9b656c65e';