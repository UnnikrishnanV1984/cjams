/*
   Issue Description: CDM-20270 - CJAMS Error
   Case # 3267598 & # 2021061086624 (IR) needs to be removed from Approval Inbox / Case Pending Approval dashboard
   Category/ Module  : Approval Inbox
   Root cause: As per QA: Case # 3267598 & # 2021061086624 (IR) needs to be removed from Approval Inbox / Case Pending Approval dashboard

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

-- Case # 3267598
-- Not found in the approval inbox

-- 2021061086624 (IR)
 
select	activeflag, routingid, routingstatustypeid, tosecurityusersid, * 
from 	routing 
where 	objectid = '81115af5-db8f-4457-9391-e7ba26d74861' and tosecurityusersid = 'b567fa07-daef-4762-b877-079ccd874a11';

update 	routing
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-20270'
where 	routingid = 'f40dffa4-433e-4193-8bb5-d4e1ef967508' and activeflag = 1;


