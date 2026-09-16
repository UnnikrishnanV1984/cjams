/*
   Issue Description: CDM-15914
   Category/ Module  : Multiple approvals
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
 
*/


update placement
	set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
	where placementid in (
	'd77b874f-0871-4818-b451-8c8a05879e2c', 
	'c96f5a21-e565-428c-a573-d5f63bb4c02e', 
	'55d3ee54-fd1c-4281-bc78-c7f85165e1f6', 
	'eb8d66b8-6e1a-4cd3-940f-4f0f268893d1', 
	'7b9ae5e3-b1a3-4459-8a10-658be90e12ec',
	'fb455959-7fff-4d44-8568-fac07401fcf9');

	update livingarrangement 
	set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
	where placementid in (
	'd77b874f-0871-4818-b451-8c8a05879e2c', 
	'c96f5a21-e565-428c-a573-d5f63bb4c02e', 
	'55d3ee54-fd1c-4281-bc78-c7f85165e1f6', 
	'eb8d66b8-6e1a-4cd3-940f-4f0f268893d1', 
	'7b9ae5e3-b1a3-4459-8a10-658be90e12ec',
	'fb455959-7fff-4d44-8568-fac07401fcf9');

	update routing 
	set updatedby = 'CDM-15914', updatedon = now(), activeflag = 0
	where objectid in (
	'd77b874f-0871-4818-b451-8c8a05879e2c', 
	'c96f5a21-e565-428c-a573-d5f63bb4c02e', 
	'55d3ee54-fd1c-4281-bc78-c7f85165e1f6', 
	'eb8d66b8-6e1a-4cd3-940f-4f0f268893d1', 
	'7b9ae5e3-b1a3-4459-8a10-658be90e12ec',
	'fb455959-7fff-4d44-8568-fac07401fcf9');