
import {share, map, pluck} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { ObjectUtils } from '../../../../../@core/common/initializer';
import { FindIndividualService } from '../find-individual.service';
import { Router, ActivatedRoute } from '@angular/router';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { AppConstants } from '../../../../../@core/common/constants';
import { PersonSearch } from '../../_entities/involvedperson.data.model';
import { NavigationUtils, PersonInfoStore } from '../../../../_utils/navigation-utils.service';
import { InvolvedPersonsService } from '../../involved-persons.service';
import { AlertService, CommonHttpService, DataStoreService, SessionStorageService, AuthService } from '../../../../../@core/services';
import { PersonDsdsAction } from '../../../../newintake/my-newintake/_entities/newintakeModel';
import { FindUrlConfig } from '../../../../find/find.url.config';
import { ColumnSortedEvent } from '../../../../../shared/modules/sortable-table/sort.service';
import { environment } from '../../../../../../../src/environments/environment';
import { config } from '../../../../../../../src/environments/config';
import { ProgramParticipationService } from '../../../../../lib/programParticipation/programParticipation.service';
const MAX_CRITERIA = 5;
export class IntakeCaseStore {
  intakeserviceid!: string;
  servicerequestnumber!: string;
  action!: string;
}
@Component({
    selector: 'search-result',
    templateUrl: './search-result.component.html',
    styleUrls: ['./search-result.component.scss'],
    standalone: false
})
export class SearchResultComponent implements OnInit {

  paginationInfo: PaginationInfo = new PaginationInfo();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  personSearchResult$!: Observable<PersonSearch[]>;
  selectedPerson: any;
  showPersonDetail = -1;
  personDSDSActions$!: Observable<PersonDsdsAction[]>;

  // SSN
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  personSearchResult: any[] = [];
  totalRecords!: number;
  selectedCaseInfo: any;
  selectedPriorPerson: any;
  searchLabels: any = [];
  hasMoreCriteria = false;
  isReadonly = true;
  preserveDataFlag:boolean = false;
  preserveDataStore: any;
  preserveSessionData: any;
  errorMessage!: string | null;
  envName: any;
  restrictedcaseenable!: boolean;
  programParticipationService : any;

  private _router: Router;
   private route: ActivatedRoute;
    private _findIndividualService: FindIndividualService;
    private _involvedPersonService: InvolvedPersonsService;
    private _alertService: AlertService;
    private _commonHttpService: CommonHttpService;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private _navigationUtils: NavigationUtils;
    private _session: SessionStorageService;
    private _programParticipationService: ProgramParticipationService;

  constructor(private injector : Injector){
    this._router = this.injector.get<Router>(Router); 
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._findIndividualService = this.injector.get<FindIndividualService>(FindIndividualService);
    this._involvedPersonService = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._programParticipationService = this.injector.get<ProgramParticipationService>(ProgramParticipationService);
    this.programParticipationService = this._programParticipationService;
    } 

  ngOnInit() {
    this.restrictedcaseenable = config.restrictedcaseenable && environment.envName !== 'Production';
    this.isReadonly =  this._authService.readonlyButton('read_only_access','add-edit-person');
    if (!this._findIndividualService.searchCriteria) {
      this.goBack();
    } else {
      this.searchLabels = [];
      ObjectUtils.removeEmptyProperties(this._findIndividualService.searchCriteria);
      for (const [key, value] of Object.entries(this._findIndividualService.searchCriteria)) {
        if (key !== 'sortorder') {
          this.searchLabels.push({ label: key, value: value });
        }
      }
      const baseList = this.searchLabels.filter((item: { label: string; }) => !['firstname', 'lastname'].includes(item.label));
      const firstnameitem = this.searchLabels.find((item: { label: string; }) => item.label === 'firstname');
      const lastnameitem = this.searchLabels.find((item: { label: string; }) => item.label === 'lastname');
      if (lastnameitem) { baseList.unshift(lastnameitem); }
      if (firstnameitem) { baseList.unshift(firstnameitem); }
      this.searchLabels = baseList;
      if (this.searchLabels.length > MAX_CRITERIA) {
        this.hasMoreCriteria = true;
        this.searchLabels = this.searchLabels.slice(0,  MAX_CRITERIA );
      } else {
        this.hasMoreCriteria = false;
      }
      this.getPage(1);
    }
  }

  parseInteger(priors: string){
    return (priors =='' || priors==null || priors==undefined) ? 0 : parseInt(priors);
  }
  
  goBack() {
    this._router.navigate(['../search'], { relativeTo: this.route });
  }

