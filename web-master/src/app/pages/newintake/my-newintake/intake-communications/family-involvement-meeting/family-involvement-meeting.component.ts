
import {EMPTY, Observable, forkJoin } from 'rxjs';

import {share, map, pluck} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, AuthService, DataStoreService, GenericService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DSDSActionSummary, FamilyList, Fim, InvolvedPerson } from '../../_entities/newintakeModel';
import { NewUrlConfig } from '../../../newintake-url.config';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'family-involvement-meeting',
    templateUrl: './family-involvement-meeting.component.html',
    styleUrls: ['./family-involvement-meeting.component.scss'],
    standalone: false
})
export class FamilyInvolvementMeetingComponent implements OnInit {
    id: string;
    daNumber: string;
    isFim = false;
    meetingTypesDropdown$: Observable<DropdownModel[]>;
    familyMeetingTypesDropdown$: Observable<DropdownModel[]>;
    familyMeetingTypesDropdown: any[] = [];
    informalSupportDropdown$: Observable<DropdownModel[]>;
    ldssStaffDropdown$: Observable<DropdownModel[]>;
    schoolSystemDropdown$: Observable<DropdownModel[]>;
    involevedPerson$: Observable<InvolvedPerson[]>;
    familyIM: Fim;
    fimList$: Observable<FamilyList[]>;
    fimView: FamilyList;
    fimForm: FormGroup;
    lastParticipantsCall: any[];
    selectedFimType = [];
    fimSubType = [];
    minDate = new Date();
    dsdsActionsSummary = new DSDSActionSummary();
    showFollowUp = false;
    involvedDrop: boolean;
    otherPerticipants: boolean;
    selected = 'involvedPerson';
    removalfim = 'Removal FIM';
    vpafim = 'Voluntary Placement Agreement (VPA) FIM';
    private _authService: AuthService;
    constructor(
        private route: ActivatedRoute,
        private _alertService: AlertService,
        private _commonHttpService: CommonHttpService,
        private _formBuilder: FormBuilder,
        private _servicePlan: GenericService<Fim>,
        private _dataStoreService: DataStoreService,
        private injector: Injector
    ) {
        this._authService = this.injector.get<AuthService>(AuthService);
    }

    ngOnInit() {
        this.id = this.route.snapshot.parent.parent.parent.parent.parent.params['id'];
        this.daNumber = this.route.snapshot.parent.parent.parent.parent.parent.params['daNumber'];
        this.getPageList();
        this.getFimDropDown();
        this.getInvolvedPerson();
        this.fimForm = this._formBuilder.group({
            meetingdate: [new Date()],
            meetingtypekey: [null],
            persontype: [''],
            personname: [''],
            meetingdescription: [''],
            meetingcomments: [''],
            isfollowupmeeting: [null],
            followmeetingrecordingactor: [''],
            followmeetingdate: [null],
            parentmeetingid: [null],
            iscompleted: [1],
            participants: [''],
            meetingrecordingactor: [''],
            fimtype: [''],
            intakeserviceid: ['']
        });
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
        this._dataStoreService.currentStore.subscribe((store) => {
            if (store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
            }
        });
    }
    addServicePlan(fimModel) {
            fimModel.meetingrecordingactor = fimModel.meetingrecordingactor.map((res) => {
                return {
                    intakeservicerequestactorid: res.intakeservicerequestactorid,
                    personid: res.personid
                };
            });
            if (fimModel.followmeetingrecordingactor && fimModel.followmeetingrecordingactor.length) {
                fimModel.followmeetingrecordingactor = fimModel.followmeetingrecordingactor.map((resp) => {
                    return {
                        intakeservicerequestactorid: resp.intakeservicerequestactorid,
                        personid: resp.personid
                    };
                });
            }
            fimModel.fimtype = this.selectedFimType;
            if (fimModel.meetingparticipants.length > 0) {
                fimModel.meetingparticipants = fimModel.meetingparticipants.map((res) => {
                return {
                    participanttype: res.participanttype,
                    participantkey: res.participantkey,
                    firstname: res.firstname,
                    lastname: res.lastname,
                    emailid: res.emailid,
                    personid: res.personid,
                    isinvited: res.isinvited ? 1 : 0,
                    isattended: res.isattended ? 1 : 0,
                    isaccpted: res.isaccpted === '1' ? 1 : 0,
                    providerId: res.providerId
                };
            });
            this.familyIM = Object.assign(fimModel);
            this.familyIM.intakeserviceid = this.id;
            this._servicePlan.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Fim.AddParticipantUrl;
            this._servicePlan.create(this.familyIM).subscribe(
                (res) => {
                    this.getPageList();
                    (<any>$('#add-new-meeting')).modal('hide'); // NOSONAR
                    this.clearFim();
                    this._alertService.success('Participants Added successfully');
                },
                (error) => console.error(error)
            );
        } else {
            this._alertService.error('Please Add atleast One Participants');
       }
    }

    getFimType(fimType) {
        if (fimType === 'FIM') {
            this.isFim = true;
        } else {
            this.isFim = false;
        }
    }
    viewFim(family: FamilyList) {
        this.fimView = Object.assign(family);
    }
    
