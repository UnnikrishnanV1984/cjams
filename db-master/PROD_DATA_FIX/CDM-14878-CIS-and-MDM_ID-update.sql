update person set
cisclientid = 464060893,
updatedon = now(),
updatedby = 'CDM-14878'
where 
personid = '90501a40-f2a8-4afa-a1a2-2fbc19cc9758';

INSERT INTO personidentifier(                                                                                                                                                                                                                                                                         
                         personid, personidentifiertypekey, personidentifiervalue,                                                                                                                                                                                                                                         
                         insertedby, insertedon, activeflag, effectivedate)                                                                                                                                                                                                                                                
                     VALUES ('90501a40-f2a8-4afa-a1a2-2fbc19cc9758','MDM_ID','MDT-137599520','CDM-14878',now(),1,now());
