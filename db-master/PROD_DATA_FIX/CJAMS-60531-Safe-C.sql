/*
Issue Description:251030531512:Worker was misled about which children she saw. Please un-approve the Safe-C so that it can be edited to accurately reflect the child who was seen. 
Root cause: User request to delete  SAFE-C assessment dated 07/08/2025.
Fix provided: DB queries  update enddate assessment,assessment_history tables
Data/Code fix ticket#: CJAMS-60531
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update assessment
set activeflag = 0,updatedby = 'CJAMS-60531',updatedon = now()
where assessmentid = '440b055a-8193-49c9-a880-3f6b4b873252' and activeflag =1;


update assessment_history
set activeflag = 0,updatedby = 'CJAMS-60531',updatedon = now()
where assessmenthistoryid in ('432555e2-412c-4d5a-91ba-260aea23f1f7','bcddba66-9c84-44be-a618-84059c9b3d01') and activeflag =1;


update assessmentactor
set activeflag = 0,updatedby = 'CJAMS-60531',updatedon = now()
where assessmentactorid in ('96430249-3348-4867-884f-3d3f323c6cec','e88643e2-ca48-43e6-aa24-b138cb54afb8') and activeflag =1;



update assessmentcomments
set activeflag = 0,updatedby = 'CJAMS-60531',updatedon = now()
where assessmentcommentsid in ('850af6de-8b15-4015-a759-6cc02f1efe9d') and activeflag =1;



update routing
set activeflag = 0,updatedby = 'CJAMS-60531',updatedon = now()
where routingid = '268421e6-c5ff-4fec-921b-185389d73816' and activeflag =1 and eventcode = 'ASST';
