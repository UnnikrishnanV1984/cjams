--Hot Fix for Provider Maltreatment Values mapping issues datafix

--CDM-38412
select * from intakeservicerequest where servicerequestnumber = '241021918736';
select * from investigation where intakeserviceid = 'a88df97f-3e6e-46a1-9076-ebdba1cabdae' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='7e7d8042-aa60-492c-97b9-1b73f4fd4bb0';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38412',
updatedon=now()
WHERE investigationid='7e7d8042-aa60-492c-97b9-1b73f4fd4bb0';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38412'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='7e7d8042-aa60-492c-97b9-1b73f4fd4bb0' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38433
select * from intakeservicerequest where servicerequestnumber = '241021934791';
select * from investigation where intakeserviceid = 'bc8c559d-bb49-4c11-805f-20e423449082' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='1e8d4e47-47bc-4c78-be64-6c24d818f62b';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38433',
updatedon=now()
WHERE investigationid='1e8d4e47-47bc-4c78-be64-6c24d818f62b';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38433'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='1e8d4e47-47bc-4c78-be64-6c24d818f62b' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38465
select * from intakeservicerequest where servicerequestnumber = '241021909277';
select * from investigation where intakeserviceid = '7836a4cd-c888-46e0-9319-1b848bd1bed9' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='4e9e7389-732e-415a-ac0a-b04bf0073a8c';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38465',
updatedon=now()
WHERE investigationid='4e9e7389-732e-415a-ac0a-b04bf0073a8c';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38465'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='4e9e7389-732e-415a-ac0a-b04bf0073a8c' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38473
select * from intakeservicerequest where servicerequestnumber = '241021912215';
select * from investigation where intakeserviceid = '750d7e93-43c5-4dd9-a85c-8dc935513bba' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='3a96c577-6f19-43ef-8b72-9814a7089147';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38473',
updatedon=now()
WHERE investigationid='3a96c577-6f19-43ef-8b72-9814a7089147';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38473'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='3a96c577-6f19-43ef-8b72-9814a7089147' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38474
select * from intakeservicerequest where servicerequestnumber = '241021924096';
select * from investigation where intakeserviceid = 'c9e943b1-bef0-4ea9-9b37-c19e37839be8' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='81a5c789-f7ed-4aa9-9cf8-a973678149d2';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38474',
updatedon=now()
WHERE investigationid='81a5c789-f7ed-4aa9-9cf8-a973678149d2';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38474'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='81a5c789-f7ed-4aa9-9cf8-a973678149d2' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38479
select * from intakeservicerequest where servicerequestnumber = '241021923552';
select * from investigation where intakeserviceid = 'e9c3d34c-7d15-43a2-bdc3-199a6040948e' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='943d18f5-48ca-4bc9-b3c0-60344a7a3ba8';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38479',
updatedon=now()
WHERE investigationid='943d18f5-48ca-4bc9-b3c0-60344a7a3ba8';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38479'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='943d18f5-48ca-4bc9-b3c0-60344a7a3ba8' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38501
select * from intakeservicerequest where servicerequestnumber = '241021924214';
select * from investigation where intakeserviceid = '5459499f-453d-43bd-af8a-29cb674c93e6' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='caf3fac3-6ec6-4ed5-975f-e639e47978ef';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38501',
updatedon=now()
WHERE investigationid='caf3fac3-6ec6-4ed5-975f-e639e47978ef';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38501'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='caf3fac3-6ec6-4ed5-975f-e639e47978ef' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38513
select * from intakeservicerequest where servicerequestnumber = '241021931062';
select * from investigation where intakeserviceid = 'b326f6e3-9d20-42c5-a0a6-614c32ae8d08' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='f2ab57fc-9a18-4a99-894a-aba88d4d27ad';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38513',
updatedon=now()
WHERE investigationid='f2ab57fc-9a18-4a99-894a-aba88d4d27ad';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38513'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='f2ab57fc-9a18-4a99-894a-aba88d4d27ad' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38518
select * from intakeservicerequest where servicerequestnumber = '241021913752';
select * from investigation where intakeserviceid = 'f2eec7d2-342a-4fca-a8f6-c0ade75a8bbe' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='e090dd70-eca9-431c-8213-12cf1bafa34d';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38518',
updatedon=now()
WHERE investigationid='e090dd70-eca9-431c-8213-12cf1bafa34d';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38518'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='e090dd70-eca9-431c-8213-12cf1bafa34d' and 
	im.maltreatmentid = improviderswitchinfo.objectid;
	
