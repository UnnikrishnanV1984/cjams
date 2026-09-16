ALTER TABLE investigationallegationmaltreators
ADD column if not exists scisappealformsent varchar(10);

ALTER TABLE investigationallegationmaltreators
ADD column if not exists oasummarydecisionfiledflag varchar(10);

ALTER TABLE investigationallegationmaltreators
ADD column if not exists oasummarydecisionfileddate timestamp;

ALTER TABLE investigationallegationmaltreators
ADD column if not exists oacompiledwithoah varchar(10);