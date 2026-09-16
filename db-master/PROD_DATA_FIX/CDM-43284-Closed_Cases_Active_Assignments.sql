/*
   Issue Description: CDM-43284
   Category/ Module  :  Case assingnement
   Root cause: user requeseted to updated case assingment end date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment set enddate ='2024-12-13', updatedon = now(), updatedby ='CDM-43284'
where caseassignmentid in (
	select ca.caseassignmentid from caseassignment ca
	join adoptioncase ad on ca.objectid = ad.adoptioncaseid 
	where 
	ca.activeflag =1 and ca.enddate isnull and
	ad.adoptioncasenumber in ('3086250','3085998','3241813','3291719','3193144','3193146','3085493','3248704','3086484','3086614','3148692','3197310',
	'3086557','3168201','3085790','3225348','3085492','3085521','3086713','3151355','3159404','3085368','3181001','3188520','3261064','3228871','3207822','3085501','3163410')
);
