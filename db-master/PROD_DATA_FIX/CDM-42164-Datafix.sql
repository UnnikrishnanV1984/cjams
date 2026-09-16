/*
  Issue Description:  CDM-42164
   Category/ Module  :  Supervisor_Dropdown
   Root cause: The Users were deactivated in sailpoint. So, deactivated in CJAMS accordingly.
   Done a data fix to update the default supervisor accordingly.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

--leah.garvett@maryland.gov,niquita.gilliam1@maryland.gov are active users, 
 --Default supervisor -alexandra.robinson@maryland.gov

update userprofile set supervisorid = '87030587-52e7-4b49-99ae-d8fcb2ad5a50',
updatedby = 'CDM-42164', updatedon = now() 
where securityusersid in ('17ae7150-f481-4fb0-a18d-d0eb8c8385d5','837be9a3-6297-40b7-aec1-1dfdf0d9497b') and activeflag = 1;

--Deactivating niquita.gilliam@maryland.gov,  amanda.bates1@maryland.gov

update
    userprofile
set
    activeflag = 0,
    updatedby = 'CDM-42164',
    updatedon = now()
where
    securityusersid = 'f13e0acc-2b35-4dfa-84a2-f94c0f05b7c3'
    and activeflag = 1;

    update
    muser
set
    activeflag = 0,
    updatedby = 'CDM-42164',
    updatedon = now()
where
    securityusersid = 'f13e0acc-2b35-4dfa-84a2-f94c0f05b7c3'
    and activeflag = 1;

    UPDATE securityusers
	SET activeflag = 0,
		updatedby = 'CDM-42164',
		updatedon = now()
	WHERE  
		securityusersid in (
 'f13e0acc-2b35-4dfa-84a2-f94c0f05b7c3',
 'd4edc3f7-7cf6-43f9-b080-f32f03625d97'
    )
    and activeflag = 1;

    UPDATE rolemapping 
	SET activeflag = 0, updatedby = 'CDM-42164', updatedon = now()
	WHERE principalid = '12837' and teamtypekey = 'CW' and activeflag = 1;

    UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-42164',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid  in ('f13e0acc-2b35-4dfa-84a2-f94c0f05b7c3'));

    UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-42164',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('f13e0acc-2b35-4dfa-84a2-f94c0f05b7c3'));
            
    UPDATE userprofileaddress
	SET activeflag = 0,
		updatedby = 'CDM-42164',
		updatedon = now()
	WHERE  
		securityusersid in (
 'd4edc3f7-7cf6-43f9-b080-f32f03625d97'
    )
    and activeflag = 1;

