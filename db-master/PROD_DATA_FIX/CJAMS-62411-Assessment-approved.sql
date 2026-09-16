/*
   Issue Description: CCJAMS-62411
   Category/ Module  : Stuck approval
   Root cause: The YTP approval for case number 231030122148 is stuck in supervisor's approval box. This assessment for the YTP has been approved by the assigned supervisor. 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
update routing set activeflag = 0, updatedby = 'CJAMS-62411', updatedon = now() where routingid = 'e33f7f7c-75bc-4ca9-8ffb-771b971dd0f3';
