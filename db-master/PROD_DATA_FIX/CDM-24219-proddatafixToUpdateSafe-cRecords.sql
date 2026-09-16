/*
   Issue Description: CDM-24219
   Category/ Module  : Prod data fix to add child records
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200902259",
      "childname": " Kalaiyah G Spencer "
    }
    ]')
,updatedby = 'CDM-24219'
,updatedon = now()
where submissionid ='62b1de69c5455c001bc20c6d';