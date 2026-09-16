/*
   Issue Description: CDM-24233
   Category/ Module  : Assessments 
   Root cause: 1) Might be user didn't enter correct roles before submitting safe c ,  
    2) without entering child also we are giving access to user submit and approval safc 
   Pull request# for code fix: and we have other defect also from web site and i fixed that
   Reason why no related code fix: web fix already raised 
*/


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200938744",
      "childname": " Jayla Love Thornton "
    },
    {
      "age": "5 Yrs",
      "clientid": "200938746",
      "childname": " Cayden L Thornton "
    },
    {
      "age": "18 Yrs",
      "clientid": "2745280",
      "childname": "SURAYA LOGAN JONES"
    }
    ]')
,updatedby = 'CDM-24233'
,updatedon = now()
where submissionid ='bc8a2ab4-c8bb-4c08-abe0-42fd778b34cf' and assessmentid ='a7c5318c-ef8a-46f6-847b-bcf70c47b3b1';