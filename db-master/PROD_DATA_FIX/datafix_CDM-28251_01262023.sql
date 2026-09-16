-- CDM-28251 - Permanency Approval not needed, but in approval box
/*
-- Issue Description: 
   3216031:A request to approve permanency is showing in my supervisory inbox,
   but when I open the permanency tab it shows that all permanency plans are approved.

    
    remove the Permanency plan review request (case # 3216031) from the
     pending approval dashboard.


-- Category/ Module: Child Removal - Removal Tab
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select activeflag,* from routing where objectid = '26e209df-80a4-4216-82d6-4df6b23902e3' and routingid = '8c61ac14-c3e2-4fc6-b6b5-f0c165b00a23';


update routing set activeflag =0,updatedby = 'CDM-28251',updatedon = now() where  objectid = '26e209df-80a4-4216-82d6-4df6b23902e3' and routingid = '8c61ac14-c3e2-4fc6-b6b5-f0c165b00a23';