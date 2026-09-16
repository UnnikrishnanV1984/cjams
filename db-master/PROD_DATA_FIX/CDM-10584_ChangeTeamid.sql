-- CDM-10584 - Update teamid for the user from AS to CW to display in workload

update teammember set teamid ='a88ea485-4e05-4c71-9765-18c5f71a6ba2', updatedby ='CDM-10584', updatedon = now() where teammemberid ='618d26cd-48c5-4147-928a-f42220ff8b3c' and activeflag =1;
