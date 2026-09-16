/*
   Issue Description: CDM-32748
   Category/ Module  :Assessment
   Root cause: user requested to add missing child to safe-c assessment
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{childdatagrid}', '[
    {
      "age": "8 Yrs",
      "clientid": "4490116",
      "childname": "MADISON  BULLOCK"
    },
    {
      "age": "15 Yrs",
      "clientid": "4490113",
      "childname": "JEYLIN  BULLOCK"
    }
  ]') ,updatedby ='CDM-32748', updatedon =now()
WHERE assessmentid = '6e4799b9-8ceb-4431-bfbe-71568f6eff42';


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{all_childs_json}', '[
    {
      "age": "8 Yrs",
      "name": "MADISON  BULLOCK",
      "cjamspid": "4490116"
    },
    {
      "age": "15 Yrs",
      "name": "JEYLIN  BULLOCK",
      "cjamspid": "4490113"
    }
  ]') ,updatedby ='CDM-32748', updatedon =now()
WHERE assessmentid = '6e4799b9-8ceb-4431-bfbe-71568f6eff42';

