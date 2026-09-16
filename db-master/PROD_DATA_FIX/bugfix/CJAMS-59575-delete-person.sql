/*
Issue Description:251023047654:Please remove the following Client from case CPS-IR 251023047654.
This Client was entered in error at Intake.Regina ToussaintCJAMS PID# 204132637CIS ID# 574072646D.O.B. 0101/1989 
Root cause: User error
Fix provided: Data fix has been done to by removing the client
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
*/


update intakeservicerequestactor 
set activeflag = 0, updatedby='CJAMS-59575', updatedon= now()
where intakeserviceid = '4ea1a736-0bbe-4e93-b4fe-ce608f855b64' and actorid = '67b3bfcc-9236-4fd9-b783-0f61d25aa4dc';

-- select * from actor a where intakeserviceid = '4ea1a736-0bbe-4e93-b4fe-ce608f855b64' and actorid = '67b3bfcc-9236-4fd9-b783-0f61d25aa4dc';

update actor
set activeflag =0, updatedby='CJAMS-59575', updatedon= now()
where intakeserviceid = '4ea1a736-0bbe-4e93-b4fe-ce608f855b64' and actorid = '67b3bfcc-9236-4fd9-b783-0f61d25aa4dc';

-- select * from personrole where personroleid = 'b947de2a-e563-4ab7-8ed4-823292e63182' and personid ='99905e38-2103-4d72-b7f5-1cc08cd86b45';

update personrole 
set activeflag =0, updatedby='CJAMS-59575', updatedon= now()
where personroleid = 'b947de2a-e563-4ab7-8ed4-823292e63182' and personid ='99905e38-2103-4d72-b7f5-1cc08cd86b45';

-- select * from personprogramarea where personid ='99905e38-2103-4d72-b7f5-1cc08cd86b45' and personprogramid ='9ccf0a71-1a70-4546-b358-4a0cb347fd7a';

update personprogramarea
set activeflag =0, updatedby='CJAMS-59575', updatedon= now()
where personid ='99905e38-2103-4d72-b7f5-1cc08cd86b45' and personprogramid ='9ccf0a71-1a70-4546-b358-4a0cb347fd7a';

-- select * from personroletype where personroleid ='b947de2a-e563-4ab7-8ed4-823292e63182';

update personroletype
set activeflag =0, updatedby='CJAMS-59575', updatedon= now()
where personroleid ='b947de2a-e563-4ab7-8ed4-823292e63182';