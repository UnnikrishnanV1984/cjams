
/*
   Issue Description: CDM-24167
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- Cheked these 2 records there is no review stauts records found all are approved or in draft status 

--  Updatedby                             Routingid                             Updatedon
-- c1ea8af6-cf9f-4dc1-9576-44071aab64c3  3ec3f484-86d5-4be7-8e2d-f09f355576ba  2022-08-01 16:10:32
-- 3a4952e2-0077-4fbb-9a20-f3d8d6e5ec47  686ec769-d9c3-4a12-a143-ef9bb3b640cd  2022-07-05 15:23:31


update cjams.routing set activeflag =0, updatedby ='CDM-24167', updatedon = now ()
where routingid in('3ec3f484-86d5-4be7-8e2d-f09f355576ba','686ec769-d9c3-4a12-a143-ef9bb3b640cd');

