/*  Issue Description:CJAMS-66061-education
  Root cause: 
  Fix provided : 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update youthtransitionplan 
SET new_education_json  = '{"goals":[],"isGED":null,"notes":null,"aidDDA":null,"aidDORS":null,"details":[],"isOther":null,"eduGoals":null,"aidOthers":null,"esoloresl":"0","gpaGrades":null,"otherDesc":null,"appliedETV":null,"currentUse":"0","eduActions":[],"highSchool":true,"othercheck":null,"iepSupports":"1","isCompleted":false,"loggedHours":null,"aidotherDesc":null,"appliedFAFSA":true,"future_goals":"Enroll into a secondary education program. ","completionDate":null,"other_edu_desc":null,"othercheckdesc":null,"supportServices":"0","alternateProgram":null,"lastgradetypekey":"NIS","mostRecentSchool":"Not Enrolled ","appliedFosterCare":null,"appliedInternship":null,"interestMeetingDt":null,"progressForOthers":null,"current_edu_status":"3","gradcompletionDate":null,"postSecondaryGoals":null,"transitionServices":null,"appliedSchoolarship":null,"attendingJobProgram":"0","attendingMoreSchool":"1","alternateProgramName":null,"appliedOtherPrograms":null,"incentivePaymentDate":null,"attendingVocationalSchool":"0"}'::jsonb, updatedon =now(), updatedby ='CJAMS-66061'
where youthtransitionplanid ='a7250c3c-0bec-4711-9cd1-4886f89ae3f3';