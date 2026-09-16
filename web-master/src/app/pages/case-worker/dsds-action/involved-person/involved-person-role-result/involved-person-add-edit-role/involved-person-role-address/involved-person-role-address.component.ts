
import {pluck, map, share} from 'rxjs/operators';
import { Component, Input, OnInit, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { forkJoin ,  Observable } from 'rxjs';

import { DropdownModel } from '../../../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { PersonAddress, PersonDetail, PersonPhone } from '../../../_entities/involvedperson.data.model';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-role-address',
    templateUrl: './involved-person-role-address.component.html',
    styleUrls: ['./involved-person-role-address.component.scss']
})
export class InvolvedPersonRoleAddressComponent implements OnInit {
    @Input() addedAddress: PersonAddress[] = [];
    @Input() addedPhone: PersonPhone[] = [];
    @Input() person$: Observable<PersonDetail>;
    @Output() personAddressChanged = new EventEmitter<PersonAddress[]>();
    @Output() personPhoneChanged = new EventEmitter<PersonPhone[]>();

    personId: string;
    phoneDropdownItems$: Observable<DropdownModel[]>;
    addressDropdownItems$: Observable<DropdownModel[]>;
    zipcodeDropdownItems$: Observable<DropdownModel[]>;
    stateDropdownItems$: Observable<DropdownModel[]>;
    countyDropdownItems$: Observable<DropdownModel[]>;
    personAddressFormGroup: FormGroup;
    private personPhone: PersonPhone = new PersonPhone();
    private personAddress: PersonAddress = new PersonAddress();

    constructor(
        private _commonHttpService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        route: ActivatedRoute
    ) {
        this.personId = route.snapshot.params.personid;
    }

    ngOnInit() {
        this.personAddressFormBuilderGroup();
        this.involvedAddressDropdown();
        if (this.personId !== '0') {
            this.person$.subscribe(result => {
                result.data.personbasicdetails.personphonenumber.forEach(
                    (phone: PersonPhone) => {
                        return this.addedPhone.push(phone);
                    }
                );
                result.data.personbasicdetails.personaddress.forEach(
                    (address: PersonAddress) => {
                        return this.addedAddress.push(address);
                    }
                );
            });
        }
    }

    personAddressFormBuilderGroup() {
        this.personAddressFormGroup = this.formBuilder.group({
            personAddress: this.formBuilder.group({
                personaddresstypekey: ['', Validators.required],
                address: ['', Validators.required],
                address2: [''],
                city: ['', Validators.required],
                state: ['', Validators.required],
                zipcode: ['', Validators.required],
                county: [''],
                country: ['', Validators.required],
                directions: [''],
                danger: [''],
                dangerreason: ['']
            }),
            personPhone: this.formBuilder.group({
                personphonetypekey: ['', Validators.required],
                phonenumber: ['', Validators.required],
                phoneextension: ['']
            })
        });
        this.personAddressFormGroup.get('personAddress.dangerreason').disable();
    }

    addPhoneNumber(personPhone: PersonPhone) {
        if (
            this.personAddressFormGroup.get('personPhone').valid &&
            this.personAddressFormGroup.get('personPhone').dirty
        ) {
            this.personPhone.insertedby = 'default';
            this.personPhone.effectivedate = new Date();
            this.personPhone.activeflag = 1;
                this.addedPhone.push(
                    Object.assign(this.personPhone, personPhone)
                );
            this.addedPhone.forEach((item, ix) => {
                item.index = ix;
                return item;
            });
            this.clearPersonPhone();
            this._alertService.success('Person Phone added Successfully');
            this.personPhoneChanged.emit(this.addedPhone);
            this.personPhone = Object.assign({});
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }
    phoneNumberOnChange(option) {
        this.personPhone.Personphonetype = Object.assign({
            typedescription: option.label
        });
    }
    clearPersonPhone() {
        this.personAddressFormGroup.get('personPhone').reset();
    }
    confirmDeletePhone(personPhone: PersonPhone) {
        this.personPhone.index = personPhone.index;
        this.addedPhone.splice(personPhone.index, 1);
        this.clearPersonPhone();
        this.addedPhone = this.addedPhone.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.personPhoneChanged.emit(this.addedPhone);
    }

    addressTypeOnChange(option) {
        this.personAddress.Personaddresstype = Object.assign({
            typedescription: option.label
        });
    }
    stateOnChange(option) {
        this.personAddress.statetext = option.label;
    }
    countyOnChange(option) {
        this.personAddress.countytext = option.label;
    }
    countryOnChange(option) {
        this.personAddress.countrytext = option.label;
    }

    addAddress(personAddress: PersonAddress) {
        if (
            this.personAddressFormGroup.get('personAddress').valid &&
            this.personAddressFormGroup.get('personAddress').dirty
        ) {
            if (!this.personAddressFormGroup.value.personAddress.danger) {
                this._alertService.error('Please Select Danger to address');
                return false;
            }
            this.personAddress.updatedby = 'default';
            this.personAddress.insertedby = 'default';
            this.personAddress.effectivedate = new Date();
            this.personAddress.activeflag = 1;
            if (personAddress.danger === 'null') {
                personAddress.danger = null;
            }
            this.addedAddress.push(
                Object.assign(this.personAddress, personAddress)
            );
            this.addedAddress.forEach((item, ix) => {
                item.index = ix;
                return item;
            });
            this.clearPersonAddress();
            this._alertService.success('Person Address added successfully');
            this.personAddressChanged.emit(this.addedAddress);
            this.personAddress = Object.assign({});
        } else {
            this._alertService.warn('Please fill mandatory fields!');
        }
    }
    clearPersonAddress() {
        this.personAddressFormGroup.get('personAddress').reset();
    }

    confirmDeleteAddress(personAddress: PersonAddress) {
        this.personAddress.index = personAddress.index;
        this.addedAddress.splice(personAddress.index, 1);
        this.clearPersonAddress();
        this.addedAddress = this.addedAddress.map((item, ix) => {
            item.index = ix;
            return item;
        });
        this.personAddressChanged.emit(this.addedAddress);
    }

    private involvedAddressDropdown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .PersonPhoneTypeUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    order: 'decription asc',
                    nolimit : true,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .PersonAddressUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .StateListUrl + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: '1' },
                    method: 'get',
                    nolimit: true,
                    order: 'countyname asc'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .CountyListUrl + '?filter'
            )
        ]).pipe(
            map(result => {
                return {
                    phone: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.personphonetypekey
                            })
                    ),
                    address: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.personaddresstypekey
                            })
                    ),
                    states: result[2].map(
                        res =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateabbr
                            })
                    ),
                    county: result[3].map(
                        res =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    )
                };
            }),
            share(),);

        this.phoneDropdownItems$ = source.pipe(pluck('phone'));
        this.addressDropdownItems$ = source.pipe(pluck('address'));
        this.stateDropdownItems$ = source.pipe(pluck('states'));
        this.countyDropdownItems$ = source.pipe(pluck('county'));
    }
}
