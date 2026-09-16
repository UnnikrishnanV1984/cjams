/*
Issue Description:Sibling information showing incorrectly in ACA form for both sibling as they are placed in same provider.
4376862/255812 - Naveaha - It should show only Heaven in below table
Root cause: Wrong sibling details were saved by mistake, so both children were listed in each other’s records, including their own name.
Fix provided: updated records in adoptionapplicabilitysiblinginfo table
Data/Code fix ticket#: CJAMS-59122
Regression Impacts: N/A     
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The system is working fine. The problem was just with incorrect data, not the code. So, only a data correction was needed.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from adoptionapplicabilitysiblinginfo where siblingid in ('2bcb270c-558e-4264-8df4-3f8b651caf13',
'2ce5617b-5cb3-4d46-8331-8f27a582f61a',
'c5d759b7-074b-491f-b9ac-20aa7fac66f0',
'70edd46b-13a6-4af3-82f7-c500aa5b00b9',
'438cf458-da3b-4424-901d-2e91f11076d1',
'f4b69a0b-2f49-47f2-8aff-725d5107e2e0',
'226d1c05-5d77-40e3-95a3-1026b7c51e2f',
'3f6a3b03-2f4c-4edf-9e55-d42a4af50f5d');

delete from adoptionapplicabilitysiblinginfo where adoptionapplicabilityid in ('736f5cf3-e9d7-4b6f-a957-8ce32d240b33','0be2e593-5b48-4324-8fea-6939e09cf202');

insert into adoptionapplicabilitysiblinginfo
(siblingid,
adoptionapplicabilityid	,
nameofsiblingchild	,
nameofsiblingchildsadoptiveplacement,
dateofsiblingsapplicablechildassessment,
childssiblingsapplicabilitystatus,
siblingsrelationshipwithchild)
values
'3f6a3b03-2f4c-4edf-9e55-d42a4af50f5d', '736f5cf3-e9d7-4b6f-a957-8ce32d240b33',	'DA'MYA TRENT',		null,	'2025-04-02 15:19:05.666',		'Adoption Applicable and NonApplicable',		'Biological Brother'),
'438cf458-da3b-4424-901d-2e91f11076d1', '736f5cf3-e9d7-4b6f-a957-8ce32d240b33',	'DA'MYA TRENT',		null,	'2025-04-02 15:19:05.666',		'Adoption Applicable and NonApplicable',		'Half Sister       '),
'f4b69a0b-2f49-47f2-8aff-725d5107e2e0', '736f5cf3-e9d7-4b6f-a957-8ce32d240b33',	'CHYLA TRENT ',		null,	'2025-04-02 15:22:17.145',		'Adoption Applicable and NonApplicable',		'Biological Sister '),
'226d1c05-5d77-40e3-95a3-1026b7c51e2f', '736f5cf3-e9d7-4b6f-a957-8ce32d240b33',	'CHYLA TRENT ',		null,	'2025-04-02 15:22:17.145',		'Adoption Applicable and NonApplicable',		'Half Sister       '),
'2bcb270c-558e-4264-8df4-3f8b651caf13', '0be2e593-5b48-4324-8fea-6939e09cf202',	'DA'MYA TRENT',		null,	'2025-04-02 15:19:05.666',		'Adoption Applicable and NonApplicable',		'Biological Brother'),
'2ce5617b-5cb3-4d46-8331-8f27a582f61a', '0be2e593-5b48-4324-8fea-6939e09cf202',	'DA'MYA TRENT',		null,	'2025-04-02 15:19:05.666',		'Adoption Applicable and NonApplicable',		'Half Sister       '),
'c5d759b7-074b-491f-b9ac-20aa7fac66f0', '0be2e593-5b48-4324-8fea-6939e09cf202',	'CHYLA TRENT ',		null,	'2025-04-02 15:22:17.145',		'Adoption Applicable and NonApplicable',		'Biological Sister '),
'70edd46b-13a6-4af3-82f7-c500aa5b00b9', '0be2e593-5b48-4324-8fea-6939e09cf202',	'CHYLA TRENT ',		null,	'2025-04-02 15:22:17.145',		'Adoption Applicable and NonApplicable',		'Half Sister       ');
*/
delete from adoptionapplicabilitysiblinginfo where siblingid in ('2bcb270c-558e-4264-8df4-3f8b651caf13',
'2ce5617b-5cb3-4d46-8331-8f27a582f61a',
'c5d759b7-074b-491f-b9ac-20aa7fac66f0',
'70edd46b-13a6-4af3-82f7-c500aa5b00b9',
'438cf458-da3b-4424-901d-2e91f11076d1',
'f4b69a0b-2f49-47f2-8aff-725d5107e2e0',
'226d1c05-5d77-40e3-95a3-1026b7c51e2f',
'3f6a3b03-2f4c-4edf-9e55-d42a4af50f5d');


update tb_ive_adoption_audit
set childexpectedadoptiveproviderid = null,updatedby = 'CJAMS-59122', updatedon = now()
where adoptionauditid in  ('85464');

update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CJAMS-59122', updatedon= now()
where adoptionapplicabilityid in  ('78406ef4-5de6-4670-91dc-9780209fb8b1','902207c5-663a-4c43-a255-6d8792bf65a4') and activeflag =1;	

insert into adoptionapplicabilitysiblinginfo
(siblingid,
adoptionapplicabilityid	,
nameofsiblingchild	,
nameofsiblingchildsadoptiveplacement,
dateofsiblingsadoptiondecree,
dateofsiblingsapplicablechildassessment,
childssiblingsapplicabilitystatus,
expectedchildadoptiveplacement,
siblingsrelationshipwithchild)
values
(
gen_random_uuid(),	
'736f5cf3-e9d7-4b6f-a957-8ce32d240b33',	
'NEVAEH COUPLIN',	
null,
null,	
'2025-04-02 15:19:05.666',
'Applicable',
null,	
'Biological Sister'
);

insert into adoptionapplicabilitysiblinginfo
(siblingid,
adoptionapplicabilityid	,
nameofsiblingchild	,
nameofsiblingchildsadoptiveplacement,
dateofsiblingsadoptiondecree,
dateofsiblingsapplicablechildassessment,
childssiblingsapplicabilitystatus,
expectedchildadoptiveplacement,
siblingsrelationshipwithchild)
values
(
gen_random_uuid(),	
'0be2e593-5b48-4324-8fea-6939e09cf202',	
'Heaven Couplin',
null,
null,	
'2025-04-02 15:19:05.666',
'Applicable',
null,	
'Biological Sister'
);






