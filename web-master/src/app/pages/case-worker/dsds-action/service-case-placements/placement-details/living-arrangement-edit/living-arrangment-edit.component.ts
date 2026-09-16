import { Component, OnInit, Input, Output, EventEmitter, Injector } from '@angular/core';
import { Validators, FormBuilder, FormGroup, FormControl } from '@angular/forms';
import { ServiceCasePlacementsService } from '../../service-case-placements.service';
import { forkJoin, Observable, of } from 'rxjs';
import { NewUrlConfig } from '../../../../../newintake/newintake-url.config';
import { CommonHttpService, CommonDropdownsService, AlertService, DataStoreService } from '../../../../../../@core/services';
import { PlacementConstants } from '../../constants';
import moment from 'moment';
import { InvolvedPersonsService } from '../../../../../../pages/shared-pages/involved-persons/involved-persons.service';
import { AppConstants } from '../../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../../../case-worker/_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { ExitPlacementService } from '../../../../../case-worker/dsds-action/service-case-placements/exit-placements/exit-placement.service';
import _ from 'lodash';


@Component({
    selector: 'living-arrangment-edit',
    templateUrl: './living-arrangment-edit.component.html',
    styleUrls: ['./living-arrangment-edit.component.scss'],
    standalone: false
})
export class LivingArrangmentEditComponent implements OnInit {
  isRunaway = false;
  minDate: any;
  maxDate: any;
  endMinDate: any;
  placementEditForm!: FormGroup;
  disabletsafields = true;
  countyDropDownItems: any = [];
  stateDropDownItems: any = [];
  countryDropDownItems: any = [];
  tsaDropdownItems: any = [];
  livingDropDownItems: any = [];
  relationShipDropdownItems: any[] = [];
  suggestedAddress$!: Observable<any[]>;
  caregiverPersonsList: any = [];
  caregiverPersonsList2: any;
  secondaryselected = false;
  personsList: any = [];
  selectedChildren: any[] = [];
  primaryselected = false;
  selectedPrimaryPersonNameList= '';
  allRelations: any[] = [];
  isRequired = false;
  @Input() child: any;
  readOnly = false;
  fostercarehomelist: any[] = [];
  fosternonfosterlist: any[] = [];
  ratetypepicklist: any[] = [];
  fostercomments :any[] = [];
  dtformat = 'YYYY-MM-DD';
  caseNumber!: string;
  isControlAvailable: boolean = true;
  placementEditFormControls:any;
  hospitalizationData:any= [] = [];
  @Output()
  hospitalizationFormEvent = new EventEmitter();
  @Output()
  hospitalizationFormStatusEvent = new EventEmitter();
  showExitTypes = false;
  exitPlacementForm!: FormGroup;
  reasonForExitRequired :any = false;
  reasonsForExit: any = [];
  reasonforexit : any;
  exitReasonKey: any;
  exitTypes: any = [];
  commentsRequired = false;
  @Output()
  exitFormValChangesEvent = new EventEmitter();
  hospitalizationFormStatus = true;

  private readonly _ServiceCasePlacementsService: ServiceCasePlacementsService;
  private readonly formBuilder: FormBuilder;
  private readonly _dropDownService: CommonDropdownsService;
  private readonly _httpService: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _service: InvolvedPersonsService;
  private exitService: ExitPlacementService;

  constructor(private injector: Injector){
    this._ServiceCasePlacementsService = this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._service = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this.exitService = this.injector.get<ExitPlacementService>(ExitPlacementService);
  }


  ngOnInit() {
    if(this._ServiceCasePlacementsService.placementDetails[0] && this._ServiceCasePlacementsService.placementDetails[0]['placement'] &&
    this._ServiceCasePlacementsService.placementDetails[0]['placement']['placementrevision'] && this._ServiceCasePlacementsService.placementDetails[0]['placement']['placementrevision'][0]['hospitalizationdetails'] ) {
      this.hospitalizationData = this._ServiceCasePlacementsService.placementDetails[0]['placement']['placementrevision'][0]['hospitalizationdetails']
    }
    this.minDate = new Date(this.child.dob);
    this.caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.maxDate = new Date();
    this.endMinDate = new Date();
    this.forminitialize();

    this.placementEditForm.get('startdate')?.valueChanges.subscribe(result => {
        this.placementEditForm.patchValue({ enddate: null });
        if (result) {
          this.endMinDate = new Date(result);
        }
      });

    this.loadDropdownItems();
    this.personsList = this._ServiceCasePlacementsService.personsList;
    this.selectedChildren = this._ServiceCasePlacementsService.selectedChildren;
    this.initCaregiverLists();
    this.validatePlacementDates(this.selectedChildren.filter(item => item.personid === this.child.personid));
    this._dataStoreService.setData(AppConstants.GLOBAL_KEY.SOURCE_PAGE, AppConstants.MODULE_TYPE.CASE);

    this.exitService.getExitTypes() .subscribe(result => {
      if (result && result.length) {
        this.exitTypes = result;
      }
  
    });

    this.exitService.getreasontype().subscribe(result => {
      this.reasonforexit = result.filter(item=>item.activeflag === 1)
        this.reasonforexit  = this.reasonforexit .filter((item: { ref_key: string; }) => item.ref_key !== 'RNAWAY');
      this.reasonforexit.sort((a: any, b: any) => a.description.localeCompare(b.description));
     }) ;

     this.exitPlacementForm.valueChanges.subscribe((value)=>{
       const obj = {
        isExitFormOpen: this.showExitTypes,
        value:value,
        valid: this.exitPlacementForm.valid
       }
       this.exitFormValChangesEvent.emit(obj)
     })
  }


