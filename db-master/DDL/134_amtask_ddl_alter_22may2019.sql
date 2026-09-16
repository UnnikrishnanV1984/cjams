UPDATE amtask
SET  activeflag=0, updatedon=now()
WHERE "name"='Update communication details of meeting with the family or other contacts' and description='Update communication details of meeting with the family or other contacts' and activitytypekey='Investigation';
