-- CDM-15240
UPDATE caseassignment 
SET toworkeridno = null, 
	updatedby = 'CDM-15240', 
	updatedon = now() 
WHERE toworkeridno = '';