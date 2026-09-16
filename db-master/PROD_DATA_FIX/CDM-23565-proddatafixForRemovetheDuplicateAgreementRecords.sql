/*
   Issue Description: CDM-23565
    Category/ Module  : Prod data fix to remove the duplicate agreement records
   Root cause:  Re-executing the file again
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapagreementrate set activeflag =0, updatedby = 'CDM-23565', updatedon = now()  where gapagreementrateid in ('526f9bab-12fb-461c-bc1a-adfb37a3c174','e50b51d0-f5c5-43af-b4da-51103189eb13',
'bff4fb48-9b38-4cfa-b42f-123db8daf405','ce60ca8a-5e49-4880-9b23-802c3cae214f','25586573-65ab-4218-b432-b156cfff2cde') and activeflag = 1;

update gapratesrevision set activeflag =0, updatedby = 'CDM-23565', updatedon = now()  where gaprateid in ('526f9bab-12fb-461c-bc1a-adfb37a3c174','e50b51d0-f5c5-43af-b4da-51103189eb13',
'bff4fb48-9b38-4cfa-b42f-123db8daf405','ce60ca8a-5e49-4880-9b23-802c3cae214f','25586573-65ab-4218-b432-b156cfff2cde') and activeflag = 1;