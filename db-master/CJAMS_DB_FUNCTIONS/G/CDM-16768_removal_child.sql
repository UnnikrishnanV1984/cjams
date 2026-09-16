/*
   Issue Description: CDM-16768
   Category/ Module  : Removal Child
   Root cause: Accidental Deletion by the User
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-16768' , updatedon = now() where intakeservreqchildremovalid = '862e818e-c503-49a6-aca5-0cb3d27ef9ae'
and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-16768' , updatedon = now() where objectid = '862e818e-c503-49a6-aca5-0cb3d27ef9ae'
and eventcode = 'CHRR'
and activeflag = 1;


update placement set intakeservreqchildremovalid = null, updatedby = 'CDM-16768' , updatedon = now() where intakeservreqchildremovalid = '862e818e-c503-49a6-aca5-0cb3d27ef9ae'
and activeflag = 1;
