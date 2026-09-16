/*
Issue Description: CDM-43031 Amber.Barnes@maryland.gov is no longer able to get assigned cases from Charles County and Calvert County in CJAMS
Category/Module: Case assignment Workload
Root cause: Multi county  user changes done from sailpoint caused this issue and Amber is needs to be shown in three counties with following information
            StMary's
            Supervisor: Angela Sacks
            Team Name: CPS

            Charles County
            Supervisor: Wanda Collins
            Team Name: LDSS Management

            Calvert County
            Supervisor: Brenda Carr
            Team Name: CPS
Fix provided: Data fix has been done to map the user to correct team in the teammember table.
Data/Code fix ticket#: CDM-43031
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This issue is caused by mutli county setup in the sailpoint and data fix will resolve it.
Backup before update/ delete:Query:
*/

-- Please run createmulticountyuser proc before running this sql
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Charles' and activeflag = 1) and teamname = 'LDSS Management';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'Calvert' and activeflag = 1) and teamname = 'Child protective Services';
-- select teamnumber from team where countyid = (select countyid::varchar from county where countyname = 'StMary's' and activeflag = 1) and teamname = 'CPS unit';

delete from teammemberassignment where insertedby='CDM-43031';

delete from teammember where insertedby ='CDM-43031';

select * from cjams.createmulticountyuser('amber.barnes@maryland.gov', 'wanda.collins@maryland.gov','1435_13','CDM-43031');
select * from cjams.createmulticountyuser('amber.barnes@maryland.gov', 'brenda.carr@maryland.gov','1431_4','CDM-43031');

update teammemberassignment set activeflag = 0 , updatedby  = 'CDM-43031' , updatedon = now() 
where securityusersid = '1019e183-a7ab-4244-a728-854f03a3a477' 
and teammemberassignmentid = '12348428-3587-460e-8b74-df3b497e1a8f'
and activeflag = 1 ;

-- Query to Validate multicounty select
-- select tm.supervisorid, tm.teammemberid, t.countyid, c.countyname, up.fullname, * from teammemberassignment tma 
-- inner join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
-- inner join team t on t.teamid = tm.teamid and t.activeflag = 1
-- inner join county c on c.countyid = t.countyid::uuid and c.activeflag = 1
-- inner join userprofile up on up.securityusersid = tm.supervisorid
-- where tma.securityusersid = '1019e183-a7ab-4244-a728-854f03a3a477' and tma.activeflag = 1
