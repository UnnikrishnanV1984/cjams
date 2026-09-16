/*
   Issue Description: CDM-24427
   Category/ Module  : Assessments 
   Root cause: Might be user didn't enter correct roles before submitting safe c , and we have other defect also from web site and i fixed that 
   Pull request# for code fix: 
   Reason why no related code fix: web fix already raised 
*/




UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200938079",
      "childname": " Charles Alexander Harding Junior"
    },
    {
      "age": "11 Yrs",
      "clientid": "200938080",
      "childname": " Emmett Elijah Harding "
    },
    {
      "age": "16 Yrs",
      "clientid": "200938527",
      "childname": " Ethan  Carmichael "
    },
    {
      "age": "5 Yrs",
      "clientid": "200938541",
      "childname": " James  Harding "
    },
    {
      "age": "13 Yrs",
      "clientid": "4381482",
      "childname": "ELIJAH RAY CARMICHAEL"
    },
    {
      "age": "2 Yrs",
      "clientid": "200938547",
      "childname": " Evelyn  Harding "
    },
    {
      "age": "6 Yrs",
      "clientid": "200938539",
      "childname": " Henry  Harding  "
    }
    ]')
,updatedby = 'CDM-24427'
,updatedon = now()
where submissionid ='b0fa5deb-e2e7-42a9-ae06-bb05f739a85d';