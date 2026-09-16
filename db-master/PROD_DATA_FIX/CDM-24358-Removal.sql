/*
   Issue Description: 'CDM-24358
   Category/ Module  :  child removal 
   Root cause: Updating Removal End date, start date as per user request 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update cjams.intakeservreqchildremoval set removaldate='2022-06-09 00:00:00', exitdate='2022-06-10 00:00:00',updatedby='CDM-24358', updatedon=now()

where intakeservreqchildremovalid='61682cc0-2352-4bf2-8e6a-19948d1c44da';