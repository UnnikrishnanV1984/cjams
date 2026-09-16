export class Fromworkerdetail {
  assignedby!: string;
  cjamspid!: number;
}

export class Toworkerdetail {
  assignedto!: string;
  cjamspid!: number;
}

export class Workload {
  legalguardian!: string;
  localdepartment!: string;
  responsibilitytypekey!: string;
  caseassignmentid!: string;
  casetype!: string;
  selected!: boolean;
  countyname!: string;
  teamname!: string;
  startdate!: Date;
  enddate?: any;
  statustypekey!: string;
  remarks?: any;
  toteamid!: string;
  toworkeridno!: string;
  servicecasenumber!: string;
  servicecaseid!: string;
  fromworkerdetails!: Fromworkerdetail[];
  toworkerdetails!: Toworkerdetail[];
  loadnumber!: string;
  cjamspid!: number;
  assignedto!: number;
  assignedby!: string;
  actiontype!: string;
  isrestricted!: string;
}
