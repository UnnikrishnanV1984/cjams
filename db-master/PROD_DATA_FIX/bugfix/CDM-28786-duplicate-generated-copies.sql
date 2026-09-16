/*
   Issue Description: CDM-28786
   Category/ Module  :  Delete copy of requested data
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecasedisposition set activeflag= 0,
updatedby='CDM-28786',
updatedon=now()
where servicecasedispositionid in('7737aca1-0d48-4e72-99c0-209a788ef3ce', 'abcb21f8-1439-4ce7-a7e4-27e6f5013bb5');

update routing set activeflag= 0,
updatedby='CDM-28786',
updatedon=now()
where objectid in ('7737aca1-0d48-4e72-99c0-209a788ef3ce', 'abcb21f8-1439-4ce7-a7e4-27e6f5013bb5') and activeflag =1;


