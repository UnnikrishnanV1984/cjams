/*
   Issue Description: CJAMS-64023
   Category/ Module  : Prod data fix to update suspension reason type
   Root cause:  PICK list value is not available in suspensionreasontype 
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update gapsuspension set suspensionreasontypekey = 'OT', updatedby = 'CJAMS-64023', updatedon = now()
where gapid='c9243887-80d6-4827-bcb5-9eaff71db0e6';