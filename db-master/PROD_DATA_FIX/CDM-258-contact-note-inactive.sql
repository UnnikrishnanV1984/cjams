-- CDM-258 contact note inactivate 3239910

UPDATE progressnote SET activeflag = 0, updatedon = now() WHERE progressnoteid = 'ec55d774-ceec-4f83-ae62-79f73fbbbc43' ;

--CDM-241 2020049015808:The AR Case Summary populated a duplicate narrative tab.

UPDATE Investigationmaltreatment SET activeflag = 0, updatedon=now() WHERE maltreatmentid = '1435687e-d714-4a8d-b917-9a7dc10a53bd' AND activeflag = 1 ;

UPDATE investigationallegation SET activeflag = 0, updatedon=now()  WHERE maltreatmentid = '1435687e-d714-4a8d-b917-9a7dc10a53bd' AND activeflag = 1 ;

UPDATE investigationallegationmaltreators SET activeflag = 0, updatedon=now()  WHERE investigationallegationid IN (
SELECT investigationallegationid  FROM investigationallegation WHERE maltreatmentid = '1435687e-d714-4a8d-b917-9a7dc10a53bd' ) AND activeflag = 1 ;



--CDM-245 2020077017033 duplicate investigation

UPDATE Investigationmaltreatment SET activeflag = 0, updatedon=now() WHERE maltreatmentid IN ('9c5fc032-60fe-4d4a-9e24-f7c654c8c61b','695a03d9-ed7b-4d5e-9150-83a0ec8fcc86');

UPDATE investigationallegation SET activeflag = 0, updatedon=now()  WHERE maltreatmentid IN ('9c5fc032-60fe-4d4a-9e24-f7c654c8c61b','695a03d9-ed7b-4d5e-9150-83a0ec8fcc86');

UPDATE investigationallegationmaltreators SET activeflag = 0, updatedon=now()  WHERE investigationallegationid IN (
SELECT investigationallegationid  FROM investigationallegation WHERE maltreatmentid 
IN ('9c5fc032-60fe-4d4a-9e24-f7c654c8c61b','695a03d9-ed7b-4d5e-9150-83a0ec8fcc86') );