--CDM-38523    
select * from intakeservicerequest where servicerequestnumber = '241021934208';
select * from investigation where intakeserviceid = 'b81bfe47-4f82-49fe-b9f0-fcb38beb0df3' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='0608f30c-466f-4969-9d26-4a0b2af891f4';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38523',
updatedon=now()
WHERE investigationid='0608f30c-466f-4969-9d26-4a0b2af891f4';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38523'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='0608f30c-466f-4969-9d26-4a0b2af891f4' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38548
select * from intakeservicerequest where servicerequestnumber = '241021927374';
select * from investigation where intakeserviceid = '80ed5cae-bdb2-4286-a6bc-a097c2a6256e' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='e1dae122-aa08-46f5-b827-469fdeaaafe5';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38548',
updatedon=now()
WHERE investigationid='e1dae122-aa08-46f5-b827-469fdeaaafe5'; 
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38548'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='e1dae122-aa08-46f5-b827-469fdeaaafe5' and 
	im.maltreatmentid = improviderswitchinfo.objectid; 

--CDM-38549
select * from intakeservicerequest where servicerequestnumber = '241021931345';
select * from investigation where intakeserviceid = 'ad061b77-03b1-4209-a310-1f66a9568926' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='7cfe9a6a-a0b6-4754-9b34-c69cce0c43ce';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38549',
updatedon=now()
WHERE investigationid='7cfe9a6a-a0b6-4754-9b34-c69cce0c43ce';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38549'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='7cfe9a6a-a0b6-4754-9b34-c69cce0c43ce' and 
	im.maltreatmentid = improviderswitchinfo.objectid; 

--CDM-38550
select * from intakeservicerequest where servicerequestnumber = '241021923429';
select * from investigation where intakeserviceid = '604f12a4-d8e1-4b56-986a-999a4aac4983' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='4917ff7c-2f73-447f-a22b-fcba9ae95fed';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38550',
updatedon=now()
WHERE investigationid='4917ff7c-2f73-447f-a22b-fcba9ae95fed';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38550'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='4917ff7c-2f73-447f-a22b-fcba9ae95fed' and 
	im.maltreatmentid = improviderswitchinfo.objectid;
    
