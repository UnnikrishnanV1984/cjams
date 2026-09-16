
import {pluck, map, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
import { Observable ,  Subject } from 'rxjs';

import { DropdownModel, PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, GenericService } from '../../../../@core/services';
import {
    Equipment,
    TeamMemberDetails,
    TreeView,
    UserAddressdetails,
    UserDetails,
    Useriddetails,
    UserNetworkId,
    UserPhoneDetails,
    UserPositionCode,
    UserProfile,
    UserProfileDetails,
    UserProfileFormData,
    UserRoles,
    UsersSearchResult,
    UserTeamDetails,
    Countydetails,
} from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'staff-and-team-details',
    templateUrl: './staff-and-team-details.component.html',
    styleUrls: ['./staff-and-team-details.component.scss'],
    standalone: false
})
export class StaffAndTeamDetailsComponent implements OnInit {

    @Input()
    userIDSubject$!: Subject<UsersSearchResult>;

    user!: UsersSearchResult;
    equipmentList$!: Observable<Equipment[]>;
    userRoles$!: Observable<UserRoles>;
    equipmentTypeList$!: Observable<DropdownModel[]>;
    userStatusDropdown$!: Observable<DropdownModel[]>;
    teamTreeview$!: Observable<TreeView[]>;
    teamMemberDetailsList$!: Observable<TeamMemberDetails[]>;
    totalteamMemberListCount$!: Observable<number>;
    treeComponentId!: string;
    selectedEquipmentId!: string;
    selectedEquipment!: Equipment | undefined;
    userDetails$!: Observable<UserDetails>;
    addressdetails$!: Observable<UserAddressdetails>;
    iddetails$!: Observable<Useriddetails[]>;
    phonedetails$!: Observable<UserPhoneDetails[]>;
    positioncode$!: Observable<UserPositionCode>;
    teamdetails$!: Observable<UserTeamDetails>;
    networkid$!: Observable<UserNetworkId>;
    countydetails$!: Observable<Countydetails>;

    directLinePhoneModel: UserPhoneDetails;
    faxModel: UserPhoneDetails;
    businessCellModel: UserPhoneDetails;
    pagerModel: UserPhoneDetails;
    homePhoneModel: UserPhoneDetails;
    personelCellModel: UserPhoneDetails;

    webtoolModel!: Useriddetails;
    prodIdModel!: Useriddetails;

    paginationInfo: PaginationInfo = new PaginationInfo();
    eqDisableCreate: boolean;
    eqDisableReassign: boolean;
    eqDisableSave: boolean;
    eqDisableCancel: boolean;
    equipmentformGroup: FormGroup;
    userDataFormGroup: FormGroup;

    // datepicker
    minDate = new Date();
    colorTheme = 'theme-blue';
    bsConfig!: Partial<BsDatepickerConfig>;

