/*
   Issue Description: CJAMS-60787
   Category/ Module  : Case assignment
   Root cause: data fix to change the response timer dropdown value  TO "Initial contact with family would place child's safety at risk"
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VISR',
cpsresponsetimerreason2  = null,
cpsresponsetimerreason7 = 'CISR',
cpsresponsetimerreason8 = null,
updatedby ='CJAMS-60787',
updatedon =now()
where intakeserviceid ='ae99fed9-850e-4237-8244-362c17de9b83'
and cpsresponsetimeractionsid= 'ac45ab16-c55c-4e18-84bd-8b1eea70faf9';