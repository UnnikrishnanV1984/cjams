-- CDM-37450 - Case Closure
/*
-- Issue Description: 
   Dashboard:User is unable to submit case for closure. The Add button is not populating .
            CJAMS # 3124224 Screen
-- Case ID: 3124224

-- Category/ Module: Assignments
-- Root cause: UUser is unable to submit case for closure. The Add button is not populating .
            CJAMS # 3124224 Screen
-- Fix Provided: Promoted a datafix to soft delete record in servicedispositioncase table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select *from servicecasedisposition
where servicecasedispositionid='5760164b-c223-404a-aef1-3a9a62463f5e'
and activeflag=1;



update servicecasedisposition
set activeflag=0,
    updatedby = 'CDM-37450',
    updatedon = now()
where servicecasedispositionid = '5760164b-c223-404a-aef1-3a9a62463f5e'
and activeflag=1;


select * from routing
where objectid = '5760164b-c223-404a-aef1-3a9a62463f5e'
and activeflag = 1;

update routing 
set activeflag=0,
    updatedby = 'CDM-37450',
    updatedon = now()
where objectid = '5760164b-c223-404a-aef1-3a9a62463f5e'
and activeflag=1;