INSERT INTO cjams.meetingtype(
	meetingtypekey, typedescription, displayorder, activeflag )
	VALUES ( 'AM', 'Assessment Meeting', 7, 1);

UPDATE cjams.meetingtype
	SET  meetingtypekey= 'TLM', typedescription= 'Time Limited Meeting'
	WHERE meetingtypeid = 'fc828524-8023-456b-99cd-34e6640824cf';
