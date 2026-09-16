
/*
   Issue Description: CDM-31138
   Category/ Module  : Person 
   Root cause: Case is closed so user requested this change 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.person set substanceexposednewbornflag =1, cjamspid='201163120', substanceexposednewbornsourceid ='I231010521597', substanceexposednewbornsourcetypekey ='2954',
substanceexposednewborntimetamp='2023-03-12 00:00:00', substanceclasses ='["BMJA"]', othersubstances ='', senstatusflag =1,updatedby ='CDM-31138', updatedon = now()
where personid ='38557ee6-0647-438d-8bdd-5ff8c8bbed85';
