/*
Issue Description:231020507063:Hi,I work in appeals and was going over this file in cjams when I noticed that I previously must have uploaded the wrong document to this case. The document that needs deleted is labeled "A. Marquina Withdrawn File.pdf" and it has a document date of May 18, 2025. Cjams is not allowing me to delete this document. I do have a trash can icon but it is not doing anything. Can cjams support help me with this?
Root cause: User requested delete the document due to they do not have accesss to do that.
Fix provided: Data fix has been done to update the documentproperties,documentattachment table.
Data/Code fix ticket#: CJAMS-62034
Regression Impacts: N/A
Is Code fix Required?: no
Code fix ticket#:no
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update documentproperties
set activeflag = 0 ,updatedby = 'CJAMS-62034', updatedon = now()
where documentpropertiesid = '592adbb6-3218-4c32-9349-8c5d2cf614b9' and activeflag =1;

update documentattachment 
set activeflag = 0 ,updatedby = 'CJAMS-62034', updatedon = now()
where documentattachmentid = '9eff8b2c-dd50-41f8-a200-a799cdef83ba' and activeflag = 1;