  forminitialize() {
    this.placementEditForm = this.formBuilder.group({
      placementtypekey: ['LA'],
      livingarrangementtypekey: [this.child.placement.livingarrangementtypekey, Validators.required],
      contactname: [null],
      caregiverclientid: [this.child.placement.caregiverclientid],
      placementid: [this.child.placement.placementid],
      primarycaregiver: [this.child.placement.primarycaregiver],
      partnerid: [this.child.placement.partnerid],
      secondarycaregiver: [this.child.placement.secondarycaregiver],
      primaryrelationship: [this.child.placement.primaryrelationship],
      startdate: [this.child.placement.startdate, Validators.required],
      remarks: [this.child.placement.remarks],
      leastrestrictiveplacement: [this.child.placement.leastrestrictiveplacement],
      contactphone: [this.child.placement.contactphone],
      workphone: [this.child.placement.workphone],
      enddate: [this.child.placement.enddate],
      add1: [this.child.placement.address1],
      add2: [this.child.placement.address2],
      cityname: [this.child.placement.cityname],
      statetypekey: [this.child.placement.statetypekey],
      zipcode: [this.child.placement.zipcode],
      countytypekey: [this.child.placement.countytypekey],
      runawayreported: [this.child.placement.runawayreported ? "YES" : "NO"],
      runawayreportnumber: [this.child.placement.runawayreportnumber],
      runawaynotreportedreason: [null],
      endtime: [this.child.placement.etime ? moment(this.child.placement.etime).add(0, 'seconds').format('hh:mm') : null],
      starttime: [moment(this.child.placement.stime).add(0, 'seconds').format('HH:mm')],
      justification: [this.child.placement.justification, Validators.required],
      isSupervisor: [false],
      personid: [this.child.placement.personid],
      ischangepreadoptive: [false],
      whereabouts: [{ value: this.child.placement.whereabouts, disabled: true }],
      country: [this.child.placement.country],
      tribalservicearea: [this.child.placement.tribalservicearea],
      fostercarehome :[this.child.placement.fostercarehome],
      fostercarenonfoster :[this.child.placement.fostercarenonfoster],
      hotelorother: [this.child.placement.hotelorother],
      agency1to1: [this.child.placement.agency1to1],
      agency1to1desc: [this.child.placement.agency1to1desc],
      agency1to1explaination: [this.child.placement.agency1to1explaination],
      dailyrate: [this.child.placement.dailyrate],
      ratetype: [this.child.placement.ratetype],
      agency1to1rate: [this.child.placement.agency1to1rate],
      fostercomments :[this.child.placement.fostercomments],
      livingarrangementluggage :[this.child.placement.livingarrangementluggage],
      laluggagepurchased :[this.child.placement.laluggagepurchased],
      laluggagecomments: [this.child.placement.laluggagecomments],
      ladisposableortrashbag :[this.child.placement.ladisposableortrashbag],
      casenumber :this.caseNumber  
    });
    this.placementEditFormControls = this.placementEditForm.controls;
    
    //ERM ---->ER Medical
    //ERP ---->ER Psychiatric
    //IMC ---->Inpatient Medical Care
    //PSYH---->Inpatient Psychiatric Hospital


    if(this.child.placement.livingarrangementtypekey  === "ERM" || this.child.placement.livingarrangementtypekey === "ERP" || this.child.placement.livingarrangementtypekey === "IMC" || this.child.placement.livingarrangementtypekey === "PSYH"){
      this.isControlAvailable = false;
    }

    if (this.child.placement.statetypekey != null) {
      this.loadStateDropdownItems(this.child.placement.statetypekey, null);
    }
    if(this.child.placement.tribalservicearea) {
      this.disabletsafields = false;
    }
    if(this.child.placement.livingarrangementtypekey == 'RNW') {
      this.isRunaway = true;
    }

    this.exitPlacementForm =  this.formBuilder.group({
      exittypekey:[null,Validators.required],
      exitreasontypekey: null,
      remarks: null,
      leastrestrictiveplacement: [null,Validators.required]
     });
  }

  isRelationRequired() {
    return this.isRequired;
  }


  onDailyAmountChange(event: any, key: any) {
    const amount: any = event.target.value;
    if (!_.isNaN(_.toNumber(amount)) && key == 1) {
      this.placementEditForm.patchValue ({
        dailyrate : _.toNumber(amount).toFixed(2)
      });
    } else if (!_.isNaN(_.toNumber(amount)) && key == 2) {
      this.placementEditForm.patchValue ({
        agency1to1rate : _.toNumber(amount).toFixed(2)
      });
    }
  }

