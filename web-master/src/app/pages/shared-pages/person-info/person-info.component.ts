
import { fromEvent as observableFromEvent } from 'rxjs';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { PersonInfoService } from './person-info.service';
import { PersonTabs } from './person-tab-config';
import moment from 'moment';
import { Location } from '@angular/common';
import { Router } from '@angular/router';
import { DataStoreService, AuthService, SessionStorageService } from '../../../@core/services';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
declare var $: any;

@Component({
    selector: 'person-info',
    templateUrl: './person-info.component.html',
    styleUrls: ['./person-info.component.scss'],
    standalone: false
})
export class PersonInfoComponent implements OnInit, OnDestroy {


  tabs = PersonTabs;
  title: string|null ='';
  personInfo: any;
  personAge: number=0;
  loggedInUser: any;

  selectedurl: string='';
  selectedPageName: string='';
  saveDoneFlag: boolean=false;
  dataChanged: boolean =false;
  store: any;
  isAdoptionCase = false;
  isAdoptiveParent = false;
  isNavgToMdPsyPage = false;
  multiTabData : any;

  constructor(private _service: PersonInfoService,
    private readonly _authService: AuthService,
    private readonly _router: Router,
    private readonly location: Location,
    private readonly storage: SessionStorageService,
    private readonly _dataStoreService: DataStoreService,
    private _navigationUtils: NavigationUtils,
    ) {
    this.store = this._dataStoreService.getCurrentStore();
    if (this.store && Object.keys(this.store).length === 0) {
      const storeInfoData: any = localStorage.getItem('storeInfo');
      this.store =  this.parseData(storeInfoData);
    }
  }

  parseData(input: any): any {
    if (typeof input === 'string') {
      try {
        return JSON.parse(input);
      } catch (e: any) {
        return input;
      }
    }
    return input;
  }

  ngOnInit() {


    this.isAdoptionCase = this.storage.getItem('CASE_TYPE') === "ADOPTION";
    this.isAdoptiveParent = this.store?.['isAdoptiveParent'];
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;

    this.dataChanged = false;
    observableFromEvent(document, 'keypress').subscribe(_e => {
      this.dataChanged = true;
    });
    this.checkLocationPathFn();
    this.saveDoneFlag = false;
    if(this.store){
      this.store['SAVEDONEFLAG'] = this.saveDoneFlag;
    } 

    this.title = this._service?.getTitle();
    this.serviceisNotNewFn();
    this._service.personInfoListener$.subscribe(_action => {
      this.title = this._service.getTitle();
    });
    this._service.personDobListener$.subscribe(dob => {
      this.personAge = this.calculateAge(dob ? dob : null);
      this.enableProfileTab();
    });
    this.enableSecurityTab();
    this.enableAddressTab();


      this.isNavgToMdPsyPage = JSON.parse(localStorage.getItem('IsNavigateToMedPsy') || 'false');
      if (this.isNavgToMdPsyPage) {
        setTimeout(() => {
          this._navigationUtils.navigateToHealthMedicationPsychotropic();
        }, 500);       
      }
  }

  private checkLocationPathFn() {
    if (this.location.path()?.length > 2) {
      this.selectedurl = this.location.path().split('/')[3] ? this.location.path().split('/')[3] : this.selectedurl;
      const selectedTab:any = this.tabs.find(item => item.path === this.selectedurl);
      this.ifSelectedTabFn(selectedTab);
    }
  }

  private ifSelectedTabFn(selectedTab: { active: boolean; path: string; name: string; enable: boolean; }) {
    if (selectedTab) {
      this.selectedPageName = selectedTab.name;
    }
  }

  private serviceisNotNewFn() {
    if (!this._service.isNew()) {
      this._service.getPersonDetails().subscribe(response => {
        this.personInfo = response;
        this._service.setPersonInfo(response);
        if (this.personInfo?.personbasicdetails?.dob) {
          this.personAge = this.calculateAge(this.checkDobFn());
        }
        this.enableProfileTab();
      });
    }
  }

  private checkDobFn(): any {
    return this.personInfo.personbasicdetails.dob ? this.personInfo.personbasicdetails.dob : null;
  }

  enableAddressTab() {
    this.tabs.forEach(data => {
      if (data.name === 'Address') {
        data.enable = !(this.isAdoptionCase && this.isAdoptiveParent);
      }
    });
  }


  enableSecurityTab() {
    for (const tab of this.tabs) {
      // Role Based access implementation.
      tab.enable = this._authService.isView('person', `person.person.${tab.name}`);
    }
  }


  calculateAge(dob:any) {
    let age = 0;
    if (dob && moment(new Date(dob), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dob), 'MM/DD/YYYY').toDate();
      age = moment().diff(rCDob, 'years');
    }
    return age;
  }

  enableProfileTab() {
    this.tabs.forEach((data:any) => {
      if (data.name === '18-21') {
        data.enable = this.personAge && this.personAge >= 18 && this.personAge <= 21;
      }
    });
  }

  goBack() {
    this._dataStoreService.setData(IntakeStoreConstants.NAVIGATE_TO_PERSON, true);
    this._dataStoreService.setData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE, true);
    this._service.goBack();
  }

  ngOnDestroy(): void {
    this._service.personInfo = null;
  }

  tabChanged(url:any) {
    if (this._service.isNew()) {
      $('#route-confirm-addnew').modal('show');
    } else {
      this.selectedurl = url;
      const selectedTab = this.tabs.find(item => item.path === this.selectedurl);
      if (selectedTab) {
        this.selectedPageName = selectedTab.name;
      }
      this.saveDoneFlag = this.store['SAVEDONEFLAG'];
      // if save done = true => navigate without popup
      // if save done = false => show confirmation popup
      //if (this.saveDoneFlag === false) {
      if (this.dataChanged) {
        $('#route-confirm').modal('show');
      } else {
        this.routeConfirm();
      }
    }
  }

  routeConfirm() {
    this._router.navigate([`pages/person-info-cw/${this.selectedurl}`]);
    // navigated to new page, reset the save done flag
    this.saveDoneFlag = false;
    this.dataChanged = false;
    this.store['SAVEDONEFLAG'] = this.saveDoneFlag;
  }

  resetSelectedURL() {
    if (this.location.path() && this.location.path().length > 2) {
      this.selectedurl = this.location.path().split('/')[3] ? this.location.path().split('/')[3] : this.selectedurl;
    }
  }
}