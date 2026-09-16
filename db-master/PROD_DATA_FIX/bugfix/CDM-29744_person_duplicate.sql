/*
   Issue Description: CDM-29744
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix 201161797,201161798,201161799,201161801,201161802
*/

update cjams.intakeservicerequestactor
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29744'
where personid in ('1789fa85-faca-43d9-ae73-3b43dd404a37','82896f62-07b2-43c0-b847-6601e7dcbf3d','f756e61b-1fcf-4b64-a259-ebb085ebca62',
'88587002-8154-4694-a2a7-af880d27a48a','fe0cab89-076d-42b7-a674-98b6a9c33f80') and intakeserviceid = 'ac41fdcd-6755-4de5-8bad-5c4c39f1f48f';

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29744'
where personid in ('1789fa85-faca-43d9-ae73-3b43dd404a37','82896f62-07b2-43c0-b847-6601e7dcbf3d','f756e61b-1fcf-4b64-a259-ebb085ebca62',
'88587002-8154-4694-a2a7-af880d27a48a','fe0cab89-076d-42b7-a674-98b6a9c33f80') and intakeserviceid = 'ac41fdcd-6755-4de5-8bad-5c4c39f1f48f';

update cjams.actor
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29744'
where personid in ('1789fa85-faca-43d9-ae73-3b43dd404a37','82896f62-07b2-43c0-b847-6601e7dcbf3d','f756e61b-1fcf-4b64-a259-ebb085ebca62',
'88587002-8154-4694-a2a7-af880d27a48a','fe0cab89-076d-42b7-a674-98b6a9c33f80') and intakeserviceid = 'ac41fdcd-6755-4de5-8bad-5c4c39f1f48f';
