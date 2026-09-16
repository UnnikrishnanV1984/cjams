import  {map} from 'rxjs/operators';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService } from '../../../../../@core/services/alert.service';
import _  from 'lodash';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { AuthService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { CASE_STORE_CONSTANTS ,CASE_TYPE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { forkJoin, Observable } from 'rxjs';
import { DropdownModel, DynamicObject} from '../../../../../@core/entities/common.entities';
import { InvolvedPerson } from '../../../_entities/caseworker.data.model';
import moment from 'moment';
import { AppConstants } from '../../../../../@core/common/constants';

import { CourtOrderList, HearingDetails } from '../_entities/court.data.model';
import { CourtResolverService } from '../court-resolver-service';
declare var $: any;

@Component({
    selector: 'court-tpr',
    templateUrl: './court-tpr.component.html',
    styleUrls: ['./court-tpr.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})

export class CourtTprComponent implements OnInit{
    id!: string;
    courtorderdetails: any[] = [];
    tprlist:any[]=[];
    involvedPersons$!: Observable<any[]>;
    involvedPersons: any[] = [];
    preadopinvolvedPersons: any[] = [];
    involvedYouth!: string;
    selectedChildarray: any[] = [];
    everbeenadoptedflag: any;
    remainingPeople!: InvolvedPerson[];

    tprDetailsForm!: FormGroup;
    hearingDetails: HearingDetails = new HearingDetails();
    hearingData: any[] = [];
    courtDetailsList: CourtOrderList[] = [];
    isCourtOrderEditable!: boolean;
    courthearingtprdetails:any[] = [];
    hearingtypeArray: string[] = [];
    hearingstatustypeArray: string[] = [];

    store!: DynamicObject;
    // tprDetailsForm: FormGroup;
    // tprDetailsForm: FormGroup;
    isTermination!: boolean;
    // involvedPersons: InvolvedPerson[] = [];
    // involvedPersons: InvolvedPerson[] = [];
    appealDecisionDropdownItems$!: Observable<DropdownModel[]>;
    terminationtypDropdownItems$!: Observable<DropdownModel[]>;
    methodServiceDropdownItems$!: Observable<DropdownModel[]>;
    // tprListDetails: TprDetails[];
    // tprListDetails: TprDetails[];
    tprListDetails: any[] = [];
    tprDetailsFromPermanencyplan: any[] = [];
    adoptiontprlist: any[] = [];
    tprclientlist: any[] = [];
    addEditLabel!: string;
    updateButton!: boolean;
    // hearingData: any[] = [];
    courtOrder: CourtOrderList[] = [];
    private daNumber!: string;
    alertMessage!: string;
    // remainingPeople: InvolvedPerson[];
    // remainingPeople: InvolvedPerson[];
    isAdoptionCreated!: boolean;
    alertText!: string;
    deletingTPR: any;
    // selectedChildarray: any[];
    // everbeenadoptedflag: any;
    everadoptedsingleparentcheck: any;
    tprRecommendationList: any;
    isEditDisabled = false;
    isDeleteDisabled = false;
    // _navigationService: any;
    // _navigationService: any;
    courtOrderCoho: any[] = [];
    courtOrderColang: any[] = [];
    courtOrderCopp: any[] = [];
    selectedparentname!: string;
    tprclientlistnew: any[] = [];
    addtprparent!: boolean;
    isAdoptionCase=false;
    selectedchild: any;
    _bioCjamspid: any;
    _bioServicecaseid: any;
  
    gettypesurl = 'referencetype/gettypes';
    terminationpopupid = '#termination-ofparental';
    iscaseexpunged: any = 0;
    editTpr: boolean = false;
    selectedTprRow: any;
    selectedParentRow: any = null;
    private readonly _commonHttpService: CommonHttpService;
    private readonly _alertService: AlertService;
    public _authService: AuthService;
    private readonly _datastore: DataStoreService;
    private readonly storage: SessionStorageService;
    private readonly _courtResolverService: CourtResolverService;
    public cdr: ChangeDetectorRef;
   

    constructor(
        private injector: Injector,
        private readonly _formBuilder: FormBuilder
        ) {
            this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
            this._alertService = this.injector.get<AlertService>(AlertService);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._datastore = this.injector.get<DataStoreService>(DataStoreService);
            this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
            this._courtResolverService = this.injector.get<CourtResolverService>(CourtResolverService);
            this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
         }

    ngOnInit(): void {
        this.iscaseexpunged = this._datastore.getData('iscaseexpunged');
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const caseType = this.storage.getItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
         } 
        this.getInvolvedPerson();
        this.initializetprform();
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.addEditLabel = 'Add';

        this.getBreaklink();
        this.getAppealDecisionDropdown();
        this.getTerminationTypeDropdown();
        this.getMethodServiceDropdown();
        this.tprDetailsForm.controls['parentname'].disable();
        
    }

    


    private getBreaklink() {
        this._commonHttpService
          .getArrayList({
            method: 'get', where: {
            
            }
          }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
          .subscribe(res => {
            if (res && res.length) {
                res.forEach((item) => {
                  if (item && item.getadoptionbreakthelink) {
                    item.getadoptionbreakthelink.forEach((breaklink: any) => {
                      this.isAdoptionCreated = !!breaklink.adoptioncasenumber;
                    });
                  }
                });
              }
          });
      }

    ValidateStoreValues() {
        if (this.store['CASEUID']) {
        this.id = this.store['CASEUID'];
        }
        if (
            !this.store['LegalCustodyDetails'] ||
            !this.store['LegalCustodyDetails'].length
        ) {
            $('#ap-tpr').modal('show');
        } else {
            if (!this.store['LegalCustodyDetails'].filter((custody: { legalcustodytypekey: string; }) => custody.legalcustodytypekey === 'GUARDDSS').length) {
                $('#ap-tpr').modal('show');
                this.alertMessage = 'Please complete the Legal Custody with Guardianship to DSS';
            } 
        }
    }
    

    isSetValidator(item: any) {
    const isEditMode = this.editTpr && !this.tprDetailsForm.controls['isdisabled'].value;

    if (item) {
        this.tprDetailsForm.controls['isdssappealed'].setValidators([Validators.required]);
        this.tprDetailsForm.controls['appealdate'].setValidators([Validators.required]);

        if (isEditMode) {
            this.tprDetailsForm.get('isdssappealed')?.enable();
            this.tprDetailsForm.get('appealdate')?.enable();
            this.tprDetailsForm.get('appealdecisiontypekey')?.enable();
            this.tprDetailsForm.get('decisiondate')?.enable();
            this.tprDetailsForm.get('parentname')?.enable();
        }
    } else {
        this.tprDetailsForm.controls['isdssappealed'].clearValidators();
        this.tprDetailsForm.controls['appealdate'].clearValidators();

        this.tprDetailsForm.patchValue({
            isdssappealed: null,
            appealdate: null,
            appealdecisiontypekey: '',
            decisiondate: null
        });

        if (isEditMode) {
            this.tprDetailsForm.get('isdssappealed')?.disable();
            this.tprDetailsForm.get('appealdate')?.disable();
            this.tprDetailsForm.get('appealdecisiontypekey')?.disable();
            this.tprDetailsForm.get('decisiondate')?.disable();
            this.tprDetailsForm.get('parentname')?.disable();
        }
    }

    this.tprDetailsForm.controls['appealdate'].updateValueAndValidity();
    this.tprDetailsForm.controls['isdssappealed'].updateValueAndValidity();
}

    cancelTRPDetails() {
        this.isSetValidator(false);
        this.tprDetailsForm.reset();
        this.updateButton = false;
        this.addEditLabel = 'Add';
    }
   

    private getAppealDecisionDropdown() {
        this.appealDecisionDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '29',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
            map(result => {
                return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
            }));
    }

    private getMethodServiceDropdown() {
        this.methodServiceDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '35',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
            map(result => {
                return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
            }));
    }


    patchTPR(data: any) {
        this.tprDetailsForm.reset();
        this.tprDetailsForm.patchValue(data);
        this.tprDetailsForm.disable();
            this.tprDetailsForm.patchValue({
                 isdisabled: true
            });
            $(this.terminationpopupid).modal('show');
    }  

  manageTPR(type: any, item?: any, parentrow?: any) {
    const hearingdatetime = moment(item.hearingdatetime).format('YYYY-MM-DD');

    if (type === 'add') {
        this.selectedTprRow = null;
        this.selectedParentRow = null;
        this.addEditLabel = 'Add';
        this.editTpr = false;
        this.updateButton = false;
        this.tprDetailsForm.enable();
        this.tprDetailsForm.reset();
        this.tprDetailsForm.patchValue({
            tprdetailsid: null,
            isdisabled: false
        });
        this.disableParentNameFields();
        $(this.terminationpopupid).modal('show');
        return;
    }

    this.selectedParentRow = parentrow;
    item.isdssappealed = item.isdssappealed ? `${item.isdssappealed}` : '';

    if (parentrow?.intakeservicerequestactorid) {
        let tpr: any[] = [];
        tpr = this.tprListDetails.filter(list =>
            list.intakeservreqcourtorderid === item.intakeservicerequestpetitionid &&
            list.intakeservicerequestactorid === parentrow.intakeservicerequestactorid &&
            moment(list.tprdecisiondate).format('YYYY-MM-DD') === hearingdatetime
        );

        tpr = _.sortBy(tpr, 'updatedon').reverse();

        if (tpr?.length === 1) {
            this.selectedTprRow = tpr[0];
            this.tprDetailsForm.reset();
            this.tprDetailsForm.patchValue(tpr[0]);
            this.selectedparentname = tpr[0]?.parentname;
            this.isSetValidator(tpr[0]?.isappealed);
        } else {
            tpr = this.tprListDetails.filter(list =>
                list.personid === item.personid &&
                parentrow.intakeservicerequestactorid === list.intakeservicerequestactorid
            );
            tpr = _.sortBy(tpr, 'updatedon').reverse();
            this.selectedTprRow = tpr[0];
            this.tprDetailsForm.reset();
            this.tprDetailsForm.patchValue(tpr[0]);
            this.selectedparentname = tpr[0]?.parentname;
            this.isSetValidator(tpr[0]?.isappealed);
        }
    } else {
        let tpr: any[] = [];
        tpr = this.tprListDetails.filter(list =>
            list.intakeservreqcourtorderid === item.intakeservicerequestpetitionid &&
            list.parentname === parentrow &&
            list.tprdecisiondate === hearingdatetime
        );
        if (tpr?.length) {
            this.selectedTprRow = tpr[0];
            this.tprDetailsForm.reset();
            this.tprDetailsForm.patchValue(tpr[0]);
            this.selectedparentname = tpr[0]?.parentname;
            this.isSetValidator(tpr[0].isappealed);
        } else {
            tpr = this.tprListDetails.filter(list =>
                list.personid === item.personid &&
                parentrow?.intakeservicerequestactorid === list.intakeservicerequestactorid
            );
            this.selectedTprRow = tpr[0];
            this.tprDetailsForm.reset();
            this.tprDetailsForm.patchValue(tpr[0]);
            this.selectedparentname = tpr[0]?.parentname;
            this.isSetValidator(tpr[0]?.isappealed);
        }
    }
    this.changePerson(item.intakeservicerequestactorid);

    if (type === 'view') {
        this.addtprparent = false;
        this.editTpr = false;
        this.addEditLabel = 'View';
        this.updateButton = true;
        this.tprDetailsForm.disable();
        this.tprDetailsForm.patchValue({
            isdisabled: true
        });
    } else if (type === 'edit') {
        this.addtprparent = false;
        this.editTpr = true;
        this.addEditLabel = 'Edit';
        this.updateButton = true;
        this.tprDetailsForm.disable();
        this.tprDetailsForm.get('servicetypekey')?.enable();
        this.tprDetailsForm.get('serveddate')?.enable();
        this.tprDetailsForm.get('relationshiptypekey')?.enable();
        this.tprDetailsForm.get('terminationtypekey')?.enable();
        this.tprDetailsForm.get('isappealed')?.enable();
        this.tprDetailsForm.get('reason')?.enable();
        this.tprDetailsForm.patchValue({
            isdisabled: false
        });
        this.isSetValidator(this.tprDetailsForm.get('isappealed')?.value);
        this.disableParentNameFields();
    }
    $(this.terminationpopupid).modal('show');
    this.disableParentNameFields();
}


    deleteConfirm(){
        this._commonHttpService.patch(this.deletingTPR.tprdetailsid, {activeflag : 0}, 'tprdetails').subscribe(data => {
            if(data && data.tprdetailsid && data.activeflag === 0){
                this._alertService.info("Successfully removed parent.");
            }else{
                this._alertService.error("Error removing parent.");
            }
            this.deletingTPR = null;
            this.getTPRList();
        });
    }
    private getTerminationTypeDropdown() {
        this.terminationtypDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '30',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                `${this.gettypesurl}?filter`
            ).pipe(
                map(result => {
                    return this._courtResolverService.mapToDropdownModel(result, 'description', 'ref_key');
                }));
    }

        private getTPRList() {
            if(!this.isAdoptionCase){
        this.tprListDetails = [];
        this._commonHttpService.getArrayList(
            {
                where: { 
                    servicecaseid: this.id ? this.id : null
                 },
                method: 'get',
                nolimit: true
            }, 'tprdetails/gettprdetails' + '?filter'
            ).subscribe((res) => {
            if (res?.length) {
                this.tprListDetails = res;
                  this.mergeUnknownTprParentsIntoInvolvedPersons();
                this.tprDetailsFromPermanencyplan = [];
                res.forEach((item) => {
                    if(!item.intakeservreqcourtorderid) {
                        this.tprDetailsFromPermanencyplan.push(item);
                    } 
                })
                this.checkTPRPlacement();
                 this.tprclientlist = this.selectedChildarray.filter(entry1 => this.tprListDetails.some(entry2 => entry1.personid === entry2.personid));
                this.setTprList();
                

            }
            this.cdr.markForCheck();

        });
        setTimeout(() => {
            this.gethearingDetails();
        }, 1000);
    }   
    }

    setTprList(){
        if(this.tprlist?.length === 0) {
            this.courtDetailsList.forEach((item) => {
                this.tprclientlist.forEach((element) => {
                    if(item.personid === element.personid) {
                        this.tprlist.push(item);
                    }
                });
            })
        }
    }

    checkTPRPlacement() {
     
          //If TPR completed and missing pre-adoptive placement
       this.remainingPeople = [];
       let filterparentdetails;
        if( this.tprListDetails?.length){
            filterparentdetails = [
                ...new Map(this.tprListDetails.map((item) => [item["intakeservicerequestactorid"], item])).values(),
            ];
             
                       
            if( this.involvedPersons?.length) {

                filterparentdetails.forEach( t => {
                    this.involvedPersons.forEach(p=>{
                       if( p?.roles[0]?.intakeservicerequestactorid === t.intakeservicerequestactorid) {
                           t.correctactorid = p.roles[0].intakeservicerequestactorid
                       }
                      if( t.intakeservicerequestactorid === p.intakeservicerequestactorid){
                        this.remainingPeople.push(p);
                      }
            
                    });
                })
            }
            if(filterparentdetails?.length > 1) {
                this.tprDetailsForm.patchValue(
                    {
                        intakeservicerequestactorid1: this.getTprActorId(filterparentdetails),
                        serveddate1: filterparentdetails[1]?.serveddate,
                        servicetypekey1: filterparentdetails[1]?.servicetypekey,
                        terminationtypekey1: filterparentdetails[1]?.terminationtypekey,
                        isappealed1: filterparentdetails[1]?.isappealed,
                        isdssappealed1: filterparentdetails[1]?.isdssappealed,
                        appealdate1: filterparentdetails[1]?.appealdate,
                        appealdecisiontypekey1: filterparentdetails[1]?.appealdecisiontypekey,
                        decisiondate1: filterparentdetails[1]?.decisiondate1,
                        reason1: filterparentdetails[1]?.reason,
                        parentname1:  filterparentdetails[1]?.parentname,
                        tprdetailsid1: null,
                        tprdecisiondate1: filterparentdetails[1]?.tprdecisiondate,
                        tprpetitiondate1: filterparentdetails[1]?.tprpetitiondate,
                        relationshiptypekey1: filterparentdetails[1]?.relationshiptypekey,
                        isdenied1: filterparentdetails[1]?.isdenied,
                        isgranted1: filterparentdetails[1]?.isgranted ,
                        iscontested1: filterparentdetails[1]?.iscontested ,
                        singleparent1: filterparentdetails[1]?.singleparent ,
                        isdisabled1: filterparentdetails[1]?.isdisabled
                    });
            }
            this.changePerson(filterparentdetails[0].intakeservicerequestactorid);
            
        }
    }

    getTprActorId(filterparentdetails: any){
        return filterparentdetails[1].correctactorid ? filterparentdetails[1].correctactorid : filterparentdetails[1]?.intakeservicerequestactorid;
    }

    changePerson(_id: any) {
        // This method is intentionally left blank
        // It is used in multiple places and might be implemented in the future
    }

   
saveTprDetail() {

    if (this.tprDetailsForm.get('isappealed')?.value) {
        this.tprDetailsForm.get('isdssappealed')?.setValidators([Validators.required]);
        this.tprDetailsForm.get('appealdate')?.setValidators([Validators.required]);

        this.tprDetailsForm.get('isdssappealed')?.updateValueAndValidity();
        this.tprDetailsForm.get('appealdate')?.updateValueAndValidity();

        if (
            this.tprDetailsForm.get('isdssappealed')?.invalid ||
            this.tprDetailsForm.get('appealdate')?.invalid
        ) {
            this.tprDetailsForm.get('isdssappealed')?.markAsTouched();
            this.tprDetailsForm.get('appealdate')?.markAsTouched();
           
            return;
        }
    }
  const TprDetailInput = this.tprDetailsForm.getRawValue();
  TprDetailInput.intakeserviceid = null;
  TprDetailInput.servicecaseid = this.id;
  TprDetailInput.tprdetailsid = this.selectedTprRow?.tprdetailsid;
  TprDetailInput.tprrecommendationid =
    this.selectedTprRow?.tprrecommendationid || TprDetailInput.tprrecommendationid;

  TprDetailInput.intakeservicerequestactorid =
    this.selectedTprRow?.intakeservicerequestactorid || TprDetailInput.intakeservicerequestactorid;

  TprDetailInput.isdssappealed =
    TprDetailInput.isdssappealed !== null ? Number(TprDetailInput.isdssappealed) : null;

  TprDetailInput.isappealed = TprDetailInput.isappealed ? 1 : 0;
  this._commonHttpService.create(TprDetailInput, 'tprdetails/addtprdetail').subscribe(() => {
    this.getTPRList();
    this._alertService.success('TPR Details saved successfully');
    $(this.terminationpopupid).modal('hide');
    this.tprDetailsForm.reset();
  });
}
   
    getchecklists() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let courtReqObj = {};
        if (isServiceCase) {
            courtReqObj = {
                objectid: this.id,
                objecttype: 'servicecase'
            };
        } else {
            courtReqObj = { intakeserviceid: this.id };
        }
        forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    where: courtReqObj
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl}?filter`
            ),
            
            this._commonHttpService.getArrayList({}, 
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.HearingTypeUrl}?filter={"where": {"teamtypekey": "CW"}, "nolimit":true,"order":"description"}`),
            this._commonHttpService.getArrayList({}, 'hearingstatustype?filter={"nolimit":true,"order":"description"}'),
            
        ]).subscribe((data) => {
             if (data) {
                if (data[0].length) {
                    this.courtDetailsList = data[0];
                    this.courtorderdetails = data[0];
           
            this.tprlist =[];
            this.courtorderdetails.forEach(corder => this.checkfortprlist(corder));

            
            this.getTPRList();
                }
                data[1].forEach(type => {
                    this.hearingtypeArray[type.hearingtypekey] = type.description;
                });
                data[2].forEach(type => {
                    this.hearingstatustypeArray[type.hearingstatustypekey] = type.description;
                });
                 
            }
        }
        );
    }
    initializetprform(){
         this.tprDetailsForm = this._formBuilder.group({
            intakeservicerequestactorid: ['', [Validators.required]],
            serveddate: [null],
            servicetypekey: [''],
            terminationtypekey: [''],
            isappealed: [null],
            isdssappealed: [null],
            appealdate: [null],
            appealdecisiontypekey: [''],
            decisiondate: [null],
            reason: [''],
            parentname: [''],
            tprdetailsid: [null],
            tprdecisiondate: [null],
            tprpetitiondate: [null],
            relationshiptypekey: [null],
            isdenied: [null],
            isgranted: [null],
            iscontested: [null],
            singleparent: [null],
            isdisabled: [true],
            intakeservicerequestactorid1: [null],
            serveddate1: [null],
            servicetypekey1: [''],
            terminationtypekey1: [''],
            isappealed1: [null],
            isdssappealed1: [null],
            appealdate1: [null],
            appealdecisiontypekey1: [''],
            decisiondate1: [null],
            reason1: [''],
            parentname1: [''],
            tprdetailsid1: [null],
            tprdecisiondate1: [null],
            tprpetitiondate1: [null],
            relationshiptypekey1: [null],
            isdenied1: [null],
            isgranted1: [null],
            iscontested1: [null],
            singleparent1: [null],
            isdisabled1: [true]
        });
   }

   
    checkfortprlist(corder: any){
      if(corder.hearingoutcome && corder.courtorderdate !== null && (corder.childpermanencyplankey === 'ABN' || corder.childpermanencyplankey === 'PRA')){
        corder.hearingoutcome.forEach((item: { hearingoutcometypekey: string; }) =>{
            if((item.hearingoutcometypekey === 'TPRGRA') || (item.hearingoutcometypekey === 'TPRDEN')){
               this.tprlist.push(corder);
            }
        })
      }
    }   

    getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser(); 
        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let reqObj = {};
        if (isServiceCase) {
            reqObj = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        } else {
            reqObj = {
                intakeserviceid: this.id,
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        this._commonHttpService
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: reqObj
                },
                url + '?filter'
            )
            .subscribe((res: any) => {
                if (res['data'] && res['data'].length) {
                    this.selectedChildarray = [];
                    this.maprolename(res);
                    if(this.selectedChildarray && this.selectedChildarray.length) {
                        this.everbeenadoptedflag = this.selectedChildarray[0].everbeenadoptedflag;
                    }

                    this.setInvolvedPersons(res['data']);                  
                }
                this.getadoptiondetails();
            });

    }
    maprolename(res: any) {
 
    res['data'].map((item: any) => {
        if (!item.rolename || item.rolename === '') {
            if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                item.rolename = item.roles[0].intakeservicerequestpersontypekey;
            }
        }
        const rolename = item.rolename ? item.rolename : '';
        const child = ['CHILD', 'AV', 'OTHERCHILD', 'RC'].includes(rolename);
        if (child) {
            this.selectedChildarray.push(item);
        }
    });
    
    if (this.selectedChildarray.length) {
        this.getchecklists();
    }
}    

