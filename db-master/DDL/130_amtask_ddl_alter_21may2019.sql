UPDATE amtask
SET  activeflag=0, updatedon=now()
WHERE "name"='Service Agreement' and description='Service Agreement' and activitytypekey='services';
