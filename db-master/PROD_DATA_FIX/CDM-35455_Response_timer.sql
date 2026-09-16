-- CDM-35455 - Response timer
/*
 -- Issue Description: In case 231021278299;
 -- Category/ Module: case worker > case > Overdue worker statement
 -- Root cause: Incorrect entry.
 -- Fix Provided: Datafix has been added with the given narrative.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
update
    cpsresponsetimeractions
set
    caseworkercomments = 'Worker has two previous cases with this family and received multiple fyi''s on this family. Worker has seen all the children in Mr. Seymour''s home on 10/13/23 including baby Ashlyn who was born on 10/5/2023. This worker met with the other children (the victims) at the safe place within the expected timeframe (Emmett, Isabella and Robert). Unfortunately this worker was unable to see the other child (baby Ashlyn) within the expected timeframe of this case. Baby Ashlyn was seen again on 10/31/23.'
where
    intakeserviceid = '3bd295a3-e220-4c89-b470-c46e733728c2'
    and cpsresponsetimeractionsid = '3abb2043-6189-49fb-8704-f9ca99396601';