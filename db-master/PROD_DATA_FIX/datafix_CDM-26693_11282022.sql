-- CDM-26693 - Name change
/*
-- Issue Description: 
   User Request do a data fix to select the below substance class for CJAMS PID # 200974709,

	Baby - Methadone
	Baby - Other (Oxymorphone, Morphine, and Fentanyl)

-- Client ID: 200974709	(KASAI Dillon) - 890991bf-dc07-4713-9361-6c24aa4cdf2c
	Baby - Methadone
	Baby - Other (Oxymorphone, Morphine, and Fentanyl)

-- substanceclasses:  ["BMTD","BOTH"]
-- othersubstances: Oxymorphone, Morphine, and Fentanyl 

-- Category/ Module: Case Management
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select cjamspid, firstname, lastname, substanceexposednewbornflag, 
	substanceclasses, othersubstances, updatedby, updatedon
from person
where cjamspid = 200974709
	and activeflag = 1;

update person
set substanceclasses = '["BMTD","BOTH"]',
	othersubstances = 'Oxymorphone, Morphine, and Fentanyl',
	updatedby = 'CDM-26693', 
	updatedon = now()
where cjamspid = 200974709
	and activeflag = 1;