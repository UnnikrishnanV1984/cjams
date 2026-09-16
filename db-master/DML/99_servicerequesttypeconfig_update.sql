UPDATE servicerequesttypeconfig
SET  duedateoffset=60, updatedon=now()
WHERE intakeservreqtypeid='247a8b26-cdee-4ce8-b36e-b37e49fd0103' and servicerequestsubtypeid='b74ded78-12dc-4e6d-94db-7662d6eaf093';
