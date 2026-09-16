/*
   Issue Description: CDM-31851
   Category/ Module  :  Documents
   Root cause: Category subcategory missing, no ecords in document attachment table
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

INSERT INTO cjams.documentattachment
( documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,  attachmentdate,activeflag,attachmentclassificationsubtypekey,updatedby,updatedon,insertedby)
values
('2ea21d7a-32d5-45ab-9ec4-70b99ee15d8f', 'Document', '',  '2022-09-01 04:00:00', 1,'','CDM-31851',now(),'9312b656-d31b-4250-93a5-cd349d1551c7'),
('a88cd1ed-1e7e-4166-a6b0-02d0c8f312e0', 'Document', '',  '2022-07-25 04:00:00', 1,'','CDM-31851',now(),'9312b656-d31b-4250-93a5-cd349d1551c7'),
('dd61d8fa-808b-40c6-ad54-fca18f86fde5', 'Document', '',  '2022-09-01 04:00:00', 1,'','CDM-31851',now(),'9312b656-d31b-4250-93a5-cd349d1551c7'),
('4b65b5b7-9081-450d-ae2d-113917fea742', 'Document', '',  '2023-01-12 00:00:00', 1,'','CDM-31851',now(),'8c2ed0c1-64a2-4cf5-96a0-11bd1c7d2d39');