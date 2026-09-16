--D-25910

-- peron role update and insert for the case # 3284113
update personrole set insertedby = '2d4695d8-107d-45ad-a0fd-43c18bf4c627' where personroleid = 'fc7b4f64-b467-428f-aabf-303581aee6b4';

INSERT INTO cjams.personroletype
(personroleid, roletype, activeflag, isprimary, insertedby, insertedon, updatedby, updatedon )
VALUES('fc7b4f64-b467-428f-aabf-303581aee6b4', 'PARENT', 1, 'true',
'2d4695d8-107d-45ad-a0fd-43c18bf4c627', '2020-02-25 14:23:55', 
'2d4695d8-107d-45ad-a0fd-43c18bf4c627', '2020-02-25 14:23:55'
);

-- set other member flag for the case # CW2917229
update actor set ishouseholdmember = 2 where actorid = 'bd969c11-c61f-4d84-b43a-0db17e6e674a';

update personrole set ishouseholdmember =2 where personroleid = '2a376b5d-ce01-486d-a386-4ee87249f494';


-- D-26775 - This is a risk of harm that launched an AR.  This needs to be deleted.

update intakeservicerequest set actiontype=null, intakeservicerequestclassid ='00000000-0000-0000-0000-000000000000', 
activeflag = 0, updatedby = 'D-26775', updatedon = now() where servicerequestnumber in (20190325013843) ; 