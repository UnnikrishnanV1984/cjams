ALTER TABLE cjams.visitationlog ALTER COLUMN visitcomments TYPE text(500) USING visitcomments::text;
ALTER TABLE cjams.visitationlog ALTER COLUMN supervisecomments TYPE text(500) USING supervisecomments::text;
ALTER TABLE cjams.visitationlog ALTER COLUMN otherparticipants TYPE text(500) USING otherparticipants::text;
