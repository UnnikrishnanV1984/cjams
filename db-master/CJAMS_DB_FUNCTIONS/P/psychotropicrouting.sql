-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
-- 03/09/2026 vamshikri.byreddy - CIDM-10987 B-236421 : CW-Psychotropic Secondary all request dashboard

DROP FUNCTION IF EXISTS cjams.psychotropicrouting(psychotropic json);
CREATE OR REPLACE FUNCTION cjams.psychotropicrouting(psychotropic json)
 returns character varying
 LANGUAGE plpgsql
AS $function$

DECLARE 
result text;
v_psychotropic json;
 v_statustext character varying; 
v_result text;
v_subjectcondition character varying;
v_usernotificationid uuid;
v_reviewername character varying;
v_personname character varying;
v_newcjamspid int;
V_roleid character varying;
V_caseworker character varying;
v_casenumber character varying;
v_role character varying;
v_Request_id character varying;
    v_curentuser character varying;
    v_user character varying;
    v_curentuserjson jsonb;
    v_routingstatustypeid int;
BEGIN
-- caseworker to review coordinator -->908 psychotropic_initial_submission
--caseworker to review coordinator -->900 caseworker_to_reviewcoordinator
--review coordinator to pharmacist -->901 reviewcoordinator_to_pharmacist
--pharmacist/psychiatrist to review coordinator  -->902 return_to_reviewcoordinator
--review coordinator to psychiatrist -->903 reviewcoordinator_to_psychiatrist
--return-->904 psychotropic_return
--reject-->905 psychotropic_reject
--approved -->16 psychotropic_approve
-- INFORMATION INCOMPLETE --> 906 psychotropic_incomplete
-- PEER TO PEER REVIW --907 peer_to_peer

	v_psychotropic:=psychotropic;
v_statustext:=v_psychotropic ->> 'statustext';

-- caseworker to review coordinator -->908 psychotropic_initial_submission
IF(lower(v_statustext)='psychotropic_initial_submission') then

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
-- tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid, 
activeflag,
insertedby, 
insertedon, 
updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
-- v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
'CWCW', 
'CWPSYCOORD', 
v_psychotropic ->> 'psychotropicid',
908, 
1, 
v_psychotropic ->> 'fromsecurityusersid',
now(),
v_psychotropic ->> 'fromsecurityusersid', now(), null, NULL, null, NULL, NULL, NULL, null, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
v_result:='success';
end if;

IF(lower(v_statustext)='psychotropic_return_reviewcoordinator') then

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
-- tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid, 
activeflag,
insertedby, 
insertedon, 
updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
-- v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
'CWCW', 
'CWPSYCOORD', 
v_psychotropic ->> 'psychotropicid',
902, 
1, 
v_psychotropic ->> 'fromsecurityusersid',
now(),
v_psychotropic ->> 'fromsecurityusersid', now(), null, NULL, null, NULL, NULL, NULL, null, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
v_result:='success';
end if;

	--caseworker to review coordinator -->900 caseworker_to_reviewcoordinator from caseworker to review coordinator
IF(lower(v_statustext)='caseworker_to_reviewcoordinator') then