  removeControls() {
     
      const controls = this.placementEditForm.controls;
      const controlKeys = Object.keys(controls)
      for(const key of controlKeys) {
        if(key !== "livingarrangementtypekey" && key !== "startdate" && 
            key !== "starttime" && key  !== "livingarrangementluggage" && key !== "laluggagepurchased"
            && key !== "laluggagecomments" && key !== "placementid" && key !== "personid" &&  key !== "livingid" 
            && key !== "intakeservreqchildremovalid" && key !== "primarycaregiver" && key !== "caregiverclientid"
            && key !== "justification" && key !=="ladisposableortrashbag"
            ){
          this.placementEditForm.removeControl(key);        
        }
      
      }
      this.placementEditForm.updateValueAndValidity()
    }


    addControls(){
      
      this.placementEditForm.addControl("placementtypekey", new FormControl("LA")); 
      this.placementEditForm.addControl("contactname", new FormControl(null));   
      this.placementEditForm.addControl("caregiverclientid", new FormControl(this.child.placement.caregiverclientid)); 
      this.placementEditForm.addControl("placementid", new FormControl(this.child.placement.placementid)); 
      this.placementEditForm.addControl("primarycaregiver", new FormControl(this.child.placement.primarycaregiver)); 
      this.placementEditForm.addControl("partnerid", new FormControl(this.child.placement.partnerid)); 
      this.placementEditForm.addControl("secondarycaregiver", new FormControl(this.child.placement.secondarycaregiver)); 
      this.placementEditForm.addControl("primaryrelationship", new FormControl(this.child.placement.primaryrelationship)); 
      this.placementEditForm.addControl("remarks", new FormControl(this.child.placement.remarks)); 
      this.placementEditForm.addControl("leastrestrictiveplacement", new FormControl(this.child.placement.leastrestrictiveplacement)); 
      this.placementEditForm.addControl("contactphone", new FormControl(this.child.placement.contactphone)); 
      this.placementEditForm.addControl("workphone", new FormControl(this.child.placement.workphone)); 
      this.placementEditForm.addControl("enddate", new FormControl(this.child.placement.enddate)); 
      this.placementEditForm.addControl("add1", new FormControl(this.child.placement.address1)); 
      this.placementEditForm.addControl("add2", new FormControl(this.child.placement.address2)); 
      this.placementEditForm.addControl("cityname", new FormControl(this.child.placement.cityname)); 
      this.placementEditForm.addControl("statetypekey", new FormControl(this.child.placement.statetypekey)); 
      this.placementEditForm.addControl("zipcode", new FormControl(this.child.placement.zipcode)); 
      this.placementEditForm.addControl("countytypekey", new FormControl(this.child.placement.countytypekey)); 
      this.placementEditForm.addControl("runawayreported", new FormControl(this.child.placement.runawayreported ? "YES" : "NO"));       
      this.placementEditForm.addControl("runawayreportnumber", new FormControl(this.child.placement.runawayreportnumber)); 
      this.placementEditForm.addControl("runawaynotreportedreason", new FormControl(null)); 
      this.placementEditForm.addControl("endtime", new FormControl(this.child.placement.etime ? moment(this.child.placement.etime).add(0, 'seconds').format('hh:mm') : null)); 
      this.placementEditForm.addControl("justification", new FormControl(this.child.placement.justification, Validators.required)); 
      this.placementEditForm.addControl("isSupervisor", new FormControl(false)); 
      this.placementEditForm.addControl("personid", new FormControl(this.child.placement.personid)); 
      this.placementEditForm.addControl("ischangepreadoptive", new FormControl(false)); 
      this.placementEditForm.addControl("whereabouts", new FormControl({ value: this.child.placement.whereabouts, disabled: true })); 
      this.placementEditForm.addControl("country", new FormControl(this.child.placement.country)); 
      this.placementEditForm.addControl("tribalservicearea", new FormControl(this.child.placement.tribalservicearea)); 
      this.placementEditForm.addControl("fostercarehome", new FormControl(this.child.placement.fostercarehome)); 
      this.placementEditForm.addControl("fostercarenonfoster", new FormControl(this.child.placement.fostercarenonfoster)); 
      this.placementEditForm.addControl('hotelorother', new FormControl(null));
      this.placementEditForm.addControl('agency1to1', new FormControl(null));
      this.placementEditForm.addControl('agency1to1desc', new FormControl(null));
      this.placementEditForm.addControl('agency1to1explaination', new FormControl(null));
      this.placementEditForm.addControl('dailyrate', new FormControl(null));
      this.placementEditForm.addControl('ratetype', new FormControl(null));
      this.placementEditForm.addControl('agency1to1rate', new FormControl(null));
      this.placementEditForm.addControl("fostercomments", new FormControl(this.child.placement.fostercomments)); 
    
      this.placementEditForm.updateValueAndValidity()
    }
    

  

