
-- Service case s incorrectly created through child removal
UPDATE servicecase SET activeflag = 0, updatedon = now() WHERE servicecasenumber = 20200420948;

-- update assessment case 20200420946
UPDATE routing SET activeflag = 0, updatedby = 'CDM-290', updatedon = now() WHERE 
routingid = '2164b6d2-4356-4943-a80f-9a962751fe2b' and eventcode = 'ASST' AND activeflag = 1;
