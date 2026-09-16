
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin ,  Observable ,  Subject } from 'rxjs';
import { UpdateProfileDetails, PositionDetail, Userprofileidentifier,
     Userprofilephonenumber, UserRoleProfile, MainUserProfile, UserRoles, MainUserProfileAddress } from '../../../admin/user-security-profile/_entites/user-security-profile.data.modal';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { ValidationService, CommonHttpService, AlertService, DataStoreService } from '../../../../@core/services';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { AdminUrlConfig } from '../../../admin/admin-url.config';
import { FormControl } from '@angular/forms';



declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'user-profile',
    templateUrl: './user-profile.component.html',
    styleUrls: ['./user-profile.component.scss'],
    standalone: false
})
export class UserProfileComponent implements OnInit {
    @Input() id!: Subject<string>;
    @Input() emailSubject!: Subject<string>;
    @Input() userRoles!: Subject<UpdateProfileDetails>;
    @Input() positionTeammember$!: Subject<PositionDetail>;
    addUserProfileForm!: FormGroup;
    saveButton!: boolean;
    principalid!: string;
    teamTypeKey!: string;
    teamId!: string;
    positionDetail!: PositionDetail;
    countyDropDownItems$!: Observable<DropdownModel[]>;
    stateDropDownItems$!: Observable<DropdownModel[]>;
    userGendar$!: Observable<DropdownModel[]>;
    userWorkStatus$!: Observable<DropdownModel[]>;
    userType$!: Observable<DropdownModel[]>;
    agencyList$!: Observable<DropdownModel[]>;
    TeamList$!: Observable<DropdownModel[]>;
    userJobTitle$!: Observable<DropdownModel[]>;
    posirionList$!: Observable<PositionDetail[]>;
    addUserprofileidentifier: Userprofileidentifier[] = [];
    addUserprofilephonenumber: Userprofilephonenumber[] = [];
    addUpdateUserProfile: UserRoleProfile = new UserRoleProfile();
    editSecurityDetails: UpdateProfileDetails = new UpdateProfileDetails();
    updateBasicProfileDetails: MainUserProfile = new MainUserProfile();
    userPhoneNumber: Userprofilephonenumber[] = [];
    userIdentifier: Userprofileidentifier[] = [];
    securityRoles: UserRoles = new UserRoles();
    updateUserProfileAddress: MainUserProfileAddress = new MainUserProfileAddress();
    addsecurityrolestabref = '.nav-tabs a[href="#add-security-roles"]';
    // tslint:disable-next-line:max-line-length
    constructor(private route: ActivatedRoute, private router: Router, private formBuilder: FormBuilder, private _commonHttp: CommonHttpService, private _alertService: AlertService, private _dataStore: DataStoreService) {}

    ngOnInit() {
        this.saveButton = false;
        this.formInitilize();
        this.getAgencyList();
        this.loadDropdownItems();
        this.id.subscribe((item: any) => {
            this.principalid = item;
            if (this.principalid !== '0') {
                this.editUserProfile();
            }
            $('#add-newusers-popup').modal('show');
        });
        this.addUserProfileForm.controls['teamtypekey'].disable();
        this.addUserProfileForm.controls['teamid'].disable();
        this.addUserProfileForm.controls['teammemberid'].disable();
    }
    formInitilize() {
        this.addUserProfileForm = this.formBuilder.group({
            firstname: ['', [Validators.required, ValidationService.nameValidator]],
            middlename: [''],
            lastname: ['', [Validators.required, ValidationService.nameValidator]],
            displayname: ['', [Validators.required, ValidationService.nameValidator]],
            dob: ['', [Validators.required, Validators.minLength(1)]],
            ssn: [''],
            dcn: [''],
            email: ['', [Validators.required, ValidationService.mailFormat]],
            autonotification: [''],
            usertypekey: ['', Validators.required],
            userworkstatustypekey: [''],
            gendertypekey: ['', Validators.required],
            insertedon: [new Date()],
            mainofficephone: [''],
            directlinephone: [''],
            faxnumber: [''],
            businesscell: [''],
            businesspage: [''],
            pobox: [''],
            address: [''],
            city: [''],
            state: [''],
            zipcode: [''],
            countyid: [''],
            county: [''],
            locationcode: [''],
            jobtitlecd: [''],
            userprofileidentifierid: [''],
            userprofilephonenumberid: [''],
            teamtypekey: [''],
            teamid: [''],
            teammemberid: [''],
            primarycountyid: ['']
        });
        this.addUserProfileForm.disable();
    }