  onLivingArrangementChange(relations: any, value?: any) {

    
    this.isRequired = false;
    const livingArrangementKey = this.placementEditForm.getRawValue().livingarrangementtypekey;
    if(livingArrangementKey  === "ERM" || livingArrangementKey === "ERP" || livingArrangementKey === "IMC" || livingArrangementKey === "PSYH" ){
      
      this.removeControls()
      this.isControlAvailable = false;
      return;
    } else {
      this.addControls();
      this.isControlAvailable = true;
    }
    if(livingArrangementKey?.trim() === 'RFKH'){
      this.readOnly = true;
    }else{
      this.readOnly = false;
    }
    if (livingArrangementKey === PlacementConstants.RUN_AWAY) {
      this.isRunaway = true;
      this.placementEditForm.get("leastrestrictiveplacement")?.setValidators(null);
      this.placementEditForm.get("statetypekey")?.setValidators(null);
      this.placementEditForm.get("zipcode")?.setValidators(null);
      this.placementEditForm.get("countytypekey")?.setValidators(null);
    } else {
      this.isRunaway = false;
      this.placementEditForm.get("leastrestrictiveplacement")?.setValidators(Validators.required);
      this.placementEditForm.get("statetypekey")?.setValidators(Validators.required);
      this.placementEditForm.get("zipcode")?.setValidators(Validators.required);
      this.placementEditForm.get("countytypekey")?.setValidators(Validators.required);
    }
    this.placementEditForm.get("leastrestrictiveplacement")?.updateValueAndValidity();
    this.placementEditForm.get("statetypekey")?.updateValueAndValidity();
    this.placementEditForm.get("zipcode")?.updateValueAndValidity();
    this.placementEditForm.get("countytypekey")?.updateValueAndValidity();
    if(!value){
      this.placementEditForm.patchValue({
        fostercarehome : null,
        fostercarenonfoster :null,
        fostercomments :null,
        hotelorother: null,
        agency1to1: null,
        agency1to1desc: null,
        agency1to1explaination: null,
        dailyrate: null,
        agency1to1rate: null,
        ratetype: null,
      })
      
    this.onFostercareHomeChange();
    }
    this.handleRelationsCondFn(relations, livingArrangementKey);

    const fostercareHomeControl: any = this.placementEditForm.get('fostercarehome');
    const fostercarenonFosterControl: any = this.placementEditForm.get('fostercarenonfoster');

  if (livingArrangementKey.trim() !== "FCH" ) {
    fostercareHomeControl.setValidators(null);
    fostercareHomeControl.updateValueAndValidity();
  }  
  if (livingArrangementKey.trim() !== "FCNFHS" ) {
  fostercarenonFosterControl.setValidators(null);
  fostercarenonFosterControl.updateValueAndValidity();

  this.placementEditForm.get("hotelorother")?.setValidators(null);
  this.placementEditForm.get("hotelorother")?.updateValueAndValidity();
  this.placementEditForm.get("agency1to1")?.setValidators(null);
  this.placementEditForm.get("agency1to1")?.updateValueAndValidity();
  this.placementEditForm.get("agency1to1desc")?.setValidators(null);
  this.placementEditForm.get("agency1to1desc")?.updateValueAndValidity();
  this.placementEditForm.get("agency1to1explaination")?.setValidators(null);
  this.placementEditForm.get("agency1to1explaination")?.updateValueAndValidity();
  this.placementEditForm.get("dailyrate")?.setValidators(null);
  this.placementEditForm.get("dailyrate")?.updateValueAndValidity();
  this.placementEditForm.get("agency1to1rate")?.setValidators(null);
  this.placementEditForm.get("agency1to1rate")?.updateValueAndValidity();
  this.placementEditForm.get("ratetype")?.setValidators(null);
  this.placementEditForm.get("ratetype")?.updateValueAndValidity();


  this.placementEditForm.patchValue({
    hotelorother: null,
    agency1to1: null,
    agency1to1desc: null,
    agency1to1explaination: null,
    dailyrate: null,
    ratetype: null,
    agency1to1rate: null
  });
 }
  }
  // Assosiate with onLivingArrangementChange method
  private handleRelationsCondFn(relations: any, livingArrangementKey: any) {
    if (relations) {
      this.relationShipDropdownItems = relations;
      this.relationShipDropdownItems = JSON.parse(JSON.stringify(relations));
      const primaryrelationshipControl: any = this.placementEditForm.get('primaryrelationship');
      if (livingArrangementKey?.trim() == "FCH"
        || livingArrangementKey.trim() == "RFKH"
        || livingArrangementKey.trim() == "REC"
        || livingArrangementKey.trim() == "SHA"
        || livingArrangementKey.trim() == "TVH"
        || livingArrangementKey.trim() == "OHA") {
        primaryrelationshipControl.setValidators(Validators.required);
        primaryrelationshipControl.updateValueAndValidity();
        primaryrelationshipControl.markAsTouched({ onlySelf: true });
        this.relationShipDropdownItems = this.relationShipDropdownItems.filter(item => item.relationshiptypekey == 'Kin' || item.relationshiptypekey == 'Relative' || item.relationshiptypekey == 'NORELTVE');
        this.isRequired = true;
      } else {
        primaryrelationshipControl?.setErrors(null);
        primaryrelationshipControl?.setValidators(null);
      }
    }
  }

  removeObjRelationShipDropdownItems(key: any) {
    const index = this.relationShipDropdownItems.findIndex(x => x.relationshiptypekey === key);
    this.relationShipDropdownItems.splice(index, 1);
}

