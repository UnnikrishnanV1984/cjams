update routing
set routingstatustypeid =16, updatedon =now(), updatedby='CDM-11565'
where objectid ='fd776bb4-73e3-4fa7-b206-c45be0a5c40b';

update gapagreementrevision 
set approvalstatustypekey ='3047', updatedon =now(), updatedby='CDM-11565'
where gapagreementrevisionid ='4c354c77-cffd-4bd9-bf37-7393cf82e4df';

update gapratesrevision 
set  approvaldate =now(), updatedon =now(), updatedby='CDM-11565'
where gaprateid ='dd767a96-7698-4c95-8883-24c75e52ccd5';