-- CDM-10894 - Remove case immediately

update servicecase set activeflag =0, updatedby = 'CDM-108984', updatedon =now() where servicecaseid ='47ea95b3-58ae-4e3e-8039-1a6fdf66d1d1' and activeflag =1;
update caseassignment set activeflag =0, updatedby = 'CDM-108984', updatedon =now() where caseassignmentid='ae9c13a5-4989-48f0-84a7-351cca99dbb7' and activeflag =1;
update routing set activeflag =0, updatedby = 'CDM-108984', updatedon =now() where routingid ='ea5c02ca-ec65-4ffa-ba30-9432175203e7' and activeflag =1;
