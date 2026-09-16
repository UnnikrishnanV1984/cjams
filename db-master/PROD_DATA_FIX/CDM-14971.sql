/*
   Issue Description: CDM-14971
   Category/ Module  :documents 
   Root cause: user wants to Remove the documents and move 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update documentproperties set activeflag=0,updatedby ='CDM-14971',updatedon =now() where documentpropertiesid in('fb75ac32-26af-415b-b953-d4455d69c592');


update documentproperties set actualdocumentdate='2021-07-12 00:00:00',updatedby ='CDM-14971',updatedon =now(),documentdate='2021-07-12 00:00:00', title=originalfilename,objecttypekey='Person',objectid='f8aee09f-c1aa-4aae-b817-4ed95190673a',activeflag=1 where documentpropertiesid in(
'b358bfa8-73d8-44a0-af6f-6cfe71e9f265',
'ab629a5b-770b-48ac-9b17-92934f30c492');

update documentproperties set title=originalfilename,updatedby ='CDM-14971',updatedon =now() where documentpropertiesid='8794fd26-095a-4381-8dd3-14ce7707e00a';

INSERT INTO cjams.documentattachment
( documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,  attachmentdate,activeflag,attachmentclassificationsubtypekey,updatedby,updatedon,insertedby)
values
( 'b358bfa8-73d8-44a0-af6f-6cfe71e9f265', 'Document', 'Other',  '2021-07-12 05:10:38.659', 1,'Other','CDM-14971',now(),'528d5f40-237c-4823-9a1c-db64a1c82b47'),
( 'ab629a5b-770b-48ac-9b17-92934f30c492', 'Document', 'Other',  '2021-07-12 05:10:38.659', 1,'Other','CDM-14971',now(),'528d5f40-237c-4823-9a1c-db64a1c82b47'),
( '8794fd26-095a-4381-8dd3-14ce7707e00a', 'Document', 'Other',  '2021-07-12 05:10:38.659', 1,'Other','CDM-14971',now(),'528d5f40-237c-4823-9a1c-db64a1c82b47');
