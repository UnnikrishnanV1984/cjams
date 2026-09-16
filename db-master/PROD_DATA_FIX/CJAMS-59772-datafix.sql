-- CJAMS-59772  LRR Reporting Window

/*
-- Issue Description: 
	Updated the following reasons to the LRR window: Alleged victim: "Alleged victim unavailable > Attempted face to face > 1-2 attempts". 
    Other children: "Other children unavailable > Family was contacted but unavailable to meet within mandate

-- Category/ Module: Persons
-- Root cause: : Updated the following reasons to the LRR window: Alleged victim: "Alleged victim unavailable > Attempted face to face > 1-2 attempts". 
    Other children: "Other children unavailable > Family was contacted but unavailable to meet within mandate
-- Resolution: Data fix has been done to update the LRR Reporting Window
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
cpsresponsetimerreason2 = 'VAFF',
  cpsresponsetimerreason3 = 'V12F',
  cpsresponsetimerreason4 = 'OOCN',
  cpsresponsetimerreason5 = 'OFMN',
    updatedby ='CJAMS-59772',
    updatedon =now()
where intakeserviceid = 'efa8a5b8-70c8-4222-a75e-8a3848c67aff'
and cpsresponsetimeractionsid = 'd9f8f433-928e-4b53-8f1a-3f503f4908e1'
and activeflag = 1;