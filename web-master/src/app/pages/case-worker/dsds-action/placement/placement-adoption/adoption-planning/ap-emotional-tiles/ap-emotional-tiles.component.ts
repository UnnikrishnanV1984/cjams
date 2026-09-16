import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { DynamicObject, PaginationInfo, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { AlertService } from '../../../../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { DataStoreService } from '../../../../../../../@core/services/data-store.service';
import { InvolvedPerson } from '../../../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { Adoptionemotional, Adoptionemotionaldetail } from '../../_entities/adoption.model';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';
declare let google: any;
import moment from 'moment';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { AuthService } from '../../../../../../../@core/services/auth.service';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'ap-emotional-tiles',
    templateUrl: './ap-emotional-tiles.component.html',
    styleUrls: ['./ap-emotional-tiles.component.scss'],
    standalone: false
})
export class ApEmotionalTilesComponent implements OnInit {
    store: DynamicObject;
    private id: string;
    private daNumber: string;
    providerSearchForm!: FormGroup;
    currProcess!: string;
    providername!: string;
    emotionalTiesForm!: FormGroup;
    selectedProvider: any;
    personRelationForm!: FormGroup;
    adoptionemotional!: Adoptionemotional;
    involvedPersons: InvolvedPerson[] = [];
    selectedPerson!: InvolvedPerson;
    emotionalTies: Adoptionemotionaldetail[] = [];
    selectedEmotional!: { index: number; action: string; };
    speechData!: string;
    selectedViewProvider: any;
    isAdoptionCreated!: boolean;

    placementStrType: any;
    notification!: string;

    fcpaginationInfo: PaginationInfo = new PaginationInfo();

    selectedProviderData: any;
    permanencyplanid!: string;
    agreementRate!: any[];
    fcProviderSearch: any;
    parent1providername!: string;
    parent2providername!: string;
    markersLocation : Array<any> = [];
    zoom!: number;
    defaultLat = 39.29044;
    defaultLng = -76.61233;
    paginationInfo: PaginationInfo = new PaginationInfo();
    fcTotal: any;
    childPlacement: any;
    breakLink: any;
    isView!: boolean;
    specialNeedsDropDown!: any[];
    relationshipDropDown!: any[];
    childCharacteristics!: any[];
    otherLocalDeptmntType!: any[];
    bundledPlcmntServicesType!: any[];
    viewEmotionalTies = false;
    selectedIndex!: number;
    adoptionagreementrateid: any;
    genderDropdownItems!: any[];
    isEdit!: boolean;
    minAge!: number;
    maxAge!: number;
    gender!: string;
    lat = 51.678418;
    lng = 7.809007;
    showMap!: boolean;

    isSupervisor!: boolean;
    user!: AppUser;
    approvalStatus!: string;
    recognizing = false;
    currentLanguage!: string;
    speechRecogninitionOn!: boolean;
    token!: AppUser;
    suffixTypes: any[] = [];
    prefixTypes: any[] = [];
    isEditDisabled = false;
    mappopupid = '#map-popup';

    marker = {
      position: {lat: this.lat, lng: this.lng}
    }
  
    mapOptions: google.maps.MapOptions = {
      center: {lat: this.lat, lng: this.lng},
      zoom : 12
    }

    private readonly _store: DataStoreService;
    private readonly route: ActivatedRoute;
    private readonly _router: Router;
    private readonly _commonHttp: CommonHttpService;
    private readonly _formBuilder: FormBuilder;
    private readonly _alertService: AlertService;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;
    
