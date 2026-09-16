
/*
   Issue Description: CDM-18652
   Category/ Module  : Permanency plan  
   Root cause: User requested to udpate establish and end date
   Pull request# for code fix: 4241
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--establisheddate = 2017-03-21 04:00:00.000, enddate = 2017-04-01 00:00:00.000
update Permanencyplan set establisheddate = '06/29/2016', enddate = '05/30/2017', updatedby = 'CDM-18652', updatedon = now() where permanencyplanid = 'cd25764f-974c-4a35-9293-c1ae1f77856b';