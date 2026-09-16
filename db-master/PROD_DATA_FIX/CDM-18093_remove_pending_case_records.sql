/*
   Issue Description: CDM-18093
   Category/ Module  : Approval Inbox
   Root cause: User reported approved case is displayed under case pending approval dashboard
   Pull request# for code fix: 4197
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from routing where objectid = 1801005 and routingid in (
'166d024d-f273-4629-b1e2-5f6572f4f759',
'a2a8a3e9-9814-4b18-8ca0-d605c040a74b',
'0dfdc915-d644-4648-98e9-f46dbda843b6',
'2d18683d-62f3-41db-9094-93a631137a0a',
'fea6c234-4aea-4581-9e72-99c6235b5385',
'019a6d65-5710-4705-a209-94603fe48b7d',
'05882c0e-2fcc-4bca-8abc-7a10dfcb656d',
'8b974304-a633-488c-aed4-5d100ab57770');


delete routing where objectid = 1801005 and routingid in (
'166d024d-f273-4629-b1e2-5f6572f4f759',
'a2a8a3e9-9814-4b18-8ca0-d605c040a74b',
'0dfdc915-d644-4648-98e9-f46dbda843b6',
'2d18683d-62f3-41db-9094-93a631137a0a',
'fea6c234-4aea-4581-9e72-99c6235b5385',
'019a6d65-5710-4705-a209-94603fe48b7d',
'05882c0e-2fcc-4bca-8abc-7a10dfcb656d',
'8b974304-a633-488c-aed4-5d100ab57770');