    getFullName(person) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
            if(person && person.hasOwnProperty(key)){
                if (person[key] !== null && person[key] !== 'null' && person[key] !== '') {
                    name = name + person[key] + ' ';
                }
            }
        });
        return name.trim();
      }

    clearFim() {
        this.fimForm.reset();
        this.selectedFimType = [];
        this.fimSubType = [];
        this.isFim = false;
        this.informalSupportDropdown$ = EMPTY;
        this.ldssStaffDropdown$ = EMPTY;
        this.schoolSystemDropdown$ = EMPTY;
        this.getFimDropDown();
        this.fimForm.setControl('meetingparticipants', this._formBuilder.array([]));
    }
    changeParticipants(event) {
        this.involvedDrop = true;
        this.otherPerticipants = false;
        if (event.source.selected && event.source.value !== this.lastParticipantsCall) {
            this.addMeetingParticipants(event.source.value);
            this.lastParticipantsCall = event.source.value;
        } else if (!event.source.selected) {
            const control = <FormArray>this.fimForm.controls['meetingparticipants'];
            control.controls.forEach((cont) => {
                const participantType = event.source.value.participanttype ? event.source.value.participanttype : 'IP';
                if (event.source.value.rolename === cont.value.participantkey && participantType === cont.value.participanttype) {
                    const removeIndex = control.controls.indexOf(cont);
                    this.deleteMeetingParticipants(removeIndex, event);
                }
            });
        } else {
            this.lastParticipantsCall = [];
        }
    }
    newParticipants(modal) {
        const role = [];
        role.push({ typedescription: modal.source.value.split('~')[2] });
        if (modal.checked) {
            const psrticip = Object.assign({
                rolename: modal.source.value.split('~')[1],
                parentrolename: modal.source.value.split('~')[0],
                roles: role
            });
            this.addMeetingParticipants(psrticip);
        } else {
            const control = <FormArray>this.fimForm.controls['meetingparticipants'];
            control.controls.forEach((cont) => {
                if (modal.source.value.split('~')[1] === cont.value.participantkey && modal.source.value.split('~')[0] === cont.value.participanttype) {
                    const removeIndex = control.controls.indexOf(cont);
                    this.deleteMeetingParticipants(removeIndex, modal);
                }
            });
        }
    }
    otherParticipants() {
        this.otherPerticipants = true;
        this.involvedDrop = false;
        const psrticip = Object.assign({
            rolename: '',
            parentrolename: '',
            roles: ''
        });
        this.addMeetingParticipants(psrticip);
    }
    deleteOthersMeetingParticipants(index: number) {
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        control.removeAt(index);
    }

    displayCaseworker(event) {
        if (event === 'Case worker') {
            const caseworkerName = this.dsdsActionsSummary.da_assignedto.split(',');
            this.fimForm.patchValue({ personname: caseworkerName[1] + ' ' + caseworkerName[0] });
            this.fimForm.get('personname').disable();
        } else {
            this.fimForm.get('personname').reset();
            this.fimForm.get('personname').enable();
        }
    }
    addMeetingParticipants(getROle) {
        let involvedpersontype = '';
        if (this.involvedDrop) {
            involvedpersontype = 'involvedperson';
        }
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        control.push(this.createFormGroup(getROle, involvedpersontype));
    }
    deleteMeetingParticipants(index: number, e) {
        const control = <FormArray>this.fimForm.controls['meetingparticipants'];
        control.removeAt(index);
    }

    onFimTypeChange(event) {
        this.fimSubType = event.value;
        this.selectedFimType = [];
        event.value.map((subType) => {
            if (!subType.familymeetingsubtype.length) {
                this.selectedFimType.push({
                    familymeetingtypekey: subType.familymeetingtypekey,
                    familymeetingsubtypekey: 'null'
                });
            }
        });
        if (this.selectedFimType.length !== event.value.length) {
            this.fimForm.markAsPristine();
        } else {
            this.fimForm.markAsDirty();
        }
        if (event.value.length) {
            this.ifEventValueLengthFn(event);
        } else {
            this.familyMeetingTypesDropdown.forEach((item) => {
                item.additionalProperty = false;
            });
        }
    }

    private ifEventValueLengthFn(event: any) {
        const fimType = this.fimForm.value.fimtype;
        if (event.value.filter((fim) => fim.familymeetingtypekey === this.removalfim)?.length) {
            this.ifRemovalfimFn(fimType);
        } else if (event.value.filter((fim) => fim.familymeetingtypekey === this.vpafim)?.length) {
            this.ifVpafimFn(fimType);
        } else {
            this.eventValueLengthFnElseCondFn(fimType);
        }
    }

    private eventValueLengthFnElseCondFn(fimType: any) {
        if (fimType && fimType.length) {
            fimType.forEach((fim, index) => {
                if (fim.familymeetingtypekey === this.removalfim || fim.familymeetingtypekey === this.vpafim) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey === this.removalfim || item.familymeetingtypekey === this.vpafim) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }

    private ifVpafimFn(fimType: any) {
        if (fimType && fimType.length) {
            fimType.forEach((fim, index) => {
                if (fim.familymeetingtypekey !== this.vpafim) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey !== this.vpafim) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }

    private ifRemovalfimFn(fimType: any) {
        if (fimType && fimType.length) {
            fimType.forEach((fim, index) => {
                if (fim.familymeetingtypekey !== this.removalfim) {
                    fimType.splice(index, 1);
                }
            });
            this.fimForm.patchValue({ primaryPlan: fimType });
        }
        this.familyMeetingTypesDropdown.forEach((item) => {
            if (item.familymeetingtypekey !== this.removalfim) {
                item.additionalProperty = true;
            } else {
                item.additionalProperty = false;
            }
        });
    }

    onFimSubTypeChange(event) {
        this.selectedFimType.push({
            familymeetingtypekey: event.value.familymeetingtypekey,
            familymeetingsubtypekey: event.value.familymeetingsubtypekey
        });
        this.fimForm.markAsDirty();
    }
    private createFormGroup(getROle, involvedpersontype) {
        return this._formBuilder.group({
            participanttype: [getROle.parentrolename ? getROle.parentrolename : 'IP'],
            participantkey: [getROle.rolename ? getROle.rolename : null],
            participantDesc: [getROle.roles ? getROle.roles[0].typedescription : null],
            firstname: [getROle.firstname ? getROle.firstname : null, Validators.required],
            lastname: [getROle.lastname ? getROle.lastname : null, Validators.required],
            emailid: [getROle.email ? getROle.email : null],
            personid: [null],
            isinvited: [''],
            isattended: [''],
            isaccpted: [''],
            providerId: [null],
            Persondropdown: [involvedpersontype]
        });
    }

    enableFollowUp(event) {
        this.showFollowUp = event === '1' ? true : false;
    }

    private getInvolvedPerson() {
        this.involevedPerson$ = this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: { intakeservreqid: this.id }
                },
                NewUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .InvolvedPersonListUrl +
               '?data'
            ).pipe(
            map((res) => {
                return res['data'];
            }));
    }

    private getFimDropDown() {
        const source = forkJoin([
            this._commonHttpService.getArrayList({}, NewUrlConfig.EndPoint.DSDSAction.Fim.MeetingTypesUrl),
            this._commonHttpService.getArrayList({ method: 'get' }, NewUrlConfig.EndPoint.DSDSAction.Fim.FamilyMeetingTypesUrl + '?filter'),
            this._commonHttpService.getArrayList(
                {
                    method: 'get'
                },
                NewUrlConfig.EndPoint.DSDSAction.Fim.ParticipantTypesUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    meetingType: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.meetingtypekey
                            })
                    ),
                    familyMeeting: result[1],
                    InformalSupport: result[2].filter((final) => final.participanttypekey === 'IS')[0].participantsubtype.map(
                        (resp) =>
                            new DropdownModel({
                                text: resp.typedescription,
                                value: resp.participanttypekey + '~' + resp.participantsubtypekey + '~' + resp.typedescription
                            })
                    ),
                    LdssStaff: result[2].filter((final) => final.participanttypekey === 'LDSS')[0].participantsubtype.map(
                        (response) =>
                            new DropdownModel({
                                text: response.typedescription,
                                value: response.participanttypekey + '~' + response.participantsubtypekey + '~' + response.typedescription
                            })
                    ),
                    SchoolSystem: result[2].filter((final) => final.participanttypekey === 'SS')[0].participantsubtype.map(
                        (payload) =>
                            new DropdownModel({
                                text: payload.typedescription,
                                value: payload.participanttypekey + '~' + payload.participantsubtypekey + '~' + payload.typedescription
                            })
                    )
                };
            }),
            share(),);
        this.meetingTypesDropdown$ = source.pipe(pluck('meetingType'));
        this.familyMeetingTypesDropdown$ = source.pipe(pluck('familyMeeting'));
        this.informalSupportDropdown$ = source.pipe(pluck('InformalSupport'));
        this.ldssStaffDropdown$ = source.pipe(pluck('LdssStaff'));
        this.schoolSystemDropdown$ = source.pipe(pluck('SchoolSystem'));
        this.familyMeetingTypesDropdown$.subscribe((res) => {
            res.forEach((item) => {
                item.additionalProperty = false;
            });
            this.familyMeetingTypesDropdown = res;
        });
    }

    private getPageList() {
         const isExpungementSuperUser = this._authService.isExpungementSuperUser();
         const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.fimList$ = this._commonHttpService
            .getArrayList(
                {
                    where: { intakeserviceid: this.id, 'isExpungementSuperUser': isExpungementSuperUser, 'iscaseexpunged': iscaseexpunged },
                    method: 'get',
                    count: -1,
                    page: 1,
                    limit: 20
                },
                NewUrlConfig.EndPoint.DSDSAction.Fim.FimListUrl + '?filter'
            ).pipe(
            map((res) => {
                return res;
            }));
    }
}
