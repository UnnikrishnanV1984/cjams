-- CDM-9680 - Remove approved record from approval inbox of the supervisor

insert into routing (eventcode , fromsecurityusersid , tosecurityusersid , teamid , fromroleid , toroleid , objectid , routingstatustypeid , activeflag , insertedby , insertedon , updatedby , updatedon , remarks , servicerequestnumber)
				values	('YTP','4b8d30e9-1b01-47cb-9cdf-9308451bf98a','d1c5ffcf-e5dd-44a4-ad27-5001457483aa','13021883-e81b-49f1-8556-4e048236e271','CWSP', 'CWCW','2eaac3eb-fb49-4607-a857-0d5c5041244a', 16, 1, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', now(), null,3116540);
update routing set activeflag = 0, updatedon = now(), remarks = 'Service plan  Approved' where routingid = '22625b47-d4f0-4de3-8247-210e61080911' and activeflag = 1;
