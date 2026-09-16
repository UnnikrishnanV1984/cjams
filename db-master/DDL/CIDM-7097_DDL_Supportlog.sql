/*New column in supportlog table to track jira ticket resolution */

alter table defecttracking.supportlog add column if not exists jiraticketresolution character varying;
COMMENT ON COLUMN defecttracking.supportlog.jiraticketresolution IS 'Updated resolution from JIRA ticket';
