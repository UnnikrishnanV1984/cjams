--CDM-10363 - Update child removal exit date and exit reason

update intakeservreqchildremoval set exitdate = '2020-12-10 00:00:00', removalexitreason = 'REUNIF', updatedby = 'CDM-10363', updatedon = now() where intakeservreqchildremovalid in ('0358c765-f431-4ca6-ad30-695a7afc991d','49bd2326-d1b7-4d53-bf24-4701c4468d09') and activeflag =1;

update intakeservreqchildremoval set exitdate = '2020-09-25 00:00:00', removalexitreason = 'CGUARDNR', updatedby = 'CDM-10363', updatedon = now() where intakeservreqchildremovalid ='4fdf6e69-80c4-4c27-a955-2a7bed3e7a09' and activeflag =1;

update intakeservreqchildremoval set exitdate = '2020-12-29 00:00:00', removalexitreason = 'REUNIF', updatedby = 'CDM-10363', updatedon = now() where intakeservreqchildremovalid ='2fd25bfc-ac7b-401c-a317-bf8b5f93c1ff' and activeflag =1;

update intakeservreqchildremoval set exitdate = '2021-01-22 00:00:00', updatedby = 'CDM-10363', updatedon = now() where intakeservreqchildremovalid ='9ed3862c-a34a-4a85-8806-a5d5d037ddd1' and activeflag =1;