ALTER TABLE investigationfinding ALTER COLUMN findingcomments TYPE text USING findingcomments::text;

ALTER TABLE investigationfinding ALTER COLUMN harmdesc TYPE text USING harmdesc::text;

ALTER TABLE investigationfinding ALTER COLUMN omissiondesc TYPE text USING omissiondesc::text;