
/*
   Issue Description:CDM-24258
   Category/ Module  : Assessments 
   Root cause: 1) Might be user didn't enter correct roles before submitting safe c ,  
    2) without entering child also we are giving access to user submit and approval safc 
   Pull request# for code fix: and we have other defect also from web site and i fixed that
   Reason why no related code fix: web fix already raised 
*/


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "4399257",
      "childname": "BRYTIN  LOWER"
    },
    {
      "age": "12 Yrs",
      "clientid": "4399261",
      "childname": "KADEN M BOLYARD"
    }
    ]')
,updatedby = 'CDM-24258'
,updatedon = now()
where submissionid ='33ce155e-22f4-47fa-ba01-3b4c05b86a66' and assessmentid ='1c816f2e-a5ea-452a-b086-99b59eb8a0f5';