/*
Issue Description: A duplicate note appeared after I changed the persons involved in this contact.
Category/ Module :bug
Root cause: Contacts notes duplicates entry
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-40004
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating progressnote
update ProgressNote
 set 
    updatedon = now(),
    updatedby = 'CDM-40004',
    activeflag = 0
 where progressnoteid = 'a39dda7a-b13d-4526-b759-931009d12d6e' and activeflag = 1 ;
 
--Updating progressnotedetail
update progressnotedetail
set 
	updatedon = now(),
    updatedby = 'CDM-40004',
    activeflag = 0
where progressnoteid = 'a39dda7a-b13d-4526-b759-931009d12d6e' and activeflag = 1 ;

--Nothing in contactparticipant