    private loadDropdownItems() {
        const source = forkJoin([
            this._commonHttp.create(
                {
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.CountryListUrl
            ),
            this._commonHttp.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                NewUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
            ),
            this._commonHttp.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                'admin/usertype?filter'
            ),
            this._commonHttp.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                'admin/userworkstatustype?filter'
            ),
            this._commonHttp.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                'admin/gendertype?filter'
            ),
            this._commonHttp.getArrayList(
                {
                    method: 'get',
                    where: { referencetypeid: 902 },
                    nolimit: true
                },
                'referencetype/gettypes?filter'
            )
        ]).pipe(
            map((result: any) => {
                return {
                    counties: result[0].map(
                        (res: { countyname: any; countyid: any; }) =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyid
                            })
                    ),
                    stateList: result[1].map(
                        (res: { statename: any; stateabbr: any; }) =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateabbr
                            })
                    ),
                    usertype: result[2].map(
                        (res: { typedescription: any; usertypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.usertypekey
                            })
                    ),
                    userworkstatustype: result[3].map(
                        (res: { typedescription: any; userworkstatustypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.userworkstatustypekey
                            })
                    ),
                    gendertype: result[4].map(
                        (res: { typedescription: any; gendertypekey: any; }) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.gendertypekey
                            })
                    ),
                    jobtitle: result[5].map(
                        (res: { description: any; ref_key: any; }) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.ref_key
                            })
                    )
                };
            }),
            share(),);
        this.countyDropDownItems$ = source.pipe(pluck('counties'));
        this.stateDropDownItems$ = source.pipe(pluck('stateList'));
        this.userType$ = source.pipe(pluck('usertype'));
        this.userWorkStatus$ = source.pipe(pluck('userworkstatustype'));
        this.userGendar$ = source.pipe(pluck('gendertype'));
        this.userJobTitle$ = source.pipe(pluck('jobtitle'));
    }

    userProfileIdentifier(control: any, identifier: string) {
        const idvalue = control.target.value;
        if (identifier === 'SSN' || identifier === 'DCN') {          
            this.isCheckIdentifier(idvalue, identifier);       
        }
    }
    countyChange(modal: any) {
        if (modal) {
            this.addUserProfileForm.value.county = modal;
        }
    }
    getAgencyList() {
        this.agencyList$ = this._commonHttp
            .getArrayList(
                {
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.UserProfile.AgencyListUrl + '?filter'
            ).pipe(
            map((result: any) => {
                return result.map(
                    (res: { description: any; teamtypekey: any; }) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.teamtypekey
                        })
                );
            }));
    }
    agencyChange() {
        if (this.addUserProfileForm.value.teamtypekey) {
            this.teamTypeKey = this.addUserProfileForm.value.teamtypekey;
            this.TeamList$ = this._commonHttp
                .getArrayList(
                    {
                        method: 'get',
                        where: {
                            teamtypekey: this.teamTypeKey
                        }
                    },
                    AdminUrlConfig.EndPoint.UserProfile.TeamListUrl + '?filter'
                ).pipe(
                map((result: any) => {
                    return result.map(
                        (res: { name: any; id: any; }) =>
                            new DropdownModel({
                                text: res.name,
                                value: res.id
                            })
                    );
                }));
        } else {
            this.addUserProfileForm.patchValue({ teamid: '' });
        }
    }
    teamChange() {
        if (this.addUserProfileForm.value.teamid) {
            this.teamId = this.addUserProfileForm.value.teamid;
            this.posirionList$ = this._commonHttp.getArrayList({}, AdminUrlConfig.EndPoint.UserProfile.PositionList + this.teamId).pipe(map((result) => {
                return result;
            }));
        } else {
            this.addUserProfileForm.patchValue({
                teammemberid: ''
            });
        }
    }
    
    changePosition(event: any) {
        this.posirionList$.subscribe((data: any) => {
            data.forEach((teamData: any) => {
                if (teamData.teammemberid === event.value) {
                    this.positionTeammember$.next(teamData);
                }
            });
        });
        this.positionTeammember$.next(this.positionDetail);
    }

    isCheckIdentifier(idvalue: any, identifier: string) {
        const sssnValue = idvalue
            .match(/\d+/g)
            .map(Number)
            .join('');

        this.userIdentifier.forEach((item) => {
            if (item.userprofileidentifiertypekey === identifier) {
                this.addUserProfileForm.patchValue({ userprofileidentifierid: item.userprofileidentifierid ? item.userprofileidentifierid : '' });
            } else {
                this.addUserProfileForm.patchValue({ userprofileidentifierid: '' });
            }
        });
        if (this.addUserProfileForm.value.userprofileidentifierid === '') {
            const modal = {
                userprofileidentifiertypekey: identifier,
                userprofileidentifiervalue: sssnValue
            };

            this.addUserprofileidentifier = this.addUserprofileidentifier.filter((item) => item.userprofileidentifiertypekey !== identifier);
            if (idvalue) {
                this.addUserprofileidentifier.push(modal);
            }
        } else {
            const modal = {
                userprofileidentifierid: this.addUserProfileForm.value.userprofileidentifierid,
                userprofileidentifiertypekey: identifier,
                userprofileidentifiervalue: sssnValue
            };
            this.addUserprofileidentifier = this.addUserprofileidentifier.filter((item) => item.userprofileidentifiertypekey !== identifier);
            if (idvalue) {
                this.addUserprofileidentifier.push(modal);
            }
        }
    }

    userProfilePhoneNumber(control: any, identifier: string) {
        const idvalue = control.target.value;
        if (identifier === 'office' || identifier === 'DirectLine' || identifier === 'fax' || identifier === 'cell' || identifier === 'pager') {
            this.isCheckPhoneNumber(idvalue, identifier);
        }
    }

    isCheckPhoneNumber(idvalue: any, identifier: string) {
        const contactNumber = idvalue
            .match(/\d+/g)
            .map(Number)
            .join('');
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === identifier) {
                this.addUserProfileForm.patchValue({ userprofilephonenumberid: item.userprofilephonenumberid ? item.userprofilephonenumberid : '' });
            } else {
                this.addUserProfileForm.patchValue({ userprofilephonenumberid: '' });
            }
        });
        if (this.addUserProfileForm.value.userprofilephonenumberid === '') {
            const modal = {
                userprofiletypekey: identifier,
                phonenumber: contactNumber
            };
            this.addUserprofilephonenumber = this.addUserprofilephonenumber.filter((item) => item.userprofiletypekey !== identifier);
            if (idvalue) {
                this.addUserprofilephonenumber.push(modal);
            }
        } else {
            const modal = {
                userprofilephonenumberid: this.addUserProfileForm.value.userprofilephonenumberid,
                userprofiletypekey: identifier,
                phonenumber: contactNumber
            };
            this.addUserprofilephonenumber = this.addUserprofilephonenumber.filter((item) => item.userprofiletypekey !== identifier);
            if (idvalue) {
                this.addUserprofilephonenumber.push(modal);
            }
        }
    }
    closeUserProfile() {
       $('#add-newusers-popup').modal('hide');
        const currentUrl = 'pages/admin/user-security-profile';
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
    }
    editUserProfile() {
        let roledescription: string;
        this.saveButton = true;
        this.addUserProfileForm.reset(); 
        this.addUserProfileForm.controls['email'].disable();
        this._commonHttp.getById(this.principalid, 'users/getuser').subscribe((result: any) => {
            this.editSecurityDetails = result;
            this.updateBasicProfileDetails = result?.userprofile || new UpdateProfileDetails();
            if (result.role) {
                this.securityRoles = result.role;
                if (result.role.role.description) {
                    roledescription =  this.securityRoles.role.description;
                }
            }
            this.userPhoneNumber = result?.userprofile?.userprofilephonenumber || [];
            const userprofileaddress = result?.userprofile?.userprofileaddress || [];
            // tslint:disable-next-line:max-line-length
            this.updateUserProfileAddress = userprofileaddress.length ? userprofileaddress[0] : new MainUserProfileAddress();
            this.userIdentifier = result?.userprofile?.userprofileidentifier || [];
            this.userRoles.next(this.editSecurityDetails);
            this.addUserProfileForm.patchValue(this.editUserProfileFormPatchData());

            if (this.updateUserProfileAddress.county) {
                this.countyChange(this.updateUserProfileAddress.county);
            }
            if (this.editSecurityDetails?.userprofile?.teammemberassignment) {
                this.teammemberassignmentPatchData(roledescription);
            }
            this.phoneNumberPatchData();
            this.userIdentifierPatchData();
        });
    }
    
    private userIdentifierPatchData() {
        this.userIdentifier.forEach((item) => {
            if (item.userprofileidentifiertypekey === 'SSN') {
                this.addUserProfileForm.patchValue({ ssn: item.userprofileidentifiervalue });
            }
        });
        this.userIdentifier.forEach((item) => {
            if (item.userprofileidentifiertypekey === 'DCN') {
                this.addUserProfileForm.patchValue({ dcn: item.userprofileidentifiervalue });
            }
        });
        this.addUserprofileidentifier = this.userIdentifier;
    }

    private phoneNumberPatchData() {
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === 'office') {
                this.addUserProfileForm.patchValue({ mainofficephone: item.phonenumber });
            }
        });
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === 'DirectLine') {
                this.addUserProfileForm.patchValue({ directlinephone: item.phonenumber });
            }
        });
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === 'fax') {
                this.addUserProfileForm.patchValue({ faxnumber: item.phonenumber });
            }
        });
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === 'cell') {
                this.addUserProfileForm.patchValue({ businesscell: item.phonenumber });
            }
        });
        this.userPhoneNumber.forEach((item) => {
            if (item.userprofiletypekey === 'pager') {
                this.addUserProfileForm.patchValue({ businesspage: item.phonenumber });
            }
        });
        this.addUserprofilephonenumber = this.userPhoneNumber;
    }

    private teammemberassignmentPatchData(roledescription: any) {
        const teammemberassignment: any = this.editSecurityDetails.userprofile.teammemberassignment;

        this.addUserProfileForm.patchValue({
            teamtypekey: teammemberassignment.length > 0 ? teammemberassignment[0].teammember.team.teamtype.teamtypekey : null
        });
        this.agencyChange();
        this.addUserProfileForm.patchValue({
            teamid: teammemberassignment.length > 0 ? teammemberassignment[0].teammember.team.name : null
            // teamid: this.editSecurityDetails.userprofile.teammemberassignment.teammember.team.id
        });
        this.teamChange();
        this.addUserProfileForm.patchValue({
            teammemberid: roledescription
        });
    }
    // Assosiated to editUserProfile method
    private editUserProfileFormPatchData() {
        return {
            ...this.checkAndReturnUserProfileDetailsFn(),
            email: this.editSecurityDetails.email,
            ...this.checkAndReturnUserAddressDetailsFn(),
        };
    }
    // Assosiated to editUserProfile method
    private checkAndReturnUserAddressDetailsFn() {
        return {
            pobox: this.updateUserProfileAddress.pobox,
            address: this.updateUserProfileAddress.address,
            city: this.updateUserProfileAddress.city,
            state: this.updateUserProfileAddress.state,
            zipcode: this.updateUserProfileAddress.zipcode,
            countyid: this.updateUserProfileAddress.countyid,
            county: this.updateUserProfileAddress.county,
            locationcode: this.updateUserProfileAddress.zipcodeplus
        };
    }
    // Assosiated to editUserProfile method
    private checkAndReturnUserProfileDetailsFn() {
        return {
            firstname: this.updateBasicProfileDetails.firstname,
            middlename: this.updateBasicProfileDetails.middlename,
            lastname: this.updateBasicProfileDetails.lastname,
            displayname: this.updateBasicProfileDetails.displayname,
            dob: new Date(this.updateBasicProfileDetails.dob),
            ssn: this.updateBasicProfileDetails.ssn,
            autonotification: this.updateBasicProfileDetails.autonotification,
            usertypekey: this.updateBasicProfileDetails.usertypekey,
            userworkstatustypekey: this.updateBasicProfileDetails.userworkstatustypekey,
            gendertypekey: this.updateBasicProfileDetails.gendertypekey,
            jobtitlecd: this.updateBasicProfileDetails.jobtitlecd,
            primarycountyid: this.updateBasicProfileDetails.primarycountyid
        };
    }

    saveProfile(modal: UserRoleProfile) {
        if (this.addUserProfileForm.dirty && this.addUserProfileForm.valid) {
            this.addUpdateUserProfile.User = {
                firstname: this.addUserProfileForm.value.firstname,
                middlename: this.addUserProfileForm.value.middlename,
                lastname: this.addUserProfileForm.value.lastname,
                displayname: this.addUserProfileForm.value.displayname,
                fullname: this.addUserProfileForm.value.firstname + ' ' + this.addUserProfileForm.value.lastname,
                email: this.addUserProfileForm.value.email,
                isavailable: 'Y',
                userworkstatustypekey: this.addUserProfileForm.value.userworkstatustypekey,
                usertypekey: this.addUserProfileForm.value.usertypekey,
                autonotification: this.addUserProfileForm.value.autonotification,
                gendertypekey: this.addUserProfileForm.value.gendertypekey,
                dob: this.addUserProfileForm.value.dob,
                userphoto: '',
                teamtypekey: this.addUserProfileForm.value.teamtypekey,
                jobtitlecd: this.addUserProfileForm.value.jobtitlecd,
                primarycountyid: this.addUserProfileForm.value.primarycountyid
            };
            this.addUpdateUserProfile.Userprofileaddress = {
                userprofileaddresstypekey: 'P',
                address: this.addUserProfileForm.value.address,
                pobox: this.addUserProfileForm.value.pobox,
                city: this.addUserProfileForm.value.city,
                state: this.addUserProfileForm.value.state,
                zipcode: this.addUserProfileForm.value.zipcode,
                county: this.addUserProfileForm.value.county,
                countyid: this.addUserProfileForm.value.countyid
            };
            this.addUpdateUserProfile.Userprofileidentifier = this.addUserprofileidentifier;
            this.addUpdateUserProfile.Userprofilephonenumber = this.addUserprofilephonenumber;
            this.addUpdateUserProfile.teammemberid = this.addUserProfileForm.value.teammemberid;
            this._commonHttp.create(this.addUpdateUserProfile, 'admin/userprofile/addupdate').subscribe((result: { data: any; user: { securityusersid: any; }; }) => {
                if (result) {
                    if (result.data && result.data.length) {
                        this.id.next(result.user.securityusersid);
                        this.saveButton = true;
                        this.emailSubject.next(this.addUserProfileForm.value.email);
                        $(this.addsecurityrolestabref).tab('show');
                    } else {
                        this._alertService.error('Unable to save the user profile.');
                    }
                }
            });
        }
    }
    updateProfile(modal: UserRoleProfile) {
        if (this.addUserProfileForm.dirty && this.addUserProfileForm.valid) {
            $(this.addsecurityrolestabref).tab('show');
            this.emailSubject.next(this.editSecurityDetails.email);
            this.addUpdateUserProfile.User = {
                securityusersid: this.updateBasicProfileDetails.securityusersid,
                firstname: this.addUserProfileForm.value.firstname,
                middlename: this.addUserProfileForm.value.middlename,
                lastname: this.addUserProfileForm.value.lastname,
                displayname: this.addUserProfileForm.value.displayname,
                fullname: this.addUserProfileForm.value.firstname + ' ' + this.addUserProfileForm.value.lastname,
                email: this.addUserProfileForm.value.email,
                isavailable: 'Y',
                userworkstatustypekey: this.addUserProfileForm.value.userworkstatustypekey,
                usertypekey: this.addUserProfileForm.value.usertypekey,
                autonotification: this.addUserProfileForm.value.autonotification,
                gendertypekey: this.addUserProfileForm.value.gendertypekey,
                dob: this.addUserProfileForm.value.dob,
                userphoto: '',
                teamtypekey: this.addUserProfileForm.value.teamtypekey,
                jobtitlecd: this.addUserProfileForm.value.jobtitlecd,
                primarycountyid: this.addUserProfileForm.value.primarycountyid
            };
            this.addUpdateUserProfile.Userprofileaddress = {
                securityusersid: this.updateBasicProfileDetails.securityusersid,
                userprofileaddressid: this.updateUserProfileAddress.userprofileaddressid,
                userprofileaddresstypekey: 'P',
                address: this.addUserProfileForm.value.address,
                pobox: this.addUserProfileForm.value.pobox,
                city: this.addUserProfileForm.value.city,
                state: this.addUserProfileForm.value.state,
                zipcode: this.addUserProfileForm.value.zipcode,
                county: this.addUserProfileForm.value.county,
                countyid: this.addUserProfileForm.value.countyid
            };
            this.addUpdateUserProfile.Userprofileidentifier = this.addUserprofileidentifier;
            this.addUpdateUserProfile.Userprofilephonenumber = this.addUserprofilephonenumber;
            this.addUpdateUserProfile.teammemberid = this.addUserProfileForm.value.teammemberid;
            this._commonHttp.create(this.addUpdateUserProfile, 'admin/userprofile/addupdate').subscribe((result: { data: any; }) => {
                if (result) {
                    if (result.data && result.data.length) {
                        this.saveButton = true;
                        this._alertService.success('User details updated successfully.');
                        $(this.addsecurityrolestabref).tab('show');
                    } else {
                        this._alertService.error('Unable to save the user profile.');
                    }
                }
            });
        }
    }

    getControlByIndexFn(index: string): FormControl {
        return this.addUserProfileForm.controls[index] as FormControl;
    }
}
