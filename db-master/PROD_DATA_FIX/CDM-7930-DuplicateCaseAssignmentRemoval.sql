-- CDM-7930 - Remove duplicate case assignments


update caseassignment set activeflag=0, updatedby = 'CDM-7930', updatedon = now() where caseassignmentid = 'e2115b28-4b86-40b2-b56b-d12bc664267e' and activeflag = 1;
update caseassignment set activeflag=0, updatedby = 'CDM-7930', updatedon = now() where caseassignmentid = '2bf887a1-5c2e-4084-b300-d7c3a210a8eb' and activeflag = 1;