filterPersons(persons: any) {
    return persons.filter((item: any) => {
        if (!item.rolename || item.rolename === '') {
            if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                item.rolename = item.roles[0].intakeservicerequestpersontypekey;
            }
        }
        if (item.rolename &&
            item.rolename !== 'AV' &&
            item.rolename !== 'CHILD' &&
            item.rolename !== 'RC' &&
            item.rolename !== 'BIOCHILD' &&
            item.rolename !== 'NVC' &&
            item.rolename !== 'OTHERCHILD' &&
            item.rolename !== 'PAC'
        ) {
            if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
            }
            return true;
        }
        return false;
    });
}

    setInvolvedPersons(persons: any) {
        this.involvedPersons = this.filterPersons(persons);
         this.mergeUnknownTprParentsIntoInvolvedPersons();
    }

    getadoptiondetails() {
        if (this.isAdoptionCase) {
            this._commonHttpService.getArrayList(
                {
                    where: {
                        client: this.selectedChildarray[0]?.cjamspid ? this.selectedChildarray[0]?.cjamspid : null
                    },
                    method: 'get',
                    nolimit: true
                }, 'tprdetails/getadoptiondetails' + '?filter'
            ).subscribe((result) => {
                if (result && result.length) {
                    this._bioServicecaseid = result[0].getadoptiondetails[0].bio_case;
                    this._bioCjamspid = result[0].getadoptiondetails[0].bio_client;
                    const _bioPersonid = result[0].getadoptiondetails[0].bio_personid ? result[0].getadoptiondetails[0].bio_personid : null;
                    this._commonHttpService.getArrayList(
                        {
                            where: {
                                servicecaseid: this._bioServicecaseid ? this._bioServicecaseid : null
                            },
                            method: 'get',
                            nolimit: true
                        }, 'tprdetails/gettprdetails' + '?filter'
                    ).subscribe((tprlist) => {
                        this.tprlistcheck(tprlist,_bioPersonid);
                  
                    });
                }
            });
        }

    }

    tprlistcheck(tprlist: any,_bioPersonid: any){
        if (tprlist && tprlist.length) {
            const alltprListDetails = tprlist.filter((item: { personid: any; }) => item.personid === _bioPersonid);
            if (alltprListDetails && alltprListDetails.length) {
                const sorting = _.sortBy(alltprListDetails, 'tprdecisiondate').reverse();
                const filterUnique = _.uniqBy(sorting, 'intakeservicerequestactorid');
                this.adoptiontprlist = filterUnique;
            } else {
                this.adoptiontprlist = alltprListDetails;
            }
            this.getservicecaseinvolvedperson();
         this.cdr.markForCheck()
        }
    }
