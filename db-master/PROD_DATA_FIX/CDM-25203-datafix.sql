--CDM-25203

update servicecase set activeflag = 0, updatedby = 'CDM-25203', updatedon = now() where servicecasenumber = 221030018537;
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-25203', updatedon = now() where servicecaseid = '992fa145-d1d5-4801-bccf-aff4197013d4';
update caseassignment set activeflag = 0, updatedby = 'CDM-25203', updatedon = now() where objectid ='992fa145-d1d5-4801-bccf-aff4197013d4';
update routing set activeflag = 0, updatedby = 'CDM-25203', updatedon = now() where objectid = '992fa145-d1d5-4801-bccf-aff4197013d4';
