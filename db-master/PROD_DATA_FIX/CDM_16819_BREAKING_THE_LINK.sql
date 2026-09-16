/*
   Issue Description: CDM-16819
   Category/ Module  : Adoption subsidy 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

update adoptionagreement 
	set startdate = '2021-08-25 13:09:53', updatedby = 'CDM-16819', updatedon = now()
	where adoptionagreementid = 'a3428920-0c8a-497b-b20f-b579b0861b11';


    update adoptionagreementrevision 
set startdate = '2021-08-25 13:09:53', updatedby = 'CDM-16819', updatedon = now()
where adoptionagreementid = 'a3428920-0c8a-497b-b20f-b579b0861b11' and activeflag = 1;