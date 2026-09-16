--CDM-24249

update servicecase set activeflag = 0, updatedby = 'CDM-24249', updatedon = now() where servicecasenumber = 221030013976;
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-24249', updatedon = now() where servicecaseid = '919b46d3-8d57-43a9-b872-d5074505220a';
update caseassignment set activeflag = 0, updatedby = 'CDM-24249', updatedon = now() where objectid ='919b46d3-8d57-43a9-b872-d5074505220a';
update routing set activeflag = 0, updatedby = 'CDM-24249', updatedon = now() where objectid = '919b46d3-8d57-43a9-b872-d5074505220a';
