UPDATE  personidentifier SET personidentifiervalue='MDT-131014312', updatedon = now()
WHERE personidentifiertypekey ='MDM_ID' AND personid
IN (SELECT personid FROM person WHERE cjamspid = 1291078 )
