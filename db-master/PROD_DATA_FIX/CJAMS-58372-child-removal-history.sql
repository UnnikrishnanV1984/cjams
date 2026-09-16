/*
   Issue Description: CJAMS-58372
   Category/ Module  : Decision
   Root cause: User request to delete duplicate record inserted to child removal history and person program area
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- select personid ,activeflag ,* from intakeservreqchildremoval i where personid ='75419e79-ba18-44ba-8cb4-b4b17a958d6d';

update intakeservreqchildremoval
set activeflag =0, updatedby ='CJAMS-58372', updatedon =now()
where intakeservreqchildremovalid = '07975dad-58c7-4e44-bf6b-7c364146080f';


-- select activeflag ,* from personprogramarea where personid ='75419e79-ba18-44ba-8cb4-b4b17a958d6d';

update personprogramarea
set activeflag =0, updatedby ='CJAMS-58372', updatedon =now()
where personprogramid = '677bb23e-3b8a-4756-9752-64fcb326e38c' and programkey ='OOH' and activeflag =1;

update routing
set activeflag =0, updatedby ='CJAMS-58372', updatedon =now()
where objectid = '07975dad-58c7-4e44-bf6b-7c364146080f' and activeflag = 1;

update intakeservreqchildremoval_history
set activeflag =0, updatedby ='CJAMS-58372', updatedon =now()
where intakeservreqchildremovalid = '07975dad-58c7-4e44-bf6b-7c364146080f' and activeflag = 1 ;