import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AuthService } from '../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { Allegedperson, Assessors, Findings, InvestigationComar, InvestigationFinding, InvolvedPerson, PersonComar, ProfessionType } from '../_entities/investigation-finding-data.models';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

// tslint:disable-next-line:import-blacklist
declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-coma',
    templateUrl: './investigation-coma.component.html',
    styleUrls: ['./investigation-coma.component.scss'],
    standalone: false
})
export class InvestigationComaComponent implements OnInit {
    [key: string]: any;
    @Input()
    investigationComar$!: Subject<InvestigationComar>;
    @Input()
    investigationAllegedPerson$!: Subject<Allegedperson[] | null>;
    neglectIndicatedForm!: FormGroup;
    neglectRuledForm!: FormGroup;
    neglectUnsubstantiatedForm!: FormGroup;
    physicalAbuseIndicatedForm!: FormGroup;
    physicalAbuseRuledOutForm!: FormGroup;
    physicalAbuseRuledUnsubstantiatedForm!: FormGroup;
    sexualAbuseIndicatedForm!: FormGroup;
    sexualAbuseRuledOutForm!: FormGroup;
    sexualAbuseUnsubstantiatedForm!: FormGroup;
    mentalInjuryAbuseIndicatedForm!: FormGroup;
    mentalInjuryAbuseRuledOutForm!: FormGroup;
    mentalInjuryAbuseUnsubstantiatedForm!: FormGroup;
    mentalInjuryNeglectedIndicatedForm!: FormGroup;
    mentalInjuryNeglectedRuledOutForm!: FormGroup;
    mentalInjuryNeglectedUnsubstantiatedForm!: FormGroup;
    sexualAbuseSexTraffickingIndicatedForm!: FormGroup;
    sexualAbuseSexTraffickingRuledOutForm!: FormGroup;
    sexualAbuseSexTraffickingUnsubstantiatedForm!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    fromInvestigationMain!: InvestigationFinding;
    id: string;
    allegedPerson: Allegedperson[] = [];
    personComar = new PersonComar();
    setInvestigation: Findings[] = [];
    professionType: ProfessionType[] = [];
    roleId!: AppUser;
    securityusersId!: string;
    displayMode = 'edit';
    assessorsList = new Assessors();
    isReadonly = true;
    isSaveEnabled = true;

    mentalinjuryabuse = 'MENTAL INJURY- ABUSE';
    mentalinjuryneglect = 'MENTAL INJURY- NEGLECT';
    physicalabuse = 'PHYSICAL ABUSE';
    sexualabuse = 'SEXUAL ABUSE';
    mentalabuse = 'MENTAL INJURY ABUSE';
    validationmsg = 'Please fill mandatory fields!';
    mentalneglect = 'MENTAL INJURY NEGLECT';

