ALTER TABLE defecttracking.supportlog ADD application varchar(20) NULL;
CREATE INDEX supportlog_application_idx ON defecttracking.supportlog (application);
update defecttracking.supportlog set application = 'CW' where application is null and updatedon < NOW() - INTERVAL '1 days' ;

