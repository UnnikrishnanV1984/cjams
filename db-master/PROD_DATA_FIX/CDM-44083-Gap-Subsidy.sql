/*
   Issue Description: CDM-44083 Need Help Entering GAP subsidy
   Category/ Module  : GAP
   Root cause: GAP agreement review for the case 3171993 has been sent to the supervisor who is inactive.
               Data fix requested to redirect the GAP agreement to different supervisor 
   Fix Provided: Data fix has been done to redirect GAP to  Supervisor (ronda.lewis@maryland.gov). 
   Data/Code fix ticket#: CDM-44083
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This issue happend due to user deactivation and data fix will fix this.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update routing 
set tosecurityusersid = '299210ac-c6df-4985-a02b-bdeda0cdad67',
    toroleid = 'CWSP',
    updatedby = 'CDM-44083',
    updatedon = now()
where objectid ='351ba902-7288-41fc-947d-12062f864326'
and routingid in ('ef79eb09-f0b5-42a4-8756-d3e547ffa095','80393a73-af5b-4a42-8bc1-edb82ff780c9');