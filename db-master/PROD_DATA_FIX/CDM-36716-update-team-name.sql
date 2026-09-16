-- CDM-36176-- 
/*
-- Issue Description: 
 --Unit types and names need to be changed

-- Customer Email ID:  robyn.adams2@maryland.gov
-- Root cause: Data fix to update unit team name
-- Resolution: Data fix is provided to update unit team name
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



select * from team where countyid='bbce9638-24f9-4336-993c-007f6755c980';

update team set teamname='CPS-PW', updatedby='CDM-36176', updatedon=now()
where teamid='4c5c51e4-6983-4d7a-b5bf-b1b327cb7c05';

update team set teamname='Appeals', updatedby='CDM-36176', updatedon=now()
where teamid='aa902e82-ef46-43f2-81c8-b24fa69c3ed2';

update team set teamname='CAC', updatedby='CDM-36176', updatedon=now()
where teamid='df384b77-289b-4373-ad43-a5abc131766d';
    
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Screening', '1440_15', 'CW', 'Screening', NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980', 'CDM-36176', now(), 'CDM-36176', now(), now(), NULL, NULL, NULL, NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980', NULL);

    
    