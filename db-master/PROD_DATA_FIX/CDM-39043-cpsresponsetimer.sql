/*
   Issue Description: CDM-39043
   The overdue timer continues to display even though all contact items are check marked. 
   The response timer stopped on 4/26/24 and was still due until 5/1/24. Can the overdue pop up be removed?
   CASE#: 241022005342	(5c70db34-d334-4ad6-a8b0-b0ff51f57895)
   Category/ Module: Over due Response Popup
   Root cause: .
   Pull request# for code fix: NA
*/

UPDATE cjams.cpsresponsetimeractions
	SET updatedby='CDM-39043', 
		updatedon=now(), 
		activeflag=0
	where cpsresponsetimeractionsid in ('8fba73b1-3bbb-434a-acf7-9845957917af', '1c93fd7c-2290-43b3-9df2-a62208e25c89') 
		and intakeserviceid = '5c70db34-d334-4ad6-a8b0-b0ff51f57895' and activeflag = 1;
		

UPDATE routing
	SET activeflag = 0,
		updatedby = 'CDM-39043',
		updatedon = now()
	WHERE objectid in ('8fba73b1-3bbb-434a-acf7-9845957917af', '1c93fd7c-2290-43b3-9df2-a62208e25c89') and activeflag = 1;


