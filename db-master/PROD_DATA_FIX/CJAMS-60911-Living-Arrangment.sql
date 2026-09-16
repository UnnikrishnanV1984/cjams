/*
Issue Description:211030011190:Please delete the two rejected living arrangements under Ka'Myrah and Kai'ryn
Root cause: User request to delete the living arrangements,due to they do not have access to do that.
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#:CJAMS-60911
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update routing 
set activeflag = 0, updatedby = 'CJAMS-60911', updatedon  = now()
where routingid  in ('1caeaf3b-8867-432c-8f87-6a9332a4dc5f','f13c6e57-130d-4718-bdb0-477571c36634') and  activeflag =1;

update livingarrangement
set activeflag = 0, updatedby = 'CJAMS-60911', updatedon  = now()
where  livingid  in ('949160eb-45b7-4f27-b51f-c45e825346eb','e3219a1b-a6f2-43dd-b162-8bd133547d67') and activeflag =1;

update placementrevision
set activeflag = 0, updatedby = 'CJAMS-60911', updatedon  = now()
where placementrevisionid  in ('b1bdcf91-686c-46ee-a288-308a90224844','6db81f71-4060-4c55-a2db-85f2ef627153') and activeflag =1;


update placement 
set activeflag = 0, updatedby = 'CJAMS-60911', updatedon  = now()
where placementid in ('33f2c0b2-49e4-4d29-bb04-ffd8cd4008c6','f67c0eb1-a16c-4d06-84fc-0cc5622e00d8') and activeflag =1;