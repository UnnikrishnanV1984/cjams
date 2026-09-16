ALTER TABLE personemail ADD column if not exists startdate timestamp without time zone null;
ALTER TABLE personemail ADD column if not exists enddate timestamp without time zone null;
ALTER TABLE personphonenumber ADD column if not exists startdate timestamp without time zone null;
ALTER TABLE personphonenumber ADD column if not exists enddate timestamp without time zone null;