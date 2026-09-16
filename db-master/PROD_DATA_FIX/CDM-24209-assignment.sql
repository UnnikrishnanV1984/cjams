/*
   Issue Description: CDM-24209
   Category/ Module  :  Assignment 
   Root cause: wrong unit name inserted 
   Pull request# for code fix: 
   Reason why no related code fix: Migration insertion issue 
*/


update cjams.caseassignment set toteamid ='70c5f926-488c-44ec-a363-29ab1c8bf749', updatedby ='CDM-24209', updatedon =now() where caseassignmentid ='aea97e3a-73d9-483e-b800-aa1581e2a02b';