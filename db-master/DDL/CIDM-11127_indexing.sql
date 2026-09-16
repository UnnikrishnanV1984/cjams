-- Index to optimize joins where routing.objectid (stored as varchar) for sp_list_payable_approvels
CREATE INDEX idx_routing_objectid_bigint
ON routing ((objectid));

COMMENT ON INDEX idx_routing_objectid_bigint IS
  'Index on expression (objectid) to accelerate lookups by objectid.';

CREATE INDEX idx_routing_payable_lookup
ON routing (
  toroleid,
  fromroleid,
  routingstatustypeid,
  activeflag,
  eventcode,
  tosecurityusersid,
  teamid,
  objectid
);

COMMENT ON INDEX idx_routing_payable_lookup IS
  'Composite index to optimize routing/payable lookups filtering by toroleid, fromroleid, routingstatustypeid, activeflag, eventcode, tosecurityusersid, teamid, and objectid.';

--
-- Index to optimize joins where routing.objectid (stored as varchar) for gethospitalizationlistfilter

  CREATE INDEX idx_livingarrangement_objectid
ON cjams.livingarrangement (objectid);

COMMENT ON INDEX idx_livingarrangement_objectid IS
  'Index on livingarrangement expression (objectid) to accelerate lookups by objectid for SP gethospitalizationlistfilter.';

CREATE INDEX idx_placementrevision_objectid_activeflag
ON cjams.placementrevision (objectid, activeflag);

COMMENT ON INDEX idx_placementrevision_objectid_activeflag IS
  'Index on placementrevision expression (objectid) to accelerate lookups by objectid for SP gethospitalizationlistfilter.';