    constructor(
        private _alertService: AlertService,
        private _authService: AuthService,
        private _commonHttpService: CommonHttpService,
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private _dataStoreService: DataStoreService,
        private _session: SessionStorageService
    ) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    }

    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.user.securityusersid) {
            this.securityusersId = this.roleId.user.securityusersid;
        }
        this.formInitilize();
        this.getProferssion();
        const activeModuleRole = this._session.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.isReadonly = false;
        } else {
        this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-invest-find');}
        this.isSaveEnabled = !this._authService.isDisabled('investigationfinding','investigationfinding.investigationfindings.save');
        this.investigationComar$.subscribe((data) => {
            this.displayMode = (data.displayMode || 'edit');
            this.fromInvestigationMain = data.investigationfinding;
            const type = this.fromInvestigationMain.name.toUpperCase();
            const key = data.maltreatmentkey.toUpperCase();
            this.victimInfo(data.involvedPerson);
            if (data.isInitialLoad) {
                this.showForm(key, type);
            }
        });
    }
    showForm(key: string, type: string) {
        switch (true) {
            case (type === this.mentalinjuryabuse && key === 'ID'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-ABUSE-ID').modal('show'); break;
            case (type === this.mentalinjuryabuse && key === 'RO'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-ABUSE-RO').modal('show'); break;
            case (type === this.mentalinjuryabuse && key === 'UD'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-ABUSE-UD').modal('show'); break;
            case (type === this.mentalinjuryneglect && key === 'ID'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-NEGLECT-ID').modal('show'); break;
            case (type === this.mentalinjuryneglect && key === 'RO'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-NEGLECT-RO').modal('show'); break;
            case (type === this.mentalinjuryneglect && key === 'UD'):
                this.setFormValue(key, type);
                $('#MENTAL-INJURY-NEGLECT-UD').modal('show'); break;
            case (type === 'NEGLECT' && key === 'ID'):
                this.setFormValue(key, type);
                $('#NEGLECTID').modal('show'); break;
            case (type === 'NEGLECT' && key === 'RO'):
                this.setFormValue(key, type);
                $('#NEGLECTRO').modal('show'); break;
            case (type === 'NEGLECT' && key === 'UD'):
                this.setFormValue(key, type);
                $('#NEGLECTUD').modal('show'); break;
            case (type === this.physicalabuse && key === 'ID'):
                this.setFormValue(key, type);
                $('#PHYSICAL-ABUSEID').modal('show'); break;
            case (type === this.physicalabuse && key === 'RO'):
                this.setFormValue(key, type);
                $('#PHYSICAL-ABUSERO').modal('show'); break;
            case (type === this.physicalabuse && key === 'UD'):
                this.setFormValue(key, type);
                $('#PHYSICAL-ABUSEUD').modal('show'); break;
            case (this.checksexualabuse(key, type, 'ID')):
                this.setFormValue(key, type);
                $('#SEXUAL-ABUSEID').modal('show'); break;
            case (this.checksexualabuse(key, type, 'RO')):
                this.setFormValue(key, type);
                $('#SEXUAL-ABUSERO').modal('show'); break;
            case (this.checksexualabuse(key, type, 'UD')):
                this.setFormValue(key, type);
                $('#SEXUAL-ABUSEUD').modal('show'); break;
            case (this.checksextrafficking(key, type, 'ID')):
                this.setFormValue(key, type);
                $('#SEX-TRAFFICKING-INDICATED').modal('show'); break;
            case (this.checksextrafficking(key, type, 'RO')):
                this.setFormValue(key, type);
                $('#SEX-TRAFFICKING-RULED-OUT').modal('show'); break;
            case (this.checksextrafficking(key, type, 'UD')):
                this.setFormValue(key, type);
                $('#SEX-TRAFFICKING-UNSUBSTANTIATED').modal('show'); break;
        }
    }
    checksexualabuse(key: string, type: string, comparekey: string){
        return (type === this.sexualabuse && key === comparekey && (this.fromInvestigationMain.sextrafficking === 0 || this.fromInvestigationMain.sextrafficking !== 1));
    }
    checksextrafficking(key: string, type: string, comparekey: string){
        return (type === this.sexualabuse && key === comparekey && this.fromInvestigationMain.sextrafficking === 1)
    }
    formInitilize() {
        const generalForm = {
            personid: [''],
            investigationallegationid: [''],
            personname: [''],
            intentionalinjurydesc: [''],
            findingcomments: [''],
            investigationfindingtypekey: [''],
            isharm: false,
            isharmsubstantial: false,
            harmdesc: [''],
            name: [''],
            omissiondesc: [''],
            sextrafficking: [''],
            assessors: [''],
            firstname: [''],
            lastname: [''],
            assessorcomments: [''],
            caseworkercomments: [''],
            typedescription: [''],
            professiontypekey: [''],
            isfindingassessor: false,
            securityusersid: [''],
            investigationComarCareGiverName : ['']
        };

        this.neglectIndicatedForm = this.formBuilder.group(generalForm);
        this.neglectRuledForm = this.formBuilder.group(generalForm);
        this.neglectUnsubstantiatedForm = this.formBuilder.group(generalForm);
        this.physicalAbuseIndicatedForm = this.formBuilder.group(generalForm);
        this.physicalAbuseRuledOutForm = this.formBuilder.group(generalForm);
        this.physicalAbuseRuledUnsubstantiatedForm = this.formBuilder.group(generalForm);
        this.sexualAbuseIndicatedForm = this.formBuilder.group(generalForm);
        this.sexualAbuseRuledOutForm = this.formBuilder.group(generalForm);
        this.sexualAbuseUnsubstantiatedForm = this.formBuilder.group(generalForm);
        this.mentalInjuryAbuseIndicatedForm = this.formBuilder.group(generalForm);
        this.mentalInjuryAbuseRuledOutForm = this.formBuilder.group(generalForm);
        this.mentalInjuryAbuseUnsubstantiatedForm = this.formBuilder.group(generalForm);
        this.mentalInjuryNeglectedIndicatedForm = this.formBuilder.group(generalForm);
        this.mentalInjuryNeglectedRuledOutForm = this.formBuilder.group(generalForm);
        this.mentalInjuryNeglectedUnsubstantiatedForm = this.formBuilder.group(generalForm);
        this.sexualAbuseSexTraffickingIndicatedForm = this.formBuilder.group(generalForm);
        this.sexualAbuseSexTraffickingRuledOutForm = this.formBuilder.group(generalForm);
        this.sexualAbuseSexTraffickingUnsubstantiatedForm = this.formBuilder.group(generalForm);
    }
    victimInfo(person: InvolvedPerson[]) {
        if (person) {
            const careTaker = person.filter((res) => {
                return res.roles.length && res.roles.filter((role) => role.intakeservicerequestpersontypekey === 'CARTKR').length;
            });
            if (careTaker.length > 0) {
                this.personComar.caretakername = careTaker[0].firstname + ' ' + careTaker[0].lastname;
            } else {
                this.personComar.caretakername = '';
            }
            const personData = person.filter((item) => item.personid === this.fromInvestigationMain.personid);
            if (personData.length > 0) {
                this.personComar.victimdob = personData[0].dob;
            } else {
                this.personComar.victimdob = null;
            }

            this.personComar.victimname = this.fromInvestigationMain.personname;
        }
    }
    setFormValue(findingTypeKey: string | undefined, selectType: string | undefined) {
        this.setInvestigation = [];
        this.assessorsList = Object.assign({}, new Assessors());
        const newFindings = this.allegedPerson.filter(
            (item) => item.investigationallegationid === this.fromInvestigationMain.investigationallegationid && item.investigationfindingtypekey === findingTypeKey && item.name === selectType
        );
        if (newFindings.length > 0) {
            this.setInvestigation.push({
                intentionalinjurydesc: newFindings[0].intentionalinjurydesc,
                findingcomments: newFindings[0].findingcomments,
                investigationfindingtypekey: newFindings[0].investigationfindingtypekey,
                isharm: newFindings[0].isharm,
                isharmsubstantial: newFindings[0].isharmsubstantial,
                harmdesc: newFindings[0].harmdesc,
                omissiondesc: newFindings[0].omissiondesc,
                firstname: newFindings[0].firstname,
                lastname: newFindings[0].lastname,
                assessorcomments: newFindings[0].assessorcomments,
                caseworkercomments: newFindings[0].caseworkercomments,
                typedescription: newFindings[0].typedescription,
                professiontypekey: newFindings[0].professiontypekey,
                isfindingassessor: newFindings[0].isfindingassessor,
                securityusersid: newFindings[0].securityusersid
            });
        } else if (this.fromInvestigationMain.findings && this.fromInvestigationMain.findings.length > 0) {
            this.addToInvestigation(findingTypeKey, selectType);
        } else {
            this.setInvestigation = [];
        }
        const setGeneralForm = this.getGeneralFormData(findingTypeKey);
        this.updateFormSelection(selectType, findingTypeKey, setGeneralForm);
    }
    addToInvestigation(findingTypeKey: string | null | undefined, selectType: string | undefined) {
        this.fromInvestigationMain.findings.forEach((data) => {
            if (data.investigationfindingtypekey === findingTypeKey && this.fromInvestigationMain.name.toUpperCase() === selectType) {
                if (this.fromInvestigationMain.findings && this.fromInvestigationMain.findings.length > 0) {
                    this.setAssessorsList(data);
                    const investigation = this.getInvestigation(data);
                    this.setInvestigation.push(investigation);
                }
            }
        });
    }
    getInvestigation(data: any){
        return  {
            intentionalinjurydesc: data.intentionalinjurydesc,
            findingcomments: data.findingcomments,
            investigationfindingtypekey: data.investigationfindingtypekey,
            isharm: data.isharm,
            isharmsubstantial: data.isharmsubstantial,
            harmdesc: data.harmdesc,
            omissiondesc: data.omissiondesc,
            firstname: this.assessorsList ? this.assessorsList.firstname : '',
            lastname: this.assessorsList ? this.assessorsList.lastname : '',
            assessorcomments: this.assessorsList ? this.assessorsList.assessorcomments : '',
            caseworkercomments: this.assessorsList ? this.assessorsList.caseworkercomments : '',
            typedescription: this.assessorsList ? this.assessorsList.typedescription : '',
            professiontypekey: this.assessorsList ? this.assessorsList.professiontypekey : '',
            isfindingassessor: false,
            securityusersid: ''
        }
    }
    setAssessorsList(data: any){
        if (data.assessors && data.assessors.length) {
            this.assessorsList.firstname = data.assessors[0].firstname ? data.assessors[0].firstname : '';
            this.assessorsList.lastname = data.assessors[0].lastname ? data.assessors[0].lastname : '';
            this.assessorsList.assessorcomments = data.assessors[0].comments ? data.assessors[0].comments : '';
            this.assessorsList.typedescription = data.assessors[0].typedescription ? data.assessors[0].typedescription : '';
            this.assessorsList.professiontypekey = data.assessors[0].professiontypekey ? data.assessors[0].professiontypekey : '';
            this.assessorsList.caseworkercomments = data.assessors[1].comments ? data.assessors[1].comments : '';
        }
    }
    getGeneralFormData(findingTypeKey: any){

        return {
            personid: this.fromInvestigationMain.personid,
            investigationallegationid: this.fromInvestigationMain.investigationallegationid,
            personname: this.fromInvestigationMain.personname,
            intentionalinjurydesc: this.setInvestigation.length > 0 ? this.setInvestigation[0].intentionalinjurydesc : '',
            findingcomments: this.setInvestigation.length > 0 ? this.setInvestigation[0].findingcomments : '',
            investigationfindingtypekey: findingTypeKey,
            isharm: this.setInvestigation.length > 0 ? this.setInvestigation[0].isharm : '',
            isharmsubstantial: this.setInvestigation.length > 0 ? this.setInvestigation[0].isharmsubstantial : '',
            harmdesc: this.setInvestigation.length > 0 ? this.setInvestigation[0].harmdesc : '',
            omissiondesc: this.setInvestigation.length > 0 ? this.setInvestigation[0].omissiondesc : '',
            firstname: this.setInvestigation.length > 0 ? this.setInvestigation[0].firstname : '',
            lastname: this.setInvestigation.length > 0 ? this.setInvestigation[0].lastname : '',
            assessorcomments: this.setInvestigation.length > 0 ? this.setInvestigation[0].assessorcomments : '',
            professiontypekey: this.setInvestigation.length > 0 ? this.setInvestigation[0].professiontypekey : '',
            caseworkercomments: this.setInvestigation.length > 0 ? this.setInvestigation[0].caseworkercomments : '',
            name: this.fromInvestigationMain.name,
            sextrafficking: this.fromInvestigationMain.sextrafficking,
            isfindingassessor: this.setInvestigation.length > 0 ? this.setInvestigation[0].isfindingassessor : false,
            securityusersid: this.securityusersId
        };
    }
    updateFormSelection(selectType: any, findingTypeKey: any, setGeneralForm: any){
        switch (true){
		case (selectType === 'NEGLECT' && findingTypeKey === 'ID'):
            this.updateForm('neglectIndicatedForm', setGeneralForm); break;
        case (selectType === 'NEGLECT' && findingTypeKey === 'RO'):
            this.updateForm('neglectRuledForm', setGeneralForm); break;
        case (selectType === 'NEGLECT' && findingTypeKey === 'UD'):
            this.updateForm('neglectUnsubstantiatedForm', setGeneralForm); break;
        case (selectType === this.physicalabuse && findingTypeKey === 'ID'):
            this.updateForm('physicalAbuseIndicatedForm', setGeneralForm); break;
        case (selectType === this.physicalabuse && findingTypeKey === 'RO'):
            this.updateForm('physicalAbuseRuledOutForm', setGeneralForm); break;
        case (selectType === this.physicalabuse && findingTypeKey === 'UD'):
            this.updateForm('physicalAbuseRuledUnsubstantiatedForm', setGeneralForm); break;
        case (this.checksexualabuse(findingTypeKey, selectType, 'ID')):
            this.updateForm('sexualAbuseIndicatedForm', setGeneralForm); break;
        case (this.checksexualabuse(findingTypeKey, selectType, 'RO')):
            this.updateForm('sexualAbuseRuledOutForm', setGeneralForm); break;
        case (this.checksexualabuse(findingTypeKey, selectType, 'UD')):
            this.updateForm('sexualAbuseUnsubstantiatedForm', setGeneralForm); break;
        case (this.checksextrafficking(findingTypeKey, selectType, 'ID')):
            this.updateForm('sexualAbuseSexTraffickingIndicatedForm', setGeneralForm); break;
        case (this.checksextrafficking(findingTypeKey, selectType, 'RO')):
            this.updateForm('sexualAbuseSexTraffickingRuledOutForm', setGeneralForm); break;
        case (this.checksextrafficking(findingTypeKey, selectType, 'UD')):
            this.updateForm('sexualAbuseSexTraffickingUnsubstantiatedForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryabuse && findingTypeKey === 'ID'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryAbuseIndicatedForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryabuse && findingTypeKey === 'RO'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryAbuseRuledOutForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryabuse && findingTypeKey === 'UD'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryAbuseUnsubstantiatedForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryneglect && findingTypeKey === 'ID'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryNeglectedIndicatedForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryneglect && findingTypeKey === 'RO'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryNeglectedRuledOutForm', setGeneralForm); break;
        case (selectType === this.mentalinjuryneglect && findingTypeKey === 'UD'):
            setGeneralForm.isfindingassessor = true;
            this.updateForm('mentalInjuryNeglectedUnsubstantiatedForm', setGeneralForm); break;
        }
    }
    updateForm(formKey: any, setGeneralForm: any) {
        this[formKey].patchValue(setGeneralForm);
        if (this.displayMode == 'view'){
            this[formKey].disable();
        } else {
            this[formKey].enable();
        }
    }
    displayButton() {
        return ((this.displayMode === 'edit') && this.isReadonly && this.isSaveEnabled);
    }

    getProferssion() {
        this._commonHttpService.getSingle({}, 'professiontype/').subscribe((res) => {
            this.professionType = res;
        });
    }
    addAllegedPerson(form: any, selectPopup: any) {
        const item = selectPopup.split('-');
        const maltreatmentName = item[0];
        const maltreatmentKey = item[1];
        switch (true) {
            case (maltreatmentName === 'NEGLECT' && maltreatmentKey === 'ID'):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#NEGLECTID').modal('hide'); break;
            case (maltreatmentName === 'NEGLECT' && maltreatmentKey === 'RO'):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#NEGLECTRO').modal('hide'); break;
            case (maltreatmentName === 'NEGLECT' && maltreatmentKey === 'UD'):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#NEGLECTUD').modal('hide'); break;
            case (maltreatmentName === this.physicalabuse && maltreatmentKey === 'ID'):
                this.checkIsMandatory(form, maltreatmentName, maltreatmentKey, maltreatmentName, '#PHYSICAL-ABUSEID');
                break;
            case (maltreatmentName === this.physicalabuse && maltreatmentKey === 'RO'):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#PHYSICAL-ABUSERO').modal('hide'); break;
            case (maltreatmentName === this.physicalabuse && maltreatmentKey === 'UD'):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#PHYSICAL-ABUSEUD').modal('hide'); break;
            case (this.checksextrafficking(maltreatmentKey, maltreatmentName,'ID')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEX-TRAFFICKING-INDICATED').modal('hide'); break;
            case (this.checksextrafficking(maltreatmentKey, maltreatmentName,'RO')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEX-TRAFFICKING-RULED-OUT').modal('hide'); break;
            case (this.checksextrafficking(maltreatmentKey, maltreatmentName,'UD')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEX-TRAFFICKING-UNSUBSTANTIATED').modal('hide'); break;
            case (this.checksexualabuse(maltreatmentKey, maltreatmentName,'ID')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEXUAL-ABUSEID').modal('hide'); break;
            case (this.checksexualabuse(maltreatmentKey, maltreatmentName,'RO')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEXUAL-ABUSERO').modal('hide'); break;
            case (this.checksexualabuse(maltreatmentKey, maltreatmentName,'UD')):
                this.generalAllegedPerson(form, maltreatmentName);
                $('#SEXUAL-ABUSEUD').modal('hide'); break;
            case (maltreatmentName === this.mentalabuse && maltreatmentKey === 'ID'):
                this.checkIsMandatory(form, maltreatmentName, maltreatmentKey, this.mentalinjuryabuse, '#MENTAL-INJURY-ABUSE-ID');
                break;
            case (maltreatmentName === this.mentalabuse && maltreatmentKey === 'RO'):
                this.checkIsMandatory(form, maltreatmentName, maltreatmentKey, this.mentalinjuryabuse, '#MENTAL-INJURY-ABUSE-RO');
                break;
            case (maltreatmentName === this.mentalabuse && maltreatmentKey === 'UD'):
                this.checkIsMandatory(form, maltreatmentName, maltreatmentKey, this.mentalinjuryabuse, '#MENTAL-INJURY-ABUSE-UD');
                break;
            case (maltreatmentName === this.mentalneglect && maltreatmentKey === 'ID'):
                this.checkIsMandatory(form, maltreatmentName, maltreatmentKey, this.mentalinjuryneglect, '#MENTAL-INJURY-NEGLECT-ID');
                break;
            case (maltreatmentName === this.mentalneglect && maltreatmentKey === 'RO'):
                this.generalAllegedPerson(form, this.mentalinjuryneglect);
                $('#MENTAL-INJURY-NEGLECT-RO').modal('hide'); break;
            case (maltreatmentName === this.mentalneglect && maltreatmentKey === 'UD'):
                this.generalAllegedPerson(form, this.mentalinjuryneglect);
                $('#MENTAL-INJURY-NEGLECT-UD').modal('hide'); break;
        }
        this.investigationAllegedPerson$.next(this.allegedPerson);
    }
    checkIsMandatory(form: any, maltreatmentName: any, maltreatmentKey: any, forminfo: any, formname: any) {
        const isMandatory = this.conditionValidations(form, maltreatmentName + maltreatmentKey);
        if (isMandatory) {
            return this._alertService.warn(this.validationmsg);
        } else {
            this.generalAllegedPerson(form, forminfo);
        }
        $(formname).modal('hide'); 
    }
    resetFindingType() {
        this.investigationAllegedPerson$.next(null);
    }
    conditionValidations(formValues: any, formName: any): boolean {
        if (formName === 'MENTAL INJURY ABUSEID' || formName === 'MENTAL INJURY NEGLECTID') {
            if (!formValues.firstname || !formValues.lastname || !formValues.assessorcomments || !formValues.professiontypekey || !formValues.caseworkercomments) {
                return true;
            } else {
                return false;
            }
        } else if (formName === 'MENTAL INJURY ABUSEUD' || formName === 'MENTAL INJURY ABUSERO') {
            if (!formValues.firstname || !formValues.lastname || !formValues.assessorcomments || !formValues.professiontypekey) {
                return true;
            } else {
                return false;
            }
        } else if (formName === 'PHYSICAL ABUSEID') {
            return this.checkintentionalinjurydesc(formValues);
        }
        return true;
    }
    checkintentionalinjurydesc(formValues: any){
        if (!formValues.intentionalinjurydesc) {
            return true;
        } else {
            return false;
        }
    }
    private generalAllegedPerson(form: any, selectPopup: any): Allegedperson[] {
        if (this.allegedPerson.length > 0) {
            this.allegedPerson = this.allegedPerson.filter((res) => res.investigationallegationid !== this.fromInvestigationMain.investigationallegationid);
        }
        let isHarm = 0;
        if (typeof form.isharm === 'boolean') {
            isHarm = form.isharm === true ? 1 : 0;
        } else {
            isHarm = form.isharm;
        }
        let isharmsubstantial = 0;
        if (typeof form.isharmsubstantial === 'boolean') {
            isharmsubstantial = form.isharmsubstantial === true ? 1 : 0;
        } else {
            isharmsubstantial = form.isharmsubstantial;
        }
        this.allegedPerson.push({
            personid: form.personid,
            investigationallegationid: form.investigationallegationid,
            name: selectPopup,
            intentionalinjurydesc: form.intentionalinjurydesc,
            findingcomments: form.findingcomments,
            investigationfindingtypekey: form.investigationfindingtypekey,
            isharm: isHarm,
            isharmsubstantial: isharmsubstantial,
            harmdesc: form.harmdesc,
            omissiondesc: form.omissiondesc,
            sextrafficking: form.sextrafficking,
            firstname: form.firstname ? form.firstname : null,
            lastname: form.lastname ? form.lastname : null,
            typedescription: form.typedescription ? form.typedescription : null,
            professiontypekey: form.professiontypekey ? form.professiontypekey : null,
            assessorcomments: form.assessorcomments ? form.assessorcomments : null,
            caseworkercomments: form.caseworkercomments ? form.caseworkercomments : null,
            isfindingassessor: form.isfindingassessor,
            securityusersid: form.securityusersid
        });
        return this.allegedPerson;
    }

    discardAction(modalID: string) {
        this.investigationAllegedPerson$.next(null);
        $('#' + modalID).modal('hide');
    }
}
