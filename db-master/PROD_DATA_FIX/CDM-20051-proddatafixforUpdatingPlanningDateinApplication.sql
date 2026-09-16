
/*
   Issue Description: CDM-20051
   Category/ Module  : Updating Date of planning Meeting
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapapplication set planmeetingdate = '2021-08-25 05:00:00', updatedon = now(), updatedby = 'CDM-20051' where gapapplicationid = '32864b74-b00b-453e-a34f-c6f09280ec7c';
