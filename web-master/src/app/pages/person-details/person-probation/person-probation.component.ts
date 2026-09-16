import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, AlertService } from '../../../@core/services';
import { PersonDetailsService } from '../person-details.service';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-probation',
    templateUrl: './person-probation.component.html',
    styleUrls: ['./person-probation.component.scss'],
    standalone: false
})
export class PersonProbationComponent implements OnInit {
  probations: any[] = [];
  selectedProbation: any;
  violationPetitionForm!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  vopConditions: any[] = [];
  vopInitaitedByList: any[] = [];
  totalRecords!: number;
  currenDate: Date = new Date();
  vopconfirmationpopup = '#vop-confirmation-popup';
  constructor(private _formBuilder: FormBuilder, private _personService: PersonDetailsService,
    private _commonHttpService: CommonHttpService, private _alertService: AlertService) { }

  ngOnInit() {
    this.initForm();
    this.loadProbations();
  }

  initForm() {
    this.violationPetitionForm = this._formBuilder.group({
      violationdate: [null, Validators.required],
      notes: [null, Validators.required],
      violationoffense: [null, Validators.required],
      violatedconditions: [null, Validators.required],
      initiatedby: [null, Validators.required]
    });
  }

  loadProbations() {
    this._commonHttpService.getArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: {
        personid: this._personService.person.personid
      }, method: 'get'
    },
      CommonUrlConfig.EndPoint.PERSON.ProbationList).subscribe(res => {
        this.probations = res;
        if (this.probations.length > 0) {
          this.totalRecords = this.probations[0].totalcount;
        }
      });
  }

  getProbationDetails(probation: any) {
    this.initForm();
    this.selectedProbation = probation;
    this.vopConditions = [];
    this.getVopInitatedByList();
    this.openVOPForm();
  }

  openVOPForm() {
    $(this.vopconfirmationpopup).modal('hide');
    $('#probation-popup').modal('show');
  }

  openConfirmation() {
    $(this.vopconfirmationpopup).modal('show');
    $('#probation-popup').modal('hide');
  }

  getVopInitatedByList() {
    this._commonHttpService.getArrayList({
      nolimit: true,
      where: { referencetypeid: 47 }, method: 'get'
    },
      'referencevalues?filter').subscribe(res => {
        this.vopInitaitedByList = res;
      });
  }

  getConditions(offenseType: string, petitionid: string) {
    this._commonHttpService.getArrayList({
      nolimit: true,
      where: {
        vopviolationoffencetype: offenseType,
        intakeservicerequestpetitionid: petitionid
      }, method: 'get'
    },
      CommonUrlConfig.EndPoint.PERSON.VOPConditionList).subscribe(res => {
        this.vopConditions = res;
      });
  }

  generateVOP() {
    const VOP = this.violationPetitionForm.getRawValue();
    this._commonHttpService.create({
      intakeservicerequestpetitionid: this.selectedProbation.intakeservicerequestpetitionid,
      vopnotes: VOP.notes,
      vopviolationoffencetype: VOP.violationoffense,
      vopviolationdate: VOP.violationdate,
      initiatedby: VOP.initiatedby,
      conditiontype: this.arrayToOBjArry(VOP.violatedconditions, 'conditiontypekey', null)
    },
      CommonUrlConfig.EndPoint.PERSON.CreateVOP).subscribe(res => {
        if (res.length) {
          this._alertService.success('VOP Generated Successfully.');
          this.loadProbations();
        } else {
          this._alertService.error('VOP Generation failed. Please try again.');
        }
        $(this.vopconfirmationpopup).modal('hide');
      });
  }

  arrayToOBjArry(list: any, key: any, objkey: any) {
    let result;
    if (list) {
      result = list.map((data: { [x: string]: any; }) => {
        const obj: any = {};
        if (objkey) {
          obj[key] = data[objkey];
        } else {
          obj[key] = data;
        }
        return obj;
      });
    }
    return result;
  }

  pageChanged(pageInfo: { page: number; }) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadProbations();
  }

}