    constructor(
        private formBuilder: FormBuilder,
        private _service: GenericService<UserProfile>,
        private _commonservice: CommonHttpService) {
        this.eqDisableCancel = true;
        this.eqDisableCreate = true;
        this.eqDisableSave = true;
        this.eqDisableReassign = true;

        this.directLinePhoneModel = new UserPhoneDetails();
        this.faxModel = new UserPhoneDetails();
        this.businessCellModel = new UserPhoneDetails();
        this.pagerModel = new UserPhoneDetails();
        this.homePhoneModel = new UserPhoneDetails();
        this.personelCellModel = new UserPhoneDetails();

        this.equipmentformGroup = this.formBuilder.group({
            equipmenttypekey: new FormControl({ value: '', disabled: true }),
            manufacturer: new FormControl({ value: '', disabled: true }),
            model: new FormControl({ value: '', disabled: true }),
            serialnumber: new FormControl({ value: '', disabled: true }),
            whitetagnumber: new FormControl({ value: '', disabled: true }),
            yellowtagnumber: new FormControl({ value: '', disabled: true }),
            description: new FormControl({ value: '', disabled: true }),
            comments: new FormControl({ value: '', disabled: true }),
            dh60date: new FormControl({ value: '', disabled: true }),
            sutnumber: new FormControl({ value: '', disabled: true }),
            locationcode: new FormControl({ value: '', disabled: true }),
            upforreplacement: new FormControl({ value: '', disabled: true }),
            equipmentid: new FormControl({ value: '', disabled: true }),
            activeflag: new FormControl({ value: '', disabled: true }),
            effectivedate: new FormControl({ value: '', disabled: true }),
            expirationdate: new FormControl({ value: '', disabled: true }),
            roomnumber: new FormControl({ value: '', disabled: true }),
            primarymachine: new FormControl({ value: '', disabled: true }),
            found: new FormControl({ value: '', disabled: true }),
            transfer: new FormControl({ value: '', disabled: true }),
            disposed: new FormControl({ value: '', disabled: true }),
            unit: new FormControl({ value: '', disabled: true }),
        });

        this.userDataFormGroup = this.formBuilder.group({
            webtoolid: new FormControl({ value: '', disabled: false }),
            zipcodeplus: new FormControl({ value: '', disabled: false }),
            homePhone: new FormControl({ value: '', disabled: false }),
            personelcell: new FormControl({ value: '', disabled: false }),
            phonenumber: new FormControl({ value: '', disabled: false }),
            officePhone: new FormControl({ value: '', disabled: false }),
            directLine: new FormControl({ value: '', disabled: false }),
            fax: new FormControl({ value: '', disabled: false }),
            businessCell: new FormControl({ value: '', disabled: false }),
            pager: new FormControl({ value: '', disabled: false }),
            availability: new FormControl({ value: '', disabled: false }),
            status: new FormControl({ value: '', disabled: false }),
            internalcalenderLink: new FormControl({ value: '', disabled: false }),
            enablecalender: new FormControl({ value: '', disabled: false }),
            disablecalender: new FormControl({ value: '', disabled: false }),
            resetKey: new FormControl({ value: '', disabled: false }),
            autonotification: new FormControl({ value: '', disabled: false }),
            pobox: new FormControl({ value: '', disabled: false }),
            county: new FormControl({ value: '', disabled: false }),
            prodid: new FormControl({ value: '', disabled: false }),
        });
    }

    ngOnInit() {
        this.selectedEquipment = undefined;
        this.bsConfig = Object.assign({}, { containerClass: this.colorTheme });
        this.userIDSubject$.subscribe(data => {
            this.clearAllData();
            this.user = data;
            this.eqDisableCreate = false;
            this.eqDisableReassign = true;
            this.eqDisableSave = true;
            this.eqDisableCancel = true;
            this.getEquipmentList();
            this.getUserProfile();
            this.getEquipmentTypeList();
            this.getRoleMappings();
            this.getUserStatusList();
        });
        this.enableEquipmentForm(false);
    }

    clearAllData() {
        this.userProfileCancel();
        this.directLinePhoneModel = new UserPhoneDetails();
        this.faxModel = new UserPhoneDetails();
        this.businessCellModel = new UserPhoneDetails();
        this.pagerModel = new UserPhoneDetails();
        this.homePhoneModel = new UserPhoneDetails();
        this.personelCellModel = new UserPhoneDetails();
        this.webtoolModel = new Useriddetails();
        this.prodIdModel = new Useriddetails();
    }

    getEquipmentList() {
        this._commonservice.endpointUrl =
            `${FindUrlConfig.EndPoint.staffnteam.equipmentList}/${this.user.teammemberid}`;
        this.equipmentList$ = this._commonservice.getArrayList({}).pipe(map(res => res));
    }

    getEquipmentTypeList() {

        this.equipmentTypeList$ = this._commonservice.getArrayList(FindUrlConfig.EndPoint.staffnteam.equipmentTypeList).pipe(map(
            data => data.map(res =>
                new DropdownModel({
                    text: res.typedescription,
                    value: res.equipmenttypekey
                })
            )));

    }


