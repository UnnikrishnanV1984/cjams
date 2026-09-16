/* 
    Issue Description: CDM-38968
  Category/ Module  : Contacts: Notes
  Root cause: remove/delete the Contact ID: 12909124 as requested by the user
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update progressnote 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38968'
where progressnoteid = '0c56ab8a-fb2e-46a3-b2b4-8a2d00a88c62'
and witsid = 12909124 ;

update progressnotedetail 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38968'
where progressnoteid = '0c56ab8a-fb2e-46a3-b2b4-8a2d00a88c62'
and activeflag = 1 ;

update contactparticipant 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-38968'
where progressnoteid = '0c56ab8a-fb2e-46a3-b2b4-8a2d00a88c62'
and activeflag = 1 ;