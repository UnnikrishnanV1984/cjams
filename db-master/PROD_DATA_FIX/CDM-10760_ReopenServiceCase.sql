-- CDM-10760 - Reopen servicecase remove end date

update servicecase set enddate = null, updatedby ='CDM-10760' , updatedon = now() where servicecaseid ='72d7b2a7-8211-4d4b-b0fe-f1b8a79e7410';