getservicecaseinvolvedperson(){
    let url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    let reqObj = {};
    
        reqObj = {
            objectid: this._bioServicecaseid,
            objecttypekey: 'servicecase',
            iscaseexpunged: this.iscaseexpunged
        };
        this._commonHttpService
        .getArrayList(
            {
                page: 1,
                method: 'get',
                where: reqObj
            },
            url + '?filter'
        ) .subscribe((res: any) => {
            if (res['data'] && res['data'].length) {
                
                
                res['data'].map((item: any) => {
                  if ( !item.rolename || item.rolename === '') {
                    if ( item.roles &&  item.roles.length &&  item.roles[0].intakeservicerequestpersontypekey) {
                        item.rolename  = item.roles[0].intakeservicerequestpersontypekey; }
                  }                  
                });
                this.setPreadopinvolvedPersons(res['data']);
                this.preadopinvolvedPersons =
                    this.mergeUnknowntprparentsintopreadopinvolvedpersons(
                        this.preadopinvolvedPersons,
                        this.adoptiontprlist || []
                    );
            }
            
                });
               
            
   
}
setPreadopinvolvedPersons(persons: any) {
    this.preadopinvolvedPersons = this.filterPersons(persons);
}

manageTPRadop(item: any){
this.tprDetailsForm.patchValue(item); 
this.addtprparent = false;
            this.addEditLabel = 'View';
            this.updateButton = true;
            this.tprDetailsForm.disable();   
            $(this.terminationpopupid).modal('show');
}
routeToview(_plan: any){
    $(this.terminationpopupid).modal('show');
}
clearTPRDetails(){
    $(this.terminationpopupid).modal('hide');
    this.tprDetailsForm.reset();
}