--CDM-38553    
select * from intakeservicerequest where servicerequestnumber = '241021937995';
select * from investigation where intakeserviceid = 'b53f6eeb-a3d2-49f9-b1a5-a2cae063d4d0' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='e477bff0-aef7-41b8-90d0-370b6a1b7ebf';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38553',
updatedon=now()
WHERE investigationid='e477bff0-aef7-41b8-90d0-370b6a1b7ebf';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38553'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='e477bff0-aef7-41b8-90d0-370b6a1b7ebf' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38558
select * from intakeservicerequest where servicerequestnumber = '241021923610';
select * from investigation where intakeserviceid = '3283f4c6-e2b3-428d-bbfa-685c31d9d06d' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='0202f640-f67f-4f83-ab87-d935b5537cab';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38558',
updatedon=now()
WHERE investigationid='0202f640-f67f-4f83-ab87-d935b5537cab';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38558'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='0202f640-f67f-4f83-ab87-d935b5537cab' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38560
select * from intakeservicerequest where servicerequestnumber = '241021923494';
select * from investigation where intakeserviceid = '4fffc9b6-6da6-4daf-81d5-2fe50521230b' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='d136f3c6-da9d-4680-bfd0-9a7e15713ea7';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38560',
updatedon=now()
WHERE investigationid='d136f3c6-da9d-4680-bfd0-9a7e15713ea7';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38560'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='d136f3c6-da9d-4680-bfd0-9a7e15713ea7' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38565
select * from intakeservicerequest where servicerequestnumber = '241021940579';
select * from investigation where intakeserviceid = '68806829-634f-4dbb-9e63-d7452221968d' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='9ae9e7db-bc45-4938-ac19-e1453dd4ee1e';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38565',
updatedon=now()
WHERE investigationid='9ae9e7db-bc45-4938-ac19-e1453dd4ee1e';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38565'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='9ae9e7db-bc45-4938-ac19-e1453dd4ee1e' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38569
select * from intakeservicerequest where servicerequestnumber = '241021860368';
select * from investigation where intakeserviceid = '8039617d-4b2d-48fe-b267-8dd497606e13' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='ba78d3a0-c3d0-4b4d-a3b7-4a48cee7d679';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38569',
updatedon=now()
WHERE investigationid='ba78d3a0-c3d0-4b4d-a3b7-4a48cee7d679';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38569'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='ba78d3a0-c3d0-4b4d-a3b7-4a48cee7d679' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38570
select * from intakeservicerequest where servicerequestnumber = '241021933723';
select * from investigation where intakeserviceid = 'ef4b8f1e-87fd-4965-97c3-245d56094b61' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='e10c3c17-1452-4694-8b23-3faec7f3bb7f';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38570',
updatedon=now()
WHERE investigationid='e10c3c17-1452-4694-8b23-3faec7f3bb7f';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38570'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='e10c3c17-1452-4694-8b23-3faec7f3bb7f' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38574
select * from intakeservicerequest where servicerequestnumber = '241021898306';
select * from investigation where intakeserviceid = 'dde7baab-810d-467d-96d5-0e8c4aeb958e' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='b1470fd0-5b41-40b9-8217-bcbc29297183';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38574',
updatedon=now()
WHERE investigationid='b1470fd0-5b41-40b9-8217-bcbc29297183';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38574'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='b1470fd0-5b41-40b9-8217-bcbc29297183' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38575
select * from intakeservicerequest where servicerequestnumber = '241021915033';
select * from investigation where intakeserviceid = 'bf4474c5-b4aa-427b-82d3-5e609c92a798' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='ca83eac3-46fd-4fd8-b4db-6bccdaa8b8cf';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38575',
updatedon=now()
WHERE investigationid='ca83eac3-46fd-4fd8-b4db-6bccdaa8b8cf';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38575'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='ca83eac3-46fd-4fd8-b4db-6bccdaa8b8cf' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

--CDM-38571
select * from intakeservicerequest where servicerequestnumber = '241021926325';
select * from investigation where intakeserviceid = 'eb0b2f1f-4a09-4dbd-9283-3b615b036d28' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='8440dca4-cec6-41f9-afae-09184bd41056';
UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38571',
updatedon=now()
WHERE investigationid='8440dca4-cec6-41f9-afae-09184bd41056';
update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38571'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='8440dca4-cec6-41f9-afae-09184bd41056' and 
	im.maltreatmentid = improviderswitchinfo.objectid;


	--CDM-38599
select * from intakeservicerequest where servicerequestnumber = '241021976585';
select * from investigation where intakeserviceid = '5340d81a-b059-4de6-b16c-ebcc0f9c1df6' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='91460716-962b-46e5-9667-1441fe3d0b8d';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38599',
updatedon=now()
WHERE investigationid='91460716-962b-46e5-9667-1441fe3d0b8d';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38599'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='91460716-962b-46e5-9667-1441fe3d0b8d' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

	--CDM-38603
select * from intakeservicerequest where servicerequestnumber = '241021913419';
select * from investigation where intakeserviceid = '8acf52de-27f3-4ddd-bb7f-56933e687990' and activeflag=1;
select isproviderinvolved ,* from investigationallegation where investigationid ='7aaf1e47-6c17-4801-b186-3959cdde28ba';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CDM-38603',
updatedon=now()
WHERE investigationid='7aaf1e47-6c17-4801-b186-3959cdde28ba';

update improviderswitchinfo 
set
	activeflag=0,
	updatedon = now(),
	updatedby = 'CDM-38603'
	from 
	investigation inv 
	join Investigationmaltreatment im on im.investigationid = inv.investigationid 
	where inv.investigationid ='7aaf1e47-6c17-4801-b186-3959cdde28ba' and 
	im.maltreatmentid = improviderswitchinfo.objectid;

