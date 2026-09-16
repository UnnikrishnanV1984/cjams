
import {EMPTY,  Observable ,  Subject } from 'rxjs';

import {pluck, share, map} from 'rxjs/operators';
import { ChangeDetectorRef, Component, Injector, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';

import { ObjectUtils } from '../../../@core/common/initializer';
import { DropdownModel, PaginationRequest, PaginationInfo, ListDataItem } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../@core/entities/constants';
import { AlertService, DataStoreService } from '../../../@core/services';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { CountyDetails, ReAssignmentDetails, TeamDetails, TeamPositionDetails } from '../../admin/team-position/_entities/teamposition.data.model';
import { AdminUrlConfig } from '../admin-url.config';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'team-setup-detail',
    templateUrl: './team-setup-detail.component.html',
    styleUrls: ['./team-setup-detail.component.scss'],
    standalone: false
})
export class TeamSetupDetailComponent implements OnInit {
    closingTimeHours = '';
    openingTimeHours = '';
    loadNumber: string | undefined;
    teamId: string | undefined;
    newPostionCode: string | undefined;
    @Input() reloadTreeSubject = new Subject();
    @Input() selectedTreeSubject = new Subject();
    @Input() teamDetails$: Observable<TeamDetails> = new Observable<TeamDetails>();
    @Input() selectedTeamId = new Subject<string>();
    @Input() totalCount$ = new Subject<any>();
    @Input() pageChangedRequest$ = new Subject<any>();
    @Input() teamMemeberDetails: TeamDetails = new TeamDetails();
    @Input() emailSearch$ = new Subject<string>();
    paginationInfo = new PaginationInfo();
    totalRecordCount!: number;
    tempTeamId!: string;
    actionLabel!: string;
    teamDetailLabel!: string;
    teamFormGroup!: FormGroup;
    zipCodeFormGroup!: FormGroup;
    teamPositionFormGroup!: FormGroup;
    reAssignmentFormGroup!: FormGroup;
    emailSearch!: FormGroup;
    region:any = '';
    countyName:any = '';
    zipCodemodelBox = {};
    teamMemberId:any = '';
    firstName!: '';
    lastName!: '';
    positionCode!: '';
    showModelBox = false;
    teamDetail!: TeamDetails[];
    teamDetailData: any = new TeamDetails();
    teamMemberDetailData = new TeamPositionDetails();
    reAssignmentData = new ReAssignmentDetails();
    deleteReAssignmentData = new ReAssignmentDetails();
    countyList!: TeamPositionDetails;
    countyData: Array<any> = [];
    getEntityCategoryList!: DropdownModel[];
    countyLists: CountyDetails[] = [];
    leftItems: CountyDetails[] = [];
    rightItems: CountyDetails[] = [];
    teamTypes!: TeamDetails[];
    parentTeam$!: Observable<ListDataItem<TeamDetails>>;
    teamList$!: Observable<TeamDetails[]>;
    positionTeamlist: Array<any> = [];
    positionList$!: Observable<DropdownModel[]>;
    countyList$!: Observable<CountyDetails[]>;
    countyListBox$!: Observable<CountyDetails[]>;
    religionList$!: Observable<TeamDetails[]>;
    assignmentList$!: Observable<ReAssignmentDetails>;
    assignmentSearchList$!: Observable<ReAssignmentDetails[]>;
    private rightSelectedItems: CountyDetails[] = [];
    private leftSelectedItems: CountyDetails[] = [];
    userDetailsForm!: FormGroup;
    teammemberId!: string | null;
    searchUserDetails$!: Observable<ReAssignmentDetails[]>;
    userListTotalCount: any;
    userForm!: FormGroup;
    noPageChangeCall: boolean = true;
    private formBuilder: FormBuilder;
    private _service: GenericService<TeamDetails>;
    private _zipCodeService: GenericService<CountyDetails>;
    private _teamPositionService: GenericService<TeamPositionDetails>;
    private _reAssignmentService: GenericService<ReAssignmentDetails>;
    private _commonService: CommonHttpService;
    private _changeDetect: ChangeDetectorRef;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    constructor(private injector : Injector) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._service = this.injector.get<GenericService<TeamDetails>>(GenericService);
        this._zipCodeService = this.injector.get<GenericService<CountyDetails>>(GenericService);
        this._teamPositionService = this.injector.get<GenericService<TeamPositionDetails>>(GenericService);
        this._reAssignmentService = this.injector.get<GenericService<ReAssignmentDetails>>(GenericService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamDetailsUrl;
    }
    deletepopupid = '#delete-popup';
    noitemselectedmsg = 'No items selected.';
    ngOnInit() {
        this.zipCodeFormGroup = this.formBuilder.group({
            leftSelectedItems: [''],
            rightSelectedItems: ['']
        });
        this.getReligionList();
        this.getTeamTypes();
        this.getParentTeam();
        this.getCountyList();
        this.getTeams();

        this.region = undefined;
        this.countyName = undefined;
        this.getCountyItem();
        this.showModelBox = false;
        this.selectedTeamId.subscribe((result) => {
            this.tempTeamId = result;
            this.loadNumber = '';
            this.showModelBox = false;
        });
        this.totalCount$.subscribe((item) => {
           this.totalRecordCount = item;
        });
        this._dataStoreService.currentStore.subscribe((item) => {
            if (item['Pagination_Reset']) {
                this.paginationInfo.pageNumber = 1;
            }
            if (item['Email_Search_Reset']) {
                this.emailSearch.patchValue({
                    email: null
                });
            }
        });
        this.teamFormGroup = this.formBuilder.group(
            {
                id: [''],
                teamname: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                teamnumber: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                teamtypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                countyid: ['', [Validators.required]],
                region: [''],
                name: '',
                activeflag: 1,
                description: [''],
                officetimingfrom: [null],
                // openingTimeHour: [''],
                // openingTimeMinute: [0],
                // closingTimeHour: [''],
                // closingTimeMinute: [0],
                officetimingto: [null],
                parentteamid: null,
                insertedby: '',
                updatedby: '',
                // effectivedate: [null, [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                // expirationdate: null
            }
        );
        this.teamPositionFormGroup = this.formBuilder.group(
            {
                teamid: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                roletypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                loadnumber: [''],
                teammemberid: '',
                positioncode: ['', Validators.required],
                activeflag: 1,
                description: [''],
                isoncall: [true],
                insertedby: '',
                updatedby: '',
                effectivedate: [''],
                expirationdate: [''],
                linenumber: '',
                rtfdate: [''],
                coadate: [''],
                firstname: [''],
                lastname: [''],
                securityusersid: [''],
                userid: [''],
                isVacant: [false]
            },
            { validators: this.editPositioncheckDateRange }
        );
        this.reAssignmentFormGroup = this.formBuilder.group({
            id: null,
            teammemberassignmentid: '',
            teammemberid: '',
            securityusersid: '',
            securityusers: [],
            voidreasonid: '',
            positioncode: '',
            displayname: '',
            activeflag: 1,
            insertedby: '',
            updatedby: '',
            effectivedate: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            expirationdate: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            rtfdate: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            coadate: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this.userDetailsForm = this.formBuilder.group({
            agency: [''],
            position: [''],
            role: [''],
            name: [''],
            teamid: [''],
            email: [''],
            gender: [''],
            dob: ['']
        });
        this.userForm = this.formBuilder.group({
            name: ['', [Validators.required]],
            useremail: ['', [Validators.required]],
            gender: [''],
            dob: ['']
        });
        this.emailSearch = this.formBuilder.group({
            email: [null]
        });
        this.clearFormGroup();
        this.clearTeamPositionFormGroup();
        this.clearReAssignmentFormGroup();
        this.userDetailsForm.disable();
        this.userDetailsForm.controls['teamid'].enable();
        this.userForm.controls['gender'].disable();
        this.userForm.controls['dob'].disable();
    }

    hourMinute(n: number): any[] {
        return Array(n);
    }
    pageChanged(event: any) {
        if (this.noPageChangeCall) {
            this.pageChangedRequest$.next(event);
        }
        this.noPageChangeCall = true;
     }
     userPageChanged(event: any) {
        this.getSearchUserList(event.page);
     }
    getCountyList() {
        const filter = {
            where: { activeflag : 1, state: 'MD' },
                order: 'countyname asc',
                nolimit: true
        }
        this._commonService.create(filter, 'admin/county/countylist').subscribe((item) => {
                this.countyData = item;
            });
    }
    getReligionList() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.GetRegionListUrl;
        this.religionList$ = this._service.getArrayList({}).pipe(share());
    }

    getTeamTypes() {
        this._commonService
            .getArrayList(
                {
                    nolimit: true,
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.TeamPosition.TeamTypeListUrl + 'list?filter'
            )
            .subscribe((result) => {
                this.teamTypes = result;
            });
    }
    emailBasedSearch() {
        this.emailSearch$.next(this.emailSearch.controls['email'].value);
        this.noPageChangeCall = false;
        if (this.emailSearch.controls['email'].value === '') {
            this.noPageChangeCall = true;
        }
    }
    getCountyItem() {
        this._zipCodeService
            .getArrayList(
                new PaginationRequest({
                    where: {
                        activeflag: 1,
                        apsregion: this.region,
                        countyname: this.countyName
                    },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.TeamPosition.CountyListUrl + '?filter'
            )
            .subscribe((result) => {
                if (this.countyName === undefined) {
                    this.countyLists = result;
                } else {
                    this.leftItems = result;
                }
            });
    }

    getTeams() {
        this.teamList$  = this._service
            .getArrayList(
                {
                    page: 1,
                    order: 'teamnumber asc',
                    where: {
                        activeflag: 1
                    },
                    method: 'get',
                    nolimit: true
                },
                 'manage/team/teamlist?filter'
            ).pipe(map((item) => {
                return item;
            }));
    }

    changeTeam(teamid: string) {
        if (teamid) {
            if (this.teamPositionFormGroup.value.teamid !== '') {
                this.teamId = this.teamPositionFormGroup.get('teamid')?.value;
                this.positionList$ = this._commonService.getArrayList({
                    method: 'get',
                    order: 'roletypekey asc',
                        where: {
                        activeflag: 1,
                        id: this.teamId
                }}, AdminUrlConfig.EndPoint.TeamPosition.PositionTitleUrl + '?filter').pipe(map((result) => {
                    return result.map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.roletypekey
                            })
                    );
                }));
            } else {
                this.teamPositionFormGroup.patchValue({ roletypekey: '' });
            }
        }
    }
    updateTeamDetails() {
        this._commonService.create({teammemberid: this.teammemberId, teamid: this.userDetailsForm.controls['teamid'].value, }, 'admin/teammember/updateuserposition' ).subscribe((item) => {
            this.selectedTreeSubject.next(null);
            this.pageChangedRequest$.next(1);
            this._alertService.success('Update successfully completed');
            $('#myModal-edit-position').modal('hide');
            this.teammemberId = null;
        }, (err) => {
            $('#myModal-edit-position').modal('hide');
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }

    saveTeam(teamData: TeamDetails) {
        if (!this.teamFormGroup.dirty && !this.teamFormGroup.valid) {
            return false;
        }
        this.teamDetailData = Object.assign(new TeamDetails(), teamData);
        delete this.teamDetailData['openingTimeHour'];
        delete this.teamDetailData['openingTimeMinute'];
        delete this.teamDetailData['closingTimeHour'];
        delete this.teamDetailData['closingTimeMinute'];
        if (this.teamDetailData.id) {
            this.teamDetailData.name = teamData.teamname;
            this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamListUrl;
            this._service.patch(this.teamDetailData.id, this.teamDetailData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Team setup details saved successfully');
                        $('#myModal-new-team').modal('hide');
                        this.selectedTreeSubject.next(null);
                        this.reloadTreeSubject.next(null);
                        this.getTeams();
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.teamDetailData.name = teamData.teamname;
            this.teamDetailData.id = undefined;
            this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamListUrl;
            this._service.create(this.teamDetailData).subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Team setup details saved successfully');
                        $('#myModal-new-team').modal('hide');
                        this.reloadTreeSubject.next(null);
                        this.getTeams();
                    }
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    deleteItem() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamListUrl;
        this._service.patch(this.teamDetailData.id).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Team position deleted successfully');
                    this.reloadTreeSubject.next(null);
                    $(this.deletepopupid).modal('hide');
                    this.getTeams();
                }
            },
            (_error: any) => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error('Cannot delete a Team that has Load Numbers with active assignments');
            }
        );
    }
    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }
    confirmDelete(id: any) {
        this.teamDetailData.id = id;
        $(this.deletepopupid).modal('show');
    }

    editTeamItem(requestdata: any) {
        if (requestdata) {
            this.teamFormGroup.patchValue({
                id: requestdata.id,
                teamnumber: requestdata.teamnumber,
                teamname: requestdata.name,
                name: requestdata.name,
                officetimingfrom: requestdata.officetimingfrom,
                officetimingto: requestdata.officetimingto,
                region: requestdata.region,
                parentteamid: requestdata.parentteamid ? requestdata.parentteamid : null,
                updatedby: '',
                teamtypekey: requestdata.teamtypekey,
                activeflag: 1,
                description: '',
                insertedby: '',
                countyid: requestdata.countyid,
                effectivedate: new Date(requestdata.effectivedate),
                expirationdate: requestdata.expirationdate ? new Date(requestdata.expirationdate) : ''
            });
        }
        this.teamDetailLabel = 'Edit';
    }

    addPosition() {
        this.userListTotalCount = null;
        this.clearTeamPositionFormGroup();
        this.searchUserDetails$ = EMPTY;
        this.teamPositionFormGroup.patchValue({ teamid: this.tempTeamId });
        this.changeTeam(this.tempTeamId);
    }

    editTeamPositionItem(requestdata: any) {
        this.teammemberId = requestdata.id;
        this.getUserTeamDetails();
        this.userDetailsForm.patchValue({
            agency: this.teamMemeberDetails.name,
            position: requestdata.positioncode,
            role: `${requestdata.roletypename || ''} (${requestdata.roletype || ''})`,
            name: `${requestdata.firstname} ${requestdata.lastname}`,
            email: requestdata.email,
            gender: (requestdata && requestdata.gender) ? requestdata.gender : '',
            dob: requestdata.dob ? new Date(requestdata.dob) : ''
        });
        this.actionLabel = 'Edit';
    }
    getUserTeamDetails() {
        this._service
            .getArrayList(
                {
                    page: 1,
                    order: 'teamnumber asc',
                    where: {
                        activeflag: 1,
                        teamtypekey: this.teamMemeberDetails.teamtypekey,
                        teamid: this.teamMemeberDetails.id
                    },
                    method: 'get',
                    nolimit: true
                },
                 'manage/team/getteamlist?filter'
            ).subscribe((item) => {
                this.positionTeamlist = item;
                this.userDetailsForm.controls['teamid'].patchValue(this.teamMemeberDetails.id);
            });
    }

    savePosition(teamPositionData: any) {
        this._commonService.create({
            teamid: teamPositionData.teamid,
            roletypekey: teamPositionData. roletypekey,
            loadnumber: teamPositionData.positioncode,
            positioncode: teamPositionData.positioncode,
            securityusersid: teamPositionData.securityusersid,
            userid: teamPositionData.userid
        }, 'admin/teammember/add').subscribe((response) => {
            if (response) {
                this._alertService.success('Team Position saved successfully');
                $('#myModal-new-position').modal('hide');
                this.selectedTreeSubject.next(null);
            }
        }, (_err: any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }

    vacantCheck(event: any) {
        if (event.target.checked) {
            this.teamPositionFormGroup.patchValue({ coadate: new Date() });
        } else {
            this.teamPositionFormGroup.patchValue({ coadate: null });
        }
    }

    showZipData(listdata: any) {
        this.teamMemberId = listdata.id;
        this.loadNumber = listdata.positioncode;
        this._teamPositionService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.TeamPosition.ZipCodeModelUrl + '/' + listdata.id + '?filter'
            )
            .subscribe((response: any) => {
                this.countyList = response.data;
                this.showModelBox = true;
            });
    }

    saveZipcodeItem() {
        const selectedItems = this.rightItems.map((item) => {
            return item.countyid;
        });
        this.zipCodemodelBox = {
            activeflag: 1,
            countyid: selectedItems,
            teammemberid: this.teamMemberId,
            effectivedate: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            expirationdate: new Date(),
            id: this.teamMemberId
        };
        this._commonService.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.ZipcodeFinalUrl;
        this._commonService.create(this.zipCodemodelBox).subscribe((response) => {
            if (response) {
                this._alertService.success('Zip code saved successfully');
                $('#myModal-zipcode').modal('hide');
                this.rightItems = [];
                this.showZipData(this.zipCodemodelBox);
            }
        });
    }

    getReAssignmentHistory(requestData: any) {
        const source = this._reAssignmentService.getById(requestData.id, AdminUrlConfig.EndPoint.TeamPosition.TeamMemberAddUrl + 'list').pipe(map((result) => {
            return { data: result };
        }));
        this.newPostionCode = requestData.positioncode;
        this.teamMemberId = requestData.id;
        this.assignmentList$ = source.pipe(pluck('data'));
        this.clearReAssignmentFormGroup();
        this.getAssignmentList(0);
        this.firstName = '';
        this.lastName = '';
        this.positionCode = '';
    }

    getAssignmentList(size: any) {
        const source = this._reAssignmentService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: size,
                    where: {
                        firstname: this.firstName,
                        lastname: this.lastName,
                        positioncode: this.positionCode
                    },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.TeamPosition.AssignmentListUrl + '/list?filter'
            ).pipe(
            share());
        this.assignmentSearchList$ = source.pipe(pluck('data'));
    }
    getSearchUserList(page: any) {
        const source = this._reAssignmentService
            .getPagedArrayList(
                new PaginationRequest({
                    page: page,
                    limit: 25,
                    where: {
                        firstname: this.teamPositionFormGroup.controls['firstname'].value,
                        lastname: this.teamPositionFormGroup.controls['lastname'].value,
                    },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.TeamPosition.AssignmentListUrl + '/list?filter'
            ).pipe(
            share());
        this.searchUserDetails$ = source.pipe(pluck('data'));
        source.pipe(pluck('count')).subscribe((item) => {
            if (item) {
                this.userListTotalCount = item;
            }
        });
    }
    editAssignmentItem(requestData: any) {
        this.reAssignmentFormGroup.patchValue({
            id: null,
            teammemberassignmentid: null,
            teammemberid: requestData.teammemberid,
            securityusersid: requestData.securityusersid,
            securityusers: [null],
            positioncode: this.newPostionCode,
            voidreasonid: null,
            displayname: requestData.displayname,
            activeflag: 1,
            insertedby: null,
            updatedby: null,
            effectivedate: requestData.effectivedate ? requestData.effectivedate : null,
            expirationdate: requestData.expirationdate ? requestData.expirationdate : null,
            rtfdate: requestData.rtfdate ? requestData.rtfdate : null,
            coadate: requestData.coadate ? requestData.coadate : null
        });
    }
    selectedUser(modal: any) {
        this.userForm.patchValue({
            usertemid: modal.teammemberid,
            name: modal.displayname,
            useremail: modal.email,
            dob: modal.dob ? new Date(modal.dob) : '',
            gender: modal.gender
        });
        this.teamPositionFormGroup.patchValue({
            securityusersid: modal.securityusersid,
            userid: modal.userid
        });
    }

    saveReAssignment(reAssignmentData: ReAssignmentDetails) {
        if (!this.reAssignmentFormGroup.dirty || !this.reAssignmentFormGroup.valid) {
            return false;
        }
        this.reAssignmentData = Object.assign(new ReAssignmentDetails(), reAssignmentData);

        ObjectUtils.removeEmptyProperties(this.reAssignmentData);
        reAssignmentData.teammemberid = this.teamMemberId;
        this.reAssignmentData.teammemberid = this.teamMemberId;
        this.reAssignmentData.securityusers = undefined;
        this._reAssignmentService.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.AddReAssignmentURl;
        this._reAssignmentService.create(this.reAssignmentData).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Reassignent saved successfully');
                    this.reAssignmentData.id = this.teamMemberId;
                    this.getReAssignmentHistory(this.reAssignmentData);
                    $('#myModal-reassign').modal('hide');
                    this.selectedTreeSubject.next(null);
                    this.clearReAssignmentFormGroup();
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    deleteAssignmentData(requestData: any) {
        this.deleteReAssignmentData = Object.assign(new ReAssignmentDetails(), requestData);
        this.deleteReAssignmentData.securityusers = undefined;
        this.deleteReAssignmentData.activeflag = 0;
        this._reAssignmentService.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.DeleteReAssignmentURl;
        this._reAssignmentService.patch(this.deleteReAssignmentData.teammemberassignmentid, this.deleteReAssignmentData).subscribe(
            (response: any) => {
                if (response) {
                    this._alertService.success('Reassignent deleted successfully');
                    this.deleteReAssignmentData.id = this.teamMemberId;
                    this.getReAssignmentHistory(this.deleteReAssignmentData);
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    clearFormGroup() {
        this.actionLabel = 'Add';
        this.teamDetailLabel = 'Add';
        this.teamFormGroup.reset();
        this.openingTimeHours = '';
        this.closingTimeHours = '';
        this.teamFormGroup.patchValue({
            openingTimeHour: '',
            closingTimeHour: '',
            teamtypekey: '',
            region: '',
            parentteamid: null
        });
    }
    // checkDateRange(teamFormGroup) {
    //     if (teamFormGroup.controls.expirationdate.value) {
    //         if (teamFormGroup.controls.expirationdate.value < teamFormGroup.controls.effectivedate.value) {
    //             return { notValid: true };
    //         }
    //         return null;
    //     }
    // }
    clearTeamPositionFormGroup() {
        this.actionLabel = 'Add New';
        this.teamPositionFormGroup.reset();
        this.userForm.reset();
    }
    editPositioncheckDateRange(teamPositionFormGroup: any) {
        if (teamPositionFormGroup.controls.expirationdate.value) {
            if (teamPositionFormGroup.controls.expirationdate.value < teamPositionFormGroup.controls.effectivedate.value) {
                return { notValid: true };
            }
            return null;
        }
    }

    clearReAssignmentFormGroup() {
        this.reAssignmentFormGroup.reset();
    }
    selectAll() {
        if (this.leftItems.length) {
            this.moveItems(this.leftItems, this.rightItems, Object.assign([], this.leftItems));
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }

    select() {
        if (this.leftSelectedItems.length) {
            this.moveItems(this.leftItems, this.rightItems, this.leftSelectedItems);
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }

    unSelect() {
        if (this.rightSelectedItems.length) {
            this.moveItems(this.rightItems, this.leftItems, this.rightSelectedItems);
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }

    unSelectAll() {
        if (this.rightItems.length) {
            this.moveItems(this.rightItems, this.leftItems, Object.assign([], this.rightItems));
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    selectItem(position: string, selectedItem: CountyDetails, control: any) {
        if (position === 'left') {
            if (control.target.checked) {
                this.leftSelectedItems.push(selectedItem);
            } else {
                const index = this.leftSelectedItems.indexOf(selectedItem);
                this.leftSelectedItems.splice(index, 1);
            }
        } else {
            if (control.target.checked) {
                this.rightSelectedItems.push(selectedItem);
            } else {
                const index = this.rightSelectedItems.indexOf(selectedItem);
                this.rightSelectedItems.splice(index, 1);
            }
        }
    }
    private moveItems(source: CountyDetails[], target: CountyDetails[], selectedItems: CountyDetails[]) {
        selectedItems.forEach((item: CountyDetails, i) => {
            const selectedIndex = source.indexOf(item);
            if (selectedIndex !== -1) {
                source.splice(selectedIndex, 1);
                target.push(item);
            }
        });
        this._changeDetect.detectChanges();
    }
    private clearSelectedItems(position: string) {
        if (position === 'left') {
            this.leftSelectedItems = [];
        } else {
            this.rightSelectedItems = [];
        }
    }
    clearCountyListBox() {
        this.rightItems = [];
    }

    private getParentTeam() {
        const source = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    order: 'teamtypekey asc',
                    where: { activeflag: 1,
                    teamtypekey: 'LDSS'
                },
                    method: 'get',
                    nolimit: true
                }),
                AdminUrlConfig.EndPoint.TeamPosition.ParentTeamListUrl + '?filter'
            ).pipe(
            map((result) => {
                return { parentTeam: result };
            }));
        this.parentTeam$ = source.pipe(pluck('parentTeam'));
    }

    getControlByIndexFn(index: string): FormControl {
        return this.reAssignmentFormGroup.controls[index] as FormControl;
    }

    getTeamPositionControlByIndexFn(index: string): FormControl {
        return this.teamPositionFormGroup.controls[index] as FormControl;
    }

    getTeamFormGroupByIndexFn(index: string): FormControl {
        return this.teamFormGroup.controls[index] as FormControl;
    }
}
