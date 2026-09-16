/*
   Issue Description: CDM-18807
   Category/ Module  : close empty case
   Root cause: user wants to close the empty case
   Pull request# for code fix: 6687
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update servicecase set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where servicecasenumber = 221030016106;
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where servicecaseid = 'b6501b30-c3e1-4fab-b37d-f14a7e92cc46';
update caseassignment set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where objectid ='b6501b30-c3e1-4fab-b37d-f14a7e92cc46';
update routing set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where objectid = 'b6501b30-c3e1-4fab-b37d-f14a7e92cc46';


update servicecase set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where servicecasenumber = 221030015985;
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where servicecaseid = '7ab8b375-81e5-4a4c-8ae5-821ced35d57f';
update caseassignment set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where objectid ='7ab8b375-81e5-4a4c-8ae5-821ced35d57f';
update routing set activeflag = 0, updatedby = 'CDM-25839', updatedon = now() where objectid = '7ab8b375-81e5-4a4c-8ae5-821ced35d57f';