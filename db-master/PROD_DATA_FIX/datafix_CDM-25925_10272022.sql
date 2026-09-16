-- CDM-25925 - Response Timer
/*
-- Issue Description: 
	To remove the pending 'CPS Response Timer Skip Request to Supervisor' approval requets

-- CPS-AR: 221020259071 - b0e8758b-ea9f-4417-ae65-a4424959efce
-- CPS-AR: 221020244437 - e538a5b3-9cbc-4de1-80a4-7b4d594f08a2

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-AR: 221020259071 - b0e8758b-ea9f-4417-ae65-a4424959efce
select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where routingid = 'fcbd291b-2697-4041-b815-167b27b0a5fd'
	and eventcode = 'CPSRTS' -- CPS Response Timer Skip Request to Supervisor
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-25925',
	updatedon = now()
where routingid = 'fcbd291b-2697-4041-b815-167b27b0a5fd'
	and eventcode = 'CPSRTS' -- CPS Response Timer Skip Request to Supervisor
	and activeflag = 1 ;


-- CPS-AR: 221020244437 - e538a5b3-9cbc-4de1-80a4-7b4d594f08a2
select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where routingid = '552706ae-909e-4b5a-92f1-2c724286da41'
	and eventcode = 'CPSRTS' -- CPS Response Timer Skip Request to Supervisor
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-25925',
	updatedon = now()
where routingid = '552706ae-909e-4b5a-92f1-2c724286da41'
	and eventcode = 'CPSRTS' -- CPS Response Timer Skip Request to Supervisor
	and activeflag = 1 ;
