/*
   Issue Description: CDM-37216
   The overdue timer continues to display even though all contact items are check marked. 
   The response timer stopped on 2/8/24 and was still due until 2/12/24. Can the overdue pop up be removed?
   CASE#: 241021900168	(53e470c1-bc28-45f8-9c34-958008bd662a)
   Category/ Module: Over due Response Popup
   Root cause: .
   Pull request# for code fix: NA
*/

UPDATE cjams.cpsresponsetimeractions
	SET updatedby='CDM-37216', 
		updatedon=now(), 
		activeflag=0
	where cpsresponsetimeractionsid = '79c000cd-ab5b-45c2-b95b-2bae7a602d03' 
		and intakeserviceid = '53e470c1-bc28-45f8-9c34-958008bd662a'
		and activeflag = 1;
		

UPDATE routing
	SET activeflag = 0,
		updatedby = 'CDM-37216',
		updatedon = now()
	WHERE objectid = '79c000cd-ab5b-45c2-b95b-2bae7a602d03' 
		and activeflag = 1;