    selectEquipment(equipment: Equipment) {
        this.selectedEquipmentId = equipment.equipmentid;
        this.selectedEquipment = equipment;
        this._commonservice.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.equipmentDetails + '/' + equipment.equipmentid;
        this._commonservice.getSingle({}).subscribe(data => {
            this.patchupEquipmentFormData(data);
        });
        this.eqDisableCreate = false;
        this.eqDisableCancel = false;
        this.eqDisableReassign = false;
        this.eqDisableSave = false;
        this.enableEquipmentForm(true);
    }

    patchupEquipmentFormData(data: Equipment) {
        this.equipmentformGroup.patchValue(data);
    }

    getRoleMappings() {
        this._commonservice.endpointUrl =
            `${FindUrlConfig.EndPoint.staffnteam.rolemappings}/${this.user.securityusersid}`;
        this.userRoles$ = this._commonservice.getSingle({}).pipe(share());
    }

    getUserStatusList() {
        this._commonservice.endpointUrl =
            `${FindUrlConfig.EndPoint.staffnteam.userStatus}`;

        this.userStatusDropdown$ = this._commonservice.getArrayList(FindUrlConfig.EndPoint.staffnteam.userStatus).pipe(map(
            data => data.map(res =>
                new DropdownModel({
                    text: res.typedescription,
                    value: res.userworkstatustypekey
                })
            )));
    }

    getUserProfile() {
        this._service.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.userProfile + '/' + this.user.securityusersid;
        const source = this._service.getSingle({}).pipe(share());
        this.userDetails$ = source.pipe(pluck('userdetails'));
        this.addressdetails$ = source.pipe(pluck('addressdetails'));
        this.iddetails$ = source.pipe(pluck('iddetails'));
        this.phonedetails$ = source.pipe(pluck('phonedetails'));
        this.positioncode$ = source.pipe(pluck('positioncode'));
        this.teamdetails$ = source.pipe(pluck('teamdetails'));
        this.networkid$ = source.pipe(pluck('networkid'));
        this.countydetails$ = source.pipe(pluck('countydetails'));
        source.subscribe((data: UserProfile) => {
            this.patchUpFormData(data);
        });

    }

    patchUpFormData(data: UserProfile) {

        this.userDataFormGroup.patchValue({
            zipcodeplus: (data.addressdetails) ? data.addressdetails.zipcodeplus : '',
            availability: (data.userdetails) ? data.userdetails.unavailableflag : '',
            status: (data.userdetails) ? data.userdetails.userworkstatustypekey : '',
            internalcalenderLink: (data.userdetails) ? data.userdetails.calendarkey : '',
            autonotification: (data.userdetails) ? data.userdetails.autonotification : '',
            pobox: (data.addressdetails) ? data.addressdetails.pobox : '',
            county: (data.addressdetails) ? data.addressdetails.county : '',

        });

        const calKey = (data.userdetails) ? data.userdetails.calendarkey : '';
        if (calKey == null || calKey === '') {
            this.userDataFormGroup.patchValue({
                enablecalender: false,
                resetKey: false,
                disablecalender: true
            });
        } else {
            this.userDataFormGroup.patchValue({
                enablecalender: true,
                resetKey: true,
                disablecalender: false
            });
        }

        this.patchIdDetailsFn(data);
        this.patchPhoneDetailsFn(data);

    }

    private patchPhoneDetailsFn(data: UserProfile) {
        data.phonedetails.forEach(res => {
            if (res.userprofiletypekey === 'fax') {
                this.userDataFormGroup.patchValue({
                    fax: res.phonenumber,
                });
                this.faxModel = res;
            } else if (res.userprofiletypekey === 'cell') {
                this.userDataFormGroup.patchValue({
                    personelcell: res.phonenumber,
                });
                this.personelCellModel = res;
            } else if (res.userprofiletypekey === 'home') {
                this.userDataFormGroup.patchValue({
                    homePhone: res.phonenumber,
                });
                this.homePhoneModel = res;
            } else if (res.userprofiletypekey === 'statecell') {
                this.userDataFormGroup.patchValue({
                    businessCell: res.phonenumber,
                });
                this.businessCellModel = res;
            } else if (res.userprofiletypekey === 'office') {
                this.userDataFormGroup.patchValue({
                    officePhone: res.phonenumber,
                });
            } else if (res.userprofiletypekey === 'pager') {
                this.userDataFormGroup.patchValue({
                    pager: res.phonenumber,
                });
                this.pagerModel = res;
            } else if (res.userprofiletypekey === 'DirectLine') {
                this.userDataFormGroup.patchValue({
                    directLine: res.phonenumber,
                });
                this.directLinePhoneModel = res;
            }
        });
    }

