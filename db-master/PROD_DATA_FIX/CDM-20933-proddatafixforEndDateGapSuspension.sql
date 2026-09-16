
/*
   Issue Description: CDM-20933
   Category/ Module  : End dating Gap suspension
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


 update cjams.gapsuspension  
set enddate = '2022-02-18 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-20933'
where gapsuspensionid = 'b84280f8-c885-4730-9e37-4246ce467328'
	and activeflag = 1 ;
	
update cjams.gapsuspensionrevision  
set enddate = '2022-02-18 05:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-20933'
where suspensionid = 'b84280f8-c885-4730-9e37-4246ce467328' ;