/*
   Issue Description: CDM-17300
   Category/ Module  : pending approvals
   Root cause: user wants to remove pending approvals
   Pull request# for code fix: 
  explanantion: user wants to delete the pending approvals which are already approved
*/

update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-19076'
where (objectid, routingid)  in 
(('9f38dbdd-a36f-49a7-b4d7-fa708afbbdcb', 'dca18f35-1403-42f4-a45f-ed50fabbaf78'), 
('de3d9d5b-640b-4f77-bc95-15bad6d5be8c', '17bca6af-426a-4cce-bacb-d84386c7b92a'),
('5984e166-d4f3-41b9-8b50-15311096c694', '793898b8-f8bf-45b4-a913-2b17f1cfbd68'), 
('62ce7410-0269-42af-a6cf-75c47d02e471','8dd6b0ba-7eb9-41d3-b9f6-2c0bef0f1273'),
('c6ff3735-9003-4e3e-a940-351a655ca120','7132be04-c987-47af-8fd7-d33e94e69f35'));
