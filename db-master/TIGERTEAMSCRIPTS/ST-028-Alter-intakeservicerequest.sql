-- Please take back up of views DROP the viws and create it after below script has been executed 
ALTER TABLE cjams.intakeservicerequest ALTER COLUMN reporterincidentlocation TYPE text   USING reporterincidentlocation::varchar;
ALTER TABLE cjams.investigationmaltreatment ALTER COLUMN incidentlocationtypekey TYPE text USING incidentlocationtypekey::text;
