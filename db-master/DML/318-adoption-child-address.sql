--Need to remove address of this child that came from previous identity to that after adoption
DELETE FROM personaddress WHERE personid = (SELECT personid FROM person WHERE cjamspid = '200000496');