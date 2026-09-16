-- CDM-26255 - approval error
/*
-- Issue Description: 
   User wants to remove the case# 3247795 in Case Pending Approval tab. Disclosure Review is already in Approved Status under GAP 
   but still Case# 3247795 is showing in Case Pending Approval

-- Resolution: For some or the other reason with a 1sec gap two records where created in Routing table 
where servicerequestnumber='3247795' and eventcode= 'GADR' and routingstatustypeid= '15' -- objectid a6a5f9ea-72fc-4a42-b8b4-d819f80231b8, 99f27fee-3c70-4929-9bda-b37bbd23052b

So we have two records in gapdisclosure table with objectids that we got from routing table. 
As one case is already approved, modified the flag value in routing table and gapdisclosure for the pending case.

-- Case ID: 3247795 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update routing set activeflag = 0,updatedby = 'CDM-26255', updatedon = now()
where routingid = '07341e5d-1960-4ba5-9857-13b5cd8806bc' and activeflag = 1;

update gapdisclosure set activeflag = 0,updatedby = 'CDM-26255', updatedon = now()
where gapdisclosureid='a6a5f9ea-72fc-4a42-b8b4-d819f80231b8' and activeflag = 1;