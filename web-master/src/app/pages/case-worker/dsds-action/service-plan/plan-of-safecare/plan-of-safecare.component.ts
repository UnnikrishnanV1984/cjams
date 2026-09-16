import { Component, OnInit, Injector } from '@angular/core';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import moment from 'moment';
import { Router,ActivatedRoute  } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../../@core/common/constants';
import { SharedService } from '../_service/shared-service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { InvolvedPersonsService } from '../../../../shared-pages/involved-persons/involved-persons.service';

@Component({
    selector: 'plan-of-safecare',
    templateUrl: './plan-of-safecare.component.html',
    styleUrls: ['./plan-of-safecare.component.scss'],
    standalone: false
})



export class PlanOfSafeCareComponent implements OnInit {
  childList: any[] = [];
  isformopen:boolean  = false;
  list: any[] = [];
  senChildList: boolean = false;
  senAge: boolean = false;
  padsFormCheck: boolean = false;
  sectionTabOne: boolean=true;;
  sectionTabTwo!: boolean;
  sectionTabThree!: boolean;
  sectionTabFour!: boolean;
  sectionTabFive!: boolean;
  sectionTabSix!: boolean;
  sectionTabSeven!: boolean;
  sectionTabEight!: boolean;
  caseId: any;
  objectTypeKey!: string;
  safeCarePlanList: any;
  id: any;
  isClosed = false;
  daNumber: any;
  approvalStatus!: string;
  isSupervisor: boolean;
  supervisorList: any[] = [];
  teamID: any;
  supervisorID: any;
  caseworkerComments:any;
  supervisorComments : any;
  disableapprovalbtn: any;
  safecareHistoryList: any[] = [];
  roleId: AppUser;
  reason :boolean  = false;
  cwreason:boolean  =false;
  countId: any;
  totalsenchild:any;
  senChildListforhistoric:any;
  sencount:any;
  selectedTab:any='active';
  popupversionid = '#popup-version';
  versionsafecareplanid :any;
  isReadonly: boolean = true;
  caseworkerpageurl = '/pages/case-worker/';
  safecareplanaddupdateurl = 'safecareplan/addupdate';
  isViewMode: boolean = false;
  showmember!: boolean;
  failedSections: { [key: string]: any[] } = {
      SECTION1: [],
      SECTION2: [],
      SECTION3: [],
      SECTION4: [],
      SECTION5: [],
      SECTION6: [],
      SECTION7: [],
      SECTION8: [],
  };

  sectionKeyMapping: any = {
    SECTION1: 'SECTION I',
    SECTION2: 'SECTION II',
    SECTION3: 'SECTION III',
    SECTION4: 'SECTION IV',
    SECTION5: 'SECTION V',
    SECTION6: 'SECTION VI',
    SECTION7: 'SECTION VII',
    SECTION8: 'SECTION VIII',
  }
  activeSenChild: any = [];
  commonErrorMessage = 'Please fill all the required fields';

  private _dataStoreService: DataStoreService;
  private _httpService: CommonHttpService;
  private _router:Router;
  private route: ActivatedRoute;
  private _alert: AlertService;
  private _datastore: DataStoreService;
  private _authService: AuthService;
  private _sharedService : SharedService;
  private _session: SessionStorageService;
  isServiceCase: any;
  involevedPerson$: any;
  private _service!: InvolvedPersonsService;
  isCpsIRorAR!: boolean;
  safecareplanid: any;
  safecareplan: any;
  enablePocFormBtn: boolean = false;
  isApproved: boolean = false;
  senPersonids: string[] = [];

  constructor(private injector: Injector) {
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._httpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._alert = this.injector.get<AlertService>(AlertService);
    this._datastore = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._sharedService  = this.injector.get<SharedService>(SharedService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);

    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this.roleId = this._authService.getCurrentUser();
       const da_status = this._session.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
  }

  ngOnInit() {
    this.caseId = this._dataStoreService.getData('CASEUID');
    const userDetails = this._authService.getCurrentUser();
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (userDetails && userDetails.user && userDetails.user.userprofile && userDetails.user.userprofile.teammemberassignment
      && userDetails.user.userprofile.teammemberassignment.teammember && userDetails.user.userprofile.teammemberassignment.teammember.team
      && userDetails.user.userprofile.teammemberassignment.teammember.team.county && userDetails.user.userprofile.teammemberassignment.teammember?.team?.county?.countyid){
     this.countId = userDetails.user.userprofile.teammemberassignment.teammember.team?.county?.countyid;
    }
    const caseInfo = this._datastore.getData('dsdsActionsSummary');
    if(this.isServiceCase){
      this.objectTypeKey = 'servicecase';

    } else  if (caseInfo && (caseInfo.da_subtype === 'CPS-IR' || caseInfo.da_subtype === 'CPS-AR')) {
      this.objectTypeKey = 'ServiceRequest';
      this.isCpsIRorAR = true;
      
    }
    this.generateObjectReq();
    this.getPersonsList();

    this.sectionTabOne = true;
    this.route.params.subscribe((item) => {
      this.teamID = item['teamId'];
    });
    this.loadSupervisor();
    const activeModuleRole = this._session.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-planofsafecare');
    }

