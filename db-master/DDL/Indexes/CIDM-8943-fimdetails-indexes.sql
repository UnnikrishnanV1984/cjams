/*
    -- CIDM-8943 Query Optimisation for FimDetails API
    -- Query tuning for `getfimdetails` API
*/

CREATE INDEX idx_meetingrecordingactor_meetingrecordingid ON cjams.meetingrecordingactor (meetingrecordingid);
CREATE INDEX idx_meetingrecordinghearingdetail_meetingrecordingid ON cjams.meetingrecordinghearingdetail (meetingrecordingid);
CREATE INDEX idx_meetingfimdetails_meetingrecordingid ON cjams.meetingfimdetails (meetingrecordingid);