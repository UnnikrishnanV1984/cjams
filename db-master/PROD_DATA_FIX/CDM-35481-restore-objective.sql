/*
   Issue Description: CDM-35481
   Category/ Module  : Service plan objective restoring
   Root cause: User requested to restore the accidentally deleted service plan objective
   Fix Provided: 
*/

update cjams.splangoal set activeflag =1, updatedby ='CDM-35481', updatedon = now()

where splangoalid ='aefb5e21-6a34-44dd-a87f-65977b210b49';