select routingstatustypeid into v_routingstatustypeid from routing where objectid=v_psychotropic ->> 'psychotropicid' and 
activeflag =1  and eventcode='PSY';

 IF v_routingstatustypeid = 908 THEN
            SELECT jsonb_agg(securityusersid) 
            INTO v_curentuserjson 
            FROM v_userprofile 
            WHERE roletypekey = 'CWPSYCOORD';
        ELSE
            SELECT jsonb_agg(tosecurityusersid) 
            INTO v_curentuserjson 
            FROM routing 
            WHERE objectid = v_psychotropic ->> 'psychotropicid' 
              AND activeflag = 1 
              AND routingstatustypeid = 900 
              AND eventcode = 'PSY';
        END IF;

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid, 
activeflag,
insertedby, 
insertedon, 
updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'fromsecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid'),
'CWPSYCOORD', 
'CWPSYCOORD', 
v_psychotropic ->> 'psychotropicid',
900, 
1, 
v_psychotropic ->> 'fromsecurityusersid',
now(),
v_psychotropic ->> 'fromsecurityusersid', now(), null, NULL, null, NULL, NULL, NULL, null, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SELECT psychotropicrequestid 
        INTO v_Request_id 
        FROM psychotropicmedications 
        WHERE psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid 
          AND activeflag = 1;

        SELECT (u.firstname || ' ' || u.lastname) 
        INTO v_reviewername 
        FROM userprofile u 
        WHERE securityusersid = v_psychotropic ->> 'fromsecurityusersid';

        SELECT cjamspid 
        INTO v_newcjamspid 
        FROM person 
        WHERE personid IN (SELECT personid FROM psychotropicmedications WHERE psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);

        SELECT CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)  
        INTO v_personname 
        FROM person p 
        WHERE personid IN (SELECT personid FROM psychotropicmedications WHERE psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
IF v_routingstatustypeid = 908 THEN
v_subjectcondition := 'Psychotropic Prescription for the client ' || v_personname || ' (CJAMS PID:' || v_newcjamspid || ') has been assigned to the Review Coordinator ' || v_reviewername;
ELSE
        v_subjectcondition := 'Psychotropic Prescription for the client ' || v_personname || ' (CJAMS PID:' || v_newcjamspid || ') has been re-assigned to the Review Coordinator ' || v_reviewername;
END IF;
        FOR v_user IN SELECT * FROM jsonb_array_elements_text(v_curentuserjson) LOOP
            INSERT INTO cjams.usernotification
            (
                securityusersid, 
                usernotificationtypekey, 
                objectid, 
                activeflag, 
                url,
                subject, 
                priorityleveltypekey, 
                body, 
                hasattachments, 
                updatedby, 
                updatedon, 
                insertedby, 
                insertedon, 
                effectivedate, 
                expirationdate, 
                "timestamp", 
                teammemberid, 
                isread, 
                attachmentlocation, 
                isexternalentity, 
                ismailsent, 
                mailsentdate, 
                old_id,
                objecttype, 
                objectcasenumber, 
                entityid, 
                isdeleted, 
                teamtypekey
            )
            VALUES
            (
                v_user, 
                'System', 
                v_psychotropic ->> 'psychotropicid', 
                1, 
                NULL,
                v_subjectcondition,
                'High',
                v_subjectcondition::text,
                NULL, 
                v_psychotropic ->> 'fromsecurityusersid', 
                NOW(),
                v_psychotropic ->> 'fromsecurityusersid', 
                NOW(), 
                NOW(), 
                NOW(), 
                NULL, 
                NULL, 
                NULL, 
                NULL, 
                FALSE, 
                TRUE, 
                NOW(),
                NULL, 
                'psychotropic', 
                v_Request_id,
                NULL, 
                NULL, 
                'CW'
            ) RETURNING "usernotificationid" INTO v_usernotificationid;

            INSERT INTO usernotificationmap
            (
                usernotificationid,
                tosecurityusersid,
                isread,
                effectivedate,
                activeflag,
                updatedby,
                updatedon,
                insertedby,
                insertedon,
                fromsecurityusersid
            ) 
            VALUES 
            (
                v_usernotificationid, 
                v_user, 
                FALSE, 
                NOW(), 
                1, 
                v_psychotropic ->> 'fromsecurityusersid', 
                NOW(), 
                v_psychotropic ->> 'fromsecurityusersid', 
                NOW(), 
                v_psychotropic ->> 'fromsecurityusersid'
            );
        END LOOP;


v_result:='success';
end if;

--review coordinator to pharmacist -->901 reviewcoordinator_to_pharmacist from review coordinator to pharmacist

IF(lower(v_statustext)='reviewcoordinator_to_pharmacist') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role, 
'CWPSYPHARM', 
v_psychotropic ->> 'psychotropicid',
901, 
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;
	

--pharmacist to review coordinator  -->902 return_to_reviewcoordinator from pharmacist to review coordinator

IF(lower(v_statustext)='return_to_reviewcoordinator') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';
select fromsecurityusersid into V_caseworker from routing where objectid =v_psychotropic ->> 'psychotropicid' and eventcode ='PSY' and routingstatustypeid in (901,903) order by insertedon desc limit 1 ;

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
-- tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
-- V_caseworker, 
(select teamid  from v_userprofile where securityusersid= V_caseworker),
v_role, 
'CWPSYCOORD', 
v_psychotropic ->> 'psychotropicid',
902,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

--pharmacist/psychiatrist to review coordinator  -->900 return_to_reviewcoordinator/assign_to_reviewcoordinator from pharmacist/psychiatrist to review coordinator
IF(lower(v_statustext)='assign_to_reviewcoordinator') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role, 
'CWPSYCOORD', 
v_psychotropic ->> 'psychotropicid',
900,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

--review coordinator to pharmacist -->901 reviewcoordinator_to_pharmacist from review coordinator to pharmacist
IF(lower(v_statustext)='sp_cw_assign') then

select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role , 
'CWCW', 
v_psychotropic ->> 'psychotropicid',
904,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;
--review coordinator to pharmacist -->901 reviewcoordinator_to_pharmacist from review coordinator to pharmacist

IF(lower(v_statustext)='pharmacist_to_pharmacist') then

select tosecurityusersid  into v_curentuser from routing where objectid=v_psychotropic ->> 'psychotropicid' and 
activeflag =1 and routingstatustypeid =901 and eventcode='PSY';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid', 
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
'CWPSYPHARM', 
'CWPSYPHARM', 
v_psychotropic ->> 'psychotropicid',
901, 
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());

