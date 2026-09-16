-- CDM-7850 - Update team type key for the user to CW

update userprofile set teamtypekey='CW', updatedby = 'CDM-7850', updatedon = now() where securityusersid='9cdfed48-30e7-4216-9b78-6e6117b0e768' and activeflag=1;