  private getPage(pageNumber: number) {
    this.selectedPerson = null;
    this._findIndividualService.searchPerson(pageNumber, this.paginationInfo).pipe(
      map((result) => {
        return {
          data: result.data,
          count: result.count,
          canDisplayPager: result.count > this.paginationInfo.pageSize
        };
      })).subscribe(response => {
        this.personSearchResult = response.data;
        if (pageNumber === 1) {
          this.totalRecords = response.count;
        }
      });
  }

  clearSearchFilter() {
    this._findIndividualService.searchCriteria.sortorder = 'asc';
    this._findIndividualService.searchCriteria.sortcolumn = null;
    this.getPage(1);
    this.paginationInfo.pageNumber = 1;
  }

  onSortedPerson($event: ColumnSortedEvent) {
    this._findIndividualService.searchCriteria.sortorder = $event.sortDirection;
    this._findIndividualService.searchCriteria.sortcolumn = $event.sortColumn;
    this.paginationInfo.pageNumber = 1;
    this.getPage(1);
  }

  selectPerson(row: any) {
    this.selectedPerson = row;
  }

  editSelectedPerson() {
    if(this.selectedPerson?.isbioadoptedflag === 1){
      (<any>$('#bioadoptedflag')).modal('show');
      return;
    }
    if(this.preserveDataFlag){
      this._dataStoreService.clearStore();
      this._dataStoreService.clearStoreWithout();
      this.preserveDataStore.filter((data: { key: string; value: any; }) => {
        this._dataStoreService.setData(data.key, data.value);
      });
      
      if(this._dataStoreService.getData('ISSERVICECASE')){
        this._session.setTabKeyKey(this._dataStoreService.getData('DANUMBER'));
      }
      this.preserveSessionData.filter((data: { key: string; value: any; }) => {
        this._session.setItemKey(data.key, data.value);
      });
      
      this.preserveDataFlag = false;
    }

    if (this.selectedPerson) {
      this.ifSelectedPersonFn();
    } else {
      this._alertService.error('Please select person');
    }
  }

  private ifSelectedPersonFn() {
    if (this.selectedPerson.source === 'SDR') {
      this._dataStoreService.setData('personsdrsource', true);
      const url = FindUrlConfig.EndPoint.PersonSearch.identifier;
      this._commonHttpService.getArrayList(
        {
          where: {
            personidentifiervalue: this.selectedPerson.mdm_id,
            personidentifiertypekey: 'MDM_ID'
          },
          method: 'get'
        },
        url).subscribe(data => {
          if (data[0]) {
            this.selectedPerson.personid = data[0].personid;
          }
          if (this.selectedPerson.personid) {
            this._involvedPersonService.editSDRPerson(this.selectedPerson);
          } else {
            this._involvedPersonService.newSDRPerson(this.selectedPerson);
          }
        });
    } else {
      this._dataStoreService.setData('personsdrsource', false);
      this._involvedPersonService.editPerson(this.selectedPerson.personid);
    }
  }

  validateSelectedPerson() {
    if(this.selectedPerson && this.selectedPerson.source === 'SDR') {
      this.editSelectedPerson();
    }else {
      const url = FindUrlConfig.EndPoint.PersonSearch.getpersonexists;
      const personInfo = Object.create(PersonInfoStore);
      personInfo.source = this._involvedPersonService.getSource();
      personInfo.sourceID = this._involvedPersonService.getUniqueNumber();
      personInfo.personId = this.selectedPerson?.personid;
      this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
      this._commonHttpService.getArrayList(
        {
          where: this._navigationUtils.getPersonRequestParam(),
          method: 'get'
        }
        , url).subscribe(data => {
          if (data && data.length > 0 && data[0].count >0) {
            this.showProfileErrorMessage('Person entered already exists in this Case');
          }else{
            this.editSelectedPerson();
          }
        });       
    }
  }

  validateAddNew() {
    const ssnData = this.searchLabels.filter((item: { label: string; }) => item.label === 'ssn');
    if(ssnData.length > 0 && ssnData[0].value && ssnData[0].value.length === 9) {
      this._commonHttpService.getPagedArrayList({ where: { 'ssn': ssnData[0].value }, method: 'post' }, 'globalpersonsearches/getEnhancedPersonSearchData').subscribe(result => {
        if (result.count > 0) {
          result.data = result.data.filter(data => data.source === 'Local');
          if (result.data && result.data.length) {
            this.showProfileErrorMessage(this.getSSNErrorMessage());
            return;
          } else {
            this.addNewPerson();
          }
        } else {
          this.addNewPerson();
        } 
      })
    } else {
      this.addNewPerson();
    }
  }