select psychotropicrequestid into v_Request_id from psychotropicmedications where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and activeflag=1;
select (u.firstname || ' ' || u.lastname) into v_reviewername from userprofile u where securityusersid =v_psychotropic ->> 'fromsecurityusersid';
SELECT cjamspid INTO v_newcjamspid FROM person WHERE personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select (concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname))  into v_personname from person p where personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);


-- v_subjectcondition :=' Psychotropic Prescription Review has been approved for the client '  ||  (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') by ' || (v_role) ||' '|| (v_reviewername)  ;
v_subjectcondition := ' Psychotropic Prescription for the client ' || (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') has been re-assigned to the Pharmacist '||(v_reviewername) ;


INSERT INTO cjams.usernotification
( securityusersid, usernotificationtypekey, objectid, activeflag, url,
 subject, priorityleveltypekey, body, hasattachments, 
 updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id,
objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
VALUES( v_curentuser,'System', v_psychotropic ->> 'psychotropicid', 1, NULL,
v_subjectcondition,
 'High',
v_subjectcondition::text,
 NULL, 
 v_psychotropic ->> 'fromsecurityusersid', now(),
v_psychotropic ->> 'fromsecurityusersid', now(), now(), now(), NULL, NULL, NULL, NULL, false, true, now(),
NULL, 'psychotropic', v_Request_id,
 NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;

INSERT INTO usernotificationmap(usernotificationid,tosecurityusersid,isread,                                                                                                                                                                                                                
 effectivedate,activeflag,updatedby,                                                                                                                                                                                                                                                         
 updatedon,insertedby,insertedon,fromsecurityusersid)                                                                                                                                                                                                                                                            
 VALUES (v_usernotificationid,v_curentuser,false,                                                                                                                                                                                                                                    
         now(),1,v_psychotropic ->> 'fromsecurityusersid',                                                                                                                                                                                                                                                         
         now(),v_psychotropic ->> 'fromsecurityusersid',now(),v_psychotropic ->> 'fromsecurityusersid');

v_result:='success';
end if;

IF(lower(v_statustext)='psychiatrist_to_psychiatrist') then

select tosecurityusersid  into v_curentuser from routing where objectid=v_psychotropic ->> 'psychotropicid' and 
activeflag =1 and routingstatustypeid =903 and eventcode='PSY';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid', 
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
'CWPSYPSYCH', 
'CWPSYPSYCH', 
v_psychotropic ->> 'psychotropicid',
903,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());

select psychotropicrequestid into v_Request_id from psychotropicmedications where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and activeflag=1;
select (u.firstname || ' ' || u.lastname) into v_reviewername from userprofile u where securityusersid =v_psychotropic ->> 'fromsecurityusersid';
SELECT cjamspid INTO v_newcjamspid FROM person WHERE personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select (concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname))  into v_personname from person p where personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);


-- v_subjectcondition :=' Psychotropic Prescription Review has been approved for the client '  ||  (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') by ' || (v_role) ||' '|| (v_reviewername)  ;
v_subjectcondition := ' Psychotropic Prescription for the client ' || (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') has been re-assigned to the Psychiatrist '||(v_reviewername) ;


INSERT INTO cjams.usernotification
( securityusersid, usernotificationtypekey, objectid, activeflag, url,
 subject, priorityleveltypekey, body, hasattachments, 
 updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id,
objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
VALUES( v_curentuser,'System', v_psychotropic ->> 'psychotropicid', 1, NULL,
v_subjectcondition,
 'High',
v_subjectcondition::text,
 NULL, 
 v_psychotropic ->> 'fromsecurityusersid', now(),
v_psychotropic ->> 'fromsecurityusersid', now(), now(), now(), NULL, NULL, NULL, NULL, false, true, now(),
NULL, 'psychotropic', v_Request_id,
 NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;

INSERT INTO usernotificationmap(usernotificationid,tosecurityusersid,isread,                                                                                                                                                                                                                
 effectivedate,activeflag,updatedby,                                                                                                                                                                                                                                                         
 updatedon,insertedby,insertedon,fromsecurityusersid)                                                                                                                                                                                                                                                            
 VALUES (v_usernotificationid,v_curentuser,false,                                                                                                                                                                                                                                    
         now(),1,v_psychotropic ->> 'fromsecurityusersid',                                                                                                                                                                                                                                                         
         now(),v_psychotropic ->> 'fromsecurityusersid',now(),v_psychotropic ->> 'fromsecurityusersid'); 
v_result:='success';
end if;

--review coordinator to psychiatrist -->903 reviewcoordinator_to_psychiatrist from review coordinator to psychiatrist

IF(lower(v_statustext)='reviewcoordinator_to_psychiatrist') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role, 
'CWPSYPSYCH', 
v_psychotropic ->> 'psychotropicid',
903,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

IF(lower(v_statustext)='pharmacist_to_psychiatrist') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role, 
'CWPSYPSYCH', 
v_psychotropic ->> 'psychotropicid',
903, 
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

IF(lower(v_statustext)='psychiatrist_to_pharmacist') then
select roletypekey into v_role from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid';
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'tosecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'tosecurityusersid'),
v_role, 
'CWPSYPHARM', 
v_psychotropic ->> 'psychotropicid',
901, 
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

--return-->904 psychotropic_return from pharmacist/psychiatrist to caseworker

IF(lower(v_statustext)='psychotropic_return') then

select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';
select insertedby into V_caseworker from psychotropicmedications where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and activeflag=1;
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
V_caseworker, 
(select teamid  from v_userprofile where securityusersid=V_caseworker),
V_roleid , 
'CWCW', 
v_psychotropic ->> 'psychotropicid',
904,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());

--notification to caseworker
if(V_roleid='CWPSYPHARM') THEN
v_role:='Pharmacist';
end if;
if(V_roleid='CWPSYPSYCH') THEN
v_role:='Psychiatrist';
end if;
if(V_roleid='CWPSYCOORD') THEN
v_role:='Coordinator';
end if;
select (u.firstname || ' ' || u.lastname) into v_reviewername from userprofile u where securityusersid =v_psychotropic ->> 'fromsecurityusersid';
SELECT cjamspid INTO v_newcjamspid FROM person WHERE personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select (concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname))  into v_personname from person p where personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select p.psychotropicrequestid into v_casenumber
from psychotropicmedications p
-- left join servicecase s on s.servicecaseid=p.objectid::uuid and s.activeflag =1
-- left join adoptioncase a  on a.adoptioncaseid=p.objectid::uuid and a.activeflag =1 
where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and p.activeflag =1;

-- v_subjectcondition := 'Psychotropic Primary review has been rejected for the client ' ||  (v_personname) || '(CJAMS PID:' || (v_newcjamspid) || ') by Primary reviewer '|| (v_reviewername)  ;
v_subjectcondition :=' Psychotropic Prescription Review has been returned for the client '  ||  (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') by ' || (v_role) ||' '|| (v_reviewername)  ;

INSERT INTO cjams.usernotification
( securityusersid, usernotificationtypekey, objectid, activeflag, 
 subject, priorityleveltypekey, body, hasattachments, 
 updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id,
objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
VALUES( V_caseworker,'System', v_psychotropic ->> 'psychotropicid', 1,
v_subjectcondition,
 'High',
(v_subjectcondition)::text,
 NULL, 
 v_psychotropic ->> 'fromsecurityusersid', now(),
v_psychotropic ->> 'fromsecurityusersid', now(), now(), now(), NULL, NULL, NULL, NULL, false, true, now(),
NULL, 'psychotropic', v_casenumber,
 NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;

INSERT INTO usernotificationmap(usernotificationid,tosecurityusersid,isread,                                                                                                                                                                                                                
 effectivedate,activeflag,updatedby,                                                                                                                                                                                                                                                         
 updatedon,insertedby,insertedon,fromsecurityusersid)                                                                                                                                                                                                                                                            
 VALUES (v_usernotificationid,V_caseworker,false,                                                                                                                                                                                                                                    
         now(),1,v_psychotropic ->> 'fromsecurityusersid',                                                                                                                                                                                                                                                         
         now(),v_psychotropic ->> 'fromsecurityusersid',now(),v_psychotropic ->> 'fromsecurityusersid'); 
		  
v_result:='success';
end if;


--reject-->905 psychotropic_reject from pharmacist/psychiatrist to caseworker

IF(lower(v_statustext)='psychotropic_reject') then

BEGIN

    select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';
    select insertedby into V_caseworker from psychotropicmedications where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and activeflag=1;
    update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
    where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

    INSERT INTO cjams.routing
    ( eventcode, 
    fromsecurityusersid, 
    tosecurityusersid,
    teamid,
    fromroleid,
    toroleid,
    objectid,
    routingstatustypeid,
    routeddescription,
    remarks,
    reassignnotes,
    activeflag,
    insertedby, 
    insertedon)
    VALUES( 'PSY', 
    v_psychotropic ->> 'fromsecurityusersid',
    V_caseworker, 
    (select teamid  from v_userprofile where securityusersid=V_caseworker),
    V_roleid , 
    'CWCW', 
    v_psychotropic ->> 'psychotropicid',
    905,
    v_psychotropic ->> 'comments',
    v_psychotropic ->> 'rejectcomments',
    v_psychotropic ->> 'rejectreason',
    1, 
    v_psychotropic ->> 'fromsecurityusersid',
    now());

    --notification to caseworker
    if(V_roleid='CWPSYPHARM') THEN
    v_role:='Pharmacist';
    end if;
    if(V_roleid='CWPSYPSYCH') THEN
    v_role:='Psychiatrist';
    end if;
    select (u.firstname || ' ' || u.lastname) into v_reviewername from userprofile u where securityusersid =v_psychotropic ->> 'fromsecurityusersid';
    SELECT cjamspid INTO v_newcjamspid FROM person WHERE personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
    select (concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname))  into v_personname from person p where personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
    select p.psychotropicrequestid into v_casenumber
    from psychotropicmedications p
    -- left join servicecase s on s.servicecaseid=p.objectid::uuid and s.activeflag =1
    -- left join adoptioncase a  on a.adoptioncaseid=p.objectid::uuid and a.activeflag =1 
    where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and p.activeflag =1;

    v_subjectcondition :=' Psychotropic Prescription Review has been rejected for the client '  ||  coalesce(v_personname, ' ') || ' (CJAMS PID:' || coalesce(v_newcjamspid, 0) || ') by ' || coalesce(v_role, ' ') ||' '|| coalesce(v_reviewername, ' ') ;

    INSERT INTO cjams.usernotification
    ( securityusersid, usernotificationtypekey, objectid, activeflag, url,
    subject, priorityleveltypekey, body, hasattachments, 
    updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id,
    objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
    VALUES( V_caseworker,'System', v_psychotropic ->> 'psychotropicid', 1, NULL,
    v_subjectcondition,
    'High',
    v_subjectcondition::text,
    NULL, 
    v_psychotropic ->> 'fromsecurityusersid', now(),
    v_psychotropic ->> 'fromsecurityusersid', now(), now(), now(), NULL, NULL, NULL, NULL, false, true, now(),
    NULL, 'psychotropic', v_casenumber,
    NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;

    INSERT INTO usernotificationmap(usernotificationid,tosecurityusersid,isread,                                                                                                                                                                                                                
    effectivedate,activeflag,updatedby,                                                                                                                                                                                                                                                         
    updatedon,insertedby,insertedon,fromsecurityusersid)                                                                                                                                                                                                                                                            
    VALUES (v_usernotificationid,V_caseworker,false,                                                                                                                                                                                                                                    
            now(),1,v_psychotropic ->> 'fromsecurityusersid',                                                                                                                                                                                                                                                         
            now(),v_psychotropic ->> 'fromsecurityusersid',now(),v_psychotropic ->> 'fromsecurityusersid'); 

    EXCEPTION
    WHEN OTHERS THEN
        v_result := 'failure';
    END;
    v_result:='success';
end if;

--906 psychotropic_incomplete 

IF(lower(v_statustext)='psychotropic_incomplete') then
select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon,
updatedon,
updatedby)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'fromsecurityusersid',
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid'),
V_roleid, 
V_roleid, 
v_psychotropic ->> 'psychotropicid',
906,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now(),
now(),
v_psychotropic ->> 'fromsecurityusersid'
);
v_result:='success';
end if;

-- incomplete_to_reviewcordinator 

IF(lower(v_statustext)='incomplete_to_reviewcordinator') then
select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'fromsecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid'),
V_roleid, 
V_roleid, 
v_psychotropic ->> 'psychotropicid',
900,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());
v_result:='success';
end if;

--907 peer_to_peer 

IF(lower(v_statustext)='peer_to_peer') then
select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon,
 updatedon,
updatedby)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
v_psychotropic ->> 'fromsecurityusersid', 
(select teamid  from v_userprofile where securityusersid=v_psychotropic ->> 'fromsecurityusersid'),
V_roleid, 
V_roleid, 
v_psychotropic ->> 'psychotropicid',
907,
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now(),
now(),
v_psychotropic ->> 'fromsecurityusersid');
v_result:='success';
end if;

--approve -->16 psychotropic_approve from pharmacist/psychiatrist to caseworker

IF(lower(v_statustext)='psychotropic_approve') then

select toroleid  into V_roleid  from cjams.routing where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';
select insertedby into V_caseworker from psychotropicmedications where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and activeflag=1;
update cjams.routing set activeflag =0,updatedby=v_psychotropic ->> 'fromsecurityusersid',updatedon=now()
where objectid=v_psychotropic ->> 'psychotropicid' and activeflag=1 and eventcode='PSY';

INSERT INTO cjams.routing
( eventcode, 
fromsecurityusersid, 
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
routeddescription,
activeflag,
insertedby, 
insertedon)
VALUES( 'PSY', 
v_psychotropic ->> 'fromsecurityusersid',
V_caseworker, 
(select teamid  from v_userprofile where securityusersid=V_caseworker),
V_roleid , 
'CWCW', 
v_psychotropic ->> 'psychotropicid',
16, 
v_psychotropic ->> 'comments',
1, 
v_psychotropic ->> 'fromsecurityusersid',
now());

-- notification to caseworker
if(V_roleid='CWPSYPHARM') THEN
v_role:='Pharmacist';
end if;
if(V_roleid='CWPSYPSYCH') THEN
v_role:='Psychiatrist';
end if;
select (u.firstname || ' ' || u.lastname) into v_reviewername from userprofile u where securityusersid =v_psychotropic ->> 'fromsecurityusersid';
SELECT cjamspid INTO v_newcjamspid FROM person WHERE personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select (concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname))  into v_personname from person p where personid in (select personid from psychotropicmedications where psychotropicid = (v_psychotropic ->> 'psychotropicid')::uuid);
select p.psychotropicrequestid into v_casenumber
from psychotropicmedications p
-- left join servicecase s on s.servicecaseid=p.objectid::uuid and s.activeflag =1
-- left join adoptioncase a  on a.adoptioncaseid=p.objectid::uuid and a.activeflag =1 
where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid and p.activeflag =1;