  private loadDropdownItems() {
    forkJoin([   
      this._dropDownService.getPickListByName('livingarrangementstates'),
      this._dropDownService.getPickListByName('country'),
      this._dropDownService.getPickListByName('tribalservicearea'),
      this._dropDownService.getListAllByTableID(76),
      this._dropDownService.getRelations(),
      this._dropDownService.getListByTableID(762),
      this._dropDownService.getListByTableID(760),
      this._dropDownService.getListByTableID(942)
    ]).subscribe(([stateList, countryList, tsaList, livingArrangements, relations,fostercarehomelist,fosternonfosterlist, ratetypepicklist]) => {
      this.stateDropDownItems = stateList;
      const withMD = stateList.filter(item => item.ref_key == 'MD')[0];
      this.stateDropDownItems = stateList.filter(item => item.ref_key != 'MD');
      this.stateDropDownItems.unshift(withMD);
      
      const withUSA = countryList.filter(item => item.ref_key == 'USA')[0];
      this.countryDropDownItems = countryList.filter(item => item.ref_key != 'USA');
      this.countryDropDownItems.unshift(withUSA);
     
      this.countryDropDownItems = countryList;
      this.fostercarehomelist = fostercarehomelist.filter(item => item.activeflag ===1);
      this.fosternonfosterlist =fosternonfosterlist.filter(item => item.activeflag ==1);
      this.ratetypepicklist =ratetypepicklist.filter(item => item.activeflag === 1);
    if(this.child.placement.country) {
      this.placementEditForm.patchValue({
        country: this.child.placement.country
      });
    }
      this.tsaDropdownItems = tsaList;
      this.livingDropDownItems = livingArrangements.filter(item => item.activeflag === 1 && item.teamtypekey !== 'AS' && item.ref_key !== 'HMLS');

      livingArrangements.forEach(element => {
        if (this.child.placement.livingarrangementtypekey === element.ref_key && this.livingDropDownItems.indexOf(element.ref_key) <= -1) {
          if (!this.livingDropDownItems.find((ele: { ref_key: any; }) => ele.ref_key === element.ref_key)) {
            this.livingDropDownItems.push(element);
          }
        }
      })
      this.allRelations = relations;
      this.livingDropDownItems = this.sortlivingDropDownItems();

      this.onLivingArrangementChange(relations,1);
      this.relationShipDropdownItems = relations;

      const livingArrangementKey = this.placementEditForm.getRawValue().livingarrangementtypekey;
      if(livingArrangementKey  === "ERM" || livingArrangementKey === "ERP" || livingArrangementKey === "IMC" || livingArrangementKey === "PSYH" ){
      
       this.placementEditForm.get('livingarrangementtypekey')?.disable();
       
      }
      this.relationShipDropdownItems = JSON.parse(JSON.stringify(relations));
      if (livingArrangementKey.trim() == "FCH" || livingArrangementKey.trim() == "RFKH" || livingArrangementKey.trim() == "REC" || livingArrangementKey.trim() == "SHA" || livingArrangementKey.trim() == "TVH" || livingArrangementKey.trim() == "OHA") {
        this.relationShipDropdownItems = this.relationShipDropdownItems.filter (item => item.relationshiptypekey == 'Kin' || item.relationshiptypekey == 'Relative' || item.relationshiptypekey == 'NORELTVE');
        this.isRequired = true;
      } else {
            this.isRequired = false;
       }
    });

  }

  sortlivingDropDownItems(){
    return this.livingDropDownItems.sort((a: { value_text: string; }, b: { value_text: any; }) => a.value_text.localeCompare(b.value_text));
  }

  setFormControlValidators() {

    // If living arrangement is Runaway runawayreported is required otherwise not
    const runawayReportedControl: any = this.placementEditForm.get('runawayreported');
    const address1Control: any = this.placementEditForm.get('add1');
    const statetypekey: any = this.placementEditForm.get('statetypekey');
    const countytypekey: any = this.placementEditForm.get('countytypekey');
    const zipcode: any = this.placementEditForm.get('zipcode');
    
    this.placementEditForm.get('livingarrangementtypekey')?.valueChanges
      .subscribe(livingArrangement => {
        if (livingArrangement === PlacementConstants.RUN_AWAY) {
          address1Control.setValidators(null);
          address1Control.setErrors(null);
          address1Control.clearValidators();
          statetypekey.setValidators(null);
          statetypekey.setErrors(null);
          statetypekey.clearValidators();
          countytypekey.setValidators(null);
          countytypekey.setErrors(null);
          countytypekey.clearValidators();
          zipcode.setValidators(null);
          zipcode.setErrors(null);
          zipcode.clearValidators();
        } else {
          address1Control.setValidators([Validators.required]);
          runawayReportedControl.setValidators(null);
          runawayReportedControl.setErrors(null);
          runawayReportedControl.clearValidators();
        }
        if(!this.isRunaway){
          runawayReportedControl.updateValueAndValidity();}
         address1Control.updateValueAndValidity();
      });

  }

  getSuggestedAddress() {
    if (this.placementEditForm.value.add1 &&
      this.placementEditForm.value.add1.length >= 3) {
      this.suggestAddress();
    }
  }