  getSSNErrorMessage() {
    return `The SSN entered already exists in CJAMS`;
  }

  showProfileErrorMessage(message: string) {
    this.errorMessage = message;
    (<any>$('#profile-error-message')).modal('show');
  }

  closeErrorMessage() {
    this.errorMessage = null;
    (<any>$('#profile-error-message')).modal('hide');
  }

  addNewPerson() {
    let searchdata: any = {};
    if (this._findIndividualService.searchCriteria) {
      searchdata = this._findIndividualService.searchCriteria;
      searchdata['exist'] = 1;
    }
    if(searchdata && searchdata['clientflag'] === 0){
      this._involvedPersonService.editPerson(searchdata['personid']);
    } else {   
      let persontypeselected: any = null;
      persontypeselected = this._dataStoreService.getData('QUICK_PERSON_ID');
      if(persontypeselected && persontypeselected.persontype === 'QP') {
        searchdata['clientflag'] = 1;
        searchdata['qptype'] = persontypeselected.persontype;
        searchdata['qpid']=  persontypeselected.quickpersonid ;
      }
      else{
        searchdata['clientflag'] = 1;
        searchdata['qptype'] = null;
        searchdata['qpid']=  null;
      }   
      this._involvedPersonService.newPerson(searchdata);
    }
  }

  searchPersonDetailsRow(id: number, model: any) {
    this.searchPersonDetails(id);
    //Get prior history only when source is local and person id exists
    if (model && (model.cisclientid != '' || model.mdm_id != '' || model.personid != '')) {
      this.getPersonDSDSAction(model);
    }
  }

  searchPersonDetails(id: number) {
    if (this.showPersonDetail !== id) {
      this.showPersonDetail = id;
    } else {
      this.showPersonDetail = -1;
    }
  }

  getPersonDSDSAction(model: PersonDsdsAction) {
    const url = 'Intakeservicerequests/searchpriordsdsactionsbyperson'+ `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + '&filter';
    const source = this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          method: 'get',
          where: { intakerequestid: null, cjamspid: model.cjamspid }
        }),
        url
      ).pipe(
      share());
      this.personDSDSActions$ = source.pipe(
        pluck('data'),
        map((data : any) => data as PersonDsdsAction[])
      );
    this.personDSDSActions$.pipe(
      map((data) => {
        data.forEach((address) => {
          address.daDetails.forEach((addressdata) => {
            // filter the duplicate roles
            if (addressdata.roles) {
              const uniqueRoles = addressdata.roles.filter((elem: any, i: any, arr: string | any[]) => {
                if (arr.indexOf(elem) === i) {
                  return elem;
                }
              });
              addressdata.roles = uniqueRoles;
            }
            if (addressdata.dasubtype === 'Peace Order') {
              address.highLight = true;
              return address;
            }
          });
        });
        return data;
      })).subscribe();
  }


  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.getPage(this.paginationInfo.pageNumber);
  }

  toggleSsn = (row: any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isSsnHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }

  openCase(item: any) {
    if (item.restrictedstatus == 'EXCLUDE' || (item.restrictstatus === 'INCLRES' && this.restrictedcaseenable)) {
      (<any>$('#exclude')).modal('show');
      return ;
    }
    if(!this.preserveDataFlag){
      this.preserveDataFlag = true;
      var currentDataStore = this._dataStoreService.getCurrentStore() ; 
      var currentSessionStorage = this._session.getCurrentSessionStorage();
      this.preserveDataStore = Object.keys(currentDataStore).map((key)=>{ return {key:key, value:currentDataStore[key]}});
      this.preserveSessionData = Object.keys(currentSessionStorage).map((key)=>{ return {key:key, value:currentSessionStorage[key]}});
    }
    this._navigationUtils.openRespectiveItem(item);
  }

  showOutcome(person: any, caseInfo: any) {
    this.selectedPriorPerson = person;
    this.selectedCaseInfo = caseInfo;
    if(caseInfo.datype == 'Child Protective Services'){
      (<any>$('#person-out-come')).modal('show');
    }
  }
  close() {
    (<any>$('#person-out-come')).modal('hide');
    this.selectedCaseInfo = null;
    this.selectedPriorPerson = null;
  }

  isMaltreator(roles: any) {
    let hasMaltreator = false;
    if (Array.isArray(roles)) {
      const maltreatorIndex = roles.indexOf('Alleged Maltreator');
      if (maltreatorIndex !== -1) {
        hasMaltreator = true;
      }
    }
    return hasMaltreator;
  }
}
