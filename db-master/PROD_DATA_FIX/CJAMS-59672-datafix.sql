-- CJAMS-59672 Erroneously Created Client

/*
-- Issue Description: 
	The following Client was created in error and should be removed from Case # 251023054983 and 
     deleted from CJAMS.Jeyanah MillerCJAMS PID# 204139866CIS ID# 526071727

-- Category/ Module: Persons
-- Root cause: :The following Client was created in error and should be removed from Case # 251023054983 and 
                 deleted from CJAMS.Jeyanah MillerCJAMS PID# 204139866CIS ID# 526071727
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea
set activeflag = 0,
    updatedby = 'CJAMS-59672',
    updatedon = now()
where personid = '1e80de3b-f8b0-4f75-871e-751f32431882'
    and objectid = '1a690801-db77-42c5-bd3a-7f222f889fec' 
    and activeflag = 1 ;

    update personrole
set activeflag = 0,
    updatedby = 'CJAMS-59672',
    updatedon = now()
where personid = '1e80de3b-f8b0-4f75-871e-751f32431882'
    and activeflag = 1 ;

   update actor
set activeflag = 0,
    updatedby = 'CJAMS-59672',
    updatedon = now()
where personid = '1e80de3b-f8b0-4f75-871e-751f32431882'
    and activeflag = 1 ;

    update intakeservicerequestactor
set activeflag = 0,
    updatedby = 'CJAMS-59672',
    updatedon = now()
where personid = '1e80de3b-f8b0-4f75-871e-751f32431882'
    and activeflag = 1 ;

    update personroletype 
        set  activeflag = 0,
             updatedby = 'CJAMS-59672',
             updatedon = now()
        where personroleid in (select
            personroleid
        from
            personrole
        where
            personid = '1e80de3b-f8b0-4f75-871e-751f32431882');

update actorrelationship    
   set activeflag = 0,
       updatedby = 'CJAMS-59672',
       updatedon = now()
   where intakeservicerequestactorid
    in ( select intakeservicerequestactorid
            from intakeservicerequestactor
        where personid = '1e80de3b-f8b0-4f75-871e-751f32431882'
    and intakeserviceid  = '1a690801-db77-42c5-bd3a-7f222f889fec'
    and actorrelationshipid = '36f7a68b-249f-47d6-ad29-47e88f063827')
    and activeflag = 1 ;

update intakeservicerequestactor 
   set intakenumber = 'I251013283808',
       updatedby = 'CJAMS-58096', 
	   updatedon = now() 
where personid = '6f21b280-acd3-4d24-8069-4d9d0a4b42be'
    and intakeserviceid = '1a690801-db77-42c5-bd3a-7f222f889fec' 
	and activeflag = 1;