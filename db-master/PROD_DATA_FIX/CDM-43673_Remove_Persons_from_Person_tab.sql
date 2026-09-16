/*
   Issue Description: CDM-43673
   SSA approved on 01/28/2025 and please proceed with the data fix to remove the following person from the case # 241022952319
    1. CJAMS PID# : 204026039
    CIS ID# : 512071098
    2. CJAMS PID# : 204026042
    CIS ID# : 531070856
    3. CJAMS PID# : 204026048
    CIS ID# : 557072117
    4. CJAMS PID# : 204026053
    CIS ID# : 543070904
    5. CJAMS PID# : 204026045
    CIS ID# : 553071930
   Category/ Module  :  person
   Root cause: User Request
    Fix Provided: Did data fix to remove persons and personprogramareas  
*/

/*
select updatedby,insertedby,activeflag,cjamspid,personid,* from person where cjamspid in (
204026039,
204026042,
204026048,
204026053,
204026045
);
cjamspid  personid
204026039	0f6b6861-8b8d-4fee-8fa7-0b372385a5b5
204026042	565329b7-6c26-4e34-9518-cc3c1745b5e1
204026045	fbcf22ec-09e3-4203-a2c1-3c2ee927d04b
204026048	795ed24f-b134-44cc-a733-a7c52cd10d34
204026053	a3b0a514-9f05-4060-85c0-08afafb509b4
*/
/*
select personid,actorid,* 
from actor where personid in('0f6b6861-8b8d-4fee-8fa7-0b372385a5b5',
'565329b7-6c26-4e34-9518-cc3c1745b5e1',
'fbcf22ec-09e3-4203-a2c1-3c2ee927d04b',
'795ed24f-b134-44cc-a733-a7c52cd10d34',
'a3b0a514-9f05-4060-85c0-08afafb509b4') 
and actortype = 'OTH'
and activeflag = 1;

personid actorid
0f6b6861-8b8d-4fee-8fa7-0b372385a5b5	f32b4eb0-96e2-470e-89b5-68fc0c20965c
565329b7-6c26-4e34-9518-cc3c1745b5e1	6bc0bd46-1027-49f9-9ecb-3d45df6e0737
795ed24f-b134-44cc-a733-a7c52cd10d34	49f8af01-dfef-4ec6-a7e2-4de125fe3f82
a3b0a514-9f05-4060-85c0-08afafb509b4	574cb2e9-0655-4758-9848-1b20500c74c0
fbcf22ec-09e3-4203-a2c1-3c2ee927d04b	682429a3-3f84-40e8-9f99-13fc7ebf21dc
*/

update actor 
set updatedby = 'CDM-43673',
	updatedon =  now(),
	activeflag = 0
where actorid in('f32b4eb0-96e2-470e-89b5-68fc0c20965c',
'6bc0bd46-1027-49f9-9ecb-3d45df6e0737',
'49f8af01-dfef-4ec6-a7e2-4de125fe3f82',
'574cb2e9-0655-4758-9848-1b20500c74c0',
'682429a3-3f84-40e8-9f99-13fc7ebf21dc') 
and actortype = 'OTH'
and activeflag = 1; 

/*
select activeflag,* from intakeservicerequestactor
where actorid in('f32b4eb0-96e2-470e-89b5-68fc0c20965c',
'6bc0bd46-1027-49f9-9ecb-3d45df6e0737',
'49f8af01-dfef-4ec6-a7e2-4de125fe3f82',
'574cb2e9-0655-4758-9848-1b20500c74c0',
'682429a3-3f84-40e8-9f99-13fc7ebf21dc') 
and activeflag = 1; 

israID actorID
78cf1d55-e265-4205-95e4-03fcb57ba545	49f8af01-dfef-4ec6-a7e2-4de125fe3f82
0effebb8-c95f-4c67-a368-27aff30a17a1	574cb2e9-0655-4758-9848-1b20500c74c0
7ce8b67a-5ab9-471f-b848-09e2e005892c	682429a3-3f84-40e8-9f99-13fc7ebf21dc
26bbfc17-9963-4b16-83ef-9ac1904e57b7	6bc0bd46-1027-49f9-9ecb-3d45df6e0737
2e09c0ad-2b56-40f1-a289-b37c3fca02c0	f32b4eb0-96e2-470e-89b5-68fc0c20965c
*/

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43673'
where intakeservicerequestactorid in(
'78cf1d55-e265-4205-95e4-03fcb57ba545',
'0effebb8-c95f-4c67-a368-27aff30a17a1',
'7ce8b67a-5ab9-471f-b848-09e2e005892c',
'26bbfc17-9963-4b16-83ef-9ac1904e57b7',
'2e09c0ad-2b56-40f1-a289-b37c3fca02c0'
)
and activeflag = 1;
/*

select personroleid,personid,* from personrole where intakeserviceid = 'd0a32bb8-482a-4d31-86c2-a88bcac09d31' and activeflag = 1
and personid in
('0f6b6861-8b8d-4fee-8fa7-0b372385a5b5',
'565329b7-6c26-4e34-9518-cc3c1745b5e1',
'fbcf22ec-09e3-4203-a2c1-3c2ee927d04b',
'795ed24f-b134-44cc-a733-a7c52cd10d34',
'a3b0a514-9f05-4060-85c0-08afafb509b4');

personroleid  personid
d25a9f3d-6905-4134-9895-779f7b991fbc	565329b7-6c26-4e34-9518-cc3c1745b5e1
218944ec-09e6-44a2-8aec-6934c3582a29	795ed24f-b134-44cc-a733-a7c52cd10d34
7bbe216b-e3eb-4d4f-bd3e-5ad71ea4920f	a3b0a514-9f05-4060-85c0-08afafb509b4
3aa41025-7c0b-484c-a3c7-f629f7bc6316	fbcf22ec-09e3-4203-a2c1-3c2ee927d04b
4a271c83-8e63-4570-8290-236b1c2a14ed	0f6b6861-8b8d-4fee-8fa7-0b372385a5b5
*/

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43673'
where personroleid in(
'd25a9f3d-6905-4134-9895-779f7b991fbc',
'218944ec-09e6-44a2-8aec-6934c3582a29',
'7bbe216b-e3eb-4d4f-bd3e-5ad71ea4920f',
'3aa41025-7c0b-484c-a3c7-f629f7bc6316',
'4a271c83-8e63-4570-8290-236b1c2a14ed'
) and activeflag =1;