    private patchIdDetailsFn(data: UserProfile) {
        data.iddetails.forEach(res => {
            if (res.userprofileidentifiertypekey === 'WebToolId') {
                this.userDataFormGroup.patchValue({
                    webtoolid: res.userprofileidentifiervalue,
                });
                this.webtoolModel = res;
            } else if (res.userprofileidentifiertypekey === 'PRODId') {
                this.userDataFormGroup.patchValue({
                    prodid: res.userprofileidentifiervalue,
                });
                this.prodIdModel = res;
            }
        });
    }

    userProfileCancel() {
        this.userDataFormGroup.reset();
    }

    userProfileSave(params: UserProfileFormData) {
        const userDetailsSaveParams = new UserProfileDetails();
        userDetailsSaveParams.Userprofileaddress = new UserAddressdetails();
        userDetailsSaveParams.User = new UserDetails();
        userDetailsSaveParams.Userprofileidentifier = [];
        userDetailsSaveParams.Userprofilephonenumber = [];

        userDetailsSaveParams.Userprofileaddress.zipcodeplus = params.zipcodeplus;
        userDetailsSaveParams.Userprofileaddress.pobox = params.pobox;
        userDetailsSaveParams.Userprofileaddress.county = params.county;
        userDetailsSaveParams.Userprofileaddress.securityusersid = this.user.securityusersid;

        this.updateProfileSavePhoneDetailsFn(params, userDetailsSaveParams);
        this.updateProfileSaveIdDetailsFn(params, userDetailsSaveParams);

        userDetailsSaveParams.User.autonotification = params.autonotification;
        userDetailsSaveParams.User.isavailable = params.availability;
        userDetailsSaveParams.User.userworkstatustypekey = params.status;
        userDetailsSaveParams.User.securityusersid = this.user.securityusersid;


        this._commonservice.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.userProfileupdate;
        this._commonservice.create(userDetailsSaveParams).subscribe(data => {
            // Need to handle the fail scenario
        });
    }

    private updateProfileSaveIdDetailsFn(params: UserProfileFormData, userDetailsSaveParams: UserProfileDetails) {
        if (params.webtoolid != null && params.webtoolid !== '') {
            this.webtoolModel.userprofileidentifiertypekey = 'WebToolId';
            this.webtoolModel.userprofileidentifiervalue = params.webtoolid;
            this.webtoolModel.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofileidentifier.push(this.webtoolModel);
        }
        if (params.prodid != null && params.prodid !== '') {
            this.prodIdModel.userprofileidentifiervalue = params.prodid;
            this.prodIdModel.userprofileidentifiertypekey = 'PRODId';
            this.prodIdModel.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofileidentifier.push(this.prodIdModel);
        }
    }

    private updateProfileSavePhoneDetailsFn(params: UserProfileFormData, userDetailsSaveParams: UserProfileDetails) {
        if (params.homePhone != null && params.homePhone !== '') {
            const homePhone = new UserPhoneDetails(this.homePhoneModel);
            homePhone.phonenumber = params.homePhone;
            homePhone.userprofiletypekey = 'home';
            homePhone.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(homePhone);
        }
        if (params.personelcell != null && params.personelcell !== '') {
            const personelcell = new UserPhoneDetails(this.personelCellModel);
            personelcell.phonenumber = params.personelcell;
            personelcell.userprofiletypekey = 'cell';
            personelcell.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(personelcell);
        }
        if (params.businessCell != null && params.businessCell !== '') {
            const bussinesscell = new UserPhoneDetails(this.businessCellModel);
            bussinesscell.phonenumber = params.businessCell;
            bussinesscell.userprofiletypekey = 'statecell';
            bussinesscell.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(bussinesscell);
        }
        if (params.directLine != null && params.directLine !== '') {
            const directPhone = new UserPhoneDetails(this.directLinePhoneModel);
            directPhone.phonenumber = params.directLine;
            directPhone.userprofiletypekey = 'DirectLine';
            directPhone.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(directPhone);
        }
        if (params.fax != null && params.fax !== '') {
            const fax = new UserPhoneDetails(this.faxModel);
            fax.phonenumber = params.fax;
            fax.userprofiletypekey = 'fax';
            fax.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(fax);
        }
        if (params.pager != null && params.pager !== '') {
            const pager = new UserPhoneDetails(this.pagerModel);
            pager.phonenumber = params.pager;
            pager.userprofiletypekey = 'pager';
            pager.securityusersid = this.user.securityusersid;
            userDetailsSaveParams.Userprofilephonenumber.push(pager);
        }
    }

