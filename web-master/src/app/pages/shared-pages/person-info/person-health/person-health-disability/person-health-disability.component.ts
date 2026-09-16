import { Component, OnInit, OnDestroy, Input, Injector } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PersonDisabilityService } from '../../../person-disability/person-disability.service';
import { DataStoreService, AlertService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { PersonInfoService } from '../../person-info.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { Subscription } from 'rxjs';
import { PAGES_STORE_CONSTANTS } from '../../../../pages.constants';
import { ChildRemovalService } from '../../../../case-worker/dsds-action/child-removal/child-removal.service';

declare var $ : any;

@Component({
    selector: 'person-health-disability',
    templateUrl: './person-health-disability.component.html',
    styleUrls: ['./person-health-disability.component.scss'],
    standalone: false
})
export class PersonHealthDisabilityComponent implements OnInit, OnDestroy {

  @Input()
  removalPersonid!: string;
  @Input()
  disabled!: boolean;
  childhasdisability!: boolean;
  nodisability!: boolean;
  resultreceived  = "unknown";
  personDisabilities: any[] = [];
  personId: any;
  subscription!: Subscription;
  personDisabilityForm!: FormGroup;
  dateStart!: boolean;
  ispersonProfile!: boolean;
  isEditMode!: boolean;
  personDisabilityid!: string | null;
  disabilityTypes: any = [];
  disabilityConditions: any = [];
  disablityFlag = false;
  hasDisability: any;
  NoDisability: any[] = [];
  UnknownDisability: any[] = [];
  specialNeeds: any[] = [];
  personalHygieneList: any[] = [];
  selectedItem: any;
  SAVE_QUEUE = 0;
  isSaveQueueInprogress = false;
  disabilityhistory: any[] = [];
  isSelected: any ='';
  showdisability!: boolean;
  description: any;
  disabilitycheckboxes: any = [
    {
      name:'existingcondition',
      label :'Existing Condition',
      status: true
    },
    {
      name:'previouscondition',
      label:'Previous Condition',
      status: true
    },
    {
      name:'doesnotapply',
      label :'Does not Apply',
      status: true
    }
  ];
  checkmandatory: boolean = false;
  savedisabilityrequired: boolean =false;
  adddisabilitypopupid = '#add-disability';
  resetconfirmpopupid = '#reset-confirm';
  removedisabilitypopupid = '#remove-disability';

   private _service: PersonDisabilityService;
    private _dataStoreService: DataStoreService;
    private _router: Router;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _personInfoService: PersonInfoService;
    private _childRemovalService: ChildRemovalService;
    private _authService: AuthService;

  constructor(private injector: Injector){
    this._service = this.injector.get<PersonDisabilityService>(PersonDisabilityService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._childRemovalService = this.injector.get<ChildRemovalService>(ChildRemovalService);
    this._authService = this.injector.get<AuthService>(AuthService);
    
 }

  ngOnInit() {
    const personid = this.removalPersonid ? this.removalPersonid : this._personInfoService.getPersonId();
    this.personId = personid;
    const urlSegments = this._router.url.split('/');
    if (urlSegments && urlSegments.length) {
      const routeLength = urlSegments.length;
      this.ispersonProfile =  urlSegments[routeLength - 1 ] === 'disability' ? true : false;
    }
    this.listenForPersonDisability();
    this.initForm();
    this.loadDropDowns();
    if (this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.disabilitysave')) {
      this.disabled = true;
    }
  }

  initForm() {
    this.personDisabilityForm = this._formBuilder.group({
      persondisabilityid: [null],
      personid: [this.personId],
      disabilityconditiontypekey: [null, Validators.required],
      diagnoiseddisabilitynotes: [null],
      startdate: [null],
      startdateunknown: [null],
      existingcondition :[null],
      previouscondition :[null],
      doesnotapply :[null], 
      enddate: [null],
      disabilityflag: [null],
      evaluationdate: [null],
      evaluatorname: [null],
      specialkey: [null],
      hygienekey: [null],
      disabilitytypekey: [null, Validators.required],
      comments: [null],
      isnew:[null]
    });
  }

  loadDropDowns() {
    this._service.getDisabilityTypes().subscribe(response => {
      if (response && Array.isArray(response)) {
        this.loadPersonDisabilityList();
        this.disabilityTypes = response;
        this.setDisabiltyFields();
      }
    });
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'picklist_type_id': '203', 'delete_sw': 'N' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    ).subscribe(response => {
      this.specialNeeds = response;
    });
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'picklist_type_id': '137', 'delete_sw': 'N' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    ).subscribe(response => {
      this.personalHygieneList = response;
    });
    this.disabilityConditions = [{
      'value_text': 'Yes',
      'description': 'Yes'
    },
    {
      'value_text': 'No',
      'description': 'No'
    },
    {
      'value_text': 'Unknown',
      'description': 'Unknown'
    }];
  }

  clearStartdate(event: any) {
    if (event) {
      this.personDisabilityForm.get('startdate')?.clearValidators();
      this.personDisabilityForm.get('startdate')?.updateValueAndValidity();
      this.personDisabilityForm.get('startdate')?.setValue(null);
      this.personDisabilityForm.controls['startdate'].disable();
      this.dateStart = true;
    } else {
      this.personDisabilityForm.get('startdate')?.setValidators([Validators.required]);
      this.personDisabilityForm.get('startdate')?.updateValueAndValidity();
      this.personDisabilityForm.controls['startdate'].enable();
      this.dateStart = false;
    }
  }


  saveDisability() {
    this.savedisabilityrequired =true;
    this.checkmandatory =true;
    if (this.personDisabilityForm.invalid) {
      this._alertService.error('please fill required fields');
      return;
    }
    const data = this.personDisabilityForm.getRawValue();
    data.personid = this.personId;
    this._service.createDisability(data).subscribe(response => {
      this.reset();
      this.selectedItem = null;
      this._alertService.success('Disability added successfully');
      this.loadPersonDisabilityList();
    });
  }




  loadPersonDisabilityList() {
    this._service.getDisabilityList(this.personId).subscribe(response => {
      this._dataStoreService.setData(PAGES_STORE_CONSTANTS.PERSON_DISABILITY_PRINSTINE, false);
      const disabilityInfo = {
        personid: this.personId,
        hasDisability: this.hasDisability === "false" ? false : "unknown"
      };
      if (response && Array.isArray(response) && response.length) {
        this.personDisabilities = response;
        disabilityInfo.hasDisability = true;
        const yesDisablities = this.personDisabilities.filter(pd => pd.disabilityconditiontypekey === 'Yes');
        const noDisablities = this.personDisabilities.filter(pd => pd.disabilityconditiontypekey === 'No');
        const unkDisablities = this.personDisabilities.filter(pd => pd.disabilityconditiontypekey === 'Unknown');
        
        if (this.personDisabilities.length === 0) {
          this.hasDisability = null;
        } else if (yesDisablities && yesDisablities.length > 0 ) {
          this.hasDisability = "true";
        } else if (noDisablities && noDisablities.length > 0) {
          this.hasDisability = "false";
        }
        else if(unkDisablities && unkDisablities.length>0) {
          if(this.personDisabilities[0].selectdisability){
            this.hasDisability = this.personDisabilities[0].selectdisability;
          } 
        } 
      } else {
        this.personDisabilities = [];
        this.hasDisability = null;
        disabilityInfo.hasDisability = false;
        
      }
      this._childRemovalService.removalDisabilityConfig$.next(disabilityInfo);
      this.setDisabiltyFields();
    });
  }

  loadPersonDisabilityHistory() {
    this._service.getDisabilityHistory(this.personId).subscribe(response => {
      this.disabilityhistory = response;
      $('#disability-history').modal('show');
    });
  }

  openDisabilityForm() {
    this._router.navigate(['disability/' + this.personId + '/create'], { relativeTo: this.route });
  }

  listenForPersonDisability() {
    this.subscription = this._dataStoreService.currentStore.subscribe(store => {
      if (store.SUBSCRIPTION_TARGET === 'DISABILITY') {
        this.loadPersonDisabilityList();
      }
    });
  }



  deleteConfirm(item: any) {
    $('#delete-popup').modal('show');
    this.selectedItem = item;
  }

  delete() {
    this._service.deleteDisability(this.selectedItem.persondisabilityid).subscribe(response => {
      this._alertService.success('Disability deleted successfully');
      this.disabilityTypes.forEach((element: { ref_key: any; conditionType: null; }) => {
        if (element.ref_key === this.selectedItem.disabilitytypekey) {
          element.conditionType = null;
        }
      });
      this.loadPersonDisabilityList();
    });
  }

  addDisability(item: any, disabilitycondition: any) {
    this.isSelected = disabilitycondition;
    this.selectedItem = item;
    this.personDisabilityForm.patchValue({ disabilitytypekey: item.ref_key });
    this.personDisabilityForm.patchValue({ disabilityconditiontypekey: disabilitycondition });
    if (disabilitycondition === "Yes") {
      $(this.adddisabilitypopupid).modal('show');
      if (this.personDisabilityForm.get('startdateunknown')?.value && this.personDisabilityForm.get('startdateunknown')?.value === true) {
        this.personDisabilityForm.get('startdate')?.clearValidators();
        this.personDisabilityForm.get('startdate')?.updateValueAndValidity();
        this.personDisabilityForm.get('startdate')?.setValue(null);
        this.personDisabilityForm.controls['startdate'].disable();
        this.dateStart = true;
      } else {
        this.personDisabilityForm.get('startdate')?.setValidators([Validators.required]);
        this.personDisabilityForm.get('startdate')?.updateValueAndValidity();
        this.personDisabilityForm.controls['startdate'].enable();
        this.dateStart = false;
      }
    } else  {
      this.setNoDisabilities(item, disabilitycondition);
    }
    
    this._dataStoreService.setData(PAGES_STORE_CONSTANTS.PERSON_DISABILITY_PRINSTINE, true);
  }
  resetDisabilityForm() {
    this.reset();
    this.disabilityTypes.forEach((element: { conditionType: null; }) => {
      element.conditionType = null;
    });
    this.NoDisability = [];
    this.loadPersonDisabilityList();
  }
  saveDisablityQueue(data: any) {
    data.persondisabilityid = null;
    data.selectdisability = this.hasDisability;
    
    this._service.createDisability(data).subscribe((response: any) => {
        if(this.isSelected === "No") {
          this.SAVE_QUEUE =  this.SAVE_QUEUE + 1; 
      if (this.SAVE_QUEUE <= this.NoDisability.length - 1) {
        this.saveDisablityQueue(this.NoDisability[this.SAVE_QUEUE]);
      } else {
        this._alertService.success('Disability saved successfully');
        this.isSaveQueueInprogress = false;
        this.NoDisability = [];
        this.loadPersonDisabilityList();
      }
    }
    else if(this.isSelected =="Unknown"){
      this.SAVE_QUEUE =  this.SAVE_QUEUE + 1; 
      if (this.SAVE_QUEUE <= this.UnknownDisability.length - 1) {
              this.saveDisablityQueue(this.UnknownDisability[this.SAVE_QUEUE]);
        
      } else {
        this._alertService.success('Disability saved successfully');
        this.isSaveQueueInprogress = false;
        this.UnknownDisability = [];
        this.loadPersonDisabilityList();
      }
    }
    });
  

  }
  
  submitDisability() {
    this.checkmandatory = true;
    const totalDisabilityTypeCount = this.disabilityTypes.length;
    if(this.hasDisability === 'true'){
      //Check if atleast one disability is selected when they select child has disability.
      const yesDisabilityFromBE = this.personDisabilities?.filter(pd => pd.disabilityconditiontypekey === 'Yes') || [];
      let containsDisability = false ;
      for(const currentDisability of yesDisabilityFromBE){
        if(!this.NoDisability?.find((i)=>i.disabilitytypekey === currentDisability.disabilitytypekey) && 
           !this.UnknownDisability?.find((i)=>i.disabilitytypekey === currentDisability.disabilitytypekey )) {
          containsDisability = true;
          break;
        } 
      }
      if (!containsDisability) {
      return this.hasDisabilityWarningMsgFn();
    }
  }
  if(this.returnShowResetconfirmpopupCond1Fn(totalDisabilityTypeCount)) {
    return true;
  }
    
    const allFiled = this.disabilityTypes.filter((pd: { conditionType: null; }) => pd.conditionType === null);
    if (Array.isArray(allFiled) && allFiled.length > 0) {
      return this.allFiledWarningMsgFn();
    } else {
      this.disabilityTypeNullFn();
    }
    if(this.returnShowResetconfirmpopupCond2Fn(totalDisabilityTypeCount)) {
      return true;
    }
  }
  private returnShowResetconfirmpopupCond2Fn(totalDisabilityTypeCount: any) {
    if (this.NoDisability.length === totalDisabilityTypeCount && this.hasDisability) {
      return this.showResetconfirmpopupFn();
    } else if (this.UnknownDisability.length === totalDisabilityTypeCount && this.hasDisability) {
      return this.showResetconfirmpopupFn();
    } else {
      this.disabilitiesSavedMsgFn();
    }
    return false;
  }
  private returnShowResetconfirmpopupCond1Fn(totalDisabilityTypeCount: any) {
    const allNo = this.disabilityTypes.filter((pd: { disabilityconditiontypekey: string; }) => pd.disabilityconditiontypekey === 'No');
    if (allNo && allNo.length === totalDisabilityTypeCount) {
      return this.showResetconfirmpopupFn();
    }
    const allunk = this.disabilityTypes.filter((pd: { disabilityconditiontypekey: string; }) => pd.disabilityconditiontypekey === 'Unknown');
    if (allunk && allunk.length === totalDisabilityTypeCount) {
      return this.showResetconfirmpopupFn();
    }
    return false;
  }

  private disabilitiesSavedMsgFn() {
    this.isSaveQueueInprogress = false;
    this._alertService.success('Disabilities Saved successfully');
  }

  private hasDisabilityWarningMsgFn() {
    this._alertService.warn('Please select atleast one disability', true);
  }

  private allFiledWarningMsgFn() {
    this._alertService.warn('Please answer all the questions');
    return false;
  }

  private disabilityTypeNullFn() {
    const noDisabilityCount = this.NoDisability.length;
    const UnknownDisabilitycount = this.UnknownDisability.length;  
    if (noDisabilityCount > 0) {
      if (this.NoDisability && this.NoDisability.length) {
        this.saveQueueData();
        this.saveDisablityQueue(this.NoDisability[this.SAVE_QUEUE]);
      }
    } else if (UnknownDisabilitycount > 0) {
      if (this.UnknownDisability && this.UnknownDisability.length) {
        this.saveQueueData();
        this.saveDisablityQueue(this.UnknownDisability[this.SAVE_QUEUE]);
      }
    }
  }

  private saveQueueData() {
    this.SAVE_QUEUE = 0;
    this.isSaveQueueInprogress = true;
  }

  private showResetconfirmpopupFn() {
    $(this.resetconfirmpopupid).modal('show');
    return true;
  }

  savedisability() {
    this.saveQueueData();
    if (Array.isArray(this.NoDisability) && this.NoDisability.length > 0) {
      this.saveDisablityQueue(this.NoDisability[this.SAVE_QUEUE]);
    }
  }

  setNoDisabilities(item: any, disabilitycondition: any) {
    const disabilityObj = this.returnDisabilityObjData(item, disabilitycondition);
    this.getUnknownDisabilityFn(disabilitycondition, disabilityObj, item);
    this.getNoDisabilityFn(disabilitycondition, disabilityObj, item);
  }


  private getNoDisabilityFn(disabilitycondition: any, disabilityObj: any, item: any) {
    if (this.NoDisability) {
      let noflag = false;
      let noindex = -1;
      if (this.NoDisability.length > 0) {
        for (const element of this.NoDisability) {
          noindex++;
          if(element.disabilitytypekey === item?.ref_key){
            noflag = true;
            break;
          }
        }
      }
      this.pushDatagetNoDisabilityFn(noflag, disabilitycondition, disabilityObj, noindex);
    }
  }

  private pushDatagetNoDisabilityFn(noflag: boolean, disabilitycondition: any, disabilityObj: any, noindex: number) {
    if (!noflag && disabilitycondition === "No") {
      this.NoDisability.push(disabilityObj);
    }
    if (noflag && disabilitycondition === "Unknown") {
      if (noindex > -1) {
        this.NoDisability.splice(noindex, 1);
      }
    }
  }

  private getUnknownDisabilityFn(disabilitycondition: any, disabilityObj: any, item: any) {
    if (this.UnknownDisability) {
      let unflag = false;
      let unindex = -1;
      if (this.UnknownDisability.length > 0) {
        for (const element of this.UnknownDisability) {
          unindex++;
          if(element.disabilitytypekey === item?.ref_key){
            unflag = true;
            break;
          }
        }
      }
      this.pushDataUnknownDisabilityFn(unflag, disabilitycondition, disabilityObj, unindex);
    }
  }

  private pushDataUnknownDisabilityFn(unflag: boolean, disabilitycondition: any, disabilityObj: any, unindex: number) {
    if (!unflag && disabilitycondition === "Unknown") {
      this.UnknownDisability.push(disabilityObj);
    }
    if (unflag && disabilitycondition === "No") {
      if (unindex > -1) {
        this.UnknownDisability.splice(unindex, 1);
      }
    }
  }

  private returnDisabilityObjData(item: any, disabilitycondition: any) {
    return {
      persondisabilityid: item.persondisabilityid ? item.persondisabilityid : null,
      personid: [this.personId],
      disabilityconditiontypekey: disabilitycondition,
      diagnoiseddisabilitynotes: null,
      startdate: null,
      enddate: null,
      disabilityflag: null,
      evaluationdate: null,
      evaluatorname: null,
      existingcondition: null,
      previouscondition: null,
      doesnotapply: null,
      specialkey: null,
      hygienekey: null,
      disabilitytypekey: item.ref_key,
      comments: disabilitycondition + '_Disability',
      isnew: null
    };
  }

  closeDisabilityModal() {
    this.personDisabilityForm.reset();
    if (this.selectedItem) {
      this.disabilityTypes.forEach((disability: { ref_key: any; persondisabilityid: any; conditionType: null; }) => {
        if (disability.ref_key === this.selectedItem.ref_key) {
          const previousValue = this.personDisabilities.find(disabilityItem => disabilityItem.persondisabilityid === disability.persondisabilityid);
          if (previousValue) {
            disability.conditionType = previousValue.disabilityconditiontypekey;
          } else {
            disability.conditionType = null;
            this.NoDisability = this.NoDisability.filter(item => item.disabilitytypekey !== disability.ref_key);
            this.UnknownDisability = this.UnknownDisability.filter(item => item.disabilitytypekey !== disability.ref_key);
          }
        }
      });
    }
    this.loadPersonDisabilityList();
    $(this.adddisabilitypopupid).modal('hide');
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }

  setDisabiltyFields() {
    
    if (this.disabilityTypes && this.disabilityTypes.length) {
      const personDisabilities = this.personDisabilities;
      this.disabilityTypes.forEach((element: { conditionType: any; persondisabilityid: null; ref_key: any; disabled: boolean; }) => {
        element.conditionType = element.conditionType ? element.conditionType : null;
        element.persondisabilityid = null;
        if (personDisabilities && personDisabilities.length) {
          const isDisabilityAvailable = personDisabilities.find(child => child.disabilitytypekey === element.ref_key);
          if (isDisabilityAvailable) {
            element.persondisabilityid = isDisabilityAvailable.persondisabilityid;
            element.conditionType = isDisabilityAvailable.disabilityconditiontypekey;
            element.disabled = true;
          } else {
            element.disabled = false;
          }
        }
      });
    }
  }

  reset() {
    this.isEditMode = false;
    this.savedisabilityrequired =false;
    this.disabilitycheckboxes.forEach((checkbox: { status: boolean; }) => {
       checkbox.status = true;
   })
    this.personDisabilityForm.reset();
    this.closeDisabilityModal();
    this.loadPersonDisabilityList();
  }

  resetDisabilityPopup() {
    $(this.removedisabilitypopupid).modal('hide');
    this.personDisabilityForm.reset();
    this.loadPersonDisabilityList();
  }
  
  onDisabiltyChange(isSelected: any) {
       if (isSelected=="false") {
        
      this.disabilityTypes.forEach((disablity: any) => {
        this.addDisability(disablity, 'No');
      });
      $(this.removedisabilitypopupid).modal('show');
    }
    if (isSelected =="unknown"|| isSelected =="unknowns") {
      
      this.disabilityTypes.forEach((disablity: any) => {
        this.addDisability(disablity, 'Unknown');
      });
      $(this.removedisabilitypopupid).modal('show');
    }
    this._dataStoreService.setData(PAGES_STORE_CONSTANTS.PERSON_DISABILITY_PRINSTINE, true);
  }

  closeRemoveDisabilityModal() {
    $(this.removedisabilitypopupid).modal('hide');
  }

  edit(item: any) {
    this.isEditMode = true;
    if(item.hygienekey) {
      item.hygienekey = Array.isArray(item.hygienekey) ? item.hygienekey : item.hygienekey.split(',');
    }
    if( item.specialkey) {
      item.specialkey = Array.isArray(item.specialkey) ? item.specialkey : item.specialkey.split(',');

    }
 
    this.personDisabilityForm.patchValue(item);
    let checkboxval ='';
    if(item.existingcondition){
      checkboxval ='existingcondition';
    }
    else if(item.previouscondition){
      checkboxval ='previouscondition';

    } 
    else if(item.doesnotapply){
      checkboxval ='doesnotapply';

    }
    const disabilitycondition  =item.disabilityconditiontypekey ;
    if(disabilitycondition =='Yes' && checkboxval ==''){
      this.disabilitycheckboxes.forEach((checkbox: { status: boolean; })=>{
        checkbox.status = true;       
      })

    } else { this.disabilitycheckboxedit(checkboxval);}
    this.personDisabilityid = item.persondisabilityid ? item.persondisabilityid : null;
    $(this.adddisabilitypopupid).modal('show');
  }
  add(item: any) {
    this.isEditMode = false;
    item.hygienekey = [];
    item.specialkey = [];
    item.persondisabilityid = null;
    item.isnew = true;
    this.personDisabilityForm.patchValue({
      isnew: true,
      hygienekey: [],
      specialkey: [],
      persondisabilityid: null,
      existingcondition :null,
      previouscondition :null,
      doesnotapply :null,
      disabilitytypekey: item.disabilitytypekey,
      disabilityconditiontypekey: item.disabilityconditiontypekey
    });
    this.personDisabilityid =  null;
    $(this.adddisabilitypopupid).modal('show');
  }

  updateDisability() {
    const data = this.personDisabilityForm.getRawValue();
    data.personDisabilityid = this.personDisabilityid ? this.personDisabilityid : null;
    if (this.personDisabilityForm.invalid) {
      this._alertService.error('please fill required fields');
      return;
    }
    if (this.personDisabilityid) {
      this._service.createDisability(data).subscribe((response: any) => {
        this.reset();
        this.NoDisability = [];
        this.UnknownDisability = [];      
        const totalDisability = (this.personDisabilities && this.personDisabilities.length) ? (this.personDisabilities.length + 1) : 1;
        if (totalDisability < 11) {
          this._alertService.warn('Please  answer all the questions');
          this.loadPersonDisabilityList();
        } else {
          this._alertService.success('Disability updated successfully');
          this.loadPersonDisabilityList();
        }

        $(this.adddisabilitypopupid).modal('hide');
      });
    }
  }



  removeAllDisability() {
    if (this.NoDisability && this.NoDisability.length) {
      this.SAVE_QUEUE = 0;
      this.isSaveQueueInprogress = true;
      this.saveDisablityQueue(this.NoDisability[this.SAVE_QUEUE]);
    }
    else if (this.UnknownDisability && this.UnknownDisability.length) {
      this.SAVE_QUEUE = 0;
      this.isSaveQueueInprogress = true;
      this.saveDisablityQueue(this.UnknownDisability[this.SAVE_QUEUE]);
    }
    
    $(this.removedisabilitypopupid).modal('hide');
  }

  resetDisability(event: any) {
    this.hasDisability = event;
    this.closeRemoveDisabilityModal();
    this.savedisability();
  }
  unkDateChange(event: any) {
    this.clearStartdate(event.checked);
  }
  disabilitycheckboxchange(selectedcheckbox: any,checkboxname: any){
        this.disabilitycheckboxes.forEach((checkbox: any)=>{
      if(checkbox.name !==checkboxname){
        checkbox.status = !selectedcheckbox.checked;

      }
    })

  }
  disabilitycheckboxedit(checkboxname: any){
    this.disabilitycheckboxes.forEach((checkbox: any) => {
      if(checkbox.name ==checkboxname){
        checkbox.status = true;

      }
      else{
        checkbox.status = false;
      }
    })

  }
  public disabilityOpen(text: any): void{
    this.description = text;
    $('#information-view').modal('show');
  }
  disabilitycheckboxvalidation(){
    const checkboxchecked =this.disabilitycheckboxes.filter((item: { status: boolean; })=>item.status === true);
    if(checkboxchecked.length === 3){
      return true;
    }else {return false;}
  }
  
}