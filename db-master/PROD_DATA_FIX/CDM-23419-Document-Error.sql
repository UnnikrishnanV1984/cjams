/*
   Issue Description: CDM-23419
   Category/ Module  : Prod data fix to retreive document
   Pull request# for code fix: 5813
   Reason why no related code fix: User unable to select dreopdown to change from AR to IR
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

insert into documentattachment(documentattachmentid,documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,
			attachmentid, attachmentdate, sourceauthor, sourceposition, sourcephonenumber, sourceaddress, 
			attachmentsubject, attachmentpurpose, acquisitionmethod, locationoforiginal, note, updatedby, 
			updatedon, insertedby, insertedon, activeflag, expirationdate, old_id, "timestamp", assessmenttemplateid, 
			attachmentclassificationsubtypekey)
values(gen_random_uuid(),'3cb53dc9-6a0e-43f0-8ec2-fb0ba117793e', 'Document', 'CW-Document',	NULL, now(), NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL, 'CDM-23419','now', 'CDM-23419', now(), 1, NULL, NULL, NULL, NULL, 
			NULL);			
