import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { PersonInfoService } from '../../person-info.service';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { ListDataItem, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, AuthService } from '../../../../../@core/services';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import moment from 'moment';

@Component({
    selector: 'list-employment',
    templateUrl: './list-employment.component.html',
    styleUrls: ['./list-employment.component.scss'],
    standalone: false
})
export class ListEmploymentComponent implements OnInit {
  personid:any= '';
  workInfo: any=[];
  selectedemployment= '';
  personNarrative!: FormGroup;
  narrativeInfo: any=[];
  narrativeuniqueInfo: any[]=[];
  selectedProgram= '';
  selectednarrative= '';
  age :any= null;
  selectedProgramName:any= '';
  selectedProgramType= '1';
  enableEdit= false;
  enableEndDateEdit= false;
  addedNarrative= false;
  showNarrrative= false;
  workdetails: any;
  deleteItem: any;
  isClosed = false;
  deletepopupid = '#delete-popup';
  constructor(       //SonarQube - Members are never reassigned; marked it as `readonly`.
  private readonly route: ActivatedRoute,
  private readonly _alertSevice: AlertService,
  private readonly _commonHttpService: CommonHttpService,
  private readonly _personInfoService: PersonInfoService,
  private readonly _formBuilder: FormBuilder,
  public _authService: AuthService
) {
  this.workInfo  = [];
  this.narrativeInfo  = [];
  this.enableEdit = false;
  if (this._personInfoService.personInfo && this._personInfoService.personInfo.personbasicdetails) {
    this.personid = this._personInfoService.personInfo.personbasicdetails.personid;
    this.loadWorkDetails(this._personInfoService.personInfo.personbasicdetails.personid);
    this.loadNarrativeDetails(this._personInfoService.personInfo.personbasicdetails.personid);

    if (this._personInfoService.personInfo.personbasicdetails.dob) {
        const dob = this._personInfoService.personInfo.personbasicdetails.dob;
        this.age = this._personInfoService.calculateAge(dob);
    }

    this._personInfoService.personDobListener$.subscribe(dob => {
      this.age = this._personInfoService.calculateAge(dob);
    });

  }
  this.profileUpdateListener();
  this.reloadPersonWork();
  this.initiateFormGroup();
}
  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personemployment')
  }
  private initiateFormGroup() {
    this.personNarrative = this._formBuilder.group({
      personemploymentid: '',
      promotedemploymentprogramname: '',
      promotedemploymentprogramstartdate: '',
      promotedemploymentprogramenddate: '',
      promotedemploymentnarrative: ''
    }, {validators: this.dateLessThan('promotedemploymentprogramstartdate', 'promotedemploymentprogramenddate')});
  }
  dateLessThan(start: string, end: string) {
    return (group: FormGroup): {[key: string]: any} => {
      const s = group.controls[start];
      const e = group.controls[end];
      if (s.value && e.value && s.value > e.value) {
        return {
          dates: 'End should be greater than start date'
        };
      }
      return {};
    };
}
  editNarrativedetails(workdetails: { [x: string]: any; promotedemploymentprogramenddate?: any; }) {
    this.enableEdit = true;
    this.enableEndDateEdit = true;

    if (!workdetails.promotedemploymentprogramenddate) {
      this.enableEndDateEdit = false;
    }
    this.personNarrative.patchValue(workdetails);
    this.personNarrative?.get('promotedemploymentprogramname')?.disable();

  }

  deleteProgram(narrativedetails: any){
    this.workdetails = narrativedetails;
  }
  
  deleteNarrative() {
    this._personInfoService.deletePersonnarrativeDetails(this.workdetails).subscribe(response => {
      this._alertSevice.success('Program deleted successfully!');
      this.loadNarrativeDetails(this.personid);
  },
    error => {
      // No content to add or call
    }
  );
  }
  addNarrative() {
    this.personNarrative?.get('promotedemploymentnarrative')?.setValidators([Validators.required]);
    this.showNarrrative = true;
  }
  isToday(datestring: any) {
    if (datestring) {
      const date1 = moment(datestring).format('MM/YYYY');
      const date2 = moment().format('MM/YYYY');
      if ( date1 === date2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  cancelForm() {
    this.enableEdit = false; 
    this.enableEndDateEdit = false;
    this.showNarrrative = false;
    this.personNarrative?.get('promotedemploymentprogramname')?.enable();
    this.personNarrative?.get('promotedemploymentnarrative')?.clearValidators();
    this.personNarrative.patchValue({
      personemploymentid: '',
      promotedemploymentprogramname: '',
      promotedemploymentprogramstartdate: '',
      promotedemploymentprogramenddate: '',
      promotedemploymentnarrative: ''
    });


  }
  saveProgram() {
    const data = this.personNarrative?.getRawValue();
    data.promotedemploymentprogramstartdate = data.promotedemploymentprogramstartdate || null;
    data.promotedemploymentprogramenddate = data.promotedemploymentprogramenddate || null;
    this._personInfoService.savePersonnarrativeDetails(data).subscribe(response => {
      if (response.error === 1) {
        this._alertSevice.error(response.message);
      } else {
        this._alertSevice.success('Program added successfully!');
        this.enableEdit = false;
        this.enableEndDateEdit = false;
        this.showNarrrative = false;
        this.personNarrative?.get('promotedemploymentprogramname')?.enable();
        this.personNarrative?.get('promotedemploymentnarrative')?.clearValidators();
        this.personNarrative.patchValue({
          personemploymentid: '',
          promotedemploymentprogramname: '',
          promotedemploymentprogramstartdate: '',
          promotedemploymentprogramenddate: '',
          promotedemploymentnarrative: ''
        });

        this.loadNarrativeDetails(this.personid);
      }
    },
      error => {
        // No content to add or call
      }
    );
  }
  delete() {
    const workdetails= this.deleteItem;
    this._personInfoService.deletePersonworkDetails(workdetails).subscribe(response => {
      (<any>$(this. deletepopupid)).modal('hide');
      this._alertSevice.success('Employment details deleted successfully!');
      this._personInfoService.reloadworkDetails(1);
      this.deleteItem = null;
      this.selectedemployment = '';
  },
    error => {
      // No content to add or call
    }
  );
  }
  onChangeProgram(programdetails: { personemploymentid: string; promotedemploymentprogramname: string; }) {
    this.selectedProgram = programdetails.personemploymentid;
    this.selectedProgramName = programdetails.promotedemploymentprogramname;
  }
  editEmployment(workdetails: {}) {
    this._personInfoService.setWorkInfo(workdetails);
    this._personInfoService.empActionText = 'UPDATE';
  }
  reloadPersonWork() { //SonarQube - revrted back the _self assignment changes
    const _self = this;
    this._personInfoService.personInfoWorkListener$.subscribe(personInfo => {
      if (personInfo === 1) {
        if (_self._personInfoService.personInfo && _self._personInfoService.personInfo.personbasicdetails) {
          _self.loadWorkDetails(_self._personInfoService.personInfo.personbasicdetails.personid);
        }
      }
    });
  }
  profileUpdateListener() {
    const _self = this;
    this._personInfoService.personInfoListener$.subscribe(personInfo => {
      if (!_self.personid || _self.personid === '') {
        _self.personid = personInfo.personbasicdetails.personid;
        _self.loadWorkDetails(personInfo.personbasicdetails.personid);
        _self.loadNarrativeDetails(personInfo.personbasicdetails.personid);
        const dob = personInfo.personbasicdetails.dob;
        _self.age = this._personInfoService.calculateAge(dob);

      }
    });
  }
  loadWorkDetails(personid: string) {
    this.getworkDetails(personid).subscribe(workdetails => {
      this.workInfo = workdetails;
    });
  }
  loadNarrativeDetails(personid: string) {
    this.getNarrativeDetails(personid).subscribe(workdetails => {

      this.narrativeInfo = workdetails;
      this.narrativeuniqueInfo = [];

      //SonarQube fix - used single for-of loop instead of the 2 for loops above
      for(const i of this.narrativeInfo){
        const promotedemploymentprogramname = i.promotedemploymentprogramname;
        if (promotedemploymentprogramname) {
          this.narrativeuniqueInfo.push(i);
        }
      }
    });
  }
  getNarrativeDetails(personid: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/getpersonworknarrative?filter'
      );
  }
  getworkDetails(personid: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/getpersonwork?filter'
      );
  }
  declineDelete() {
    (<any>$(this. deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
    (<any>$(this. deletepopupid)).modal('show');
  }
}

