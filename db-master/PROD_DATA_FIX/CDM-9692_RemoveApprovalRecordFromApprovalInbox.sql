-- CDM-9692 - Remove approved record from approval inbox of the supervisor

insert into routing (eventcode , fromsecurityusersid , tosecurityusersid , teamid , fromroleid , toroleid , objectid , routingstatustypeid , activeflag , insertedby , insertedon , updatedby , updatedon , remarks , servicerequestnumber)
				values	('YTP','4b8d30e9-1b01-47cb-9cdf-9308451bf98a','628da123-2ce7-4c64-b7b4-d9949fd8c23a','13021883-e81b-49f1-8556-4e048236e271','CWSP', 'CWCW','ebf143d2-5670-4786-97b7-20d2d00072e9', 16, 1, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), null,3267524);
update routing set activeflag = 0, updatedon = now(), remarks = 'Service plan  Approved' where routingid = '19fc720b-b007-4f2b-b3e1-765fad95b050' and activeflag = 1 and routingstatustypeid = 15;
