/*
Issue Description: CJAMS-66429
Category/ Module  : Glitch with Child Removal Review
Root cause: user wants to remove all the cases from case pending approval, this issue might have occurred due to a glitch
Fix provided: Data fix has been done to remove the cases from case pending dashboard
Pull request# for code fix: 
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: 

 */
UPDATE intakeservreqchildremoval
SET
   activeflag = 0,
   updatedby = 'CJAMS-66429',
   updatedon = now ()
WHERE
   intakeservreqchildremovalid in (
      '953f6ff4-a1d3-4a4b-afae-507b5cf9b6b1',
      'acfc08bb-bc7f-4230-8870-07b0a7ef46b2',
      '19063e99-697c-47b5-93cc-f2d6c5e3643c',
      'de470b5c-a8a6-43cb-9bbc-43ad4b67f341',
      '5b5f9537-3dde-4335-898e-1c5fb7703997',
      'cb108bf5-f3b6-4f06-9fc2-e878299cc580',
      '7f9e3bee-5d85-44a7-a39a-f0dd271089ab',
      'ed71bc67-7be4-44a9-b041-ef4033350c23',
      '431d7deb-43d2-42ad-a9e1-34d54cf5f4cb',
      '8f9cc68f-d61f-4968-94f6-09c8ab508c45'
   );

update intakeservreqchildremoval_history
set
   activeflag = 0,
   updatedby = 'CJAMS-66429',
   updatedon = now ()
WHERE
   intakeservreqchildremovalid in (
      '953f6ff4-a1d3-4a4b-afae-507b5cf9b6b1',
      'acfc08bb-bc7f-4230-8870-07b0a7ef46b2',
      '19063e99-697c-47b5-93cc-f2d6c5e3643c',
      'de470b5c-a8a6-43cb-9bbc-43ad4b67f341',
      '5b5f9537-3dde-4335-898e-1c5fb7703997',
      'cb108bf5-f3b6-4f06-9fc2-e878299cc580',
      '7f9e3bee-5d85-44a7-a39a-f0dd271089ab',
      'ed71bc67-7be4-44a9-b041-ef4033350c23',
      '431d7deb-43d2-42ad-a9e1-34d54cf5f4cb',
      '8f9cc68f-d61f-4968-94f6-09c8ab508c45'
   );

update routing
set
   activeflag = 0,
   updatedby = 'CJAMS-66429',
   updatedon = now ()
where
   routingid in (
      '00f114d0-f32e-4ee3-a032-2282f8e0d917',
      '19f03e1d-3eca-4224-95d2-f5e2b6a52064',
      '85b735ce-9832-4592-9872-d7e316e90316',
      '12fbf172-9c9f-4292-b984-c90a795449bf',
      '93585c59-b162-4487-a1b0-c6da76754027',
      'f3cc1098-17cc-4a79-b288-bf97f3c4a8f2',
      '168e4020-ff27-4db6-ae27-c42293c63406',
      'c9aed0c7-087d-4168-8026-27d3e48fe459',
      '2f7db670-62e2-4556-a827-0600d1c2053e',
      'ab4083b7-49ca-4258-abd6-d648a102e199'
   )
   and activeflag = 1;