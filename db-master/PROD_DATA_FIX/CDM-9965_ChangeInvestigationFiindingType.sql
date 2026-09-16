-- CDM-9965 - Change the investigation finding type key to display in summary report

update investigationfinding set investigationfindingtypekey = 'UD', updatedby = 'CDM-9965', updatedon = now() where  investigationfindingid = 'd80c1303-a96e-4561-937e-e22b43ab930a';