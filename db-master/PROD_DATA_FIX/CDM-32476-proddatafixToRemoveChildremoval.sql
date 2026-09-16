/*
   Issue Description: CDM-32476
   Category/ Module  : Prod data fix to Remove Removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-32476', updatedon = now()
where intakeservreqchildremovalid in ('6f3ae45b-4869-492a-abb0-aeea6ea52f87');


update cjams.intakeservreqchildremoval_history set activeflag =0, updatedby ='CDM-32476', updatedon = now ()
where intakeservreqchildremovalid ='6f3ae45b-4869-492a-abb0-aeea6ea52f87';

UPDATE cjams.routing SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-32476'
WHERE objectid='6f3ae45b-4869-492a-abb0-aeea6ea52f87';

update personprogramarea set activeflag = 0, updatedby = 'CDM-32476', updatedon = now()
where personprogramid = '1e8850eb-abd0-4507-958b-83381063df95';

update tb_client_eligibility set delete_sw = 'Y', update_user_id = 'CDM-32476', update_ts = now() 
where removal_id = '274154';
