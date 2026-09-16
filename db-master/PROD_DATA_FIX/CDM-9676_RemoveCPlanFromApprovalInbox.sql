-- CDM- 9676 - Remove the case plan review from the approval inbox as it is already approved

insert into routing (eventcode , fromsecurityusersid , tosecurityusersid , teamid , fromroleid , toroleid , objectid , routingstatustypeid , activeflag , insertedby , insertedon , updatedby , updatedon , remarks , servicerequestnumber)
				values	('CPLAN2','4b8d30e9-1b01-47cb-9cdf-9308451bf98a','f5547748-27d9-477a-9b2c-5eae73d102ab','13021883-e81b-49f1-8556-4e048236e271','CWSP', 'CWCW','6c1ec5bb-1918-41b7-8f0d-8fb588aa83c9', 16, 1, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), null,3003543);
update routing set activeflag = 0, updatedon = now(), remarks = 'Case plan Approved' where routingid = '28a2b096-48f3-4e1e-a84a-86eb529c3ec6' and activeflag = 1 and routingstatustypeid = 15;
