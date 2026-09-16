
/*
Issue Description: Need data fix to remove progress note and the contact notes : 16257159 & 16257142 were placed in the incorrect case.
Category/Module: Bug
Root cause: Users cannot change the contacts numbers  in  contacts tab, They can able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-68128
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '968b35d2-2cc8-4f81-ae4b-8d85b4810fdb' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '968b35d2-2cc8-4f81-ae4b-8d85b4810fdb' and activeflag =1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '968b35d2-2cc8-4f81-ae4b-8d85b4810fdb' and activeflag =1;


update progressnote
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '441cac42-0a09-4d1a-8a9b-bef04eb4293c' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '441cac42-0a09-4d1a-8a9b-bef04eb4293c' and activeflag =1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-68128', updatedon = now()
where progressnoteid = '441cac42-0a09-4d1a-8a9b-bef04eb4293c' and activeflag =1;