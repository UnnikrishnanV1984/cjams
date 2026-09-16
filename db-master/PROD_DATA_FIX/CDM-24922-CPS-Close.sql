/*
   Issue Description: CDM-24922
   Category/ Module  : Case assignment Removal - Old CHESSIE records
   Root cause: user wants to Close the case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- CW2950974 Case Close

INSERT INTO cjams.intakeservicerequestdispositioncode 
    ( intakeservicerequestdispositioncodeid,intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", 
    statusdate, description, expirationdate, effectivedate, activeflag, 
    intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason,
    lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id,
    closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, 
    approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey,
    entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey,
    denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, 
    forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid)
    VALUES('ecdb4fd6-1539-466f-8eb6-6e53174ac4d2', 'ece748ab-a53a-49e0-b57f-46f8c7bc2bd9','ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', now(),'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', now(), NULL,
    now(), NULL, NULL, now(), 1, 
    '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL,
    NULL, NULL, now(), '', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

select routingintake from routingintake('49465306-f583-491b-a9e3-90e41977ed8e'::character varying ,
     'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c' ::character varying,
    'INDR',15,'Disposition approved','ba8e461b-eeb7-4266-aea0-cc8766b6ca8c' ::character varying,true,false,false,
   'Disposition approved','Disposition approved','ece748ab-a53a-49e0-b57f-46f8c7bc2bd9'::character varying,'',0)  ;
 
 update routing set routingstatustypeid=16, updatedby='CDM-24922', updatedon=now() where objectid='ecdb4fd6-1539-466f-8eb6-6e53174ac4d2' ::character varying;
  
 update intakeservicerequest set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby='CDM-24922', updatedon=now() where intakeserviceid='ece748ab-a53a-49e0-b57f-46f8c7bc2bd9';


 --CW2896754 Case Close

 INSERT INTO cjams.intakeservicerequestdispositioncode 
    ( intakeservicerequestdispositioncodeid,intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", 
    statusdate, description, expirationdate, effectivedate, activeflag, 
    intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason,
    lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id,
    closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, 
    approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey,
    entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey,
    denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, 
    forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid)
    
	VALUES('07e67162-8150-4017-8bea-5ba98eeee3d0', 'edcb15ac-7605-4447-8031-9d0a469293a6','ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', now(),'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', now(), NULL,
    now(), NULL, NULL, now(), 1, 
    '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL,
    NULL, NULL, now(), '', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

select routingintake from routingintake('49465306-f583-491b-a9e3-90e41977ed8e'::character varying ,
     'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c' ::character varying,
    'INDR',15,'Disposition approved','ba8e461b-eeb7-4266-aea0-cc8766b6ca8c' ::character varying,true,false,false,
   'Disposition approved','Disposition approved','edcb15ac-7605-4447-8031-9d0a469293a6'::character varying,'',0)  ;

update routing set routingstatustypeid=16, updatedby='CDM-24922', updatedon=now() where objectid='581b768b-91df-49ab-bb31-6a6b9dc53b68' ::character varying;
  
update intakeservicerequest set intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby='CDM-24922', updatedon=now() where intakeserviceid='edcb15ac-7605-4447-8031-9d0a469293a6';