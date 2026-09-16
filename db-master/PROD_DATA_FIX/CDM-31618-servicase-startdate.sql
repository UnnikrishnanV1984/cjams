/*
   Issue Description: CDM-31618
   Category/ Module  : Servicecase
   Root cause: User requested to update  details about servicecase including atartdate, program assignments and assessments . 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set startdate ='2023-04-20 18:26:00',effectivedate ='2023-04-20 18:26:00',insertedon ='2023-04-20 18:26:00',updatedby = 'CDM-31618',updatedon =now() where servicecaseid ='3af07524-b021-4d11-8428-da58eef92a01';

update servicecasedisposition set statusdate ='2023-04-20 18:26:00',effectivedate ='2023-04-20 18:26:00',insertedon ='2023-04-20 18:26:00',updatedby = 'CDM-31618',updatedon =now() where servicecasedispositionid ='dc89e51c-fc52-4cf3-91cb-cbcc4918acab';

update personprogramarea set activeflag =0, updatedby = 'CDM-31618',updatedon =now() where objectid ='2ddafbda-467c-473a-9fa5-22b61b615904';

update assessment set updatedby ='f36f2ac1-6acf-4ad2-807a-11c726c42dce',updatedon =now()where servicecaseid ='3af07524-b021-4d11-8428-da58eef92a01' and assessmentid = 'd229cdd7-fb95-4c5f-bdac-3c75eb12403f';