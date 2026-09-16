--	D-23722: 3178432 An error stating that character limit has been exceeded in the meeting notes field.
ALTER TABLE cjams.meetingrecording ALTER COLUMN meetingdescription TYPE character varying;