
/*
   Issue Description: CIDM-5439
   Category/ Module  : Assessments 
   Root cause: 1) Might be user didn't enter correct roles before submitting safe c ,  
    2) without entering child also we are giving access to user submit and approval safc 
   Pull request# for code fix: and we have other defect also from web site and i fixed that
   Reason why no related code fix: web fix already raised 
*/


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3666938",
      "childname": " JADEN M DENNIS "
    },
    {
      "age": "7 Month(s)",
      "clientid": "200872063",
      "childname": " Jacinta Dennis "
    }
    ]')
,updatedby = 'CIDM-5439'
,updatedon = now()
where submissionid ='4f422aee-3ce0-4ee9-8b18-e88beea70260' and assessmentid ='ba6a172f-6dc3-499c-ad0b-6e82d4dc72fb';