-- CDM-9470 - Update Object type key in case assignment record

update caseassignment set objecttypekey = 'servicecase', updatedby = 'CDM-9470', updatedon = now() where  caseassignmentid = 'd04edfb0-0355-44b8-bb79-c221fc0ca862' and objectid = '211064f4-758b-498b-ab24-d35974e3358b' and activeflag =1;
