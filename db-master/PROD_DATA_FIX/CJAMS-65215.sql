

/*
-- Issue Description: CJAMS glitch caused two service cases (261030641262, 261030641258) to be opened in error. These service cases should be deleted.Related intakes - I261013891027, I261013891269. I261013891269 was entered after I261013891027 did not populate a service case at the time of approval due to CJAMS glitch. 
-- Category/ Module: Intake and Case Management
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to soft delete the intakedastaging, intakedastatus and routing records.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-65215',
    updatedon = now()
where intakenumber='I261013891027'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-65215',
    updatedon = now()
where intakenumber='I261013891027'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-65215',
    updatedon = now()
where objectid = 'I261013891027'
and activeflag = 1;

update servicecase set activeflag=0,updatedby = 'CJAMS-65215',
        updatedon = now() where servicecaseid in ('9d19a0d2-908e-4b6d-b486-521a6aa5424e','4024cabd-dafd-4f6c-8a28-e5e6eb171c7f') and activeflag = 1;

update servicecasedisposition set activeflag=0, updatedby = 'CJAMS-65215',
        updatedon = now() where servicecaseid in ('9d19a0d2-908e-4b6d-b486-521a6aa5424e','4024cabd-dafd-4f6c-8a28-e5e6eb171c7f') and activeflag = 1;

update servicecaserequest set activeflag=0,updatedby = 'CJAMS-65215',
        updatedon = now()  where servicecaseid in ('9d19a0d2-908e-4b6d-b486-521a6aa5424e','4024cabd-dafd-4f6c-8a28-e5e6eb171c7f') and activeflag = 1;

update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-65215',
        updatedon = now()
    where objectid in ('9d19a0d2-908e-4b6d-b486-521a6aa5424e','4024cabd-dafd-4f6c-8a28-e5e6eb171c7f')
    and activeflag = 1;

    
update routing 
    set activeflag = 0,
        updatedby = 'CJAMS-65215',
        updatedon = now()
    where objectid in ('9d19a0d2-908e-4b6d-b486-521a6aa5424e','4024cabd-dafd-4f6c-8a28-e5e6eb171c7f')
    and activeflag = 1;