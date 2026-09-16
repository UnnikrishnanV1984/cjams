-- Removed duplicate assigment 
update cjams.caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CDM-6907' where caseassignmentid = '92136c4d-8a2a-453a-b8b1-18067ccb0f24';
