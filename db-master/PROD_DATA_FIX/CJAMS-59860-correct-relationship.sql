/*
Issue Description:CJAMS-59860 Relationship to child needs to be corrected
Category/Module: Relationship
Root cause:User Data entry error and case is Completed.Correction needs to be done as data fix to modify the Relationships between Client ID# : 2528575 (JA'NELL M GRIFFIN) with ANDREA YOUNG (Client ID# 3281340) and DONTIA J CANTEY (Client ID# 1515210)
Fix provided: Data fix to add seconds in the approval date time stamp. Reporting team needs to validate it from their end.
              JA'NELL M GRIFFIN with ANDREA YOUNG - Support Staff
              JA'NELL M GRIFFIN with DONTIA J CANTEY - Biological Mother, Caregiver.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User entry error
*/

--Update relation for JA'NELL M GRIFFIN with ANDREA YOUNG - Support Staff

update actorrelationship
set relationshiptypekey = 'NORLTN',
    updatedby = 'CJAMS-59860',
    updatedon = now()
where actorrelationshipid = 'eaef4323-195c-44e7-b911-76ec17a5bcce'
and person1id = '3c8d84fd-d09e-4761-8d13-c23d31e669a8'
and person2id = '4d4069ab-b981-4385-943c-2717702bb6eb'
and activeflag = 1;

update actorrelationship
set relationshiptypekey = 'SUPRTSTF',
    caregiverflag = 0,
    updatedby = 'CJAMS-59860',
    updatedon = now()
where actorrelationshipid = 'c375bec9-3dad-4db4-91fd-a3b82af12b2e'
and person1id = '4d4069ab-b981-4385-943c-2717702bb6eb'
and person2id = '3c8d84fd-d09e-4761-8d13-c23d31e669a8'
and activeflag = 1;


--Update relation for JA'NELL M GRIFFIN with DONTIA J CANTEY - Biological Mother, Caregiver.

update actorrelationship
set relationshiptypekey = 'BGMTHR',
    caregiverflag = 1,
    updatedby = 'CJAMS-59860',
    updatedon = now()
where actorrelationshipid = 'f9adbb5a-9d24-4dfc-ad69-074ebeb06474'
and person1id = '9c34bc9a-2e46-4cbc-9ac2-40fd510c59be'
and person2id = '3c8d84fd-d09e-4761-8d13-c23d31e669a8'
and activeflag = 1;


update actorrelationship
set relationshiptypekey = 'BGCHLD',
    updatedby = 'CJAMS-59860',
    updatedon = now()
where actorrelationshipid = '5c036905-d2a5-4f8d-9876-cefbb2c1dc53'
and person1id = '3c8d84fd-d09e-4761-8d13-c23d31e669a8'
and person2id = '9c34bc9a-2e46-4cbc-9ac2-40fd510c59be'
and activeflag = 1;