    constructor(private readonly injector : Injector, private readonly _dataStoreService: DataStoreService, public readonly _authService: AuthService) {
      this._store = this.injector.get<DataStoreService>(DataStoreService);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._router = this.injector.get<Router>(Router);
      this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
      this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
      
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.planning.emotionaltiesedit');
        if (this.store['adoptionEffort'] && !this.store['adoptionEffort'].adoptionplanningid) {
            this._alertService.error('Please Submit Adoption Efforts');
            const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/efforts';
            setTimeout(() => {
                this._router.navigate([redirectUrl]);
            }, 1000);
        }


          this.suffixTypes = ['Jr', 'Sr'];
          this.prefixTypes = ['Mr', 'Mrs', 'Ms', 'Dr', 'Prof', 'Sister', 'Atty'];
        this.initializeForm();
        this.getInvolvedPerson();
        this.getEmotionalTieList();
        this.getEmotionalPersonal();
        this.getPlacementStrType(null);
        this.loadGenderDropdownItems();
        this.getChildCharacteristics();
        this.getOtherLocalDeptmntType();
        this.getBundledPlcmntServicesType();
        this.getBreaklink();
        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
          if (data === 'TRPList_a') { 
                    this.getEmotionalTieList();
                    this.getEmotionalPersonal();
                    setTimeout(() => {
                      const unsavedForm = false;
                      this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
                    }, 1000);
                   
          } });
    }
    onPersonChange(personId: any) {
        const selectedPerson: any = this.involvedPersons.filter(item => item.intakeservicerequestactorid === personId)[0];
        const adoptingChild : any= this.store['placed_child'];
        const relations: any = selectedPerson['relationshiparray'];

        if (Array.isArray(relations)) {
            const reationToChild = relations.find(relation => relation.primaryuserid === adoptingChild.personid && relation.secondaryuserid === selectedPerson.personid);
            if (reationToChild) {
                selectedPerson.relationship = reationToChild.description;
            }
        }


        this.personRelationForm.patchValue(selectedPerson);
    }
    onchangePersonType() {
        this.selectedProviderData = [];
        this.personRelationForm.patchValue({
            fmprefixtypekey:'',
            fmfirstname: '',
            fmmiddlename: '',
            fmlastname: '',
            fmsuffixtypekey: '',
            relationshiptochildtx: '',
            importancetochildtx: '',
            providerid: null
        });
    }


    addemotionaldetails(emotionalTie: any) {
        this._commonHttp.create(emotionalTie, 'adoptionemotionalties/addupdate').subscribe(
            res => {
                const msg = ( this.selectedEmotional && this.selectedEmotional.action === 'Add' ) ?  'Emotional Tie saved successfully!' : 'Emotional Tie updated successfully!';
                this._alertService.success(msg);
                this.getEmotionalTieList();
                this.getEmotionalPersonal();
                const unsavedForm = true;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);

            },
            err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

    }

    manageEmotionalPerson(action: string, modal?: any, i?: any) {
        this.viewEmotionalTies = false;
        this.personRelationForm.enable();
        this.personRelationForm.reset();
        this.selectedProvider = null;
        this.selectedProviderData = [];
        this.selectedEmotional = {
            index: i,
            action: action
        };
        $('#manage-emotional-tie').modal('show');
        this.personRelationForm.patchValue({
          persontype : 'Provider'
        });
        if (action !== 'Add') {
            const emotionaltie = this.emotionalTies[i];
            emotionaltie.persontype = emotionaltie.providerid ? 'Provider' : 'Other';
            if (emotionaltie.providerid) {
            this.getProvider(emotionaltie.providerid);
            }
            this.personRelationForm.patchValue(emotionaltie);
        }
        if (action === 'View') {
            this.viewEmotionalTies = true;
            this.personRelationForm.disable();
        }
    }
    saveEmotionalPerson() {
        if(this.personRelationForm.value.persontype === 'Provider'){
            if(!(this.selectedProviderData && this.selectedProviderData.length > 0 && this.selectedProviderData[0].provider_id)){
              this._alertService.error('Please select a Provider');
              return;
            }
        }

        const emotion = this.personRelationForm.getRawValue();
        const planningid = this._PlacementAdoptionService.getAdoptionPlanning();
        emotion.adoptionplanningid = planningid ? planningid.adoptionplanningid : null;
        emotion.providerid = emotion.persontype === 'Provider' ? emotion.providerid  : null;
        emotion.fmfirstname =  emotion.persontype !== 'Provider' ? emotion.fmfirstname  : null;
        emotion.fmlastname =  emotion.persontype !== 'Provider' ? emotion.fmlastname  : null;
        emotion.fmmiddlename =  emotion.persontype !== 'Provider' ? emotion.fmmiddlename  : null;
        if (!this.selectedEmotional.index && this.selectedEmotional.index !== 0) {
            this.emotionalTies.push(emotion);
            this.addemotionaldetails(emotion);
        } else if (this.selectedEmotional.index || this.selectedEmotional.index === 0) {
            this.emotionalTies[this.selectedEmotional.index] = emotion;
            this.addemotionaldetails(emotion);
        }
        $('#manage-emotional-tie').modal('hide');
        const unsavedForm = true;
        this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);

    }

    getEmotionalPersonal() {
        this._commonHttp
        .getArrayList(
            {
                where: { adoptionplanningid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null },
                method: 'get'
            },
            'adoptionemotionalties/list?filter'
        )
        .subscribe(res => {
          if (res && res.length) {

            this.emotionalTies = res ? res : [];
              this.emotionalTies = this.emotionalTies.map((item: any) => {
              if (item.providerid) {
                item['fullname'] = this.getProviderName(item) ;
              } else {
                item['fullname'] = this.getFullName(item);
              }
              return item;
            });
          } else {
            $('#info-pop').modal('show');
          }
        });
    }
  getProviderName(provider: any){
    const nameKeys = [ 'provider_first_nm', 'provider_last_nm' ];
    const nmkey= 'provider_nm';
    let name = '';
    if(provider && provider.hasOwnProperty(nmkey) && (provider[nmkey] != null) && (provider[nmkey] != 'null') && (provider[nmkey] != '') ) {
      name = provider[nmkey];
    }
    else {
      nameKeys.forEach(key => {
        if(provider && provider.hasOwnProperty(key)){
        if ( (provider[key] != null) && (provider[key] != 'null') && (provider[key] != '') ) {
          name = name + provider[key] + ' ';
        }}
      });
    }
    return name;
  }
  getFullName(person: any) {
    const nameKeys = [ 'fmprefixtypekey' , 'fmfirstname' , 'fmmiddlename' , 'fmlastname' , 'fmsuffixtypekey'];
    let name = '';
    nameKeys.forEach(key => {
      if(person && person.hasOwnProperty(key)){
      if ( (person[key] != null) && (person[key] != 'null') && (person[key] != '') ) {
        name = name + person[key] + ' ';
      }}
    });
    return name;
  }
    selectProvider() {
    this.personRelationForm.patchValue({ 'providerid': (this.selectedProvider && this.selectedProvider.provider_id) ? this.selectedProvider.provider_id : null });
    if ((this.selectedProvider && this.selectedProvider.provider_id)) {
    this.getProvider(this.selectedProvider.provider_id);
    }
    $('#searchProvider').modal('hide');
    }
  fcPageChanged(pageEvent: any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getFcProviderSearch();
  }
    saveEmotionalTie(nextNavigation: any) {
        const emotionalTieInput = this.emotionalTiesForm.value;
        emotionalTieInput.adoptionemotionaldetails = this.emotionalTies;
        emotionalTieInput.isfosterparents = emotionalTieInput.isfosterparents ? 1 : 0;
        emotionalTieInput.isadoptivefamily = emotionalTieInput.isadoptivefamily ? 1 : 0;
        emotionalTieInput.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        if (!emotionalTieInput.adoptionemotionalid) {
            delete emotionalTieInput.adoptionemotionalid;
        }
        this._commonHttp.create(emotionalTieInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEmotionalTieAdd).subscribe(
            res => {
                this._alertService.success('Emotional Tie saved successfully!');
                const unsavedForm = false;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
                if (nextNavigation === 'Next') {
                    const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/narrative';
                    this._router.navigate([redirectUrl]);
                }
            },
            err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    private initializeForm() {
        this.emotionalTiesForm = this._formBuilder.group({
            isfosterparents: [null],
            isadoptivefamily: [null],
            notes: [''],
            adoptionemotionalid: [null]
        });
        this.personRelationForm = this._formBuilder.group({
            emotionaltieid: [null],
            fmprefixtypekey: [null],
            fmfirstname: [null],
            fmmiddlename: [null],
            fmlastname: [null],
            fmsuffixtypekey: [null],
            relationshiptochildtx: [null],
            importancetochildtx: [null],
            adoptionplanningid:  [null],
            providerid: [null],
            persontype: [null]
        });

        this.providerSearchForm = this._formBuilder.group({
            childcharacteristics: [null],
            bundledplacementservices: [null],
            otherLocalDeptmntTypeId: [null],
            placementstructures: [null],
            zipcode: null,
            isLocalDpt: [true],
            firstname: null,
            middlename: null,
            lastname: null,
            isgender: [false],
            isAge: [false],
            providerid: null,
            agemin: null,
            agemax: null,
            gender: null
          });

    }

    private getAge(dateValue: any) {
      if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
        const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
        return moment().diff(rCDob, 'years');
      } else {
        return '';
      }
    }
    private getEmotionalTieList() {
        this._commonHttp
            .getArrayList(
                {
                    where: { adoptionplanningid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEmotionalTieList + '?filter'
            )
            .subscribe(res => {
                if (res && res.length) {
                    this.emotionalTiesForm.patchValue(res[0]);
                }
                this.onChanges();
                const unsavedForm = false;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
            
            });

    }

    private onChanges() {
      this.emotionalTiesForm.valueChanges.subscribe(effort => {

          const unsavedForm = true;
          this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);

      });
     }

    filterSavedPersons(personid: any) {
        if (this.emotionalTies && this.emotionalTies.length) {
            const person = this.emotionalTies.filter(item => item.intakeservicerequestactorid === personid);
            if (person && person.length) {
                return false;
            } else {
                return true;
            }
        }
        return true;
    }

    private getInvolvedPerson() {
        this._commonHttp
            .getPagedArrayList(
                {
                    where: {
                        objectid: this.id, objecttypekey: 'servicecase'
                    },
                    page: 1,
                    limit: 10,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe(result => {
              if (!result['data'] || result['data'].length === 0) {
                return;
              }
              this.involvedPersons = result['data'].filter(item => {
                  this.handleIfNoRolenameFn(item);
                  if (item.rolename &&
                      item.rolename !== 'AV' &&
                      //  item.rolename !== 'AM' &&
                      item.rolename !== 'CHILD' &&
                      item.rolename !== 'RC' &&
                      item.rolename !== 'BIOCHILD' &&
                      item.rolename !== 'NVC' &&
                      item.rolename !== 'OTHERCHILD' &&
                      item.rolename !== 'PAC'
                      // (item.roles.length &&
                      //     item.roles.filter(
                      //         itm =>
                      //             itm.rolename !== 'AV' &&
                      //             itm.rolename !== 'AM' &&
                      //             itm.rolename !== 'CHILD' &&
                      //             itm.rolename !== 'RC' &&
                      //             itm.rolename !== 'BIOCHILD' &&
                      //             itm.rolename !== 'NVC' &&
                      //             itm.rolename !== 'OTHERCHILD' &&
                      //             itm.rolename !== 'PAC'
                      //     ))
                  ) {
                      if (!item.intakeservicerequestactorid) {
                          if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                              item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                          }
                      }
                      return item;
                  }
              });

              this.involvedPersons.sort((a, b) => a.fullname.localeCompare(b.fullname));
            });
    }

  private handleIfNoRolenameFn(item: any) {
    if (!item.rolename || item.rolename === '') {

      if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
        item.rolename = item.roles[0].intakeservicerequestpersontypekey;
      }
    }
  }

    resetproviderSearchForm() {
    this.providerSearchForm.reset();
    this.currProcess = 'search';
    }

    onSearchProvider() {
      const child = this.store['placed_child'];
      if (child) {
        const childage = this.getAge(child.dob);
        const min = 0;
        const max = childage;
        this.providerSearchForm.patchValue({
          isgender: true,
          isAge: true,
          agemin: min,
          agemax: max,
          gender: child.gender
        });
      }
    this.providerSearchForm.reset();
    $('#searchProvider').modal('show');
    this.currProcess = 'search';

    }

    getFcProviderSearch() {
        if (this.providerSearchForm.invalid) {
          this._alertService.error('Please fill required fields');
          return false;
        }

        const child = this.store['placed_child'];
        if (child) {
          this.getAge(child.dob);
          const min = 0;
        }
        const formValues = this.providerSearchForm.getRawValue();
        if (formValues.isgender && !formValues.gender) {
          this._alertService.error('Please select gender');
          return false;
        }
        formValues.gender = formValues.isgender ? this.returnGenderFn(formValues) : null;

        Object.keys(this.providerSearchForm.controls).forEach(key => {
          formValues[key] = this.CheckFormControlValue(formValues[key]);
        });
        const body: any = {};
        Object.assign(body, formValues);
        body['isLocalDpt'] = true;
        body['localdepartmenthomecaregiver'] = true;
        body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics[0] : null;
        body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId ? formValues.otherLocalDeptmntTypeId[0] : null;
        body['placementstructures'] = formValues.placementstructures ? formValues.placementstructures[0] : null;
        body['bundledplacementservices'] = formValues.bundledplacementservices ? formValues.bundledplacementservices[0] : null;

        this._commonHttp.getPagedArrayList(new PaginationRequest({
          where: body,
          page: this.paginationInfo.pageNumber,
          limit: 10,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
          this.fcProviderSearch = result.data;
          this.fcTotal = result.count;
          $('#fc_list').click();
          this.currProcess = 'select';
        });
      }
      // Assosiated with getFcProviderSearch method
  private returnGenderFn(formValues: any): any {
    return (formValues.gender ? formValues.gender : null);
  }

      getProvider(id: any) {

        this.selectedProviderData = [];
        const child = this.store['placed_child'];
        if (child) {
          this.getAge(child.dob);
          const min = 0;
          this.providerSearchForm.patchValue({
            // isgender: true,
            // isAge: true,
            // agemin: min,
            // agemax: max,
            // gender: child.gender ,
            isLocalDpt: true,
            localdepartmenthomecaregiver: true,
          });
        }
        const formValues = this.providerSearchForm.getRawValue();

        formValues.providerid = id;

        Object.keys(this.providerSearchForm.controls).forEach(key => {
          formValues[key] = this.CheckFormControlValue(formValues[key]);
        });
        const body: any = {};
        Object.assign(body, formValues);

        body['isLocalDpt'] = true;
        body['localdepartmenthomecaregiver'] = true;        
        body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics[0] : null;
        body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId ? formValues.otherLocalDeptmntTypeId[0] : null;
        body['placementstructures'] = formValues.placementstructures ? formValues.placementstructures[0] : null;
        body['bundledplacementservices'] = formValues.bundledplacementservices ? formValues.bundledplacementservices[0] : null;

        this._commonHttp.getPagedArrayList(new PaginationRequest({
          where: body,
          page: this.paginationInfo.pageNumber,
          limit: 10,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
            this.selectedProviderData = result.data;
        });
      }


        CheckFormControlValue(formControl: any) {
            return (formControl && formControl !== '') ? formControl : null;
        }

      backToSearchList() {
        this.currProcess = 'select';
        this.selectedProvider = null;
      }

      backToSearch() {
        this.providerSearchForm.reset();
        const child = this.store['placed_child'];
        if (child) {
          this.getAge(child.dob);
          const min = 0;
        }
        this.currProcess = 'search';
        this.selectedProvider = null;
      }

      getRangeArray(n: number): any[] {
        return Array(n);
      }


      listMap(provider: any) {
        this.zoom = 13;
        this.defaultLat = 39.29044;
        this.defaultLng = -76.61233;
        // this.fcProviderSearch.map((map) => {
        $(this.mappopupid).modal('show');
        this.showMap = true;
        this.markersLocation = [];
        // if (map.length > 0) {
        // this.fcProviderSearch.forEach((provider) => {
        //  this._ServiceCasePlacementsService.getGoogleMarker(provider.providerdetails[0].address).subscribe(res => {
        //     console.log(res);
        //   });
        const geocoder = new google.maps.Geocoder();
        if (geocoder) {
          geocoder.geocode({ 'address': provider.providerdetails[0].address }, (results: any, status: any) => {
            if (status === google.maps.GeocoderStatus.OK) {
              this.markersLocation = [];
              const marker = { lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng() };
              this.lat = marker.lat;
              this.lng = marker.lng;
              this.markersLocation.push(marker);
              this.defaultLat = marker.lat;
              this.defaultLng = marker.lng;
              $(this.mappopupid).modal('show');
              setTimeout(() => {
                this.showMap = true;
              }, 300);

            } else {
              // No operation needed here 
            }
          });
        }

        // json.map(res => {
        //   console.log(res);
        // });
        //   if ( json.results && json.results.length > 0  && json.results[0].geometry.location  ) {
        //   const res = json.results[0].geometry.location;
        //   const mapLocation = {
        //         lat: +res.lat,
        //         lng: +res.lon,
        //         draggable: +true,
        //         providername: provider.providername,
        //         addressline1: provider.providerdetails[0].address
        //     };
        //     this.markersLocation.push(mapLocation);
        //     this.defaultLat = this.markersLocation[0].lat;
        //     this.defaultLng = this.markersLocation[0].lng;
        //   // });
        // // });
        // (<any>$(this.mappopupid)).modal('show');
        //   }
        //     }
        // });
      }
      mapClose() {
        this.markersLocation = [];
        this.showMap = false;
      }


      selectedViewProv(provId: any) {
        this.selectedViewProvider = provId;
      }

      selectedProv(provId: any) {
        this.selectedProvider = provId;
      }



      getPlacementStrType(providerId: any) {
        this._commonHttp.getArrayList(new PaginationRequest({
          where: {
            'structure_service_cd': 'P',
            'provider_id': providerId
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
          this.placementStrType = result;
        });
      }

      loadGenderDropdownItems() {
        this._commonHttp.create(
          {
            where: { activeflag: 1 },
            method: 'post',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
        ).subscribe((genderList) => {
          this.genderDropdownItems = genderList;
        });
        // text: res.typedescription,
        // value: res.gendertypekey
      }

      closeMap() {
        this.markersLocation = [];
        this.showMap = false;
        $(this.mappopupid).modal('hide');
      }

      getChildCharacteristics() {
        this._commonHttp.getArrayList(new PaginationRequest({
          where: {
            'picklist_type_id': '43'
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
          this.childCharacteristics = result;
        });
      }

      getOtherLocalDeptmntType() {
        this._commonHttp.getArrayList(new PaginationRequest({
          where: {
            'picklist_type_id': '104'
          },
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
          this.otherLocalDeptmntType = result;
        });
      }

      getBundledPlcmntServicesType() {
        this._commonHttp.getArrayList(new PaginationRequest({
          nolimit: true,
          method: 'get'
        }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
          this.bundledPlcmntServicesType = result;
        });
      }

      private getBreaklink() {
        this._commonHttp
          .getArrayList({
            method: 'get', where: {
              adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
            }
          }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
          .subscribe(res => {
            if (res && res.length) {
              res.forEach((item) => {
                if(item && item.getadoptionbreakthelink){
                  this.returnBreaklinkFn(item);
              }
              });
            }
          });
      }
      // Assosiated with getBreaklink method
  private returnBreaklinkFn(item: any) {
    return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
      this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
      return breaklink;
    });
  }
}
