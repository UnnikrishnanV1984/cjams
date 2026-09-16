update person set ssnno = null, updatedby = 'CDM-8772', updatedon = now() where personid = '42dd03fe-bcd3-4808-907e-aa90c457715a';
update personidentifier set activeflag = 0, updatedby = 'CDM-8772', updatedon = now() where personid = '42dd03fe-bcd3-4808-907e-aa90c457715a' and personidentifiertypekey = 'SSN';
