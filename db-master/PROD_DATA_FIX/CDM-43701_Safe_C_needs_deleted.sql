/*
Issue Description:CDM-43701: could you please delete a safe-c from the system that was already approved. I made an error in it. 251022973805SAFE-CWragg, Sophie01/08/2025 - 10:47 AMApproved
Category/Module: Assessments: SAFE-C
Root cause: User Error.
Fix provided: Data fix has been done to delete the safe-c in review state from supervisor dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select activeflag,* from assessment where assessmentid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

update assessment
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where objectid='8cc5444e-0ec2-436f-bcc1-0ca611d01258' 
and activeflag =1 
and assessmentid='617138f6-4f44-4a7d-8232-4eb155ee04d0';

/*
select activeflag,* from assessmentactor where assessmentid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

update assessmentactor
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where assessmentid='617138f6-4f44-4a7d-8232-4eb155ee04d0'
and activeflag =1;

/*
select activeflag,* from assessmentcomments where assessmentid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

update assessmentcomments
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where assessmentid='617138f6-4f44-4a7d-8232-4eb155ee04d0'
and activeflag =1;

/*
select activeflag,* from assessment_history where assessmentid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

update assessment_history
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where assessmentid='617138f6-4f44-4a7d-8232-4eb155ee04d0'
and activeflag =1;

/*
select activeflag,* from assessmentsubmission where assessmentid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

/*
update assessmentsubmission
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where assessmentid='617138f6-4f44-4a7d-8232-4eb155ee04d0'
and activeflag =1;
*/

/*
select activeflag,updatedon,* from routing where objectid = '617138f6-4f44-4a7d-8232-4eb155ee04d0';
*/

update routing
set activeflag = 0,
    updatedby = 'CDM-43701',
    updatedon = now()    
where objectid='617138f6-4f44-4a7d-8232-4eb155ee04d0'
and activeflag =1;

/*select * from routingstatustype where sequencenumber = 4;*/
