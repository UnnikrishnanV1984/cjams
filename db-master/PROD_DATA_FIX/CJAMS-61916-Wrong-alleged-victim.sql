/*
   Issue Description: 251023084940:The wrong children are appearing as victim children. When the case was closed Jermih was an alleged victim and Dominic was not. 
   Now, Dominic is listed as victim child and Jermih is not. Appeal is active on the case. 
   Category/ Module  :  Role/ investigation findings
   Root cause: User Error, CPS IR # 251023084940 was closed on 08/05/2025 and connected to intake # I251013314873. Both children roles, Dominic J Lewis (PID# 204019267) and Jeremih M Lewis (PID# 204019268) are reflected the same.
    Dominic J Lewis - Child, Alleged Victim
    Jeremih M Lewis - Child
    here the AV role is added to Dominic in error.
   Fix: datafix done to update the correct role and to update the investigation findings and allegations
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

-- intake level

/*
select * from actor a where intakenumber = 'I251013314873';

fea2b07b-6d11-448b-8261-3b8d7462676f --Malachi	Lewis, Child 
38360e8a-b7f9-4a73-a0f7-ff6fbda72214 --Alma	Lewis ,AM
e8dfb195-eb2d-457c-9ea0-aa65b0569b17 --Jamil	Lewis, PARENT
15d472e7-ecd6-445f-a3c5-f6a80e6b4323 --Dominic	Lewis, child  e54fa27a-57e9-436e-a03c-b389023d793c
8df9bbd1-cfa8-432f-95bb-565275f8313a --A'Nayeli	Lewis, child
9a4c66a1-0101-4100-a7d0-044e76157d86 -- Jeremih	Lewis, child  6326b0b8-6ee6-4477-984a-edd27607f86e

select personid ,actorid ,* from intakeservicerequestactor i 
where actorid in ('e54fa27a-57e9-436e-a03c-b389023d793c','6326b0b8-6ee6-4477-984a-edd27607f86e')
*/

update intakeservicerequestactor 
set actorid = '6326b0b8-6ee6-4477-984a-edd27607f86e', --e54fa27a-57e9-436e-a03c-b389023d793c
	personid = '9a4c66a1-0101-4100-a7d0-044e76157d86',--15d472e7-ecd6-445f-a3c5-f6a80e6b4323
	updatedby = 'CJAMS-61916',
	updatedon = now()
where intakeservicerequestactorid = '44dfabe4-7c27-4a1e-939e-65e53f279580'
	and activeflag = 1;	

-- case level
/*
select * from actor a where intakeserviceid  = 'b1351b45-c5d8-4c85-989b-0ee769c6327a';

15d472e7-ecd6-445f-a3c5-f6a80e6b4323 --Dominic	Lewis, child  14888e8a-9e3c-4808-b7c8-8dabd3e688c6
9a4c66a1-0101-4100-a7d0-044e76157d86 -- Jeremih	Lewis, child  3b30d3d3-b199-40bc-9991-d36d05eeb4a4

select personid ,actorid ,* from intakeservicerequestactor i where actorid in ('14888e8a-9e3c-4808-b7c8-8dabd3e688c6','3b30d3d3-b199-40bc-9991-d36d05eeb4a4')
*/

update intakeservicerequestactor 
set actorid = '3b30d3d3-b199-40bc-9991-d36d05eeb4a4', --14888e8a-9e3c-4808-b7c8-8dabd3e688c6
	personid = '9a4c66a1-0101-4100-a7d0-044e76157d86',--15d472e7-ecd6-445f-a3c5-f6a80e6b4323
	updatedby = 'CJAMS-61916',
	updatedon = now()
where intakeservicerequestactorid = '6582d32c-044a-473a-83f4-46dffe98ed71'
	and activeflag = 1;

-- maltreatement allegation which updated the investigation finding too.
/*
select * from Investigationmaltreatment where investigationid = '4f17e965-8ae2-414b-a997-41f425fb8582';
select * from investigationallegation i where investigationid = '4f17e965-8ae2-414b-a997-41f425fb8582';
select * from investigationmaltreatmentactor i where maltreatmentid in ('e1a2a355-cef6-4615-af51-ba85e9f423e7',
'bb2ed131-09d1-4eb9-a40a-a97d2f9a34ce',
'6e9f8908-84e7-4041-8ca0-b1c9273598e0');
*/

update investigationmaltreatmentactor
set intakeservicerequestactorid = '603f4152-00ec-4160-aeda-26f03f0e6885',--7fad6ec0-789d-47af-abff-41eb9df4ec03
	updatedby = 'CJAMS-61916',
	updatedon = now()
where investigationmaltreatmentactorid = 'c86206f1-a59d-45b9-a78c-165889258cbd'
	and activeflag =1
	and maltreatmentid = '6e9f8908-84e7-4041-8ca0-b1c9273598e0';