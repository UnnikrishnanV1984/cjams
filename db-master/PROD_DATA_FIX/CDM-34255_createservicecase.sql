
/*
   Issue Description: CDM-34255
   Category/ Module  : servicecase 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.servicecase
SET activeflag=0, updatedon=now(), updatedby='CDM-34255'
WHERE servicecaseid='5bbf748a-5776-4170-b614-27adb06eedce'::uuid and servicecasenumber='231030185295';

select * from createservicecase('92f230dc-5833-4357-9809-df51872e53ca', 'cf57d874-8126-4b25-bfb6-6c3cdbdfb95f',0,'07a546d5-9823-49d4-9167-5228b43e47d1','intake');
