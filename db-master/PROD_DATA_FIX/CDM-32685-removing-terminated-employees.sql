update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-32685',
    updatedon = now()
where
    securityusersid IN ('a7be5905-aaf4-4e5b-9d5d-e13685c45a45','ac621917-3d23-4da0-81ca-f7a4996d70a6','ae1eba39-507e-470f-acc1-76ca56d36445');
    

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-32685',
    updatedon = now()
where
    securityusersid IN ('a7be5905-aaf4-4e5b-9d5d-e13685c45a45','ac621917-3d23-4da0-81ca-f7a4996d70a6','ae1eba39-507e-470f-acc1-76ca56d36445');

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-32685',
    updatedon = now()
where
    securityusersid IN ('a7be5905-aaf4-4e5b-9d5d-e13685c45a45','ac621917-3d23-4da0-81ca-f7a4996d70a6','ae1eba39-507e-470f-acc1-76ca56d36445');

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-32685',
    updatedon = now()
where
    principalid IN ('10021','10029','9948');
    

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-32685',
    updatedon = now()
where
    securityusersid in ('a7be5905-aaf4-4e5b-9d5d-e13685c45a45','ac621917-3d23-4da0-81ca-f7a4996d70a6','ae1eba39-507e-470f-acc1-76ca56d36445');