v_subjectcondition :=' Psychotropic Prescription Review has been approved for the client '  ||  (v_personname) || ' (CJAMS PID:' || (v_newcjamspid) || ') by ' || (v_role) ||' '|| (v_reviewername)  ;


INSERT INTO cjams.usernotification
( securityusersid, usernotificationtypekey, objectid, activeflag, url,
 subject, priorityleveltypekey, body, hasattachments, 
 updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", teammemberid, isread, attachmentlocation, isexternalentity, ismailsent, mailsentdate, old_id,
objecttype, objectcasenumber, entityid, isdeleted, teamtypekey)
VALUES( V_caseworker,'System', v_psychotropic ->> 'psychotropicid', 1, NULL,
v_subjectcondition,
 'High',
v_subjectcondition::text,
 NULL, 
 v_psychotropic ->> 'fromsecurityusersid', now(),
v_psychotropic ->> 'fromsecurityusersid', now(), now(), now(), NULL, NULL, NULL, NULL, false, true, now(),
NULL, 'psychotropic', v_casenumber,
 NULL, NULL, 'CW') RETURNING "usernotificationid" INTO  v_usernotificationid;

INSERT INTO usernotificationmap(usernotificationid,tosecurityusersid,isread,                                                                                                                                                                                                                
 effectivedate,activeflag,updatedby,                                                                                                                                                                                                                                                         
 updatedon,insertedby,insertedon,fromsecurityusersid)                                                                                                                                                                                                                                                            
 VALUES (v_usernotificationid,V_caseworker,false,                                                                                                                                                                                                                                    
         now(),1,v_psychotropic ->> 'fromsecurityusersid',                                                                                                                                                                                                                                                         
         now(),v_psychotropic ->> 'fromsecurityusersid',now(),v_psychotropic ->> 'fromsecurityusersid'); 

v_result:='success';
end if;

IF(lower(v_result)='success') then
RETURN v_result;
else
v_result:='something went wrong';
RETURN v_result;
end if;

END;

$function$
;