/*
   Issue Description: CDM-32180
   Category/ Module  : 
   Root cause: user want to remove Case # 3231910 approval dashboard as the YTP has been approved
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0,updatedby='CDM-32180',updatedon=now() where routingid='ded0e97d-bda2-48b4-a1ba-f2ca1b794682';