private handleHearingResult(result: any[]): void {
    if (Array.isArray(result) && result.length) {
        this.hearingDetails = result[0];
        this.hearingData = [];

        result.forEach((res) => {
            if ((!res.old_id) && res.hearingstatustypekey !== 'SCHULD') {
                this.scheduledHearing(res);
            }

            if ((res.old_id || res.intakeservicerequestpetition.intakeservicerequestpetitionactor.length === 0) && res.hearingstatustypekey !== 'SCHULD') {
                this.unscheduledHearing(res);
            }

        });

        this.hearingData = _.orderBy(this.hearingData, ['hearingdatetime'], ['desc']);
        this.hearingData.forEach((hearing) => {
            hearing.hearingdatetime = moment(hearing.hearingdatetime).format('YYYY-MM-DD hh:mm A');
        });


        this.courthearingtprdetails = this.hearingData.filter(item => ((item.hearingtype.includes('TGU') || item.hearingtype.includes('TGC'))
            && item.hearingstatustypekey === 'CONCULD'));
        this.checkcourthearingtprdetails();
        this.checktprclientlist();
    }
}

    gethearingDetails() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let hearingReqObj = {};
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        
        if (isServiceCase) {
            hearingReqObj = {
                objectid: this.id,
                objecttype: 'servicecase',
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        } else {
            hearingReqObj = {
                intakeservicerequestid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        if (this.id) {
            this._commonHttpService
                .getArrayList(
                    {
                        method: 'get',
                        where: hearingReqObj
                    },
                    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getHearingUrl}?filter`
                )
                .subscribe(
                    (result) => {
                        this.handleHearingResult(result);
                    },
                    (error) => { 
                        this._alertService.error(error);
                    }
                );
        }
    }
    // Assosiated with gethearingDetails method
    private handleScheduleHearingFn(result: any[]) {
        result.forEach((resp) => {
            if ((!resp.old_id) && resp.hearingstatustypekey !== 'SCHULD') {
                this.scheduledHearing(resp);
            }
            if ((resp.old_id || resp.intakeservicerequestpetition.intakeservicerequestpetitionactor.length === 0) && resp.hearingstatustypekey !== 'SCHULD') {
                this.unscheduledHearing(resp);
            }
        });
    }

    scheduledHearing(hearing: any) {
        const actorList = hearing.intakeservicerequestpetition.intakeservicerequestpetitionactor.filter((item: { petitionactortype: string; }) => item.petitionactortype === 'PA');
        const list = actorList.map((actor: any) => {
            const obj = Object.assign({}, hearing);
            obj.intakeservicerequestpetition.intakeservicerequestpetitionactor = actor;
            if (actor.intakeservicerequestactor) {
                const person = actor.intakeservicerequestactor.person;
                obj.personid = person.personid;
                obj.personname = person.fullname;
                obj.intakeservicerequestactorid = actor.intakeservicerequestactor.intakeservicerequestactorid;
            }
            obj.petitionid = hearing.intakeservicerequestpetition.petitionid;
            if (this.courtDetailsList.length) {
                const courtOrder = this.courtDetailsList.find(item => ((item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
                    && (item.intakeservicerequestactorid === obj.intakeservicerequestactorid)));
                if (courtOrder) {
                    obj.isEditable = (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)
                        || this._authService.selectedRoleIs('IV-E Specialist')
                        || this._authService.selectedRoleIs('IV-E Supervisor')
                        || this._authService.selectedRoleIs('DHS Legal Attorney') || this.isCourtOrderEditable);
                } else {
                    this.handleEditableAccessFn(obj);
                }
            } else {
                obj.isEditable = true;
            }
            return obj;
        });

        this.hearingData = this.hearingData.concat(list);
    }

    // Assosiated with unscheduledHearing method
    private handleEditableAccessFn(obj: any) {
        if (this._authService.readonlyButton('read_only_access', 'caseworker-court-order-add')) {
            obj.isEditable = true;
        } else {
            obj.isEditable = false;
        }
    }

    unscheduledHearing(hearing: any) {
        const clientList = (hearing.hearingclientdetails) ? hearing.hearingclientdetails : [];
        const actorList = clientList.filter((item: { otherclientflag: number; }) => item.otherclientflag === 0);
        const list = actorList.map((actor: { personid: any; clientname: any; intakeservicerequestactorid: any; }) => {
            const obj = Object.assign({}, hearing);
            obj.intakeservicerequestpetition.intakeservicerequestpetitionactor = actor;
            if (actor) {
                obj.personid = actor.personid;
                obj.personname = actor.clientname;
                obj.intakeservicerequestactorid = actor.intakeservicerequestactorid;
            }
            obj.petitionid = hearing.intakeservicerequestpetition.petitionid;
            if (this.courtDetailsList.length) {
                const courtOrder = this.courtDetailsList
                                        .find(item => (item.intakeservicerequesthearingid === hearing.intakeservicerequestcourthearingid)
                );
                obj.isEditable = !!courtOrder 
                ? this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)
                  || this._authService.selectedRoleIs('IV-E Specialist')
                  || this._authService.selectedRoleIs('IV-E Supervisor')
                  || this._authService.selectedRoleIs('DHS Legal Attorney')
                  || this.isCourtOrderEditable
                : this._authService.readonlyButton('read_only_access', 'caseworker-court-order-add');
            } else {
                obj.isEditable = true;
            }
            return obj;
        });
        this.hearingData = this.hearingData.concat(list);
    }

checkcourthearingtprdetails() {
    this.courthearingtprdetails.forEach((item, i) => {
        this.courthearingtprdetails[i].courtordertprdetails = [];
        this.courthearingtprdetails[i].parentdetails = [];
        this.tprlist.forEach((citem) => {
            if (item.intakeservicerequestpetitionid === citem.intakeservicerequestpetitionid) {
                this.courthearingtprdetails[i].courtordertprdetails.push(citem);
            }
        });
         if (item.hearingclientdetails) {
                item.hearingclientdetails.forEach((hc: any) => {
                    if (hc.otherclientflag === 1) {
                       this.handleIfOtherclientflagIsOneFn(hc, i);
                    }
                })
         }

        const tprParents = (this.tprListDetails || []).filter((tpr: any) =>
            tpr.intakeservreqcourtorderid === item.intakeservicerequestpetitionid
        );

        tprParents.forEach((tpr: any) => {
            const alreadyExists = this.courthearingtprdetails[i].parentdetails.some((p: any) =>
                p.tprdetailsid === tpr.tprdetailsid
            );

            if (!alreadyExists) {
                this.courthearingtprdetails[i].parentdetails.push({
                    tprdetailsid: tpr.tprdetailsid,
                    tprrecommendationid: tpr.tprrecommendationid,
                    intakeservicerequestactorid: tpr.intakeservicerequestactorid,
                    intakeservreqcourtorderid: tpr.intakeservreqcourtorderid,
                    personid: tpr.personid,
                    clientname: tpr.parentname,
                    actortype: tpr.actortype,
                    relationship: tpr.relationship,
                    breaklinkstatus: tpr.breaklinkstatus
                });
            }
        });
    });
}

    // Assosiated with checkcourthearingtprdetails method
    private handleIfOtherclientflagIsOneFn(hc: any, i: number) {
        this.involvedPersons.forEach((p) => {
            if (p.personid === hc.personid) {
                if (p.roles && p.roles.length && p.roles[0].intakeservicerequestactorid) {
                    hc.intakeservicerequestactorid = p.roles[0].intakeservicerequestactorid;
                }
            }
        });
        this.courthearingtprdetails[i].parentdetails.push(hc);
    }

    checktprclientlist() {
        this.tprclientlist?.forEach((item, i) => {
            this.tprclientlist[i].hearingtprdetails = [];
    
            const relevantCourtHearings = this.courthearingtprdetails.filter(x => 
                (x.hearingtype.includes('TGC') || x.hearingtype.includes('TGU')));
    
        relevantCourtHearings.forEach(courtitem => {
            const hearingParentNames = (courtitem.hearingparents || []).map((hp: any) => {
    const name = hp.name?.trim().toLowerCase();

    return name === 'unknown'
        ? `${hp.petitionactortype} ${name}`.toLowerCase()
        : name;
});
            courtitem.parentdetails = (courtitem.parentdetails || []).filter((pd: any) =>
                hearingParentNames.includes(
                    pd.clientname?.trim().toLowerCase()
                )
            );
            
                if (courtitem.courtordertprdetails.length > 0 && item.fullname === courtitem.personname) {
                    this.tprclientlist[i].hearingtprdetails.push(courtitem);
                }
            });
            this.tprclientlist[i].permanencyplantprdetails = [];
    
        const relevantHearingData = this.hearingData.filter(x => (x.hearingtype.includes('TGC') || x.hearingtype.includes('TGU')));
            this.tprDetailsFromPermanencyplan.forEach((pp) => {
                relevantHearingData.forEach(element => {
                    if (element.personid === pp.personid) {
                        pp.petitionid = element.petitionid;
                        pp.hearingtype = element.hearingtype;
                    }
                });

                if (pp.personid === item.personid && pp.petitionid != null && pp.hearingtype) {
                    this.tprclientlist[i].permanencyplantprdetails.push(pp);
                }
            });
        });
         this.cdr.markForCheck()
    }
    

getDateTimeFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format('MM/DD/YYYY, h:mm A');
    }else{
      return '';}
  }

    private disableParentNameFields(): void {
        this.tprDetailsForm.get('intakeservicerequestactorid')?.disable({ emitEvent: false });
        this.tprDetailsForm.get('intakeservicerequestactorid1')?.disable({ emitEvent: false });

        this.cdr.detectChanges();
    }

    getSelectedParentName(): string {
        const actorId = this.tprDetailsForm?.get('intakeservicerequestactorid')?.value;

        const selectedParent = this.remainingPeople?.find(
            (person: any) => person?.intakeservicerequestactorid === actorId
        );

        if (!selectedParent) {
            return '';
        }

        return `${selectedParent.firstname || ''} ${selectedParent.lastname || ''}`.trim();
    }

    getSelectedAdoptionParentName(): string {
        const actorId = this.tprDetailsForm?.get('intakeservicerequestactorid')?.value;

        const selectedParent = this.preadopinvolvedPersons?.find((person: any) =>
            person?.intakeservicerequestactorid === actorId
        );

        if (selectedParent) {
            return (
                selectedParent.parentname ||
                selectedParent.fullname ||
                `${selectedParent.firstname || ''} ${selectedParent.lastname || ''}`.trim()
            );
        }

        return this.tprDetailsForm?.get('parentname')?.value || '';
    }

    private mergeUnknownTprParentsIntoInvolvedPersons(): void {
    if (!this.tprListDetails?.length || !this.involvedPersons) {
        return;
    }

    const unknownTprParents = this.tprListDetails.filter((tpr: any) =>
        tpr.actortype === 'UKN' &&
        tpr.intakeservicerequestactorid
    );

    unknownTprParents.forEach((tpr: any) => {
        const exists = this.involvedPersons.some((p: any) =>
            p.intakeservicerequestactorid === tpr.intakeservicerequestactorid
        );

        if (!exists) {
            this.involvedPersons.push({
                intakeservicerequestactorid: tpr.intakeservicerequestactorid,
                personid: tpr.personid || null,
                firstname: tpr.parentname || 'Unknown',
                lastname: '',
                fullname: tpr.parentname || 'Unknown',
                clientname: tpr.parentname || 'Unknown',
                parentname: tpr.parentname || 'Unknown',
                rolename: 'UKN',
                actortype: 'UKN',
                relationship: tpr.relationship,
                relationshipdescription: tpr.relationship || 'Unknown',
                roles: [{
                    intakeservicerequestactorid: tpr.intakeservicerequestactorid,
                    intakeservicerequestpersontypekey: 'UKN',
                    typedescription: 'Unknown Parent'
                }],
                isUnknownParent: true
            });
        }
    });
}

    mergeUnknowntprparentsintopreadopinvolvedpersons(involvedPersons: any[], tprList: any[]) {
        const list = [...(involvedPersons || [])];

        (tprList || []).forEach((tpr: any) => {
            const actorId = tpr.intakeservicerequestactorid;

            const exists = list.some(
                (p: any) => p.intakeservicerequestactorid === actorId
            );

            if (!exists && tpr.parentname) {
                list.push({
                    firstname: tpr.parentname,
                    lastname: '',
                    fullname: tpr.parentname,
                    parentname: tpr.parentname,
                    intakeservicerequestactorid: actorId,
                    rolename: 'UNKNOWNPARENT',
                    roles: [{
                        intakeservicerequestactorid: actorId,
                        intakeservicerequestpersontypekey: 'UNKNOWNPARENT',
                        typedescription: 'Unknown Parent'
                    }]
                });
            }
        });

        return list;
    }


isBreakLinkApproved(parentrow: any): boolean {
    return parentrow?.breaklinkstatus?.toLowerCase() === 'approved';
}

}
