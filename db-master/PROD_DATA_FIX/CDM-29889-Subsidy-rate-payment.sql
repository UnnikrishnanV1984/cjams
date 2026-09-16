/*
   Issue Description: CDM-29889
   Category/ Module  : 3241093:Unable to approve the subsidy rate because there is an "incomplete" message.
    All of the information is correct and complete. Please assist
   Root cause: : 
   Pull request# for It's a data fix.
   Reason why no related code fix:  
   
*/


-- Delete duplicate rate slab
select adoptionrevisionid, startdate, enddate, paymentamout, status, activeflag, updatedby, updatedon 
	from adoptioncaserevision  
where adoptionagreementid = '7736a9be-1340-40c7-8aec-c3d37677f6c4' 
	and adoptionrevisionid in ( '3793ea6b-ab6f-41e5-b4d9-245f54963b3d')
	and activeflag = 1 ;

update adoptioncaserevision  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-29889'
where adoptionagreementid = '7736a9be-1340-40c7-8aec-c3d37677f6c4' 
	and adoptionrevisionid in ( '3793ea6b-ab6f-41e5-b4d9-245f54963b3d')
	and activeflag = 1;
	
