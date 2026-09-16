UPDATE cjams.participantsubtype
SET  typedescription='School' , updatedon=now()
WHERE participantsubtypeid='7b9e09d4-d379-474a-8677-c0db07441ff7';


UPDATE cjams.participantsubtype
SET typedescription='Mental Health',updatedon=now()
WHERE participantsubtypeid='531b0b88-ea44-4b61-92ab-09daf10aee0b';

INSERT INTO cjams.participantsubtype
(participantsubtypeid, participantsubtypekey, participanttypekey, typedescription, displayorder, activeflag, effectivedate, insertedon, updatedon)
VALUES(gen_random_uuid(), 'FRND', 'IS', 'Friend', 6, 1, Now(), Now(), Now());