/*
select * from personroletype
where personroleid in
	(select	personroleid
	 from personrole
		where personid in
			('0f6b6861-8b8d-4fee-8fa7-0b372385a5b5',
			'565329b7-6c26-4e34-9518-cc3c1745b5e1',
			'fbcf22ec-09e3-4203-a2c1-3c2ee927d04b',
			'795ed24f-b134-44cc-a733-a7c52cd10d34',
			'a3b0a514-9f05-4060-85c0-08afafb509b4')
			and intakeserviceid = 'd0a32bb8-482a-4d31-86c2-a88bcac09d31');
*/
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-35908',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where personid in
			('0f6b6861-8b8d-4fee-8fa7-0b372385a5b5',
			'565329b7-6c26-4e34-9518-cc3c1745b5e1',
			'fbcf22ec-09e3-4203-a2c1-3c2ee927d04b',
			'795ed24f-b134-44cc-a733-a7c52cd10d34',
			'a3b0a514-9f05-4060-85c0-08afafb509b4')
			and intakeserviceid = 'd0a32bb8-482a-4d31-86c2-a88bcac09d31');

/*
select * from actorrelationship
 where intakeservicerequestactorid in(
'78cf1d55-e265-4205-95e4-03fcb57ba545',
'0effebb8-c95f-4c67-a368-27aff30a17a1',
'7ce8b67a-5ab9-471f-b848-09e2e005892c',
'26bbfc17-9963-4b16-83ef-9ac1904e57b7',
'2e09c0ad-2b56-40f1-a289-b37c3fca02c0'
) and activeflag = 1;
*/

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-43673'
where intakeservicerequestactorid in(
'78cf1d55-e265-4205-95e4-03fcb57ba545',
'0effebb8-c95f-4c67-a368-27aff30a17a1',
'7ce8b67a-5ab9-471f-b848-09e2e005892c',
'26bbfc17-9963-4b16-83ef-9ac1904e57b7',
'2e09c0ad-2b56-40f1-a289-b37c3fca02c0'
)and activeflag = 1;

/*
select * from personprogramarea
where personid in('0f6b6861-8b8d-4fee-8fa7-0b372385a5b5',
'565329b7-6c26-4e34-9518-cc3c1745b5e1',
'fbcf22ec-09e3-4203-a2c1-3c2ee927d04b',
'795ed24f-b134-44cc-a733-a7c52cd10d34',
'a3b0a514-9f05-4060-85c0-08afafb509b4') 
and activeflag = 1;

personprogramid personid
6881ac73-b03b-4dfd-85e4-abc14a4b7c68	0f6b6861-8b8d-4fee-8fa7-0b372385a5b5
6e000e0c-b26b-4b3b-94ca-61fa63d89094	565329b7-6c26-4e34-9518-cc3c1745b5e1
78e2879c-c06d-4fc6-addd-61560636302e	a3b0a514-9f05-4060-85c0-08afafb509b4
943b7cf7-edb1-4927-b27c-66cbc1b00567	fbcf22ec-09e3-4203-a2c1-3c2ee927d04b
d742d4be-0c26-44d1-b69c-a1476bbb7f36	795ed24f-b134-44cc-a733-a7c52cd10d34
*/

update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CDM-43673'
where personprogramid in(
'6881ac73-b03b-4dfd-85e4-abc14a4b7c68',
'6e000e0c-b26b-4b3b-94ca-61fa63d89094',
'78e2879c-c06d-4fc6-addd-61560636302e',
'943b7cf7-edb1-4927-b27c-66cbc1b00567',
'd742d4be-0c26-44d1-b69c-a1476bbb7f36'
) and activeflag = 1;