-- CDM-10846 - Remove the case assessment request from to be assigned

update routing set activeflag=0, updatedby='CDM-10846', updatedon = now() where routingid='4668d15c-f4b6-4aa3-95cb-385e84c5a0c6';
