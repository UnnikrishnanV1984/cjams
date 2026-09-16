/*
   Issue Description: CDM-31217
   Category/ Module  : Placement  
   Root cause: user requested change case type
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.placement set activeflag =0, updatedby ='CDM-31217', updatedon = now()
where placementid ='15f86105-0641-4f0d-bd98-b411f9ddb363';

update cjams.placementrevision set activeflag =0, updatedby ='CDM-31217', updatedon = now()
where placementid ='15f86105-0641-4f0d-bd98-b411f9ddb363';

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-31217',
	updatedon = now()
where placementid = '15f86105-0641-4f0d-bd98-b411f9ddb363'
	and activeflag = 1 ;

    update routing 
set activeflag = 0,
	updatedby = 'CDM-31217',
	updatedon = now()
where objectid = '15f86105-0641-4f0d-bd98-b411f9ddb363'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
