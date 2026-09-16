/*
   Issue Description: CDM-27414
   Category/ Module  : remove end date 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- Datafix to re-open the Placement
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '45dd004a-b2f7-4cc7-a28c-4a65ab71d38c'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-27414'
where placementid = '45dd004a-b2f7-4cc7-a28c-4a65ab71d38c'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '45dd004a-b2f7-4cc7-a28c-4a65ab71d38c'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-27414'
where placementid = '45dd004a-b2f7-4cc7-a28c-4a65ab71d38c'
	and ( exitdate is not null or exittime is not null ) ;
	

update
	intakeservreqchildremoval
set
	exitdate = Null,
	updatedby = 'CDM-27414',
	updatedon = now()
where
	intakeservreqchildremovalid = '249a09d2-1fd3-4649-a2ce-147f1b8afa95';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-27414',
   update_ts = now()
where
   removal_id = '194913';


update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-27414',
   updatedon = now()
where
   personprogramid = 'a11444fc-da9f-4410-8108-89d385a84183';



/*
select * from placement p where placementid = '45dd004a-b2f7-4cc7-a28c-4a65ab71d38c'
select exitdate,  * from intakeservreqchildremoval where intakeservreqchildremovalid = '249a09d2-1fd3-4649-a2ce-147f1b8afa95'
select * FROM tb_client_eligibility tce where removal_id = '194913'
select  programkey, * from personprogramarea p where personid = '3d9120e1-0f02-4bfe-a5da-a300dc04781b' orderby programkey 
person programid = a11444fc-da9f-4410-8108-89d385a84183
*/