    cancel() {
        this.clearEquipmentForm();
        this.enableEquipmentForm(true);
        this.eqDisableCreate = false;
        this.eqDisableReassign = true;
        this.eqDisableCancel = false;
        this.eqDisableSave = true;
    }

    create() {
        this.selectedEquipment = undefined;
        this.clearEquipmentForm();
        this.enableEquipmentForm(true);
        this.eqDisableCreate = true;
        this.eqDisableReassign = true;
        this.eqDisableCancel = false;
        this.eqDisableSave = false;

    }

    save(params: Equipment) {
        this.enableEquipmentForm(false);
        this.eqDisableCreate = false;
        this.eqDisableReassign = true;
        this.eqDisableCancel = false;
        this.eqDisableSave = true;
        if (this.selectedEquipment === undefined) {
            this.addEquipment(params);
        } else {
            this.updateEquipment(params);
        }
    }

    clearEquipmentForm() {
        this.equipmentformGroup.reset();
        this.equipmentformGroup.patchValue({
            upforreplacement: false
        });

    }

    addEquipment(params: Equipment) {
        params.primarymachine = true;
        params.found = true;
        params.transfer = true;
        params.disposed = true;
        this._commonservice.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.addEquipment;
        this._commonservice.create(params).subscribe(res => {
            // Need to handle the fail scenario
        });

    }

    updateEquipment(params: Equipment) {
        const data = Object.assign(new Equipment(), this.selectedEquipment, params);
        this._commonservice.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.updateEquipment;
        this._commonservice.update('', data).subscribe(res => {
            // Need to handle the fail scenario
        });

    }

    enableEquipmentForm(action: boolean) {
        if (action) {
            this.equipmentformGroup.get('equipmenttypekey')?.enable();
            this.equipmentformGroup.get('manufacturer')?.enable();
            this.equipmentformGroup.get('model')?.enable();
            this.equipmentformGroup.get('serialnumber')?.enable();
            this.equipmentformGroup.get('whitetagnumber')?.enable();
            this.equipmentformGroup.get('yellowtagnumber')?.enable();
            this.equipmentformGroup.get('description')?.enable();
            this.equipmentformGroup.get('comments')?.enable();
            this.equipmentformGroup.get('dh60date')?.enable();
            this.equipmentformGroup.get('sutnumber')?.enable();
            this.equipmentformGroup.get('locationcode')?.enable();
            this.equipmentformGroup.get('upforreplacement')?.enable();
        } else {
            this.equipmentformGroup.get('equipmenttypekey')?.disable();
            this.equipmentformGroup.get('manufacturer')?.disable();
            this.equipmentformGroup.get('model')?.disable();
            this.equipmentformGroup.get('serialnumber')?.disable();
            this.equipmentformGroup.get('whitetagnumber')?.disable();
            this.equipmentformGroup.get('yellowtagnumber')?.disable();
            this.equipmentformGroup.get('description')?.disable();
            this.equipmentformGroup.get('comments')?.disable();
            this.equipmentformGroup.get('dh60date')?.disable();
            this.equipmentformGroup.get('sutnumber')?.disable();
            this.equipmentformGroup.get('locationcode')?.disable();
            this.equipmentformGroup.get('upforreplacement')?.disable();
        }

    }

}