  tsaSelectionChange() {
    const tribalservicearea: any = this.placementEditForm.getRawValue().tribalservicearea;
    const statetypekey: any = this.placementEditForm.get('statetypekey');
    const countytypekey: any = this.placementEditForm.get('countytypekey');
    const zipcode: any = this.placementEditForm.get('zipcode');

    if(tribalservicearea) {
      this.disabletsafields = false;
      if(!this.isRunaway){
      statetypekey.clearValidators();
      countytypekey.clearValidators();
      zipcode.clearValidators();
      statetypekey.updateValueAndValidity();
      countytypekey.updateValueAndValidity();
      zipcode.updateValueAndValidity();
      }
    } else {
      this.disabletsafields = true;
    }
  }

  suggestAddress() {
    this._httpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.placementEditForm.value.add1,
            cityFilter: '',
            stateFilter: '',
            geolocate: '',
            geolocate_precision: '',
            prefer_ratio: 0.66,
            suggestions: 25,
            prefer: 'MD'
          }
        },
        NewUrlConfig.EndPoint.Intake.SuggestAddressUrl
      ).subscribe(
        (result: any) => {
          if (result.length > 0) {
            this.suggestedAddress$ = of(result);
          } else {
            this.suggestedAddress$ = of([]);
          }
        }
      );
  }

  loadStateDropdownItems(stateId: any, countyId: any) {
    if(stateId !== 'NS') {
      this._httpService
        .getArrayList(
        {
          where: {
            mdmcode: {"like": stateId + "~%25","options":"i" },
            referencetypeid: 306
          },
          method: 'get',
          nolimit: true
        },
        'referencevalues?filter'
        )
       .subscribe(result => {
        this.countyDropDownItems = result;
        if (countyId) {
          const filteredCounty = this.countyDropDownItems.filter((county: { countyid: any; }) => county.countyid == countyId);
          if (filteredCounty && filteredCounty.length && filteredCounty.length > 0) {
            this.placementEditForm.patchValue({
              countytypekey: filteredCounty[0].countyname
            });
          }
        }
       });
    }
    if (stateId) {
      let whereabouts;
      let country = '';
      switch (stateId) {
        case 'MD':
          whereabouts = 'instate';
          country = 'USA';
          break;
        case 'NS':
          whereabouts = 'outcountry';
          this.countryDropDownItems = this.countryDropDownItems.filter((item: { ref_key: string; }) => item.ref_key !== 'USA');
          const countytypekey: any = this.placementEditForm.get('countytypekey');
          if (!this.isRunaway) {
            countytypekey.clearValidators();
            countytypekey.updateValueAndValidity();
          }
          break;
        default:
          whereabouts = 'outstate';
          country = 'USA';
          break
      }
      this.placementEditForm.patchValue({
           whereabouts: whereabouts,
          country: country
      });
    }
  }

  selectedAddress(model: any) {
    this.placementEditForm.patchValue({
      add1: this.nullCheck(model.streetLine),
      cityname: this.nullCheck(model.city),
      statetypekey: this.nullCheck(model.state),
    });
    this.loadStateDropdownItems(model.state, null);
    const addressInput = {
      street: this.nullCheck(model.streetLine),
      street2: '',
      city: this.nullCheck(model.city),
      state: this.nullCheck(model.state),
      zipcode: '',
      match: 'invalid'
    };
    this._httpService
      .getSingle(
        {
          method: 'post',
          where: addressInput
        },
        NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
        (result) => {
          if (result[0].analysis) {
            setTimeout(() => {
              this.placementEditForm.patchValue({
                zipcode: result[0].components.zipcode ? result[0].components.zipcode : '',
                countytypekey: result[0].metadata.countyName ? result[0].metadata.countyName : ''
              });
            }, 500);
          }
        }
      );
  }
  nullCheck(inputData: any){
    return inputData ? inputData : '';
  }

  initCaregiverLists() {
    this.caregiverPersonsList = this._ServiceCasePlacementsService.caregiversList;
    this.caregiverPersonsList2 = this.caregiverPersonsList;
  }

  primaryCaregiver($event: any) {
    if ($event.value && $event.value != null && this.caregiverPersonsList) {
      const modal = this.caregiverPersonsList.find((data: { personid: any; }) => data.personid === $event.value);
      if (modal) {
        this.selectedPrimaryPersonNameList = modal.fullname;
        this.loadStateDropdownItems(modal.state, modal.county);
        this.placementEditForm.patchValue({
          add1: this.nullCheck(modal.address),
          add2: this.nullCheck(modal.address2),
          cityname: this.nullCheck(modal.city),
          statetypekey: this.nullCheck(modal.state),
          zipcode: this.nullCheck(modal.zipcode),
          countytypekey: this.nullCheck(modal.county),
          contactphone: modal.phonenumber ? modal.phonenumber : null,
          workphone: modal.workphone ? modal.workphone : null,
          primarycaregiver: this.nullCheck(modal.fullname)
        });
        this.patchPlacementEditForm(modal);
      }
    }
    else {
      this.placementEditForm.reset({
        primarycaregiver: [null],
        partnerid: [null],
        secondarycaregiver: [null],
        primaryrelationship: [null],
        contactphone: [null],
        workphone: [null],
        add1: [null],
        add2: [null],
        cityname: [null],
        statetypekey: [null],
        zipcode: [null],
        countytypekey: [null],
        country: [null],
        tribalservicearea: [null]
      });
      this.caregiverPersonsList2 = this.caregiverPersonsList;
      this.primaryselected = false;
    }
  }

  patchPlacementEditForm(modal: any) {
    const child = this.personsList ? this.personsList.find((person: { personid: any; }) => (this.selectedChildren && this.selectedChildren[0]?.personid == person.personid)) : {};
    if (child) {
      const relationship: any = this._ServiceCasePlacementsService.getRelationShip(child.personid, modal.personid, child.relationshiparray);
      this.placementEditForm.patchValue({
        primaryrelationship: relationship ? relationship : null
      });
    }
    this.caregiverPersonsList2 = this.caregiverPersonsList.filter((care: { personid: any; }) => care.personid != modal.personid);
    this.placementEditForm.patchValue({
      partnerid: null,
      secondarycaregiver: null
    });
    this.primaryselected = true;
  }

  secondaryCaregiver($event: any) {
    let modal: any;
    if (this.caregiverPersonsList2) {
      modal = this.caregiverPersonsList2.find((data: { personid: any; }) => data.personid === $event.value);
    }
    if (modal) {
      this.placementEditForm.patchValue({
        secondarycaregiver: modal.fullname
      });
    } else {
      this.placementEditForm.patchValue({
        secondarycaregiver: [null]
      });
    }

    if($event.value && $event.value!=null) {
      this.secondaryselected = true;
    } else {
      this.secondaryselected = false;
    }
  }

  validatePlacementDates(selectedChildren: any) {
    if(selectedChildren && selectedChildren.length && Array.isArray(selectedChildren)) {
      let minDob = new Date();
      const today = new Date();
      const todayStr = moment(today).format(this.dtformat);
      selectedChildren.forEach((child) => {
        minDob = this.getMinDOB(child, minDob, todayStr);
      });
      this.endMinDate = minDob;
    }
  }

  getMinDOB(child: any, minDob: any, todayStr: any) {
    const minDobStr = moment(minDob).format(this.dtformat);
    if (child.dob) {
      const dob = new Date(child.dob);
      if (minDobStr === todayStr) {
        if (dob < minDob) {
          minDob = dob;
        }
      } else {
        if (dob > minDob) {
          minDob = dob;
        }
      }
    }
    return minDob;
  }

  timechange() {

    const currentTime = moment(new Date()).format("HH:mm");
    const currentDate = moment(new Date()).format(this.dtformat);
    const givenDate = moment(this.placementEditForm.getRawValue().startdate).format(this.dtformat);
    const givenTime = this.placementEditForm.getRawValue().starttime;

    if (givenTime !== null && currentTime < givenTime && currentDate === givenDate) {
      this._alertService.error('Start time should be less than the current time');
      this.placementEditForm.patchValue({ starttime: null});
    }

  }

  editPerson() {
    const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._httpService
    .getPagedArrayList(
        new PaginationRequest({
            where: { objectid: id, personid: this.placementEditForm.controls['personid'].value },
            method: 'get',
            nolimit: true
        }),
        'Personprogramareas/getpersonprogramarea?filter'
    )
    .subscribe((result) => {
        if (result && Array.isArray(result) && result.length) {
            const programAsssignList = result[0];
            this.checkProgramArea(programAsssignList);
        }
    });
  }

  checkProgramArea(programAsssignList: any) {
    if (programAsssignList !== null && programAsssignList.personprogramarea !== null) {
      const programAreaOohList = programAsssignList.personprogramarea.filter((item: { programkey: string; }) => item.programkey === "OOH");
      let isActiveOoh = false;
      if (programAreaOohList && programAreaOohList.length > 0) {
        programAreaOohList.map((element: { enddate: null; }) => {
          if (element.enddate === null) {
            isActiveOoh = true;
          }
        })
      }
      this._service.editPerson(this.placementEditForm.controls['personid'].value, (programAreaOohList.length > 0) ? true : false, isActiveOoh);
    } else {
      this._service.editPerson(this.placementEditForm.controls['personid'].value, false);
    }
  }

  closeModal():void{
    ($('#contact-info')as any).modal('hide');
    ($('#person-edit')as any).modal('hide');
  }
  onFostercareHomeChange(){
    const fostercareHomeControl: any = this.placementEditForm.get('fostercarehome');
    fostercareHomeControl.updateValueAndValidity();
    const livingArrangement = this.placementEditForm.controls['livingarrangementtypekey']?.value;
    const remarks:any =this.placementEditForm.get('remarks');
   if(livingArrangement ==='FCNFHS'){
         remarks.clearValidators();
        }

    const fostercarenonFosterControl: any = this.placementEditForm.get('fostercarenonfoster');
    fostercarenonFosterControl.updateValueAndValidity();
    const fostercomments: any = this.placementEditForm.get('fostercomments');
    fostercomments.clearValidators();
    
    this.placementEditForm.patchValue({
      fostercomments :null
    })
  }
  luggagebuttonreset(value: any){

    if(value ===1){
      this.placementEditForm.patchValue({
       laluggagepurchased :null,
       laluggagecomments:null,
       ladisposableortrashbag:null 
      })
      const luggagepurchased: any = this.placementEditForm.get('laluggagepurchased');
      const ladisposableortrashbag: any =this.placementEditForm.get('ladisposableortrashbag');
      ladisposableortrashbag.clearValidators();
      ladisposableortrashbag.updateValueAndValidity();
      luggagepurchased.clearValidators();
      luggagepurchased.updateValueAndValidity();
    }
      if(value ===2){
        this.placementEditForm.patchValue({
          laluggagecomments:null,
          ladisposableortrashbag:null 
         })

      }
      const luggagecomments: any = this.placementEditForm.get('laluggagecomments');
      luggagecomments.clearValidators();
      luggagecomments.updateValueAndValidity();

  }


  agency1to1change() {
    if (this.placementEditForm.controls['fostercarenonfoster'].value ===  'HOTEL') {
      if(this.placementEditForm.controls['agency1to1'].value) {
        this.placementEditForm.get("agency1to1explaination")?.clearValidators();
        this.placementEditForm.get("agency1to1explaination")?.updateValueAndValidity();
        this.placementEditForm.patchValue({
          agency1to1explaination: null
        });
      } else if (!this.placementEditForm.controls['agency1to1'].value) {

        this.placementEditForm.patchValue({
          agency1to1desc :null,
          ratetype:null,
          agency1to1rate:null 
         });

        this.placementEditForm.get("agency1to1desc")?.clearValidators();
        this.placementEditForm.get("agency1to1desc")?.updateValueAndValidity();
        this.placementEditForm.get("ratetype")?.clearValidators();
        this.placementEditForm.get("ratetype")?.updateValueAndValidity();
        this.placementEditForm.get("agency1to1rate")?.clearValidators();
        this.placementEditForm.get("agency1to1rate")?.updateValueAndValidity();
      }
    }
  }
  updateHospitalizationFormValues(event: any){
    const obj = {...this.placementEditForm.getRawValue(), ...event};
    this.hospitalizationFormEvent.emit( obj);

  }

  dischargeChangeHandler(value: any) {
    const dischargeSelected = value;
    if(dischargeSelected) {
      this.exitPlacementForm.get("exittypekey")?.setValidators([Validators.required]);
      this.exitPlacementForm.get("leastrestrictiveplacement")?.setValidators([Validators.required])
      this.showExitTypes = true;
      const obj = {
        isExitFormOpen: this.showExitTypes,
        value:value,
        valid: this.exitPlacementForm.valid
       }
       this.exitFormValChangesEvent.emit(obj)
    } else {
      this.showExitTypes = false;
      this.exitPlacementForm.get("exittypekey")?.clearValidators();
      this.exitPlacementForm.get("leastrestrictiveplacement")?.clearValidators();
      const obj = {
        isExitFormOpen: this.showExitTypes,
        value:value,
        valid: this.exitPlacementForm.valid
       }
       this.exitFormValChangesEvent.emit(obj)
      this.exitPlacementForm.reset();
    }
    this.exitPlacementForm.get("exittypekey")?.updateValueAndValidity();
    this.exitPlacementForm.get("leastrestrictiveplacement")?.updateValueAndValidity();
  }

  onExitTypeChange(status: any) {
    const exitTypeKey = this.exitPlacementForm.getRawValue().exittypekey;
    if (status) {
      this.exitPlacementForm.patchValue({
        exitreasontypekey: null
      });
    }
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.reasonForExitRequired = true;
      this.exitPlacementForm.patchValue({
        exitreasontypekey: this.getexitreasontypekey(status)
      })
      this.exitPlacementForm.get('exitreasontypekey')?.enable();
      if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT) {
        this.exitService.getReasonForExit(exitTypeKey).subscribe(result => {
          if (result && result.length) {
            this.reasonsForExit = result;
          }
        });
      }
      else if (exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
        this.reasonsForExit = this.reasonforexit;
      }
    } else {
      this.reasonForExitRequired = false;
      this.exitPlacementForm.get('exitreasontypekey')?.disable();
      this.reasonsForExit = [];
    }
    if (PlacementConstants.EXIT_TYPES.OTHER === exitTypeKey) {
     this.commentsRequired = true;
    } else {
      this.commentsRequired = false;
    }
  }



  getexitreasontypekey(status: any){
    return (this.exitReasonKey && !status) ? this.exitReasonKey : null;
  }

  getHospitalizationForm(event: any){
    this.hospitalizationFormStatus = event;
    this.hospitalizationFormStatusEvent.emit( event);
  }

  handleSartDateTimeEvent(event: any){
    if(event.time) {
      this.placementEditForm.get('starttime')?.patchValue(event.time)
    } 
    else if(event.date) {
      this.placementEditForm.get('startdate')?.patchValue(new Date(event.date))
    }

    this.placementEditForm.updateValueAndValidity();
  }

  onRunawayReportedChange() {
    // No data or function to call
  }

  openexitreasoninfo() {
    // No data or function to call
  }

}