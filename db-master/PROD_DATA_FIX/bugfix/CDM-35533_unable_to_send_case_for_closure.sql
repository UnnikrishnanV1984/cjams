/*
 Issue Description: CDM-35533
 Category/ Module : Contacts>notes
 Root cause: 231021101937:Worker is unable to submit the case for closure.
 Fix: Updating the intakeervicerequestdispositioncode, caseassignment and routing tables and adding record in legislative table
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

  INSERT INTO
    cjams.intakeservicerequestdispositioncode (
        intakeservicerequestdispositioncodeid,
        intakeserviceid,
        insertedby,
        insertedon,
        updatedby,
        updatedon,
        timestamp,
        statusdate,
        description,
        expirationdate,
        effectivedate,
        activeflag,
        intakeserreqstatustypeid,
        servicerequesttypeconfigiddispostionid,
        dateofsubpoena,
        subpoenareason,
        lastfacetofacedate,
        seenwithin,
        dateseen,
        reviewcomments,
        reasonfordelay,
        old_id,
        closingcodetypekey,
        servicerequestdispositionsubtypeconfigid,
        servicerequestdispositionsubtypenotes,
        approvalid,
        approvalnaturetypekey,
        entitytypetypekey,
        additionalkey,
        entitykeyid1,
        entitykeyid2,
        requestdate,
        actiondueddate,
        approvestaffid,
        approvalstatustypekey,
        denialreasontypekey,
        requestorcomments,
        approvalcomments,
        currentstatustypekey,
        forwardcountytypekey,
        forwardunitid,
        administratorid,
        datavalidflag,
        clientmergeid,
        etl_userid,
        etl_load_date,
        adultassignedsecurityid
    )
VALUES
(
        'af147c1b-bd26-457a-a740-daeaf32c467f',
        'eba8f0a5-9fff-4862-a405-028d02d7ab8b',
        '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9',
        '2023-12-05 12:00:00.000',
        'CDM-35533',
        '2023-12-05 12:00:00.000',
        NULL,
        '2023-12-05 12:00:00.000',
        '',
        NULL,
        '2023-12-05 12:00:00.000',
        1,
        '7995cecb-062d-406c-8ea9-b1da4b1877d8',
        '02a89a40-85bf-47d0-adc6-6e4f0bea9465',
        NULL,
        NULL,
        NULL,
        NULL,
        '2023-12-05 12:00:00.000',
        'CJAMS ticket submitted to assist with case closure due to inability to complete face-to-face visit with family.',
        '',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    );

-- Insert into routing
INSERT INTO
    cjams.routing (
        routingid,
        eventcode,
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
        updatedby,
        updatedon,
        isreviewrequest,
        remarks,
        old_id,
        routeddescription,
        servicerequestnumber,
        objecttypekey,
        old_from_id,
        old_to_id,
        principaltype,
        actiondatetime,
        etl_userid,
        etl_load_date,
        entityid,
        reassignnotes
    )
VALUES
(
        'd8be4129-784c-4ca2-b51b-7b415ce82d24',
        'INDR',
        '47d1f252-c156-479f-a7c2-414f16a85a63',
        '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9',
        '02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd',
        'CWCW',
        'CWSP',
        'af147c1b-bd26-457a-a740-daeaf32c467f',
        15,
        0,
        '47d1f252-c156-479f-a7c2-414f16a85a63',
        '2023-12-05 17:20:08.376',
        'CDM-35533',
        '2023-12-05 17:20:08.376',
        true,
        'Disposition Approved',
        NULL,
        'Disposition Approved',
        '231021101937',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    );

    
INSERT INTO
    cjams.routing (
        routingid,
        eventcode,
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
        updatedby,
        updatedon,
        isreviewrequest,
        remarks,
        old_id,
        routeddescription,
        servicerequestnumber,
        objecttypekey,
        old_from_id,
        old_to_id,
        principaltype,
        actiondatetime,
        etl_userid,
        etl_load_date,
        entityid,
        reassignnotes
    )
VALUES
(
        '8fb40ee3-4c97-4419-95b1-67fcf49f0efd',
        'INDR',
        '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9',
        '47d1f252-c156-479f-a7c2-414f16a85a63',
        '02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd',
        'CWSP',
        'CWCW',
        'af147c1b-bd26-457a-a740-daeaf32c467f',
        16,
        1,
        '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9',
        '2023-12-05 17:20:08.376',
        'CDM-35533',
        '2023-12-05 17:20:08.376',
        true,
        'Disposition Approved',
        NULL,
        'Disposition Approved',
        '231021101937',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    );


UPDATE
    cjams.intakeservicerequest
SET
    intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
    updatedby = 'CDM-35533',
    updatedon = now()
WHERE
    intakeserviceid = 'eba8f0a5-9fff-4862-a405-028d02d7ab8b';

--caseassignmentid - ee9cbb65-8e57-4d9b-9686-c9dce9a56cc0
UPDATE
    cjams.caseassignment
SET
    updatedby = 'CDM-35533',
    updatedon = now(),
    enddate = '2023-12-05 12:00:00'
where
    caseassignmentid = 'ee9cbb65-8e57-4d9b-9686-c9dce9a56cc0'
    and objectid = 'eba8f0a5-9fff-4862-a405-028d02d7ab8b'
    and fromworkeridno = '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9';

select
    *
from
    legislative
where
    intakeserviceid = 'eba8f0a5-9fff-4862-a405-028d02d7ab8b';

-- No record found
--random_uuid = 'a2dbf19a-cd05-4b49-b0b8-a2a8ab4d5ea6'
INSERT INTO
    cjams.legislative (
        legislativeid,
        intakeserviceid,
        isapprovedsafec,
        activeflag,
        updatedby,
        updatedon,
        insertedby,
        insertedon,
        isinitialfacetoface,
        isapprovedmfira,
        isapprovecansf,
        isvictimperpetrator,
        isallpersons,
        isallegedvicitm,
        isemergency,
        islegislativereporting,
        isreasonnotprovided,
        isdataentrynotes,
        islateinitialcontact
    )
VALUES
(
        'a2dbf19a-cd05-4b49-b0b8-a2a8ab4d5ea6',
        'eba8f0a5-9fff-4862-a405-028d02d7ab8b',
        true,
        1,
        'CDM-35533',
        '2023-12-05 12:00:00',
        '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9',
        '2023-12-05 12:00:00',
        true,
        true,
        false,
        NULL,
        true,
        true,
        Null,
        Null,
        Null,
        Null,
        Null
    );