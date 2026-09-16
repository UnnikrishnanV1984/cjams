/*
  Issue Description:  CDM-42251
   Category/ Module  :  User Profile
   Root cause: User request to Data fix to Reactivate the employee from CJAMS
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update teammemberassignment
set activeflag = '1', updatedby = 'CDM-42251', updatedon = now()
where securityusersid in ('b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8');

update muser set activeflag = '1', updatedby = 'CDM-42251', updatedon = now()
where securityusersid in ('b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8');
    
update userprofile set activeflag = '1', updatedby = 'CDM-42251', updatedon = now()
where securityusersid in ('b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8');

update rolemapping set activeflag = '1', updatedby = 'CDM-42251', updatedon = now()
where principalid in ('44298') and teamtypekey = 'CW' and id = 152474608;
    
update securityusers set activeflag = '1',updatedby = 'CDM-42251', updatedon = now()
where securityusersid in('b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8');

UPDATE teammember
SET activeflag = 1,
    updatedby = 'CDM-42251',
    updatedon = now()
WHERE teammemberid IN ('bb3f5438-4f6a-4eeb-bec5-f8eed75aa8c4') and activeflag = 0; 