    const hasFamilyAccessToCase = this._session.getItem('hasFamilyAccessToCase');
    
    if(activeModuleRole !== 'apcs' && hasFamilyAccessToCase !== 'true'){
      this.isReadonly = false;
    }

    this.safecareHistoryList = [{
      displayname : "System Test 3 Case Worker",
      justification: "Added new",
      insertedon: new Date()
    }]

    this._sharedService.changeEmitted$.subscribe(text => {
      switch (text) {
        case 'SectionOne':
          this.gotoSectionOne(); break;
        case 'SectionTwo':
          this.gotoSectionTwo(); break;
        case 'SectionThree':
          this.gotoSectionThree(); break;
        case 'SectionFour':
          this.gotoSectionFour(); break;
        case 'SectionFive':
          this.gotoSectionFive(); break;
        case 'SectionSix':
          this.gotoSectionSix(); break;
        case 'SectionSeven':
          this.gotoSectionSeven(); break;
        case 'SectionEight':
          this.gotoSectionEight(); break;
        case 'disableapprovebtn':
          this.disableBtn(); break;
        case 'enableapprovebtn':
          this.enableBtn(); break;
      }
    });
  }

  onChangeSection(url: string, service: string) {
    this._router.navigate([url],{relativeTo :this.route});
    this._sharedService.emitChange(service);
  }
  isResponseValid(response: any): boolean {
    return response && Array.isArray(response);
  }
  getparams(){
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    if(this.isServiceCase){
      return {
         intakenumber: '',
         objectid: this.caseId,
          objecttypekey: this.objectTypeKey,
      };
    } else if(this.isCpsIRorAR){
      return {
         intakeserviceid: this.caseId,
         objecttypekey: this.objectTypeKey,
         'isExpungementSuperUser':isExpungementSuperUser,
         'iscaseexpunged': iscaseexpunged
     };
    }
  }

  filterPOSC(tab: 'active' | 'historic') {
    this.selectedTab = tab;
    this.getSafeCareDetails();
  }
  
  
  getPersonsList() {    
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }  
    this.sencount = 0;
    this._httpService.getPagedArrayList(
        {
          page: 1,
          limit: 10,
          method: 'get',
          where: this.getparams()
        },
        url + '?filter'
      ).subscribe((result) => {
        if (result && result.data && result.data.length) {
          this.senChildListforhistoric = result.data.filter(child => child.senstatusflag === 0);
          this.activeSenChild = result.data.filter(child => child.senstatusflag === 1);
          const senChildList = result.data.filter(child => child.drugexposednewbornflag === 1);
           this.getAssessments(senChildList);
           this.totalsenchild = senChildList.length;
            if(senChildList && senChildList.length) {
            senChildList.forEach(element => {
              if (element.dobtdiffwithincidentdate <= 65 && element.senstatusflag === 1) {
                  this.sencount ++;
               }});
          } else {
            this.senChildList = true;
          }
  
          senChildList.forEach(item => {
              if(item.dobtdiffwithincidentdate <= 65) {
                this.senPersonids.push(item.personid);
              }
          });
        // Now that senChildListforhistoric is ready, call getSafeCareDetails
        this.getSafeCareDetails();
        }

        if(this.sencount === this.totalsenchild){
          this.senAge = true;
        }
    }, error => {
      console.error(error);
    });

  }

  getAssessments(senChildList: any) {
    const intakeserviceid = this._dataStoreService.getData('CASEUID');
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let inputRequest: Object;
    if (this.isServiceCase) {
      inputRequest = {
        objecttypekey: 'servicecase',
        objectid: intakeserviceid,
        isExpungementSuperUser: isExpungementSuperUser,
        'iscaseexpunged': iscaseexpunged
      };
    } else {
      inputRequest = {
        servicerequestid: intakeserviceid,
        categoryid: null,
        subcategoryid: null,
        targetid: null,
        assessmentstatus: null,
        isExpungementSuperUser: isExpungementSuperUser,
        'iscaseexpunged': iscaseexpunged
      };
    }
    return this._httpService
      .getPagedArrayList(
        {
          page: 1,
          limit: 25,
          method: 'get',
          where: inputRequest
        },
        'admin/assessment/list?filter'
      ).subscribe((result) => {
        if (result && result.data && result.data.length) {
          this.checkAssessmentsList(result,senChildList);
        }
      }, error => {
        console.error(error);
      });

  }
  checkAssessmentsList(result: any,senChildList: any) {
    const filterPadsForm = result.data.filter((x: { description: string; }) => x.description == "PADS Form");

    if (filterPadsForm && filterPadsForm.length) {
      filterPadsForm.forEach((element: any) => {
        if (element.intakassessment && element.intakassessment.length) {
          let checkSenAssessment = true;
          element.intakassessment.forEach((i: any) => {
            if (i.assessmentstatustypekey == 'Approved' || i.assessmentstatustypekey == 'Accepted') {
              this.childList = senChildList.filter((item: { dobtdiffwithincidentdate: number; }) => item.dobtdiffwithincidentdate <= 65);
              this._datastore.setData('poscChildList', this.childList);
              checkSenAssessment = false;
            }
          });
          this.padsFormCheck = checkSenAssessment;
        } else {
          this.padsFormCheck = true;
        }
      });
    }
    else {
      this.padsFormCheck = true;
    }
  }

  navitageToPersonTab(value: any) {
    const servicecaseid = this._dataStoreService.getData('CASEUID');
    const casedetails = this._dataStoreService.getData('dsdsActionsSummary');
    if(servicecaseid && casedetails.da_number) {
      if (value === 'P') {
        this._router.navigate([this.caseworkerpageurl + servicecaseid + '/' + casedetails.da_number + '/dsds-action/person-cw/list']);
      } else if (value === 'A') {
        this._router.navigate([this.caseworkerpageurl + servicecaseid + '/' + casedetails.da_number + '/dsds-action/assessment']);
      }
    }
  }

  selectedPerson(child: any) {
    this._dataStoreService.setData('POSC_SEL_CHILD', child);
  }
  close() {
    this.isformopen = false;
    this._router.navigate(['./'], { relativeTo: this.route });
    this.gotoSectionOne();
  }
  createposcform() {
    this.isformopen = true;
    if(this.isformopen === true){
      const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare/section-one'
      this._router.navigate([url]);
    }
    else {
      this._router.navigate(['./'],{relativeTo:this.route});
    }

  }

  generateObjectReq() {
    const safecareplan =this.safeCarePlanList?.filter((item: any) => item.safecareplanid == this.safecareplanid)
    if(safecareplan){
    this.safecareplan = safecareplan[0];
    }

    this.approvalStatus = (this.safecareplan && this.safecareplan.approvalstatus) ? this.safecareplan.approvalstatus.toString() : null;
    const reqobj = (this.safecareplan) ? this.safecareplan : {
      "safecareplanid" : null,
      "objectid": this.caseId,
	    "objecttypekey": this.objectTypeKey,
      "isViewMode": this.isViewMode,
      "persondetails" : {

      },
      "planparticipants" : {

      },
      "healthneedsdetails" : {

      },
      "otherservices" : {

      },
      "planreviewdetails" :  {

      },
      "justification" : '',
      "comments" : '',
      "consentform" : {

      },
      "recommendedforclosure" : false,
      "insufficientevidencetocourt" : false,
      "familypreservationtransfer" : false,
      "referredtocps" : false,
      "shelterorder" : false,
      "signatures" : {

      },
      "supervisorComments" : '',
      "caseworkerComments" : ''
    }
    
    reqobj.isViewMode = this.isViewMode;
    localStorage.setItem('generateObjectReq',JSON.stringify(reqobj));
  }

    saveSectionDetails(type: any) {
      const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
      const obj = JSON.parse(generateObjectReqId);
        if (type !== '') {
            const set1 = this.checkErrorSet1(type, obj);
            obj.approvalstatus = type;
            const set2 = this.checkErrorSet2(type, obj);
            const set3 = this.checkErrorSet3(type, obj);
            const set4 = this.checkErrorSet4(type, obj);
            const set5 = this.checkErrorSet5(type, obj);
            const set8 = this.checkErrorSet8(type, obj);

            if (set1 || set2 || set3 || set4 || set5 || set8) {
                (<any>$('#alert-popup')).modal('show');
                return;
            } else {
                this.continueSave(type, obj);
            }

        } else {
            obj.approvalstatus = type;
            this._httpService.create(obj, this.safecareplanaddupdateurl).subscribe(response => {
                if(response.success) {
 
                    this.safecareplanid = response.planid;
                }
                
                this._alert.success(response.message);
                this.getSafeCareDetails();
            });
        }
    }

    checkErrorSet1(_type: any, obj: any) {
        this.failedSections['SECTION1'] = [];
        let senClients = obj?.persondetails?.data?.filter((item: any) => item.familymember?.indexOf('Newborn') > -1) || [];

        if(this.activeSenChild.length) {
            this.sencount = this.activeSenChild.length;
            let clints  = senClients.filter((item: any) => item.senStatusFlag === 1);

            if (clints.length !== this.sencount) {
                this.failedSections['SECTION1'].push('Please add all the SEN clients to proceed');
            }    
        } else {
            if(senClients.length===0) {
                this.failedSections['SECTION1'].push('Please add atleast one Historic SEN clients to proceed');
            } else {
                this.sencount = senClients.length;
            }
        }
        this.sencount  = senClients.length;

        if (this.failedSections['SECTION1'].length) {
            return true;
        } else {
            return false;
        }
    }

    checkErrorSet2(type: any, obj: any) {
        this.failedSections['SECTION2'] = [];
        if (type !== '') {
            let pcpDetais = this.returnpcpDetails(obj);
            let noPCPDetaiils = this.returnNopcpDetails(obj);
            let count = pcpDetais.length + noPCPDetaiils.length;
            this.failedSectionsUpdate(obj, pcpDetais, noPCPDetaiils, count);
            this.notRequiredPCPSections(obj, noPCPDetaiils);

            
        }

        if (this.failedSections['SECTION2'].length) {
            return true;
        } else {
            return false;
        }
    }


    failedSectionsUpdate(obj: any, pcpDetais: any, noPCPDetaiils: any, count: any) {
      if (obj.planparticipants && !pcpDetais?.length && !noPCPDetaiils?.length) {
        if (obj.planparticipants.data?.roleCollectionList?.length === 0) {
            this.failedSections['SECTION2'].push('Please add a New born & Newborns Primary Care Doctor in Section II to submit for approval');
        } else {
            this.failedSections['SECTION2'].push('Please add a Newborns Primary Care Doctor in Section II to submit for approval');
        }
    }

      if (this.sencount != count && !this.failedSections['SECTION2'].length) {
        this.failedSections['SECTION2'].push('Please add a New born & Newborns Primary Care Doctor in Section II to submit for approval');
      }
    }

    notRequiredPCPSections(obj: any, noPCPDetaiils: any){
      if (obj.planparticipants && noPCPDetaiils?.length) {
        let notRequiredPCPDetails = noPCPDetaiils;
        for (let item of notRequiredPCPDetails) {
            if (!item.reason) {
                this.failedSections['SECTION2'].push('Please fill the mandatory reason field when primary care physician is selected as NO');
                break;
            }
        }
      }
    }

    returnpcpDetails(obj: any) {
      return obj.planparticipants?.data?.pcpDetails || []
    }

    returnNopcpDetails(obj: any) {
      return obj.planparticipants?.data?.notRequiredPCPDetails || []
    }




    checkErrorSet3(type: any, obj: any) {
        this.failedSections['SECTION3'] = [];
        const newbornexistItem = obj.healthneedsdetails?.memberform?.filter((item: any) => item.familymember.includes('Newborn')) || [];

        if (type) {
            if (!newbornexistItem || (newbornexistItem.length !== this.sencount)) {
                this.failedSections['SECTION3'].push('Please add all the SEN clients in Section III to submit for approval');
            }
        }

        if (this.failedSections['SECTION3'].length) {
            return true;
        } else {
            return false;
        }
    }

    checkErrorSet4(type: any, obj: any) {
        this.failedSections['SECTION4'] = [];
        
        if (type) {
            let establishedServices = obj?.otherservices?.establishedServices;
            let referralCurrentServices = obj?.otherservices?.referralCurrentServices;
            if (referralCurrentServices?.noneIdentified && !referralCurrentServices.noneIdentifiedReason) {
                this.failedSections['SECTION4'].push(this.commonErrorMessage);
            }
            const newbornexistItem = obj.persondetails?.data?.filter((item: any) => item.familymember.includes('Parent') || item.familymember.includes('Caregiver') );
            if (newbornexistItem && newbornexistItem.length) {
                if (!establishedServices) {
                    this.failedSections['SECTION4'].push(this.commonErrorMessage);
                } else {
                    let familyMember = newbornexistItem.map((item: any) => { return item.familymember });

                   return this.checkFamilyMemberCondition(familyMember, establishedServices);
                }
            }
        }

        if (this.failedSections['SECTION4'].length) {
            return true;
        } else {
            return false;
        }
    }

    checkFamilyMemberCondition(familyMember: any, establishedServices: any) {
      for (let member of familyMember) {
        this.checkEstablishedServicesFn(establishedServices, member)

        if (this.failedSections['SECTION4'].length) {
            break;
        }
      }
    }

    checkEstablishedServicesFn(establishedServices: any, member: any) {
      for (let item of Object.keys(establishedServices)) {
        let memberestablishedServices = establishedServices[item]?.filter((value: any) => {
            member = ['Parent', 'Parent 1'].indexOf(member) > -1 ? 'Parent 1' : member;
            
            let familymember = ['Parent', 'Parent 1'].indexOf(value.familymember) > -1 ? 'Parent 1' : value.familymember;
            if(member === familymember) {
                return value;
            }
        });

        if (!memberestablishedServices.length) {
            this.failedSections['SECTION4'].push(this.commonErrorMessage);
            break;
        }
        
       if(this.checkAdditionalServicesFn(item, memberestablishedServices)) {
         break;
       }

        
    }

  }

  checkAdditionalServicesFn(item: any, memberestablishedServices: any){
    let status = ['yes', 'no']
      if (item === 'additionalitemsFormArray' && this.checkforIsAdditionalappt(memberestablishedServices, status) ) {
          this.failedSections['SECTION4'].push(this.commonErrorMessage);
          return true;
      }

      if (item === 'drugitemsFormArray' && this.checkforDrugapptdate(memberestablishedServices, status)) {
          this.failedSections['SECTION4'].push(this.commonErrorMessage);
          return true;
      }

      if (item === 'housingitemsFormArray' && this.checkforHousingitems(memberestablishedServices, status))  {
        this.failedSections['SECTION4'].push(this.commonErrorMessage);
        return true;
      }
      
      if (item === 'paroleitemsFormArray' && this.checkforParoleItems(memberestablishedServices, status)) {
        this.failedSections['SECTION4'].push(this.commonErrorMessage);
        return true;
      }

      if (item === 'supportitemsFormArray' && this.checkforSupportItems(memberestablishedServices, status)) {
        this.failedSections['SECTION4'].push(this.commonErrorMessage);
        return true;
      }

      if (item === 'unitedwayitemsFormArray' && this.checkforUnitedwayItems(memberestablishedServices, status)) {
        this.failedSections['SECTION4'].push(this.commonErrorMessage);
        return true;
      }
      
      return false;
        
  }


  checkforIsAdditionalappt(memberestablishedServices: any, status: any) {
     return memberestablishedServices[0].isadditionalappt !== 'na' && ((!memberestablishedServices[0].additionalapptdate && !memberestablishedServices[0].isadditionalappt) || (!memberestablishedServices[0].additionalapptdate && status.indexOf(memberestablishedServices[0].isadditionalappt) > -1));
  }

  checkforDrugapptdate(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].isdrugappt !== 'na' && ((!memberestablishedServices[0].drugapptdate && !memberestablishedServices[0].isdrugappt) || (!memberestablishedServices[0].drugapptdate && status.indexOf(memberestablishedServices[0].isdrugappt) > -1))
  }


  checkforHousingitems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].ishousingappt !== 'na' && ((!memberestablishedServices[0].housingapptdate && !memberestablishedServices[0].ishousingappt) || (!memberestablishedServices[0].housingapptdate && status.indexOf(memberestablishedServices[0].ishousingappt) > -1));
  }

  checkforParoleItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].isparoleappt !== 'na' && ((!memberestablishedServices[0].paroleapptdate && !memberestablishedServices[0].isparoleappt) || (!memberestablishedServices[0].paroleapptdate && status.indexOf(memberestablishedServices[0].isparoleappt) > -1));
  }

  checkforSupportItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].issupportappt !== 'na' && ((!memberestablishedServices[0].supportapptdate && !memberestablishedServices[0].issupportappt) || (!memberestablishedServices[0].supportapptdate && status.indexOf(memberestablishedServices[0].issupportappt) > -1));
  }

  checkforUnitedwayItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].isunitedwayappt !== 'na' && ((!memberestablishedServices[0].unitedwayapptdate && !memberestablishedServices[0].isunitedwayappt) || (!memberestablishedServices[0].unitedwayapptdate && status.indexOf(memberestablishedServices[0].isunitedwayappt) > -1));
  }

    checkErrorSet5(type: any, obj: any) {
        this.failedSections['SECTION5'] = [];
        if (type) {
            let reviewdiscuss = obj?.planreviewdetails?.reviewdiscuss;
            const newbornexistItem = this.checkNewBornExists(obj);
            if (newbornexistItem && newbornexistItem.length) {
                if (!reviewdiscuss) {
                    this.failedSections['SECTION5'].push(this.commonErrorMessage);
                } else {
                    let familyMember = newbornexistItem.map((item: any) => { return item.familymember });
                    this.checkforFamilyMemberCondition(familyMember, reviewdiscuss);
                    
                }
            }
        }

        if (this.failedSections['SECTION5'].length) {
            return true;
        } else {
            return false;
        }
    }


    checkNewBornExists(obj: any) {
      return obj.persondetails?.data?.filter((item: any) => item.familymember.includes('Parent') || item.familymember.includes('Caregiver'));
    }

    checkforFamilyMemberCondition(familyMember: any, reviewdiscuss: any){
      for (let originalMember of familyMember) {
        
        let checkedMember = this.checkforParentMember(familyMember, originalMember);

        for (let item of Object.keys(reviewdiscuss)) {
            let memberestablishedServices = reviewdiscuss[item]?.filter((value: any) => {
              checkedMember = this.returnMember(checkedMember);
                let familymember = this.returnFamilyMember(value);
                if(checkedMember === familymember) {
                    return value;
                }
            });

            if(this.checkFamilyServicesFn(item, memberestablishedServices)) {
              break;
            }
        }

        if (this.failedSections['SECTION5'].length) {
            break;
        }
    }
  }


  checkforParentMember(familyMember: any, member: any) {
    if(familyMember.length > 1 &&  member === 'Parent') {
      member = `${member} 1`;
    } 
    return member;
  }

  returnMember(member: any){
    return ['Parent', 'Parent 1'].indexOf(member) > -1 ? 'Parent 1' : member;
  }

  returnFamilyMember(value: any){
    return ['Parent', 'Parent 1'].indexOf(value.familymember) > -1 ? 'Parent 1' : value.familymember;
  }


  checkFamilyServicesFn(item: any, memberestablishedServices: any) {

            if (!memberestablishedServices.length) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }
        
            let status = ['yes', 'no'];
            if (item === 'sleepingitemsFormArray' && this.checkforSleepingItems(memberestablishedServices, status)) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }

            if (item === 'copingitemsFormArray' && this.checkforCopingItems(memberestablishedServices, status)) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }
            if (item === 'homesafetyitemsFormArray' && this.checkforHomeSafetyItems(memberestablishedServices, status)) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }

            if (item === 'firesafetyitemsFormArray' && this.checkforFireSafetyItems(memberestablishedServices, status)) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }

            if (item === 'fireescapeitemsFormArray' && this.checkforFireEscapeItems(memberestablishedServices, status)) {
                this.failedSections['SECTION5'].push(this.commonErrorMessage);
                return true;
            }

            return false;
  }


  checkforSleepingItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].sleepingreviewed !== 'na' && ((!memberestablishedServices[0].sleepingcomments && !memberestablishedServices[0].sleepingreviewed) || (!memberestablishedServices[0].sleepingcomments && status.indexOf(memberestablishedServices[0].sleepingreviewed) > -1));
  }

  checkforCopingItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].copingreviewed !== 'na' && ((!memberestablishedServices[0].copingcomments && !memberestablishedServices[0].copingreviewed) || (!memberestablishedServices[0].copingcomments && status.indexOf(memberestablishedServices[0].copingreviewed) > -1));
  }

  checkforHomeSafetyItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].homesafetyreviewed !== 'na' && ((!memberestablishedServices[0].homesafetycomments && !memberestablishedServices[0].homesafetyreviewed) || (!memberestablishedServices[0].homesafetycomments && status.indexOf(memberestablishedServices[0].homesafetyreviewed) > -1));
  }

  checkforFireSafetyItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].firesafetyreviewed !== 'na' && ((!memberestablishedServices[0].firesafetycomments && !memberestablishedServices[0].firesafetyreviewed) || (!memberestablishedServices[0].firesafetycomments && status.indexOf(memberestablishedServices[0].firesafetyreviewed) > -1));
  }

  checkforFireEscapeItems(memberestablishedServices: any, status: any) {
    return memberestablishedServices[0].fireescapereviewed !== 'na' && ((!memberestablishedServices[0].fireescapecomments && !memberestablishedServices[0].fireescapereviewed) || (!memberestablishedServices[0].fireescapecomments && status.indexOf(memberestablishedServices[0].fireescapereviewed) > -1));
  }

    checkErrorSet8(type: any, obj: any) {
        this.failedSections['SECTION8'] = [];
        const signatures = obj.signatures;

        const checkldsssign = signatures.ldsssign;
        const checkldssdate = signatures.ldssdate;

        this.signatureFailedSections(obj, signatures,checkldsssign, checkldssdate);

        const checksupervisordate = signatures.supervisordate;
        const checksupervisorsign = signatures.supervisorsign;

        this.checkSupervisorDate(type, checksupervisordate,checksupervisorsign);

        

        const newbornexistItem = this.filternewbornexistItem(obj);

        if(newbornexistItem && newbornexistItem.length) {
            if ((!signatures?.signatureitemsFormArray || !signatures?.signatureitemsFormArray.length) && !this.failedSections['SECTION8'].length) {
                this.failedSections['SECTION8'].push('Please enter values in signatures');
            } else if (!this.failedSections['SECTION8'].length) {
                this.checkForSignatureItems(signatures)
                
            }
        }

        if (this.failedSections['SECTION8'].length) {
            return true;
        } else {
            return false;
        }
    }

  
  checkForSignatureItems(signatures: any) {
    for (let item of signatures?.signatureitemsFormArray) {
      if (((item.isSignatureRequired && (!item.reason || (item.reason === 'Other' && !item.otherReason ))) || (!item.isSignatureRequired && (!item.signaturevalue || !item.signaturedate)))
      && !this.failedSections['SECTION8'].length) {
        this.failedSections['SECTION8'].push('Please enter values in signatures');
        break;
      }             
    }
  }

  signatureFailedSections(obj: any, signatures: any,checkldsssign: any, checkldssdate: any){
      if (!signatures || JSON.stringify(signatures) === '{}') {
        this.failedSections['SECTION8'].push('Please enter values in signatures');
    }

    if ((!checkldssdate || !checkldsssign || checkldssdate == "Invalid date") && !this.failedSections['SECTION8'].length) {
        this.failedSections['SECTION8'].push('Please enter values in signatures');
    }

    if (obj.referredtocps && obj.signatures.showcontactvalue === 'no') {
        this.failedSections['SECTION8'].push('Please add the contact notes to send for approval');
    }
    
  }

  checkSupervisorDate(type: any, checksupervisordate: any,checksupervisorsign: any) {
    if (type === '16' && (!checksupervisordate || !checksupervisorsign || checksupervisordate === "Invalid date")) {
      this.failedSections['SECTION8'].push('Please enter Supervisor signature and Date');
    }
  }

  filternewbornexistItem(obj: any) {
    return obj.persondetails?.data?.filter((item: any) => item.familymember.includes('Parent'))
  }

  continueSave(type: any,obj: any){
    if (type === '15' && !this.supervisorID) {
      this.openApprovalPopup();
      return;
    }
    obj.approverid = this.supervisorID;
    obj.servicerequestnumber = this.daNumber;

    if (type === '15') {
      obj.justification = this.caseworkerComments;
    }
    if (type === '17') {
      this.reason = true;
      (<any>$('#supervisorcomments-popup')).modal('show');
      return;
    }

    this._httpService.create(obj, this.safecareplanaddupdateurl).subscribe(response => {
      localStorage.removeItem('generateObjectReq');
      const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare'
      this._router.navigate([url]);
      this._alert.success(response.message);
      this.isformopen = false;
      this.getSafeCareDetails();
    });
  }

    getSafeCareDetails() {
        this.enablePocFormBtn = false;
        const obj = {
            "objectid": this.caseId,
            "objecttypekey": this.objectTypeKey,
            "personids": this.senPersonids
        }
        this._httpService.create(obj, 'safecareplan/list').subscribe(response => {

            if (response.success && response.data && Array.isArray(response.data)) {
                // Sort by updatedon descending
                this.safeCarePlanList = response.data.sort((a: any, b: any) =>
                    new Date(b.updatedon).getTime() - new Date(a.updatedon).getTime()

                );

                if (this.selectedTab === 'historic') {
                    const senChildIds = this.senChildListforhistoric.map((child: any) => child.personid);
                    const activeSenChilds = this.activeSenChild.map((item: any) => { return item.personid});

                    this.safeCarePlanList = this.safeCarePlanList.filter((item: any) => {
                        const personIds = this.returnPersonIdcheck(item); 
                        const hasMatchingPerson = personIds.some((pid: any) => senChildIds.includes(pid));
                        const hasMatchingActivePerson = personIds.some((pid: any) => activeSenChilds.includes(pid));
                        return this.matchingRecordCheck(item, hasMatchingPerson, hasMatchingActivePerson);
                    });
                }

                if (this.selectedTab === 'active') {

                    let existingPersions = [
                        ...new Set(
                            response.data.flatMap((item: any) =>
                                item?.persondetails?.data?.map((item1: any) => item1.personid)
                            )
                        )
                    ];

                    let activeChildList = this.returnActiveSenChild(existingPersions);
                    this.getActiveChildList(activeChildList);

                    this.safeCarePlanList = this.safeCarePlanList?.filter((item: any) => {
                        const personIds = this.returnPersonIdcheck(item);
                        const activeSenChilds = this.activeSenChild.map((value: any) => { return value.personid});
                        const hasMatchingPerson = personIds.some((pid: any) => activeSenChilds?.includes(pid));
                        const caseDetails = this._datastore.getData('dsdsActionsSummary');
                        return this.checkforApprovalStatus(item, caseDetails, hasMatchingPerson);
                    });
                }
            } else {
                this.safeCarePlanList = null;
            }

            const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
            const objectexists = JSON.parse(generateObjectReqId);
            if (objectexists) {
                this.disableapprovalbtn = objectexists.showcontactvalue;
            }
            this.generateObjectReq();
            this.approvalStatus = (this.safeCarePlanList && this.safeCarePlanList.approvalstatus) ? this.safeCarePlanList.approvalstatus.toString() : null;

        });
    }

    returnActiveSenChild(existingPersions: any) {
      return this.activeSenChild.filter((item: any) => existingPersions.indexOf(item.personid) == -1);
    }

    getActiveChildList(activeChildList: any) {
      let list = this.safeCarePlanList.filter((item: any) => item.plan_status == 'current');
                    if (!list.length || activeChildList.length) {
                        this.enablePocFormBtn = true;
                    } else {
                        this.enablePocFormBtn = false;
                    }
    }

    returnPersonIdcheck(item: any) {
      return item?.persondetails?.data?.map((p: any) => p.personid) || [];
    }

    matchingRecordCheck(item: any, hasMatchingPerson: any, hasMatchingActivePerson: any) {
      return item?.approvalstatus === "16" && hasMatchingPerson && !hasMatchingActivePerson;
    }

    checkforApprovalStatus(item: any, caseDetails: any, hasMatchingPerson: any) {
      if(item?.approvalstatus !== "16") {
        if(this.enablePocFormBtn && caseDetails.da_number == item.case_number) {
            this.enablePocFormBtn = false;
        }
        return true;
      }

      if(hasMatchingPerson) {
        return true;
      }
      
    }

  editMember(view: any, safecareplanid: any, approvalStatus: any) {
    this.isApproved = approvalStatus === '16';
    this.safecareplanid =safecareplanid;
    this.isViewMode = view == 'view';
    this.generateObjectReq();
    this.createposcform();
  }

  gotoSectionOne() {
    this.sectionTabOne = true;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionTwo() {
    this.sectionTabOne = false;
    this.sectionTabTwo = true;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionThree() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = true;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionFour() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = true;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionFive() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = true;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionSix() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = true;
    this.sectionTabSeven = false;
    this.sectionTabEight = false;

  }
  gotoSectionSeven() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = true;
    this.sectionTabEight = false;

  }
  gotoSectionEight() {
    this.sectionTabOne = false;
    this.sectionTabTwo = false;
    this.sectionTabThree = false;
    this.sectionTabFour = false;
    this.sectionTabFive = false;
    this.sectionTabSix = false;
    this.sectionTabSeven = false;
    this.sectionTabEight = true;

  }

  getPersonInvolvedInPOSC(safecareplanid: any) {
    const safecareplan =this.safeCarePlanList.filter((item: any) =>item.safecareplanid == safecareplanid);
    return (safecareplan && safecareplan[0].persondetails && safecareplan[0].persondetails.data) ? safecareplan[0].persondetails.data.map((item: any) => item.personName) : '';
  }

  getRoutingStatus(safecareplanid: any) {
    const safecareplan =this.safeCarePlanList.filter((item: any) =>item.safecareplanid == safecareplanid);
    let status = 'In Progress'
    if(safecareplan && safecareplan[0]?.approvalstatus === "15") {
      status = 'Review'
    } else if(safecareplan && safecareplan[0]?.approvalstatus === "16") {
      status = 'Approved'
    } else if(safecareplan && safecareplan[0]?.approvalstatus === "17") {
      status = 'Rejected'
    }
    return status;
  }

  private loadSupervisor() {

    const formData = {
          v_countyid: this.countId,
          v_roletypekey: null,
          method: 'post'
      }
      this._httpService.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.GetSupervisorByCountyId)
      .subscribe(result => {
        if (result && result[0] && result[0].getsupervisorsbycounty){
        this.supervisorList = result[0].getsupervisorsbycounty.filter((item: { roletypekey: string; }) => item.roletypekey === 'CWSP');
        }
        this.supervisorList = this.sortSupervisorList();
      });
  }

  sortSupervisorList(){
    return [...this.supervisorList]?.sort((a,b) => (a.fullname > b.fullname) ? 1 : this.returnRespSortFn(b, a));
  }

  private returnRespSortFn(b: any, a: any) {
    return (b.fullname > a.fullname) ? -1 : 0;
  }

  getHistory(id: any) {
      const obj = {
        "safecareplanid": id,
      }
      this._httpService.create(obj, 'safecareplan/history').subscribe(response => {
        this.safecareHistoryList = (response.success) ? response.data : [];
      });
  }

  openApprovalPopup() {
      this.cwreason = (this.approvalStatus === '17') ? true : false;
      (<any>$('#approval-popup')).modal('show');
  }

  printPdf(safeCarePlan: any) {
    this.safecareplanid = safeCarePlan?.safecareplanid;
      const modal = {
        count: -1,
        where: {
            documenttemplatekey: ['safecareplan'],
            objectid: safeCarePlan.objectid ? safeCarePlan.objectid : this.caseId,
            objectkey: safeCarePlan.objecttypekey ? safeCarePlan.objecttypekey : this.objectTypeKey,
            safecareplanid :safeCarePlan.safecareplanid,
        },
        method: 'post'
      };
      this._httpService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe(res => {
      const blob = new Blob([new Uint8Array(res)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      const timestamp = moment(new Date()).format('MM/DD/YYYY HH:mm:ss');
      link.download = 'Safe-Care-Plane-' + '.' + timestamp + '.pdf';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }

  disableBtn()
  {
    this.disableapprovalbtn = true;
  }
  enableBtn()
  {
    this.disableapprovalbtn = false;

  }
  commentsSupervisorReject() {
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const obj = JSON.parse(generateObjectReqId);
    obj.approverid = this.supervisorID;
    obj.approvalstatus = '17';
    obj.servicerequestnumber = this.daNumber;
    obj.signatures.supervisorComments = this.supervisorComments;
    this._httpService.create(obj, this.safecareplanaddupdateurl).subscribe(response => {
      if(response.success) {
        this._alert.success(response.message);
        localStorage.removeItem('generateObjectReq');
        this.isformopen = false;
        this.supervisorComments = null;
      this.getSafeCareDetails();
      }
      });
  }
  onclosemodal() {
    this.supervisorID ='';
  }
  confirmversion(safecareplanid: any) {
    this.versionsafecareplanid = safecareplanid;
    (<any>$('#popup-version')).modal('show');
}
declineversion(){
  (<any>$('#popup-version')).modal('hide');
}
versionTemplate(){
  this.createnewversion(this.versionsafecareplanid);
  (<any>$('#popup-version')).modal('hide');
}
  createnewversion(safecareplanid: any){
    const safecareplan =this.safeCarePlanList?.filter((item: any) => item.safecareplanid == safecareplanid)
    if(safecareplan){
    this.safecareplan = safecareplan[0];
    }

    const newversiondata = {
      "safecareplanid" : null,
      "objectid": this.caseId,
	    "objecttypekey": this.objectTypeKey,
      "isViewMode": this.isViewMode,
      "persondetails" : this.safecareplan.persondetails,
      "planparticipants" : this.safecareplan.planparticipants,
      "healthneedsdetails" : {

      },
      "otherservices" : {

      },
      "planreviewdetails" :  {

      },
      "justification" : '',
      "comments" : '',
      "consentform" : {

      },
      "recommendedforclosure" : false,
      "insufficientevidencetocourt" : false,
      "familypreservationtransfer" : false,
      "referredtocps" : false,
      "shelterorder" : false,
      "signatures" : {

      },
      "supervisorComments" : '',
      "caseworkerComments" : ''
    }
    this.safecareplan.persondetails.ldss=null;
    this.safecareplan = newversiondata;
  localStorage.setItem('generateObjectReq',JSON.stringify(newversiondata));
  this.saveSectionDetails('');
  }
  
}
