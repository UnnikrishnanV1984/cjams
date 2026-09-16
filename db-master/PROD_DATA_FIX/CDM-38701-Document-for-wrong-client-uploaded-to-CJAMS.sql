/*
Issue Description: 241021896553:A Law Enforcement Notification for the wrong client was 
uploaded to the Document section of this case and needs to be deleted. Delete icon not operable.
Name of document to be deleted is New Fax Transmittal Alshaer (002).docx 
 Category/ Module  : User profiles     Documents
Root cause:Data fix to delete the document under the Documents tab
Fix provided :yes,write db query
Code fix ticket#:CDM-38701
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

update
 documentproperties
set
    activeflag = 0,
    updatedby = 'CDM-38701',
    updatedon = now()
where
    documentpropertiesid = '182bcb73-df91-4aa5-94ce-b29297833f6b';

--Updated fix

update
 documentattachment
set
    activeflag = 0,
    updatedby = 'CDM-38701',
    updatedon = now()
where
    documentpropertiesid = '182bcb73-df91-4aa5-94ce-b29297833f6b';