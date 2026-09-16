/*
   Issue Description: CDM-24466
   Category/ Module  : Assessments 
   Root cause: 1) Might be user didn't enter correct roles before submitting safe c ,  
    2) without entering child also we are giving access to user submit and approval safc 
   Pull request# for code fix: and we have other defect also from web site and i fixed that
   Reason why no related code fix: web fix already raised 
*/

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200815169",
      "childname": " Gracilyn M Niosi "
    },
    {
      "age": "1 Yrs",
      "clientid": "200815778",
      "childname": " Gwendilyn   Bernhard  "
    },
    {
      "age": "2 Yrs",
      "clientid": "200815167",
      "childname": " August A Bernhard "
    }
    ]')
,updatedby = 'CDM-24466'
,updatedon = now()
where submissionid ='ca4f332b-ea62-4af1-95a1-b073ce64e28e';