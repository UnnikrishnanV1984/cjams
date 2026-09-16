CREATE FUNCTION cjams_to_date(varchar) RETURNS date AS
$$ select to_date($1, 'YYYY-MM-DD'); $$
LANGUAGE sql immutable;