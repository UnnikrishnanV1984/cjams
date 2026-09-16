import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonDropdownsService, CommonHttpService, AlertService } from '../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonInfoService } from '../person-info.service';

@Component({
    selector: 'life-skills-assessment',
    templateUrl: './life-skills-assessment.component.html',
    styleUrls: ['./life-skills-assessment.component.scss'],
    standalone: false
})
export class LifeSkillsAssessmentComponent implements OnInit {

  lifeSkill!: FormGroup;
  requiredForApproval:boolean=false;
  isAddEdit = false;
  assessmentTypeList: any[] = [];
  lifeSkillAssessments: any[] = [];
  currentDate = new Date();
  paginationInfo: PaginationInfo = new PaginationInfo();
  deleteIndex: any = null;
  selectedLifeSkill:any = null;
  totalrecords = 0;
  constructor(private formbulider: FormBuilder,
    private _commonDDService: CommonDropdownsService,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService,
    public _personInfoService: PersonInfoService) { }

  ngOnInit() {

    this.lifeSkill = this.formbulider.group({
      assessmenttypekey: [null, Validators.required],
      assessmentlocation: [null, Validators.required],
      assessmentdate:  [null, Validators.required],
      lifeskillassessid: [null],
      personid: [null]
    });

    this._commonDDService.getPickList('10018').subscribe(response => {
      this.assessmentTypeList = response;
    });
    this.loadList();
  }
  resetAll() {
    this.lifeSkill.reset();
    this.isAddEdit = false;
  }
  addNewLifeSkills() {
    this.isAddEdit = true;
  }
  addOrUpdate() {
    this.requiredForApproval=true;
    if (this.lifeSkill.invalid) {
      this._alertService.error('Please fill required fields');
      return;
    }
    const data = this.lifeSkill.getRawValue();
    data.personid = this._personInfoService.getPersonId();
    this._commonHttpService.create(data, 'lifeskillsassessment/addupdate').subscribe(response => {
      this._alertService.success('Life skill assessment added Successfully');
      this.resetAll();
      this.loadList();
    });

  }
  getValidationMessage(controlName: string | number,displayname: string){
 
    if(this.lifeSkill.controls[controlName].status == 'INVALID')
    {
        return 'Please Enter value '+displayname;
    }
  }
  edit(item: { [key: string]: any; }) {
    this.lifeSkill.patchValue(item);
    this.isAddEdit = true;
  }
  pageChanged($event: { page: number; }) {
    this.paginationInfo.pageNumber = $event.page;
    this.loadList();
  }
  loadList () {
    const body = new PaginationRequest({
      where: {personid: this._personInfoService.getPersonId()},
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get',
      count: -1
  });
    this._commonHttpService.getPagedArrayList(body, 'lifeskillsassessment/list?filter').subscribe(list => {
      if (list && Array.isArray(list) && list.length && Array.isArray(list[0].personlifeskillassessmentlist) && list[0].personlifeskillassessmentlist.length) {
        this.lifeSkillAssessments = list[0].personlifeskillassessmentlist;
        this.totalrecords = this.lifeSkillAssessments[0].totalcount;
      } else {
        this.lifeSkillAssessments = [];
      }
    });
  }

  deleteConfirm(item: null, index: number | null) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedLifeSkill = item;
    this.deleteIndex = index;
  }

  delete() {
    this._commonHttpService.remove(this.selectedLifeSkill.lifeskillassessid, {}, 'lifeskillsassessment/delete').subscribe(_ => {
      this._alertService.success('Deleted Life Skill Assessment Successfully');
      this.resetAll();
      this.loadList();
    });
  }
}
