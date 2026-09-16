/* 
    Issue Description: CDM-38921
   Category/ Module  : investigation-findings
   Root cause: Dashboard:Change the wording under action from Physical abuse is unsubstantiated to Physical abuse is indicated. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE cjams.investigationfinding
SET findingcomments = replace(findingcomments, 'unsubstantiated', 'Indicated'),
updatedby='CDM-38921',
updatedon=now()
WHERE investigationfindingid='17dbb0aa-3919-4673-86de-ec7b82188dd0';