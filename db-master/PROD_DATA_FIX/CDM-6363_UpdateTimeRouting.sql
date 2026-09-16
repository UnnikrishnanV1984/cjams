-- CDM-6363 - Modify the updated time in routing table 

update routing set updatedby = 'CDM-6363', updatedon = '2020-10-19 14:23:42' where routingid = '2303df1e-4d4a-4e78-a517-133c50d6e4c0' and activeflag =1 and routingstatustypeid = 2 and eventcode = 'INTR';