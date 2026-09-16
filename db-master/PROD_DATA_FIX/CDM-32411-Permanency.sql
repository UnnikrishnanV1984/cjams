/*
Issue Description: CDM-32411
Root Cause :user wants change the plan established date to 2023-12-14
Data fix :Updated plan established date to 2023-12-14
*/

update cjams.permanencyplan set establisheddate ='2023-12-14 05:00:00', updatedby ='CDM-32411', updatedon = now()
where permanencyplanid ='007d2f7a-17d9-4d09-9609-ad386be7de25';