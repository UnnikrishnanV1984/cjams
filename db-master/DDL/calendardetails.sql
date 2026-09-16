DROP TABLE IF EXISTS cjams.calendardetails;
CREATE TABLE cjams.calendardetails (
    calendardetailsid  uuid NOT NULL DEFAULT gen_random_uuid(),
    securityusersid uuid NOT NULL,
    casenumber varchar(50) NULL,
    personid uuid NOT NULL,
    objectid varchar(50) NULL,
    objecttype varchar(50) NULL,
    eventtimstamp timestamp NULL,
    title varchar(50) NULL,
    appointmenttype varchar(50) NULL,
    appointmentdate timestamp NOT NULL DEFAULT now(),
    starttime varchar(50) NULL,
    endtime varchar(50) NULL,
    address jsonb NULL,
    attendees jsonb NULL,
    locationtype text NULL,
    appointmentdetails text NULL,
    other varchar(500) NULL,
    isinperson boolean NULL,
    insertedby varchar(50) NULL,
    insertedon timestamp NOT NULL DEFAULT now(),
    updatedby varchar(50) NULL,
    updatedon timestamp NOT NULL DEFAULT now(),
    activeflag int4 NOT NULL DEFAULT 1,
    CONSTRAINT pk_calendardetails PRIMARY KEY (calendardetailsid),
    CONSTRAINT fk_calendardetails_person FOREIGN KEY (personid) REFERENCES cjams.person(personid)
);

COMMENT ON COLUMN cjams.calendardetails.calendardetailsid IS 'Unique identifier for the health passport calendar entry';
COMMENT ON COLUMN cjams.calendardetails.securityusersid IS 'ID of the security user related to the calendar event';
COMMENT ON COLUMN cjams.calendardetails.casenumber IS 'Case number associated with the event, if applicable';
COMMENT ON COLUMN cjams.calendardetails.personid IS 'Person ID linked to the calendar entry';
COMMENT ON COLUMN cjams.calendardetails.objectid IS 'Identifier for the associated object, such as service or item related to the event';
COMMENT ON COLUMN cjams.calendardetails.objecttype IS 'Type of object, such as service or item';
COMMENT ON COLUMN cjams.calendardetails.eventtimstamp IS 'Timestamp when the event is logged or triggered';
COMMENT ON COLUMN cjams.calendardetails.title IS 'Title or description of the calendar event';
COMMENT ON COLUMN cjams.calendardetails.appointmenttype IS 'Type of appointment, such as meeting or medical checkup';
COMMENT ON COLUMN cjams.calendardetails.appointmentdate IS 'The date and time of the appointment';
COMMENT ON COLUMN cjams.calendardetails.starttime IS 'Start time of the appointment in a string format';
COMMENT ON COLUMN cjams.calendardetails.endtime IS 'End time of the appointment in a string format';
COMMENT ON COLUMN cjams.calendardetails.address IS 'Address associated with the event stored as a JSON object';
COMMENT ON COLUMN cjams.calendardetails.attendees IS 'List of attendees for the event stored as a JSON array';
COMMENT ON COLUMN cjams.calendardetails.locationtype IS 'Location information for the appointment';
COMMENT ON COLUMN cjams.calendardetails.appointmentdetails IS 'Additional details or notes for the appointment';
COMMENT ON COLUMN cjams.calendardetails.other IS 'Captures any additional information not covered by other defined fields';
COMMENT ON COLUMN cjams.calendardetails.isinperson IS 'Indicates whether the appointment is conducted in person';
COMMENT ON COLUMN cjams.calendardetails.insertedby IS 'The user who inserted the record into the database';
COMMENT ON COLUMN cjams.calendardetails.insertedon IS 'Timestamp when the record was inserted into the database';
COMMENT ON COLUMN cjams.calendardetails.updatedby IS 'The user who last updated the record';
COMMENT ON COLUMN cjams.calendardetails.updatedon IS 'Timestamp when the record was last updated';
COMMENT ON COLUMN cjams.calendardetails.activeflag IS 'Flag indicating whether the calendar entry is active, where 1 means active and 0 means inactive';