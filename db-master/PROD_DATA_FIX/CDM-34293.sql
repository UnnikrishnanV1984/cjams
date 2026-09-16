/* 
    Issue Description: CDM-34293
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to delete  duplicate child removal. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-34293',
updatedon = now()
WHERE intakeservreqchildremovalid = 'd1dc4088-225a-4c46-aeb2-01f52f20308d' AND activeflag=1; 

update intakeservreqchildremoval_history
SET activeflag = 0,
updatedby ='CDM-34293',
updatedon = now()
WHERE intakeservreqchildremovalid = 'b0f269df-5bdc-452f-b085-b0ad6b4d3b64' AND activeflag=1;


update routing 
SET activeflag = 0,
updatedby ='CDM-34293',
updatedon = now()
where routingid = '27b275df-c765-4b9f-982c-9b5457b05b71';