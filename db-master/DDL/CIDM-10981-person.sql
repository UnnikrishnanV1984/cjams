ALTER TABLE cjams.person
  ADD COLUMN IF NOT EXISTS limitedenglishproficiency boolean,
  ADD COLUMN IF NOT EXISTS needtranslatorinterpreter boolean,
  ADD COLUMN IF NOT EXISTS readingproficiency boolean,
  ADD COLUMN IF NOT EXISTS writingproficiency boolean,
  ADD COLUMN IF NOT EXISTS speakingproficiency boolean;


-- comments
COMMENT ON COLUMN cjams.person.limitedenglishproficiency IS 'To capture Limited English Proficiency (LEP) for the person';
COMMENT ON COLUMN cjams.person.needtranslatorinterpreter IS 'To capture whether the person needs a translator/interpreter';
COMMENT ON COLUMN cjams.person.readingproficiency IS 'To capture whether the person has Reading proficiency';
COMMENT ON COLUMN cjams.person.writingproficiency IS 'To capture whether the person has Writing proficiency';
COMMENT ON COLUMN cjams.person.speakingproficiency IS 'To capture whether the person has Speaking proficiency';