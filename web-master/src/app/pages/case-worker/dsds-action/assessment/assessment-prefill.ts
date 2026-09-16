import moment from 'moment';

import { titleCase } from '../../../../@core/common/initializer';
import { RoutingInfo } from '../../_entities/caseworker.data.model';
import { BehaviourHealth, InvolvedPerson, Medicalinformation } from '../involved-persons/_entities/involvedperson.data.model';
import { assessmentData } from './../_data/assessment';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { CommonHttpService, AuthService, DataStoreService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

export class AssessmentPreFill {
    householdmember!: boolean;
    persondetail!: InvolvedPerson[];
    educationDetails: any[] = [];
    victimChild!: boolean;
    drugList: any[] = [];
    supervisorName: any;
    caseWorkerName: any;
    deceasedChildName: any;
    dodOfDeceasedChild: any;
    dtformat = 'MM/DD/YYYY';
    dtformat1 = 'YYYY-MM-DD';
    dtformat2 = 'YYYY-MM-DD hh:mm a';
    safecRelationship: any;
    safeCOHPchildList: any[] = [];
    safeCOHPchildListWithComma: any[] = [];
    caseheadid!: string;
    relationshiparray: any;
    hohName: any;
    
    constructor(private readonly involvedPersons: InvolvedPerson[], private readonly routingInfo: RoutingInfo[], 
        private readonly routingSupervisors: any[],
        private readonly token: any,
        private readonly _commonHttpService?: CommonHttpService,
        private readonly _dataStoreService?: DataStoreService,
        private readonly _authService?: AuthService) {
            this.supervisorName = this._dataStoreService?.getData('da_assignedby');
            this.caseWorkerName = this._authService?.getCurrentUser().user.userprofile.fullname;
        }
    get caseHeadDetail() {
        const LEGAL_GUARDIAN = ['LG'];
        const res = this.involvedPersons.filter(child => {
            let childFound = false;
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, LEGAL_GUARDIAN, childFound);
            return childFound;
        });

        if(!res || res.length === 0) {
            this.hohName = this._dataStoreService?.getData('hoh')
            const res2 = this.involvedPersons.filter(e => e.fullname === this.hohName)
            return Array.isArray(res2) ? res2 : [];
        }
        return Array.isArray(res) ? res : [];
    }

    get headofHousehold() {
        const res = this.involvedPersons.filter(person => {
            return (person.isheadofhousehold ? person.isheadofhousehold : false);
        });
        return Array.isArray(res) ? res : [];
    }

    get deceasedChildDetails() {
        const res = this.involvedPersons.filter(child => {
            if (child.dateofdeath) {
                this.deceasedChildName = child.fullname;
                this.dodOfDeceasedChild = child.dateofdeath;
                return true;
            }
            return false;
        });
        return Array.isArray(res) ? res : [];
    }

    get careGiverDetails() {
        const ADULT_CATEGORIES = ['CG', 'GRD', 'LG', 'FP', 'PARENT', 'MP', 'RAS'];
        const list = this.involvedPersons.filter(child => {
            let childFound = false;
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, ADULT_CATEGORIES, childFound);
            return childFound;
        });

        return Array.isArray(list) ? list : [];
    }

    get reportedChildDetails() {
        const REPORTED_CHILD = ['RC', 'CHILD'];
        const res = this.involvedPersons.filter(child => {
            let childFound = false;
            if (child.dateofdeath) {
                return false;
            }
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, REPORTED_CHILD, childFound);
            return childFound;
        });
        return Array.isArray(res) ? res : [];
    }

    /**
     * This method can be used for getting children (household + other)
     * that are in active child removal
     * -- Currently, using in safec-ohp
     */
    get removedChildDetailsIncludingOther() {
        const REPORTED_CHILD = ['RC', 'CHILD', 'AV','OTHERCHILD'];
        const res = this.involvedPersons.filter(child => {
            let childFound = false;
            if (child.dateofdeath) {
                return false;
            }
            if (child.removaldate === null) {
                return false;
            }
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, REPORTED_CHILD, childFound);
            return childFound;
        });
        return Array.isArray(res) ? res : [];
    }

    private returnRemovedChildDetailsIncludingOtherRolesFn(child: InvolvedPerson, FILTER_CHILD: string[], childFound: boolean) {
        const roles = Array.isArray(child.roles) ? child.roles : [];
        roles.forEach(role => {
            const childCategory = FILTER_CHILD.find(category => category === role.intakeservicerequestpersontypekey);
            if (childCategory) {
                childFound = true;
                return true;
            }
            return false;
        });
        return childFound;
    }

    get getChildList() {
        const CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
        const childlist = this.involvedPersons.filter(child => {
            let childFound = false;
            if (child.dateofdeath) {
                return false;
            }
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, CHILD_CATEGORIES, childFound);
            return childFound;
        });
        return Array.isArray(childlist) ? childlist : [];
    }

    get getVictimList() {
        const CHILD_CATEGORIES = ['AV'];
        const res = this.involvedPersons.filter(childVictim => {
            let childFound = false;
            if (childVictim.dateofdeath) {
                return false;
            }
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(childVictim, CHILD_CATEGORIES, childFound);
            return childFound;
        });
        return Array.isArray(res) ? res : [];
    }

    get getChildListSafeC() {
        const CHILD_CATEGORIES = ['CHILD', 'AV'];
        const res = this.involvedPersons.filter(child => {  // NOSONAR 
            let childFound = false;
            if (child.dateofdeath) {
                this.deceasedChildName = child.fullname;
                this.dodOfDeceasedChild = child.dateofdeath;
                return false;
            }
            childFound = this.returnRemovedChildDetailsIncludingOtherRolesFn(child, CHILD_CATEGORIES, childFound);
            return childFound;
        });
        return Array.isArray(res) ? res : [];
    }

    get getChildListWithHouseHold() {
        const CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV', 'Youth', 'YOUTH'];
        const res = this.involvedPersons.filter(child => {
            let childFound = false;
            const roles = Array.isArray(child.roles) ? child.roles : [];
            roles.forEach(role => {
                const childCategory = CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                if (childCategory && child.ishousehold === 1) {
                    childFound = true;
                    return true;
                }
                return false;
            });
            return childFound;
        });
        return Array.isArray(res) ? res : [];
    }

    get getHouseHoldWithoutChild() {
        const CHILD_CATEGORIES = ['CHILD', 'OTHERCHILD', 'AV', 'AM'];
        const res = this.involvedPersons.filter(child => {
            let personFound = false;
            if(child && child.roles && child.roles.length > 0 ){
                child.roles.forEach(role => {
                    const childCategory = CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                    if (!childCategory && child.ishousehold === 1) {
                        personFound = true;
                        return true;
                    }
                    return false;
                });
            }
            return personFound;
        });
        return Array.isArray(res) ? res : [];
    }

    get careGiverDetailsWithHouseHold() {
        const ADULT_CATEGORIES = ['CG', 'GRD', 'LG', 'FP', 'PARENT', 'MP', 'RAS', 'ADV', 'AM',
        'CASAWRKER', 'CDCP', 'COURTTERAPST', 'FN', 'LE', 'LR', 'MHP', 'OTH', 'OtherADULT', 'PRVD', 'RELATIVE', 'SSP', 'TES'];
        const res = this.involvedPersons.filter(adult => {
            let adultFound = false;
            const roles = Array.isArray(adult.roles) ? adult.roles : [];
            roles.forEach(role => {
                const adultCate = ADULT_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                if (adultCate && adult.ishousehold === 1) {
                    adultFound = true;
                    return true;
                }
                return false;
            });
            return adultFound;
        });
        return Array.isArray(res) ? res : [];
    }

    get legalGuardianCareTakerlist() {
        const ADULT_CATEGORIES = ['CACA', 'LG'];
        const res = this.involvedPersons.filter(adult => {
            let adultFound = false;
            const roles = Array.isArray(adult.roles) ? adult.roles : [];
            roles.forEach(role => {
                const adultCate = ADULT_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                if (adultCate) {
                    adultFound = true;
                    return true;
                }
                return false;
            });
            return adultFound;
        });
        return Array.isArray(res) ? res : [];
    }


    get reportedAdultDetails() {
        return this.involvedPersons.filter(item => {
            return item.rolename === 'RA' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'RA').length);
        });
    }

    get reportedDjsDetails() {
        return this.involvedPersons.filter(item => {
            return item.rolename === 'Youth' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'Youth').length);
        });
    }

    get childDetails() {
        return this.involvedPersons.filter(item => {
            return item.rolename === 'CHILD' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'CHILD').length);
        });
    }

    get under18childDetails() {
        const res = this.involvedPersons.filter(
            item => {
                const roles = Array.isArray(item.roles) ? item.roles : [];
                const list = ['AV', 'SIBLING', 'PAC', 'NVC', 'OTHERCHILD', 'CHILD', 'BIOCHILD'];
                return roles.some(itm => list.includes(itm.intakeservicerequestpersontypekey) && (itm.intakeservicerequestpersontypekey !== 'AV'));
            }
        );
        return Array.isArray(res) ? res : [];
    }

    get safetySignPersons() {
        const res = this.involvedPersons.filter(
            item => {
                const roles = Array.isArray(item.roles) ? item.roles : [];
                const list = ['RC', 'AV', 'CHILD', 'OTHERCHILD' , 'BIOCHILD'];
                return roles.some(itm => !list.includes(itm.intakeservicerequestpersontypekey));
            }
        );
        return Array.isArray(res) ? res : [];
    }

    get isHouseHold() {
        return this.involvedPersons.filter(item => item.ishousehold === 1);
    }

    get nonHouseHold() {
        return this.involvedPersons.filter(item => item.ishousehold === 0 && item.rolename !== 'RA');
    }

    get allSupervisors() {
        return this.routingSupervisors;
    }

    get intakeWorkerDetails() {
        return this.routingInfo.find(item => item.fromrole === 'Intake Worker');
    }
    get participantDetail() {
        return this.involvedPersons.filter(item => {
            if (item.roles) {
                // tslint:disable-next-line:max-line-length
                const getRole = item.roles.filter(
                    items => items.intakeservicerequestpersontypekey === 'BIOPPARNT' || items.intakeservicerequestpersontypekey === 'PARENT' 
                            || items.intakeservicerequestpersontypekey === 'LG'
                );
                if (getRole.length) {
                    return item;
                }
            }
        });
    }
    get houseHoldDetail() {
        return this.involvedPersons.filter(item => {
            if (item.dateofdeath) {
                return false;
            }
            return item.ishousehold === 1;
        });
    }
    private getFullName(involvedPerson: InvolvedPerson) {
        let fullName = '';
        if (involvedPerson.fullname) {
            fullName += involvedPerson.fullname;
            return fullName.toUpperCase();
        }
        if (involvedPerson.firstname) {
            fullName += involvedPerson.firstname;
        }
        if (involvedPerson.lastname) {
            fullName += ', ' + involvedPerson.lastname;
        }
        return fullName.toUpperCase();
    }
    private getMfraFullName(involvedPerson: InvolvedPerson) {
        let fullName = '';
        if (involvedPerson.fullname) {
            fullName += involvedPerson.fullname;
        }
        return fullName.toUpperCase();
    }
    private getCaseHeadId(data: any) {
        return data.cjamspid;
    }
    private getAge(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
            const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }
    private getFormattedDate(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
            return moment(new Date(dateValue)).format(this.dtformat1);
        } else {
            return '';
        }
    }
    private getChildFormattedAddress(data: any) {
        const address = [`${data.address} ${data.address2}`, data.state, data.city, data.zipcode];
        return address.join(', ');
    }
    private getAddress(involvedPerson: InvolvedPerson) {
        let address = involvedPerson.address ? involvedPerson.address : '';
        if (involvedPerson.city) {
            address += ', ' + involvedPerson.city;
        }           //SonarQube fix - removed 'address' assigned to itself.
        return address.toUpperCase();
    }

    private getMedicationAddress(addressDetail: Medicalinformation) {
        let address = addressDetail.address1 ? addressDetail.address1 : '';

        if (addressDetail.city) {
            address += ' ' + addressDetail.city;
        }
        if (addressDetail.zip) {
            address += ' ' + addressDetail.zip;
        }
        return address.toUpperCase();
    }

    private getBehaviourAddress(addressDetail: BehaviourHealth) {
        let address = '';
        if (addressDetail.behavioraladdress1) {
            address += addressDetail.behavioraladdress1;
        }
        if (addressDetail.behavioralcity) {
            address += addressDetail.behavioralcity;
        }
        if (addressDetail.behavioralzip) {
            address += addressDetail.behavioralzip;
        }
        return address.toUpperCase();
    }

    public fillSila(submissionData: any) {
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName && submissionData['supervisorname'] === '') {
            submissionData['supervisorname'] = this.supervisorName;
        }
        submissionData['userrole'] = this.token.role.name;
        if (this.caseWorkerName && submissionData['caseworkername'] === '') {
            submissionData['caseworkername'] =  this.caseWorkerName;
        }
       return submissionData;
     }
    public fillSafeC(submissionData: any, daNumber: any) {
        const safeCInfoSet1 = this.safeCFillData1(submissionData);
        submissionData['ldss'] = safeCInfoSet1.ldss;
        submissionData['dateassessmentinitiated'] = safeCInfoSet1.dateassessmentinitiated;
        submissionData['dateoflastsafetyplan'] = safeCInfoSet1.dateoflastsafetyplan;
        submissionData['headofhouseholdname'] = safeCInfoSet1.headofhouseholdname;
        submissionData['deceasedChildName'] = safeCInfoSet1.deceasedChildName;
        submissionData['columnsChildDod'] = safeCInfoSet1.columnsChildDod;
        submissionData['actionsTaken'] = safeCInfoSet1.actionsTaken;

        let lgPersonId;
        if (this.caseHeadDetail && this.caseHeadDetail.length>0) {
            lgPersonId = this.caseHeadDetail[0].personid;
            submissionData['caseheadsname'] = this.caseHeadDetail[0].firstname + ' ' + this.caseHeadDetail[0].lastname;
            if (submissionData['age'] === '') {
                submissionData['age'] = this.getAge(this.caseHeadDetail[0].dob);
            }
        }
        if (submissionData['nameofcaregiver'] === '') {
            if (this.careGiverDetails && this.careGiverDetails.length) {
                submissionData['nameofcaregiver'] = [];
                this.careGiverDetails.forEach(item => {     //SonaQube fix - using "forEach" instead of "map" as its return value is not being used here.
                    submissionData['nameofcaregiver'].push(item.firstname + ' ' + item.lastname);
                });
            }
        }

        if (submissionData['cpscaseid'] === '') {
            submissionData['cpscaseid'] = daNumber;
        }
        
        this.safecRelationship = submissionData['relationship'];
        this.safecRelationShipData(lgPersonId);
        submissionData['relationship']= this.safecRelationship;
        
        const childNamesInfo = this.safecChildNames();
        const childsNames = childNamesInfo.childsNames;
        const childsNamesWithComma = childNamesInfo.childsNamesWithComma;
        const otherChildInfo = this.safecOtherChildInfo();
        const otherChildsNames = otherChildInfo.otherChildsNames;
        const otherChilds = otherChildInfo.otherChilds;
        const allChilds = otherChildInfo.allChilds;

        if(childsNames && childsNames.length > 1){
            submissionData['single_child_check'] = true; 
            submissionData['childdeceased'] = false;
        }
        submissionData['childs_names_json'] = JSON.stringify(childsNames);
        submissionData['other_childs_names_json'] = JSON.stringify(otherChildsNames);
        submissionData['other_childs_json'] = JSON.stringify(otherChilds);
        submissionData['all_childs_json'] = JSON.stringify(allChilds);
        
        const childListInfo = this.safecChildList(submissionData);
        const childList = childListInfo.childList;
        const childListWithComma = childListInfo.childListWithComma;
        
        submissionData['caregiversList'] = this.safecCaregiversList();
        submissionData['childs_info_json'] = JSON.stringify(childList);
        submissionData['userrole'] = this.token.role.name;
        submissionData['child_info_with_comma_json'] = JSON.stringify(childListWithComma);
        submissionData['childdatagrid'] = childList;
        submissionData['age'] = this.safecAge(submissionData);
        submissionData['addchildren'] = this.safecAddChildren(submissionData);
        submissionData['child_names_with_comma_json'] = JSON.stringify(childsNamesWithComma);
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        submissionData['supervisorname'] = this.safecGetSupervisorName(submissionData);
        submissionData['supervisortitle'] = this.safecGetSupervisorTitle(submissionData);
        submissionData['workersname'] = this.safecGetWorkerName(submissionData);
        submissionData['workertitle'] = this.safecGetWorkerTitle(submissionData);   
        submissionData = this.safecSafetySignPersons(submissionData);

        return submissionData;
    }
    safecRelationShipData(lgPersonId: any) {
        let count = 0;
        if (this.getChildList && this.getChildList.length > 0) {
            this.getChildList.forEach(child => {
                const personid = child.personid;
                if (child.firstname && child.lastname) {
                    if (lgPersonId && child && child.relationshiparray && child.relationshiparray.length > 0 &&
                        this.getChildListSafeC.findIndex(item => (item.personid === personid)) !== -1) {
                        count = this.checkRelationshipCount(count, child,personid,lgPersonId);
                    }
                }
            });
        }
    }
    checkRelationshipCount(count: any, child: any, personid: any, lgPersonId: any){
        if (count === 0) {
            for (const element of child.relationshiparray) {
                if (element.primaryuserid === personid && element.secondaryuserid === lgPersonId) {
                    this.safecRelationship = titleCase(element.description);
                    count = count + 1;
                }
            }
        }
        return count;
    }

    safeCFillData1(submissionData: any) {
        const userProfileData: any = localStorage.getItem('userProfile');
        const address = userProfileData ? JSON.parse(userProfileData) : '';
        let ldss = submissionData['ldss'];
        let dateassessmentinitiated;
        let dateoflastsafetyplan = submissionData['dateoflastsafetyplan'];
        let headofhouseholdname = submissionData['headofhouseholdname'];
        let deceasedChildName = submissionData['deceasedChildName'];
        let columnsChildDod = submissionData['columnsChildDod'];
        let actionsTaken = submissionData['actionsTaken'];
        let contactnotesformat;
        if (address && address.userprofileaddress && address.userprofileaddress.length > 0) {
            ldss = address.userprofileaddress[0].county;
        }
        if (submissionData['dateassessmentinitiated'] === '') {
            dateassessmentinitiated = moment(new Date());
        } else {
            dateassessmentinitiated = moment(submissionData['dateassessmentinitiated']);
        }
        if (submissionData['dateoflastsafetyplan'] === '' && this._dataStoreService?.getData('safetyassessmentcompletiondate')) {
            dateoflastsafetyplan = moment(this._dataStoreService.getData('safetyassessmentcompletiondate')).format(this.dtformat2);
        }
        if (this.headofHousehold && this.headofHousehold.length > 0) {
            headofhouseholdname = this.headofHousehold[0].firstname + ' ' + this.headofHousehold[0].lastname;
        }
        if (this.deceasedChildDetails && this.deceasedChildDetails.length > 0) {
            deceasedChildName = this.deceasedChildName;
            columnsChildDod = this.dodOfDeceasedChild;
        }
        contactnotesformat = this._dataStoreService?.getData('contact_action_info');
        if (contactnotesformat) {
            contactnotesformat = contactnotesformat.replace(/(<([^>]+)>)/ig, '')
            actionsTaken = contactnotesformat;
        }

        if (this.deceasedChildName){
            deceasedChildName =    this.deceasedChildName;
        }
        if(this.dodOfDeceasedChild) {
            columnsChildDod = this.dodOfDeceasedChild;
        }

        return {
            ldss: ldss,
            dateassessmentinitiated: dateassessmentinitiated,
            dateoflastsafetyplan: dateoflastsafetyplan,
            headofhouseholdname: headofhouseholdname,
            deceasedChildName: deceasedChildName,
            columnsChildDod: columnsChildDod,
            actionsTaken: actionsTaken
        }
    }
    

    safecChildNames(){
        const childsNames = new Array();
        const childsNamesWithComma = new Array();

        if(this.getChildListSafeC && this.getChildListSafeC.length > 0){
            this.getChildListSafeC.forEach(child => {
                if (child.firstname && child.lastname) {
                    childsNames.push(child.firstname + ' ' + child.lastname);
                    childsNamesWithComma.push(this.getFullName(child));
                }
            });
        }

        return {
            childsNames: childsNames,
            childsNamesWithComma: childsNamesWithComma
        };
    }

    safecOtherChildInfo() {
        const otherChildsNames = new Array();
        const otherChilds: any[] = [];
        const allChilds: any[] = [];
        if (this.getChildList && this.getChildList.length > 0) {
            this.getChildList.forEach(child => {
                child.roles.forEach(role => {
                    if (child.firstname && child.lastname && role.intakeservicerequestpersontypekey === 'OTHERCHILD') {
                        otherChildsNames.push(child.firstname + ' ' + child.lastname);
                        otherChilds.push({
                            seconename: child.firstname + ' ' + child.lastname,
                            seconeage: this.getAge(child.dob)
                        });
                    }
                    if (child.firstname && child.lastname) {
                        allChilds.push({
                            name: child.firstname + ' ' + child.lastname,
                            age: this.getAge(child.dob),
                            cjamspid: child.cjamspid
                        });
                    }
                });
            });
        }

        return {
            otherChildsNames: otherChildsNames,
            otherChilds: otherChilds,
            allChilds:  allChilds
        };
    }
    

    safecChildList(submissionData: any) {
        let childList = [];
        let childListWithComma = [];

        if (submissionData && submissionData.childdatagrid && submissionData.childdatagrid.length > 0) {
            if (submissionData.childdatagrid[0].age || (submissionData.childdatagrid[0].age !== '')) {
                const childListInfo1 = this.safecChildList1(submissionData);
                childList = childListInfo1.childList;
                childListWithComma = childListInfo1.childListWithComma;
            } else {
                const childListInfo2 = this.safecChildList2();
                childList = childListInfo2.childList;
                childListWithComma = childListInfo2.childListWithComma;

            }
        } else {
            const childListInfo3 = this.safecChildList3();
            childList = childListInfo3.childList;
            childListWithComma = childListInfo3.childListWithComma;

        }

        return {
            childList: childList,
            childListWithComma: childListWithComma
        };
    }

    safecChildList1(submissionData: any){
        const childList: any[] = [];
        const childListWithComma: any[] = [];
        for (const element of submissionData.childdatagrid) {
            if (element.childname) {
                childList.push({
                    childname: element.childname,
                    clientid: element.clientid,
                    age: element.age
                });
                childListWithComma.push({
                    seconename: element.childname,
                    seconeage: this.getAge(element.dob)
                });
            }
        }
        return {
            childList: childList,
            childListWithComma: childListWithComma
        };
    }

    safecChildList2(){
        const childList: any[] = [];
        const childListWithComma: any[] = [];
        if (this.getChildListSafeC && this.getChildListSafeC.length > 0) {
            this.getChildListSafeC.forEach(child => {
                if (child.firstname && child.lastname) {
                    childList.push({
                        childname: child.firstname + ' ' + child.lastname,
                        clientid: child.cjamspid,
                        age: this.getAge(child.dob)
                    });
                    childListWithComma.push({ seconename: child.firstname + ' ' + child.lastname, seconeage: this.getAge(child.dob) });
                }
            });
        }
        return {
            childList: childList,
            childListWithComma: childListWithComma
        };
    }

    safecChildList3(){
        const childList: any[] = [];
        const childListWithComma: any[] = [];
        if (this.getChildListSafeC && this.getChildListSafeC.length > 0) {
            this.getChildListSafeC.forEach(child => {
                if (child.childname) {
                    childList.push({
                        childname: child.firstname + ' ' + child.lastname,
                        clientid: child.cjamspid,
                        age: this.getAge(child.dob)
                    });
                    childListWithComma.push({ seconename: child.firstname + ' ' + child.lastname, seconeage: this.getAge(child.dob) });

                }
            });
        }
        return {
            childList: childList,
            childListWithComma: childListWithComma
        };
    }

    safecCaregiversList() {
        const caregiversList: any[] = [];
        if (this.safetySignPersons && this.safetySignPersons.length) {
            this.safetySignPersons.forEach(person => {
                let rolesDesc = '';
                if (person.roles && person.roles.length) {
                    rolesDesc = person.roles.map(role => role.typedescription).filter(x => (x !== 'Reporter')).join();
                }
                caregiversList.push(person.firstname + ' ' + person.lastname + ' (' + rolesDesc + ') ');
            });
        }
        return JSON.stringify(caregiversList);
    }

    safecAge(submissionData: any){
        if (this.reportedChildDetails && this.reportedChildDetails.length) {
            if (submissionData['age'] === '') {
                return this.getAge(this.reportedChildDetails[0].dob);
            } else {
                return submissionData['age'];
            }
        } else {
            return submissionData['age'];
        }
    }
        

    safecAddChildren(submissionData: any){
        let addchildren = [];
        if (submissionData['addchildren'] && submissionData['addchildren'].length && (submissionData['addchildren'][0].seconename !== '') ) {
            for (const element of submissionData['addchildren']) {
                addchildren.push(element);
            }
        } else {
            addchildren = this.safecAddChildren1();
        }

        return addchildren;
    }

    safecAddChildren1(){
        let addchildren: any = [];
        const under18Years = this.under18childDetails.filter(age => {
            const calAge = this.getAge(age.dob);
            return calAge !== '' && calAge <= 18;
        });
        if (under18Years && under18Years.length) {
            under18Years.forEach(child => {
                this.victimChild = false;
                if (child.dateofdeath) {
                    return false;
                }
                if (child.ishousehold === 1 && !child.dateofdeath && child.roles.length > 0) {
                    addchildren = this.addChildren(child, addchildren);
                }
            });
        }
        return addchildren;
    }

    addChildren(child: any, addchildren: any){
        let otherChild = false;
        if (child.ishousehold === 1 && !child.dateofdeath && child.roles.length > 0) {
            for (const element of child.roles) {
                if (element.intakeservicerequestpersontypekey === 'AV') {
                    this.victimChild = true;
                }
                if (element.intakeservicerequestpersontypekey === 'OTHERCHILD') {
                    otherChild = true;
                }
            }
            if (!this.victimChild && otherChild) {
                addchildren.push({ seconename: child.firstname + ' ' + child.lastname, seconeage: this.getAge(child.dob) });
            }
        }
        return addchildren;
    }
    safecGetSupervisorName(submissionData: any) {
        if (submissionData['supervisorname'] === '') {
            if (this.supervisorName) {
                return this.supervisorName;
            } else {
                return submissionData['supervisorname'];
            }
        } else {
            return submissionData['supervisorname'];
        }
    }
    
    safecGetSupervisorTitle(submissionData: any){
        if (submissionData['supervisorname'] === '') {
            if (this.supervisorName) {
                return 'Supervisor';
            } else {
                return submissionData['supervisortitle'];
            }
        } else {
            return submissionData['supervisortitle'];
        }

    }

  

    safecGetWorkerName(submissionData: any){
        if (submissionData['workersname'] === '') {
            if (this.caseWorkerName) {
                return this.token.role.name === 'field' ? this.token.user.userprofile.fullname : this.caseWorkerName;
            } else {
                return submissionData['workersname']; 
            }
        } else {
            return submissionData['workersname']; 
        }
        
    }

    safecGetWorkerTitle(submissionData: any){
        if (submissionData['workersname'] === '') {
            if (this.caseWorkerName) {
                return 'Case Worker';
            } else {
                return submissionData['workertitle']; 
            }
        } else {
            return submissionData['workertitle']; 
        }
    }

    safecSafetySignPersons(submissionData: any) {
        if (submissionData['associatedetails'] && submissionData['associatedetails'][0] &&
            submissionData['associatedetails'][0].intakeservicerequestactorid === '') {
            if (this.safetySignPersons && submissionData.assessmentreviewed === 'InProcess') {
                submissionData['associatedetails'] = [];
                this.safetySignPersons.forEach(person => {
                    const personRole = this.checkPersonRole(person);
                    submissionData['associatedetails'].push({
                        refusetosign: false,
                        UnavailabletoSign: false,
                        SignatureUploaded: false,
                        printedname: person.firstname + ' ' + person.lastname,
                        title: personRole.join(', '),
                        intakeservicerequestactorid: person.intakeservicerequestactorid,
                        email: person.email
                    });
                });
            }
        }

        return submissionData;
    }
    checkPersonRole(person: any) {
        const personRole: any[] = [];
        if (person.roles && person.roles.length) {
            person.roles.forEach((role: { typedescription: string; }) => {
                if (role.typedescription !== 'Reporter') {
                    personRole.push(role.typedescription);
                }
            });
        }
        return personRole;
    }

    public fillAOD(submissionData: any) {
        if (this.supervisorName) {
            submissionData['panel1553852294703002ColumnsChildWelfareCaseworkerssignature'] = this.fillAODCaseWorkerSignature(submissionData);
            submissionData['panel58292522685816ColumnsChildWelfareCaseworker'] = this.fillAODCaseWorkerName(submissionData);
            submissionData['panel58292522685816ColumnsPhoneNumber'] = this.fillAODPhoneNumber(submissionData);
            submissionData['supervisorname'] =  this.fillAODSupervisorName(submissionData);
            submissionData['supervisortitle'] = this.fillAODSupervisorTitle(submissionData);
        }
        if (this.caseWorkerName) {
            submissionData['panel58292522685816ColumnsChildWelfareCaseworker2'] = this.fillAODCWSupervisorName(submissionData);
            submissionData['panel58292522685816ColumnsPhoneNumber2'] = this.fillAODPhoneNumber2(submissionData);
        }

        if (this.reportedChildDetails.length) {
            submissionData['panel58292522685816ColumnsChildWelfareCaseworker3'] = this.fillAODFullName(submissionData)
            submissionData['panel58292522685816ColumnsDate2'] = this.fillAODDOB(submissionData);
            submissionData['panel58292522685816Columns3ClientId'] = this.fillAODClientPhone(submissionData);  // Client Telephone Number
            submissionData['panel58292522685816Columns4McOifapplicable'] = this.fillAODClientAddress(submissionData); // Client Address
        }
        if (this.reportedChildDetails.length) {
            const childNames = new Array();
            submissionData['clientNameList'] = (Array.isArray(submissionData['clientNameList']) && submissionData['clientNameList'].length) ?
                submissionData['clientNameList'] : [];
            submissionData['panel10805544092530561DataGrid'] = [];
            this.reportedChildDetails.forEach(child => {
                childNames.push(this.getFullName(child));
                submissionData['clientNameList'].push({
                    ClientName: this.getFullName(child),
                    ClientDOB: this.getFormattedDOB(child.dob),
                    ClientAddress: this.getFormattedAddress(child),
                    ClientContact: child.phonenumber
                });
            });
            submissionData['childList'] = JSON.stringify(childNames);
        }

             this.drugList = this._dataStoreService?.getData('CASEWORKER_DRUG_LIST');
             if ( this.drugList && this.drugList.length && Array.isArray(this.drugList)) {
                submissionData['drugList'] = JSON.stringify(this.drugList);
             }
             submissionData['userrole'] = this.token.role.name;
            submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);

        return submissionData;
    }

    fillAODCaseWorkerSignature(submissionData: any){
        return submissionData['panel1553852294703002ColumnsChildWelfareCaseworkerssignature'] ?
        submissionData['panel1553852294703002ColumnsChildWelfareCaseworkerssignature'] : this.caseWorkerName;
    }

    fillAODCaseWorkerName(submissionData: any){
        return submissionData['panel58292522685816ColumnsChildWelfareCaseworker'] ?
            submissionData['panel58292522685816ColumnsChildWelfareCaseworker'] : this.caseWorkerName;
    }

    fillAODPhoneNumber(submissionData: any){
        return submissionData['panel58292522685816ColumnsPhoneNumber'] ?
        submissionData['panel58292522685816ColumnsPhoneNumber'] :  null;
    }

    fillAODSupervisorName(submissionData: any){
        return submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
    }

    fillAODSupervisorTitle(submissionData: any){
        return submissionData['supervisortitle'] ? submissionData['supervisortitle'] : 'Supervisor';
    }

    fillAODCWSupervisorName(submissionData: any){
        return submissionData['panel58292522685816ColumnsChildWelfareCaseworker2'] ?
        submissionData['panel58292522685816ColumnsChildWelfareCaseworker2'] : this.supervisorName;
    }

    fillAODPhoneNumber2(submissionData: any){
        return submissionData['panel58292522685816ColumnsPhoneNumber2'] ?
                submissionData['panel58292522685816ColumnsPhoneNumber2'] : null;
    }

    fillAODFullName(submissionData: any){
        return submissionData['panel58292522685816ColumnsChildWelfareCaseworker3'] ?
                submissionData['panel58292522685816ColumnsChildWelfareCaseworker3'] : this.getFullName(this.reportedChildDetails[0]);
    }

    fillAODDOB(submissionData: any){
        return submissionData['panel58292522685816ColumnsDate2'] ?
                submissionData['panel58292522685816ColumnsDate2'] : this.getFormattedDate(this.reportedChildDetails[0].dob);
    }

    fillAODClientPhone(submissionData: any) {
        return submissionData['panel58292522685816Columns3ClientId'] ?
        submissionData['panel58292522685816Columns3ClientId'] : this.reportedChildDetails[0].phonenumber
    }

    fillAODClientAddress(submissionData: any) {
        return submissionData['panel58292522685816Columns4McOifapplicable'] ?
        submissionData['panel58292522685816Columns4McOifapplicable'] : this.getChildFormattedAddress(this.reportedChildDetails[0]);
    }


    public fillRiskAssessmentLegacy(submissionData: any, daNumber: any) {
        if (this.caseHeadDetail.length) {
            submissionData['Casehead'] = this.caseHeadDetail[0].firstname + ' ' + this.caseHeadDetail[0].lastname;

        }
        if (submissionData['cpsid'] === '') {
            submissionData['cpsid'] = daNumber;
        }
        if (this.supervisorName) {
            submissionData['SupervisorName'] =  this.getSupervisor(submissionData);
        }

        const childandHouseholdList = this.fillRALChildandHouseholdList(submissionData);     
        const childcharacteristicsList = this.fillRALChildcharacteristicsList(submissionData);    
        const childAgeList = this.fillRALChildAgeList(submissionData);

        if (this.safetySignPersons && this.safetySignPersons.length) {
        this.safetySignPersons.forEach(person => {
            let rolesDesc = '';
            if (person.roles && person.roles.length) {
                person.roles.forEach((role, index) => {
                    rolesDesc =  rolesDesc +  role.typedescription + (( index !== person.roles.length - 1) ? ', ' : '');
                });
            }
        });
        }

        submissionData['CHILDRENANDFAMILYINHOUSEHOLD2'] = childandHouseholdList;
        submissionData['CHILDCHARACTERISTICS']['DataGrid1'] = childcharacteristicsList;
        submissionData['AGE2']['DataGrid22'] = childAgeList;
        return submissionData;
    }

    getSupervisor(submissionData: any){
        return submissionData['SupervisorName'] ? submissionData['SupervisorName'] : this.supervisorName;
    }

    fillRALChildandHouseholdList(submissionData: any) {
        if (submissionData && submissionData.CHILDRENANDFAMILYINHOUSEHOLD2 && submissionData.CHILDRENANDFAMILYINHOUSEHOLD2.length > 0) {
            return this.fillRALChildandHouseholdListA(submissionData);
        } else {
            return this.fillRALChildandHouseholdListB(submissionData);
        }
    }

    fillRALChildandHouseholdListA(submissionData: any) {
        const childandHouseholdList = [];
        if (submissionData.CHILDRENANDFAMILYINHOUSEHOLD2[0].age || (submissionData.CHILDRENANDFAMILYINHOUSEHOLD2[0].age !== '')) {
            for (const element of submissionData.CHILDRENANDFAMILYINHOUSEHOLD2) {
                if (element.childname) {
                    childandHouseholdList.push({
                        childname: element.childname,
                        age: element.age,
                        dob: element.dob
                    });
                }
            }
        } else {
            if (this.houseHoldDetail.length) {
                this.houseHoldDetail.forEach(child => {
                    if (child.firstname && child.lastname) {
                        childandHouseholdList.push({
                            childname: child.firstname + ' ' + child.lastname,
                            age: this.getAge(child.dob),
                            dob: this.getFormattedDOB(child.dob)
                        });
                    }
                });
            }
        }
        return childandHouseholdList;
    }

    fillRALChildandHouseholdListB(submissionData: any) {
        const childandHouseholdList: any[] = [];
        if (this.houseHoldDetail.length) {
            this.houseHoldDetail.forEach(child => {
                if (child.childname) {
                    childandHouseholdList.push({
                        childname: child.firstname + ' ' + child.lastname,
                        age: this.getAge(child.dob),
                        dob: this.getFormattedDOB(child.dob)
                    });
                }
            });
        }
        return childandHouseholdList;
    }

    fillRALChildcharacteristicsList(submissionData: any){
        if (submissionData && submissionData.CHILDCHARACTERISTICS.DataGrid1 && submissionData.CHILDCHARACTERISTICS.DataGrid1.length > 0) {
            return this.fillRALChildcharacteristicsListA(submissionData);
        } else {
            return this.fillRALChildcharacteristicsListB(submissionData);
        }

    }

    fillRALChildcharacteristicsListA(submissionData: any){
        const childcharacteristicsList = [];
        if (submissionData.CHILDCHARACTERISTICS.DataGrid1[0].AGE || (submissionData.CHILDCHARACTERISTICS.DataGrid1[0].AGE !== '')) {
            for (let i = 0; i < submissionData.CHILDCHARACTERISTICS.length; i++) {
                if ( submissionData.CHILDCHARACTERISTICS.DataGrid1[i].ChildName) {
                    childcharacteristicsList.push({
                        ChildName: submissionData.CHILDCHARACTERISTICS.DataGrid1[i].ChildName,
                        ChildFunctioning: submissionData.CHILDCHARACTERISTICS.DataGrid1[i].ChildFunctioning,
                        RiskBasedonAGE: submissionData.CHILDCHARACTERISTICS.DataGrid1[i].RiskBasedonAGE,
                        AGE: submissionData.CHILDCHARACTERISTICS.DataGrid1[i].AGE,
                        CapacitytoSelfProtect: submissionData.CHILDCHARACTERISTICS.DataGrid1[i].CapacitytoSelfProtect
                    });
                }
            }
        } else {

            if (this.getChildList.length) {
                this.getChildList.forEach(child => {
                if (child.firstname && child.lastname) {
                    childcharacteristicsList.push({
                        ChildName: child.firstname + ' ' + child.lastname,
                        AGE: this.getAge(child.dob)
                    });
                  }
            });
          }
        }
        return childcharacteristicsList;

    }

    fillRALChildcharacteristicsListB(submissionData: any){
        const childcharacteristicsList: any[] = [];
        if (this.getChildList.length) {
            this.getChildList.forEach(child => {
            if (child.childname) {
                childcharacteristicsList.push({
                    childname: child.firstname + ' ' + child.lastname,
                    age: this.getAge(child.dob)
                });
            }
        });
       }
       return childcharacteristicsList;
        
    }


    fillRALChildAgeList(submissionData: any){
         if (submissionData && submissionData.AGE2.DataGrid22 && submissionData.AGE2.DataGrid22.length > 0) {
            return this.fillRALChildAgeListA(submissionData);
        } else {
            return this.fillRALChildAgeListB(submissionData);
        }
    }

    fillRALChildAgeListA(submissionData: any){
        const childAgeList = [];
        if (submissionData.AGE2.DataGrid22[0].AGE || (submissionData.AGE2.DataGrid22[0].AGE !== '')) {
            for (const element of submissionData.AGE2.DataGrid22) {
                if ( element.ChildName) {
                    childAgeList.push({
                        ChildName: element.ChildName,
                        ChildFunctioning: element.ChildFunctioning,
                        RiskBasedonAGE: element.RiskBasedonAGE,
                        AGE: element.AGE,
                        CapacitytoSelfProtect: element.CapacitytoSelfProtect
                    });
                }
            }
        } else {
            if (this.getChildList.length) {
                this.getChildList.forEach(child => {
                if (child.firstname && child.lastname) {
                    childAgeList.push({
                        ChildName: child.firstname + ' ' + child.lastname,
                        AGE: this.getAge(child.dob)
                    });
                  }
            });
          }
        }
        return childAgeList;
    }

    fillRALChildAgeListB(submissionData: any) {
        const childAgeList: any[] = [];
        if (this.getChildList.length) {
            this.getChildList.forEach(child => {
                if (child.childname) {
                    childAgeList.push({
                        childname: child.firstname + ' ' + child.lastname,
                        age: this.getAge(child.dob)
                    });
                }
            });
        }
        return childAgeList;
    }

    private getFormattedDOB(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
            return moment(new Date(dateValue)).format(this.dtformat);
        } else {
            return '';
        }
    }
    private getFormattedAddress(data: any) {
        return (data.address ? data.address + ',' : '')
                          + (data.address2 ? data.address2  + ',' : '')
                        + (data.state ? data.state + ',' : '')
                         + (data.city ? data.city + ',' : '')
                         + (data.zipcode ? data.zipcode : '');
    }
    private getRelationShipByCaseHeadId(primaryuserid: any, secondaryuserid: any, relationshiparray: any) {
        let relationshipdesc= '';
        if(primaryuserid === secondaryuserid){
          relationshipdesc = 'Self';
        }else if(relationshiparray && relationshiparray.length) {
          const relationship = relationshiparray.filter((person: any) => ( person.primaryuserid === secondaryuserid && person.secondaryuserid === primaryuserid ) );
          if(relationship && relationship.length) {
            relationshipdesc = relationship[0].description;
          }
        }
    
        return relationshipdesc;
      }
    private getrelationship(person1id: any, person2id: any) {
        if (person1id === person2id) {
            return 'Self';
        }
        const data = this._dataStoreService?.getData('CASEWORKER_PERSON_RELATIONS');
        const personsList = (data) ? data : [];
        const person1 = personsList.find((item: { personid: any; }) => item.personid === person1id);
        const person1relationList = (person1 && Array.isArray(person1.relation)) ? person1.relation : [];
        const person2inperson1 = (person1relationList) ? person1relationList.find((item: { person2id: any; }) => item.person2id === person2id) : null;
        return (person2inperson1) ? person2inperson1.description : '';
    }
    public fillCansF(submissionData: any, daNumber: any) {
        submissionData['userrole'] = this.token.role.name;
        submissionData['caseheaddatetime'] = this.fillCansFcaseheaddatetime(submissionData);
        let caseheadid = '';
        if (this.caseHeadDetail.length) {
            caseheadid = this.caseHeadDetail[0].personid;
            submissionData['caseheadname'] =  this.fillCansFcaseheadname(submissionData);
            submissionData['caseheadid'] = this.fillCansFcaseheadid(submissionData);
            submissionData['caregiverrelationship'] =  this.fillCansFcaregiverrelationship(submissionData); 
        }
            submissionData['familygrid'] = [];
            if (this.careGiverDetailsWithHouseHold.length) {
                this.careGiverDetailsWithHouseHold.forEach(child => {
                    submissionData['familygrid'].push({
                        caregiveryouthname: this.getFullName(child),
                        caregiveryouthdob: this.getFormattedDate(child.dob),
                        caregiveryouthage: this.getAge(child.dob),
                        caregiveryouthrelationship: this.getrelationship(child.personid, caseheadid) // titleCase(child.relationship)
                    });
                });
            }
        submissionData['familygrid1'] = this.fillCansFchildList(caseheadid);
        submissionData['cpscaseid'] = this.fillCansFcpscaseid(submissionData, daNumber);
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName) {
            submissionData['supervisorname'] =  this.fillCansFsupervisorname(submissionData);
            submissionData['supervisortitle'] = this.fillCansFsupervisortitle(submissionData);
        }
        if (this.caseWorkerName) {
            submissionData['workersname'] =  this.fillCansFworkersname(submissionData);
            submissionData['workertitle'] = this.fillCansFworkertitle(submissionData);
            submissionData['workernameandId'] = this.fillCansFworkernameandId(submissionData);
        }
        submissionData['workerdate'] = this.fillCansFworkerdate(submissionData);
        return submissionData;
    }

    fillCansFcaseheaddatetime(submissionData: any) {
        return submissionData['caseheaddatetime'] ? submissionData['caseheaddatetime'] : moment(new Date()).format(this.dtformat2);
    }

    fillCansFcaseheadname(submissionData: any) {
        return submissionData['caseheadname'] ? submissionData['caseheadname'] : this.getFullName(this.caseHeadDetail[0]);
    }

    fillCansFcaseheadid(submissionData: any) {
        return submissionData['caseheadid']  ? submissionData['caseheadid']  : this.getCaseHeadId(this.caseHeadDetail[0]);
    }

    fillCansFcaregiverrelationship(submissionData: any) {
        return submissionData['caregiverrelationship'] ? submissionData['caregiverrelationship'] : titleCase(this.caseHeadDetail[0].relationship);
    }

    fillCansFchildList(caseheadid: any) {
        const childList: any[] = [];
        this.getChildList.forEach(child => {
            if (child.firstname && child.lastname) {
                childList.push({
                    fg1childname: child.firstname + ' ' + child.lastname,
                    fg1childdob: child.dob,
                    fg1childschool: child.schoolname,
                    fg1childrelationship: this.getrelationship(child.personid, caseheadid),
                    fg1childage: this.getAge(child.dob),
                });
            }
        });

        return childList;
    }

    fillCansFcpscaseid(submissionData: any, daNumber: any) {
        return submissionData['cpscaseid'] ? submissionData['cpscaseid'] : daNumber;
    }

    fillCansFsupervisorname(submissionData: any) {
        return submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
    }

    fillCansFsupervisortitle(submissionData: any) {
        return submissionData['supervisortitle'] ? submissionData['supervisortitle'] : 'Supervisor';
    }

    fillCansFworkersname(submissionData: any) {
        return submissionData['workersname'] ? submissionData['workersname'] : this.supervisorName;
    }

    fillCansFworkertitle(submissionData: any) {
        return submissionData['workertitle'] ? submissionData['workertitle'] : 'Supervisor';
    }
    fillCansFworkernameandId(submissionData: any) {
        return submissionData['workernameandId'] ? submissionData['workernameandId'] : this.caseWorkerName;
    }

    fillCansFworkerdate(submissionData: any) {
        return submissionData['workerdate'] ? submissionData['workerdate'] : moment(new Date()).format(this.dtformat2);
    }
    
    public fillMFRR(submissionData: any, daNumber: any) {
        submissionData['userrole'] = this.token.role.name;
        submissionData['assessmentInitiated'] =  submissionData['assessmentInitiated'] ?  submissionData['assessmentInitiated']:moment(new Date()).format('YYYY-MM-DD HH:mm');
        if (this.caseHeadDetail.length) {
            submissionData['caseheadname'] = this.getFullName(this.caseHeadDetail[0]);
            this.caseheadid = this.caseHeadDetail[0].personid;
            this.relationshiparray = this.caseHeadDetail[0].relationshiparray;
        }
        if (!submissionData['familygrid'] || !submissionData['familygrid'].find((item: { childrenname: any; }) => item.childrenname)) {
            submissionData['familygrid'] = [];
            if (this.houseHoldDetail.length) {
                this.houseHoldDetail.forEach(house => {
                    submissionData['familygrid'].push({
                        childrenname: this.getFullName(house),
                        childrendob: this.getFormattedDate(house.dob),
                        childrenage: this.getAge(house.dob),
                        childrenrelationship: this.getRelationShipByCaseHeadId(house.personid, this.caseheadid, this.relationshiparray)
                    });
                });
            }
        }
        if (this.caseWorkerName) {
            submissionData['caseworkername'] = submissionData['caseworkername'] ? submissionData['caseworkername'] : this.caseWorkerName;
        }
        if (this.supervisorName) {
            submissionData['supervisorname'] = submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
         }
        submissionData['servicecaseID'] = daNumber;
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        return submissionData;
    }
    public fillMFRA(submissionData: any, daNumber: any) {
        submissionData['userrole'] = this.token.role.name;
        submissionData['assessmentInitiated'] =  this.fillMFRAassessmentInitiated(submissionData);
        if (this.caseHeadDetail.length) {
            submissionData['caseheadname'] = this.fillMFRAcaseheadname(submissionData);
        }
        if (submissionData['familygrid'] && submissionData['familygrid'][0].childrenname === '') {
            submissionData['familygrid'] = [];
            if (this.houseHoldDetail.length) {
                this.houseHoldDetail.forEach(house => {
                    submissionData['familygrid'].push({
                        childrenname: this.getFullName(house),
                        childrendob: this.getFormattedDate(house.dob),
                        childrenrelationship: titleCase(house.relationship)
                    });
                });
            }
        } else {
            if (submissionData['familygrid'] && submissionData['familygrid'].length) {
                const familyList: any[] = [];
                submissionData['familygrid'].forEach((house: any) => {
                familyList.push (house);
                });
                submissionData['familygrid'] = familyList;
            }
        }
        if (this.caseWorkerName) {
            submissionData['caseworkername'] =  this.fillMFRAcaseworkername(submissionData);
        }
        submissionData['servicecaseID'] =  this.fillMFRAservicecaseID(submissionData, daNumber);
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName) {
            submissionData['supervisorname'] = this.fillMFRAsupervisorname(submissionData);
        }
        return submissionData;
    }

    fillMFRAassessmentInitiated(submissionData: any){
        return submissionData['assessmentInitiated'] ?  submissionData['assessmentInitiated'] : moment(new Date()).format(this.dtformat2);
    }

    fillMFRAcaseheadname(submissionData: any){
        return submissionData['caseheadname'] ? submissionData['caseheadname'] : this.getMfraFullName(this.caseHeadDetail[0]);
    }

    fillMFRAcaseworkername(submissionData: any){
        return submissionData['caseworkername'] ?  submissionData['caseworkername'] : this.caseWorkerName;
    }

    fillMFRAservicecaseID(submissionData: any, daNumber: any){
        return submissionData['servicecaseID'] ?  submissionData['servicecaseID'] : daNumber;
    }

    fillMFRAsupervisorname(submissionData: any){
        return submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
    }

    get placementDetails() {
        const currentStore = this._dataStoreService?.getCurrentStore();
        let placementInfo = [];
        if (currentStore) {
        placementInfo = currentStore['CASEWORKER_PLACEMENT_INFO'];
        }
        return placementInfo;
    }
    public fillSafeCOHP(submissionData: any, daNumber: any, placements: any[], removedChidren: any[]) {
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        submissionData['supervisorname'] = this.getSafeCOHPSupervisorName(submissionData);
        submissionData['userrole'] = this.token.role.name;
        submissionData['dateassessmentinitiated'] = this.getSafeCOHPdateassessmentinitiated(submissionData);
        submissionData['approveddate'] = moment(new Date()).format(this.dtformat2);
        submissionData['caseid'] = daNumber;
        submissionData['casehead'] = this.getSafeCOHPcasehead(submissionData);

        if (this.removedChildDetailsIncludingOther.length) {
            this.safeCOHPchildList = [];
            this.safeCOHPchildListWithComma = [];
            const childsNames = this.getSafeCOHPChildNames();
            submissionData['childs_names_json'] = JSON.stringify(childsNames);
            submissionData['ClientName'] = this.getSafeCOHPClientName(submissionData, childsNames);
            submissionData['dob'] = this.getSafeCOHPdob(submissionData);
            submissionData['clientid'] = this.getSafeCOHPclientid(submissionData);
    
            this.getSafeCOHPChildListWithComma(placements);
            this.getSafeCOHPChildList();
            if (this.safeCOHPchildList && this.safeCOHPchildList.length) {
                let providerInfo;
                const childInfo = this.safeCOHPchildList.filter((child) => child.childname === submissionData['ClientName']);
                if (childInfo && childInfo.length > 0) {
                    providerInfo = childInfo[0].providerInfo;
                    if (providerInfo) {     
                        submissionData['placementlivingarrangement'] = providerInfo.providername;
                        submissionData['addressline1'] = this.getSafeCOHPAddressLine1(submissionData, providerInfo);
                        submissionData['addressline2'] = this.getSafeCOHPAddressLine2(submissionData, providerInfo);
                        submissionData['zipcode'] = this.getSafeCOHPzipcode(submissionData, providerInfo);
                        submissionData['ext'] = '';
                        submissionData['fax'] = '';
                        submissionData['work'] = providerInfo.phonenumber;
                    }
                }
            }

            submissionData['childs_info_json'] = JSON.stringify(this.safeCOHPchildList);
            submissionData['child_info_with_comma_json'] = JSON.stringify(this.safeCOHPchildListWithComma);
        }
        submissionData['supervisor'] = this.getSafeCOHPSupervisor(submissionData);
        submissionData['assessor'] = this.getSafeCOHPAssessor(submissionData);
        submissionData['userrole'] = this.getSafeCOHPUserrole(submissionData);

        return submissionData;
    }

    getSafeCOHPAddressLine1(submissionData: any, providerInfo: any){
        return this.getProviderAddressLine1(providerInfo);
    }

    getSafeCOHPAddressLine2(submissioData: any, providerInfo: any){
        return this.getProviderAddressLine2(providerInfo);
    }

    getSafeCOHPzipcode(submissionData: any, providerInfo: any){
        return submissionData.zipcode ? submissionData.zipcode : providerInfo.adr_zip5_no;
    }

    getSafeCOHPChildNames() {
        const childsNames = new Array();
        this.removedChildDetailsIncludingOther.forEach(child => {
            if (child.firstname && child.lastname) {
                childsNames.push(child.firstname + ' ' + child.lastname);
            }
        });
        return childsNames;
    }
    

    getSafeCOHPChildListWithComma(placements: any){
         this.removedChildDetailsIncludingOther.forEach(child => {
            if (child.firstname && child.lastname) {
                const providerdettails = this.getProviderInfo(placements, child);
                this.safeCOHPchildList.push({
                    childname: child.firstname + ' ' + child.lastname,
                    clientid: child.cjamspid,
                    age: this.getAge(child.dob),
                    dob: this.getFormattedDate(child.dob),
                    providerInfo: (providerdettails && providerdettails.providerInfo) ? providerdettails.providerInfo : null,
                    hasActivePlacement: (providerdettails && providerdettails.hasActivePlacement) ? providerdettails.hasActivePlacement : null,
                    placementDetails: {}
                });
                this.safeCOHPchildListWithComma.push({ seconename: child.firstname + ' ' + child.lastname, seconeage: this.getAge(child.dob) });
            }
        });
    }

    getSafeCOHPChildList(){
        if (this.safeCOHPchildList.length > 0) {
            this.safeCOHPchildList.forEach((child, $index) => {
                if (this.placementDetails) {
                    this.safeCOHPPlacementCheck(child, $index);
                }
            });
        }
    }

    safeCOHPPlacementCheck(child: any, $index: any){
        this.placementDetails.forEach((place: any) => {
            if (child.clientid === place.cjamspid) {
                if (this.placementExists(place)) {
                    for (let i = 0; i < place.placements.length; i++) {
                        if (place.placements[i].enddate == null) {
                            this.safeCOHPchildList[$index].placementDetails = this.getSafeCOHPPlacements(place, i);
                            if (this.cpahomerevisionExists(place, i)) {
                                break;
                            }
                        }
                    }
                }
            }
        });
    }
    placementExists(place: any){
        if (place && place?.placements && place?.placements?.length > 0){
            return true;
        } else {
            return false;
        }
    }
    cpahomerevisionExists(place: any, i: number){
        if (place.placements[i].cpahomerevision && place.placements[i].cpahomerevision.length > 0) {
            return true;
        } else {
            return false;
        }
    }
    getSafeCOHPPlacements(place: any, i: number){
        return (place.placements && place.placements.length) ? place.placements[i] : {};
    }

    getSafeCOHPClientName(submissionData: any, childsNames: any){
        let data = submissionData['ClientName'];
        if (!submissionData['ClientName']) {
            data = childsNames[0];
        }
        return data;
    }

    getSafeCOHPdob(submissionData: any){
        let data = submissionData['dob'];
        if (submissionData['dob'] === '') {
            data = this.getFormattedDate(this.removedChildDetailsIncludingOther[0].dob);
        }
        return data;
    }

    getSafeCOHPclientid(submissionData: any){
        let data = submissionData['clientid'];
        if (submissionData['clientid'] === '') {
            data = this.removedChildDetailsIncludingOther[0].cjamspid;
        }
        return data;
    }

    getSafeCOHPcasehead(submissionData: any){
        let data = submissionData['casehead'];
        if (this.caseHeadDetail.length) {
            data = this.getFullName(this.caseHeadDetail[0]);
        }
        return data;
    }

    getSafeCOHPdateassessmentinitiated(submissionData: any){
        const data = submissionData['dateassessmentinitiated'];
        if (!submissionData['dateassessmentinitiated']) {
            submissionData['dateassessmentinitiated'] = moment(new Date()).format('YYYY-MM-DD HH:mm');
        }
        return data;
    }
  
    getSafeCOHPSupervisorName(submissionData: any){
        let data = submissionData['supervisorname'];
        if (this.supervisorName && submissionData['supervisorname'] === '') {
            data = this.supervisorName;
        }
        return data;
    }
   
    getSafeCOHPSupervisor(submissionData: any){
        let data = submissionData['supervisor'];
        if (this.supervisorName) {
            data = this.supervisorName;
        }
        return data;
    }
    getSafeCOHPAssessor(submissionData: any){
        let data = submissionData['assessor'];
        if (this.caseWorkerName) {
            data = submissionData['assessor'] ? submissionData['assessor'] : this.caseWorkerName;
        }
        return data;
    }

    getSafeCOHPUserrole(submissionData: any){
        let data = submissionData['userrole'];
        if (submissionData['assessor'] === this._authService?.getCurrentUser().user.userprofile.fullname) {
            data = 'field';
        }
        return data;
    }
    
    public fillHomeHealthReport(submissionData: any, daNumber: any) {
        const careGiverList = this.fillHomeHealthReportCareGiverList();
        submissionData['userrole'] = this.token.role.name;
        submissionData['casenumber'] = daNumber;
        if(!submissionData['nameofcaretaker']){
        submissionData['nameofcaretaker'] = '';
        }
            if (careGiverList && careGiverList.length) {
                const caregiverNames: any[] = [];
                careGiverList.forEach(item => {
                    caregiverNames.push(item.fullname.trim());
                });
                submissionData['caregiver_names_json'] = JSON.stringify(caregiverNames);
            }
         if (this.caseWorkerName) {
            submissionData['workername1'] = this.fillHomeHealthReportCaseWorkerName(submissionData);
        }
        if (this.supervisorName) {
            submissionData['supervisorname'] = this.fillHomeHealthReportSupervisorName(submissionData);
        }

        if (this.getChildListWithHouseHold.length) {
            const data = submissionData['sleepingarrangementsgrid'];
            if (!data) {
                submissionData['sleepingarrangementsgrid'] = [];
            }
            const children: any[] = [];
            this.getChildListWithHouseHold.forEach(child => {
                children.push({
                    childerenname: child.firstname + ' ' + child.lastname,
                    DOB: child.dob
                });
                if (!data) {
                    submissionData['sleepingarrangementsgrid'].push({
                        childnamelist: child.firstname + ' ' + child.lastname,
                        sharingbedwith : '',
                        sleepinglocation: ''
                    });
                }

            });
            submissionData['childrendetails'] = children;
            submissionData['childs_names_json'] = JSON.stringify(children.map(child => child.childerenname));
            submissionData['childrenhiddendetails'] = JSON.stringify(children);
        }
        if (this.getHouseHoldWithoutChild.length) {
            submissionData['adults_names_json'] = JSON.stringify(this.getHouseHoldWithoutChild.map(person => person.firstname + ' ' + person.lastname));
        }
        if (this.careGiverDetailsWithHouseHold.length) {
            const otherHouseHold: any[] = [];
            this.careGiverDetailsWithHouseHold.forEach(child => {
                otherHouseHold.push({
                    householdmembername: child.firstname + ' ' + child.lastname,
                    householdage: this.getAge(child.dob),
                    householdmemberrelationship: titleCase(child.relationship),
                    householdpersonid: child.personid
                });
            });
            submissionData['householdmemberdetail'] = otherHouseHold;
        }
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        return submissionData;
    }

    fillHomeHealthReportCareGiverList() {
        const careGiverPersonIds = this._dataStoreService?.getData('ALL_CAREGIVERS_IN_CASE');
        let careGiverList: any[] = [];
        if(careGiverPersonIds && careGiverPersonIds.length){
            careGiverList = this.involvedPersons.filter(person => (careGiverPersonIds.includes(person.personid) && person.ishousehold === 1))
        }
        return careGiverList;
    }

    fillHomeHealthReportCaseWorkerName(submissionData: any){
        return submissionData['workername1'] ? submissionData['workername1'] : this.caseWorkerName;
    }

    fillHomeHealthReportSupervisorName(submissionData: any){
        return submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
    }
    
    public fillTransportationPlan(submissionData: any, daNumber: any, childDetail: any) {
        const childsNames = new Array();
        this.removedChildDetailsIncludingOther.forEach(child => {
            if (child.firstname && child.lastname) {
                childsNames.push(child.firstname + ' ' + child.lastname);}
        });
        submissionData['userrole'] = this.token.role.name;
        if (this.reportedChildDetails.length) {
            submissionData['studentname'] = childsNames[0];
            submissionData['studentdob'] = this.getFormattedDate(this.removedChildDetailsIncludingOther?.[0]?.dob);
        }
        if (childDetail.length && childDetail[0].schoolname && childDetail[0].schoolname.length && childDetail[0].schoolname[0]) {
            submissionData['localdepartmentofsocialservices'] = childDetail[0].schoolname[0].educationname;
            submissionData['currentgrade'] = childDetail[0].schoolname[0].typedescription;
        }
        if (this.caseWorkerName && submissionData['caseworkername'] === '') {
            submissionData['caseworkername'] = this.caseWorkerName;
        }
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName && submissionData['supervisorname'] === '') {
            submissionData['supervisorname'] = this.supervisorName;
        }
        return submissionData;
    }
    public fillBestInterestDetermination(submissionData: any, daNumber: any, currentUser: any, educationDetails: any) {
        submissionData['userrole'] = this.token.role.name;
        if (this.participantDetail.length && this._dataStoreService?.getData('CASEWORKER_SELECTED_ASSESSMENT') 
                        && this._dataStoreService?.getData('CASEWORKER_SELECTED_ASSESSMENT').mode !== "update" ) {
            submissionData['bestInterestsDeterminationMeetingParticipants'] = [];
            this.participantDetail.forEach(person => {
                submissionData['bestInterestsDeterminationMeetingParticipants'].push({
                    fname: person.firstname,
                    lname2: person.lastname,
                    // relationshiptostudent: person.relationshipdescription.replace(/\w\S*/g, txt => txt[0].toUpperCase() + txt.substr(1).toLowerCase()),
                    // otherrelation: person,
                    phonenumber: person.phonenumber,
                    emailid: person.email
                });
            });
        }
        if (this.reportedChildDetails.length) {
            submissionData = this.fillBestInterestDeterminationA(submissionData, educationDetails);
        }
        return submissionData;
    }

    fillBIDSupervisorName(submissionData: any){
        return submissionData['supervisorname'] !== '' ? submissionData['supervisorname'] : this.supervisorName;
    }

    fillBIDCaseWorkerName(submissionData: any){
        return submissionData['caseworkername'] ? submissionData['caseworkername'] : this.caseWorkerName;
    }

    fillBestInterestDeterminationA(submissionData: any, educationDetails: any) {
        submissionData['date'] = moment(new Date()).format(this.dtformat1);
        submissionData['supervisorname'] = this.fillBIDSupervisorName(submissionData);
        submissionData['caseworkername'] = this.fillBIDCaseWorkerName(submissionData);
        this.persondetail = this.reportedChildDetails;
        this.educationDetails = educationDetails;
        if (this.educationDetails && this.educationDetails.length > 0) {
            for (const element of this.persondetail) {
                for (const educationElement of this.educationDetails) {
                    if (element.personid === educationElement.Pid) {
                        element.education = educationElement.personEducation;
                    }
                }
            }
        }
        submissionData = this.fillBestInterestDeterminationB(submissionData);
        return submissionData;
    }
    fillBestInterestDeterminationB(submissionData: any) {
        const childNames = new Array();
        const studentList: any[] = [];
        const childListWithComma: any[] = [];
        this.persondetail.forEach(child => {
            if (child.firstname && child.lastname) {
                childNames.push(child.firstname + ' ' + child.lastname);
                studentList.push({
                    studentname: child.firstname + ' ' + child.lastname,
                    dob: this.getFormattedDate(child.dob),
                    personid: child.personid,
                    education: child.education
                });
                childListWithComma.push({ seconename: child.firstname + ' ' + child.lastname, seconeage: this.getAge(child.dob) });
            }
        });
        submissionData['studentList'] = JSON.stringify(childNames);
        submissionData['child_info_with_comma_json'] = JSON.stringify(childListWithComma);
        submissionData['childs_info_json'] = JSON.stringify(studentList);
        submissionData['studentname'] = submissionData['studentname'] ? submissionData['studentname'] : childNames[0];
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);

        submissionData = this.fillBestInterestDeterminationC(submissionData,studentList);
        return submissionData;
    }

    fillBestInterestDeterminationC(submissionData: any, studentList: any){
        if (studentList[0].education && studentList[0].education.length > 0) {
            for (const edu of studentList[0].education) {
                if (edu.schooltype === 'current') {
                    submissionData['currentschool'] = edu.educationname;
                    submissionData['grade'] = edu.currentgradeleveldesc;
                    submissionData['assignedstudent'] = edu.sasidno;
                } else {
                    submissionData['previousschool'] = edu.educationname;
                }
            }
        }
        if (submissionData['studentdob'] === '') {
            submissionData['studentdob'] = this.getFormattedDate(this.reportedChildDetails[0].dob);
        }
        submissionData = this.fillBestInterestDeterminationD(submissionData);
        return submissionData;
    }
    fillBestInterestDeterminationD(submissionData: any){

        if (this.reportedChildDetails[0].school && this.reportedChildDetails[0].school.length) {
            submissionData['grade'] = this.reportedChildDetails[0].school[0].typedescription;
            submissionData['currentschool'] = this.reportedChildDetails[0].school[0].educationname;
            submissionData['displaypreviousSchool'] = this.reportedChildDetails[0].school[0].educationname;
            if (this.reportedChildDetails[0].school.length > 1) {
                submissionData['currentschool'] = this.reportedChildDetails[0].school[this.reportedChildDetails[0].school.length - 1].educationname;
                submissionData['displaypreviousSchool'] = this.reportedChildDetails[0].school[this.reportedChildDetails[0].school.length - 1].educationname;
                submissionData['previousschool'] = this.reportedChildDetails[0].school[this.reportedChildDetails[0].school.length - 2].educationname;
            }
        }
        return submissionData;
    }
    public fillCaseyLifeSkills(submissionData: any, removalChildList: any) {
        submissionData['userrole'] = this.token.role.name;
        submissionData['nameList'] = [];
        if (this.involvedPersons.length) {           
            this.involvedPersons.forEach(item => {
                if(item.programarea && item.programarea.filter(prog=> ['OOH','GAP', 'ADP' ].includes(prog.programkey)).length>0){
                    submissionData['nameList'].push(item.firstname + ' ' + item.lastname);}
            });  
        }
        submissionData['name'] = submissionData['name'] ? submissionData['name'] : submissionData['nameList'][0];
        if (this.caseWorkerName && submissionData['caseworkername'] === '') {
            submissionData['caseworkername'] = this.caseWorkerName;
        }
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName) {
            submissionData['supervisorname'] = submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
         }
        return submissionData;
    }
    public fillNotificationOfPlacement(submissionData: any, removalChildList: any) { 
        submissionData['userrole'] = this.token.role.name;
        if (removalChildList && removalChildList.length) {
            submissionData['childname'] = [];
            const childlist: any[] = [];
            const childjson: any[] = [];
            removalChildList.map((item: any) => {
                childlist.push(item.firstname + ' ' + item.lastname);
                childjson.push({
                    childname: item.firstname + ' ' + item.lastname,
                    cjamspid: item.cjamspid,
                    dob: item.dob,
                    gender: item.gender,
                    removalDate: (item.removalInfo) ? item.removalInfo.removaldate : null
                });
            });
            submissionData['childname'] = childlist;
          if(submissionData?.childsName){
                submissionData['childname'] = submissionData['childname'].filter((ele: any)=>ele !== submissionData?.childsName);
                submissionData['childname']=submissionData['childname'].concat([submissionData?.childsName]);
            }
            submissionData['childsName'] =  submissionData['childname'];
            submissionData['child_info_json'] = JSON.stringify(childjson);
            submissionData['dob'] = removalChildList[removalChildList.length - 1].dob;
            submissionData['childClientId'] = removalChildList[removalChildList.length - 1].cjamspid;
            if (removalChildList[removalChildList.length - 1].gender === 'Male' || removalChildList[removalChildList.length - 1].gender === 'M') {
                submissionData['childgender'] = 'male';
            }
            if (removalChildList[removalChildList.length - 1].gender === 'Female' || removalChildList[removalChildList.length - 1].gender === 'F') {
                submissionData['childgender'] = 'female';
            }
            const minDate = (removalChildList[removalChildList.length - 1].removalInfo) ?
                            moment(removalChildList[removalChildList.length - 1].removalInfo.removaldate).format(this.dtformat) : 
                                this._dataStoreService?.getData('dsdsActionsSummary').case_opendate;
            const startDate = (<any>$(`[name="data[placemententrydatetime]"]`)[0])._flatpickr;
            startDate.set('minDate', new Date(minDate));
            const exitDate = (<any>$(`[name="data[placementexitdatetime]"]`)[0])._flatpickr;
            exitDate.set('minDate', new Date(minDate));
        }
        submissionData['supervisorname'] = this.supervisorName;
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        return submissionData;
    }
    public fillCansOutOfHomePlacement(submissionData: any, daNumber: any, currentUser: any, placement: any, assessment: any) {
        if (assessment.mode === 'start') {
            submissionData['liftdomainfunction'] = assessmentData.liftdomainfunction;
            submissionData['liftdomainfunction2'] = assessmentData.liftdomainfunction2;
            submissionData['childandenvironmentstrength'] = assessmentData.childandenvironmentstrength;
            submissionData['childandenvironmentstrength2'] = assessmentData.childandenvironmentstrength2;
            submissionData['childemotinalneeds'] = assessmentData.childemotinalneeds;
            submissionData['childriskbehaviour'] = assessmentData.childriskbehaviour;
            submissionData['Surveyculturalfactors'] = assessmentData.Surveyculturalfactors;
            submissionData['surveytrauma'] = assessmentData.surveytrauma;
            submissionData['surveystress'] = assessmentData.surveystress;
        }
        submissionData['userrole'] = this.token.role.name;
        if (this.reportedChildDetails.length) {
            submissionData['date'] = moment(new Date()).format(this.dtformat2);
            submissionData['assessmentdate'] = moment(new Date()).format(this.dtformat1);
            const childsNames = this.fillCansOutOfHomePlacementChildsNames();
            submissionData['childs_names_json'] = JSON.stringify(childsNames);
            submissionData['childname'] = childsNames[0];
            const childInfo = this.fillCansOutOfHomePlacementChildListInfo();
            const childList = childInfo.childList;
            const childListWithComma = childInfo.childListWithComma;
            submissionData['childs_info_json'] = JSON.stringify(childList);
            submissionData['child_info_with_comma_json'] = JSON.stringify(childListWithComma);
            submissionData['dob'] = this.getFormattedDate(this.reportedChildDetails[0].dob);
            submissionData['validate14to21'] = this.fillCansOutOfHomePlacementValidate14to21();
            submissionData['age'] = this.fillCansOutOfHomePlacementAge(submissionData);
            const schoolInfo = this.fillCansOutOfHomePlacementSchoolInfo(submissionData);
            submissionData['grade'] = schoolInfo.grade;
            submissionData['previousschool'] = schoolInfo.previousschool;
            submissionData['currentschool'] = schoolInfo.currentschool;
            submissionData['saseworkername'] = currentUser;
        }
        if (this.caseHeadDetail.length) {
            submissionData['caseheadsname'] = this.getFullName(this.caseHeadDetail[0]);
            submissionData['relationship'] = titleCase(this.caseHeadDetail[0].relationship);
            submissionData['source'] = this.getAge(this.caseHeadDetail[0].dob);
        }
        if (this.caseWorkerName) {
            submissionData['columns8Columns2CaseWorkerNameField2'] = this.supervisorName;
            submissionData['workertitle'] = 'Supervisor';
            submissionData['score2'] = this.caseWorkerName;
            submissionData['columns8Columns2CaseWorkerNameField'] = this.caseWorkerName;
        }
        if (this.careGiverDetails.length) {
            submissionData['panel5079156779560240Columns44CaregiverFirstName'] = titleCase(this.careGiverDetails[0].firstname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName2'] = titleCase(this.careGiverDetails[0].lastname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName3'] = titleCase(this.careGiverDetails[0].relationship);
            submissionData['panel5079156779560240Columns44CaregiverFirstName4'] = titleCase(this.careGiverDetails[0].firstname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName5'] = titleCase(this.careGiverDetails[0].lastname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName6'] = titleCase(this.careGiverDetails[0].relationship);
            submissionData['panel5079156779560240Columns44CaregiverFirstName7'] = titleCase(this.careGiverDetails[0].firstname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName8'] = titleCase(this.careGiverDetails[0].lastname);
            submissionData['panel5079156779560240Columns44CaregiverFirstName9'] = titleCase(this.careGiverDetails[0].relationship);
            submissionData['nameofcaretaker'] = this.getFullName(this.careGiverDetails[0]);
            submissionData['casenumber'] = daNumber;
            if (this.careGiverDetails[0].address && this.careGiverDetails[0].address.length) {
                submissionData['address'] = this.careGiverDetails[0].address;
                submissionData['city'] = this.careGiverDetails[0].city;
                submissionData['state'] = this.careGiverDetails[0].state;
                submissionData['zip'] = this.careGiverDetails[0].zipcode;
            }
        }
        if (placement.length) {
            submissionData['panel5079156779560240Columns44CaregiverFirstName'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName2'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName3'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName4'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName5'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName6'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName7'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName8'] = 'NA';
            submissionData['panel5079156779560240Columns44CaregiverFirstName9'] = 'NA';
        }

        if (this.childDetails.length) {
            submissionData['familygrid'] = [];
            this.childDetails.forEach(child => {
                submissionData['familygrid'].push({
                    childrenname: this.getFullName(child),
                    childrendob: this.getFormattedDate(child.dob),
                    childrenage: this.getAge(child.dob),
                    childrenrelationship: titleCase(child.relationship),
                    primarycaregiver: ''
                });
            });
        }
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        return submissionData;
    }

    fillCansOutOfHomePlacementChildsNames() {
        const childsNames: any[] = [];
        this.reportedChildDetails.forEach(reportedChild => {
            if (reportedChild.firstname && reportedChild.lastname) {
                childsNames.push(reportedChild.firstname + ' ' + reportedChild.lastname);
            }
        });
        return childsNames;
    }

    fillCansOutOfHomePlacementChildListInfo() {
        const childList: any[] = [];
        const childListWithComma: any[] = [];
        this.reportedChildDetails.forEach(reportedChildData => {
            if (reportedChildData.firstname && reportedChildData.lastname) {
                childList.push({
                    childname: reportedChildData.firstname + ' ' + reportedChildData.lastname,
                    clientid: reportedChildData.cjamspid,
                    age: this.getAge(reportedChildData.dob)
                });
                childListWithComma.push({seconename: reportedChildData.firstname + ' ' + reportedChildData.lastname , seconeage: this.getAge(reportedChildData.dob) });
                }
        });
        return {
            childList: childList,
            childListWithComma: childListWithComma
        }
    }

    fillCansOutOfHomePlacementValidate14to21() {
        const age = this.getAge(this.reportedChildDetails[0].dob);
        return age !== '' && this.return14to21CheckFn(age);
    }

    return14to21CheckFn(age: any) {
        return (age >= 14 && age <= 21) ? true : false;
    }

    fillCansOutOfHomePlacementAge(submissionData: any) {
        return submissionData['age'] !== '' ? submissionData['age'] : this.getAge(this.reportedChildDetails[0].dob);
    }

    fillCansOutOfHomePlacementSchoolInfo(submissionData: any) {
        let grade = submissionData['grade'] ? submissionData['grade'] : '';
        let previousschool = submissionData['previousschool'] ? submissionData['previousschool'] : '';
        let currentschool = submissionData['currentschool'] ? submissionData['currentschool'] : '';
        if (this.reportedChildDetails[0].school && this.reportedChildDetails[0].school.length) {
            grade = this.reportedChildDetails[0].school[0].typedescription;
            previousschool = this.reportedChildDetails[0].school[0].educationname;
            if (this.reportedChildDetails[0].school.length > 1) {
                currentschool = this.reportedChildDetails[0].school[this.reportedChildDetails[0].school.length - 1].educationname;
            }
        }

        return {
            grade: grade,
            previousschool: previousschool,
            currentschool: currentschool
        }
    }

    public fillCinaShelterPetition(submissionData: any, childRemovalInfo: any, daNumber: any, workerName: any) {
            if (childRemovalInfo?.fatherdetails) {
                submissionData['fathername'] = childRemovalInfo.fatherdetails[0].firstname + ' ' + childRemovalInfo.fatherdetails[0].lastname;
            }
            if (childRemovalInfo?.motherdetails) {
                submissionData['mothername'] = childRemovalInfo.motherdetails[0].firstname + ' ' + childRemovalInfo.motherdetails[0].lastname;
            }
            if (childRemovalInfo?.fatherdetails && childRemovalInfo.fatherdetails.length && childRemovalInfo.fatherdetails[0].address 
                && childRemovalInfo.fatherdetails[0].address.length) {
                submissionData['fatheraddress1'] = childRemovalInfo.fatherdetails[0].address[0].address;
                submissionData['fatheraddress2'] = childRemovalInfo.fatherdetails[0].address[0].address2;
                submissionData['fathercity'] = childRemovalInfo.fatherdetails[0].address[0].city;
                submissionData['fatherstate'] = childRemovalInfo.fatherdetails[0].address[0].state;
                submissionData['fatherzip'] = childRemovalInfo.fatherdetails[0].address[0].zipcode;
            }

            if (childRemovalInfo?.motherdetails && childRemovalInfo.motherdetails.length && childRemovalInfo.motherdetails[0].address 
                && childRemovalInfo.motherdetails[0].address.length) {
                submissionData['motheraddress1'] = childRemovalInfo.motherdetails[0].address[0].address;
                submissionData['motheraddress2'] = childRemovalInfo.motherdetails[0].address[0].address2;
                submissionData['mothercity'] = childRemovalInfo.motherdetails[0].address[0].city;
                submissionData['motherstate'] = childRemovalInfo.motherdetails[0].address[0].state;
                submissionData['motherzip'] = childRemovalInfo.motherdetails[0].address[0].zipcode;
            }
            submissionData['physicallyremovedfullname'] = childRemovalInfo.removerName;
        if (childRemovalInfo?.childdetails) {
            submissionData['childsname'] = this.getFullName(childRemovalInfo.childdetails[0]);
            submissionData['childsdob'] = this.getFormattedDate(childRemovalInfo.childdetails[0].dob);
        }
        if (childRemovalInfo?.childdetails && childRemovalInfo.childdetails[0].address && childRemovalInfo.childdetails[0].address.length) {
            (submissionData['address1'] = childRemovalInfo.childdetails[0].address[0].address);
                (submissionData['address2'] = childRemovalInfo.childdetails[0].address[0].address2);
                (submissionData['city'] = childRemovalInfo.childdetails[0].address[0].city);
            submissionData['address3'] = childRemovalInfo.childdetails[0].address[0].state;
            submissionData['zip'] = childRemovalInfo.childdetails[0].address[0].zipcode;
        }
        submissionData['caseworkername'] = this.caseWorkerName;
        submissionData['supervisorname'] = this.supervisorName;
        submissionData['userrole'] = this.token.role.name;
        submissionData['clientnumber'] = daNumber;
        submissionData['workerdate'] = moment(new Date()).format(this.dtformat1);

        if (this.reportedAdultDetails.length) {
            submissionData['clientname'] = this.getFullName(this.reportedAdultDetails[0]);
            submissionData['dateofreferral'] = this.getFormattedDate(this.intakeWorkerDetails?.routedon);
        }

        if (this.intakeWorkerDetails) {
            submissionData['supervisorname'] = this.intakeWorkerDetails.tousername;
            submissionData['officername'] = this.intakeWorkerDetails.fromusername;
        }
        if (workerName) {
            submissionData['workername'] = workerName.da_assignedto.toUpperCase();
            submissionData['reportnumber'] = workerName.intakenumber;
        }

        return submissionData;
    }

    public fillProjectHomeApplication(submissionData: any) {
        submissionData['userrole'] = this.token.role.name;
        if (this.reportedAdultDetails) {
            submissionData['phonenumber'] = this.reportedAdultDetails[0].phonenumber;
            submissionData['applicantsname'] = this.getFullName(this.reportedAdultDetails[0]);
            submissionData['dob'] = this.getFormattedDate(this.reportedAdultDetails[0].dob);
            submissionData['ethnicity'] = this.fillProjectHomeApplicationEthnicity();
            submissionData['secondaryphone'] = this.fillProjectHomeApplicationSecondaryphone();
            submissionData['currentaddress'] = this.fillProjectHomeApplicationCurrentaddress();
            submissionData['address'] = this.getAddress(this.reportedAdultDetails[0]);
            submissionData['gender'] = this.fillProjectHomeApplicationGender(submissionData);
            submissionData = this.fillProjectHomeApplicationMedicalInfo(submissionData);

            if (this.reportedAdultDetails[0].behavioralhealth) {
                const behaviour = this.reportedAdultDetails[0].behavioralhealth[0];
                submissionData['currentpsychiatricdiagnoses'] = behaviour.currentdiagnoses;
                submissionData['psychiatricprovider'] = behaviour.clinicianname;
                submissionData['psychiatricproviderphone'] = behaviour.behavioralphone;
                submissionData['psychiatricprovideraddress'] = this.getBehaviourAddress(behaviour);
            }

            if (this.reportedAdultDetails[0].medicalcondition) {
                let medicalCondition = '';
                this.reportedAdultDetails[0].medicalcondition.forEach(item => {
                    medicalCondition += item.description + ',';
                });
                submissionData['currentmedicaldiagnoses'] = medicalCondition;
            }
            if (this.reportedAdultDetails[0].medicationinformation) {
                submissionData['medicationinformation'] = [];
                this.reportedAdultDetails[0].medicationinformation.forEach(item => {
                    submissionData['medicationinformation'].push({
                        medication: item.medicationname,
                        dosage: item.dosage,
                        frequency: item.frequency,
                        purpose: item.compliant
                    });
                });
            }
            submissionData = this.fillProjectHomeApplicationAddendum(submissionData);
        }
        if (this.intakeWorkerDetails) {
            submissionData['referralsourcename'] = this.intakeWorkerDetails.fromusername;
            submissionData['agency'] = 'Adult Service';
            submissionData['reasonforrefferal'] = this.intakeWorkerDetails.purpose;
            submissionData['agencyphone'] = this.intakeWorkerDetails.phonenumber;
            submissionData['refferaladdress'] = this.intakeWorkerDetails.address;
        }
        return submissionData;
    }

    fillProjectHomeApplicationEthnicity() {
       return this.reportedAdultDetails[0].ethnicgrouptypekey ? this.reportedAdultDetails[0].ethnicgrouptypekey : '';
    }

    fillProjectHomeApplicationSecondaryphone() {
        return this.reportedAdultDetails[0].secondaryphone ? this.reportedAdultDetails[0].secondaryphone : '';
    }

    fillProjectHomeApplicationCurrentaddress() {
        return this.reportedAdultDetails[0].currentaddress ? this.reportedAdultDetails[0].currentaddress : '';
    }

    fillProjectHomeApplicationGender(submissionData: any) {
        let gender = submissionData['gender'] ? submissionData['gender'] : '';
        if (this.reportedAdultDetails[0].gender === 'M') {
            gender = 'male';
        }
        if (this.reportedAdultDetails[0].gender === 'F') {
            gender = 'female';
        }
        return gender;
    }

    fillProjectHomeApplicationMedicalInfo(submissionData: any) {
        if (this.reportedAdultDetails[0].medicalinformation) {
            this.reportedAdultDetails[0].medicalinformation.forEach(item => {
                submissionData['privatehealthinsuranceid'] = item.policyname;
                if (item.ismedicaidmedicare) {
                    submissionData['privatehealthinsurance'] = 'Yes';
                    submissionData['medicare'] = 'Yes';
                }
                if (item.isprimaryphycisian) {
                    submissionData['primarycareprovider'] = item.name;
                    submissionData['primarycareproviderphone'] = item.phone;
                    submissionData['primarycareprovideraddress'] = this.getMedicationAddress(item);
                }
                if (!item.isprimaryphycisian) {
                    submissionData['medicalspecialists'] = item.name;
                    submissionData['medicalspecialistsphone'] = item.phone;
                    submissionData['medicalspecialistsaddress'] = this.getMedicationAddress(item);
                }
            });
        }

        return submissionData;
    }

    fillProjectHomeApplicationAddendum(submissionData: any) {
        if (this.reportedAdultDetails[0].addendum) {
            submissionData['chemicaldependencyInformation'] = [];
            if (this.reportedAdultDetails[0].addendum[0].isusedrug) {
                submissionData['chemicaldependencyInformation'].push({
                    substance: '5',
                    lastdateused: '',
                    howused: '',
                    frequency: this.reportedAdultDetails[0].addendum[0].drugfrequencydetails
                });
            }
            if (this.reportedAdultDetails[0].addendum[0].isusealcohol) {
                submissionData['chemicaldependencyInformation'].push({
                    substance: '1',
                    lastdateused: '',
                    howused: '',
                    frequency: this.reportedAdultDetails[0].addendum[0].drugfrequencydetails
                });
            }
            if (this.reportedAdultDetails[0].addendum[0].isusetobacco) {
                submissionData['chemicaldependencyInformation'].push({
                    substance: '16',
                    lastdateused: '',
                    howused: '',
                    frequency: this.reportedAdultDetails[0].addendum[0].drugfrequencydetails
                });
            }
        }
        return submissionData;
    }

    public fillResidentAgreement(submissionData: any) {
        submissionData['responsiblepartydate'] = moment(new Date()).format(this.dtformat1);
        submissionData['providerdate'] = moment(new Date()).format(this.dtformat1);
        submissionData['casemanagerdate'] = moment(new Date()).format(this.dtformat1);
        return submissionData;
    }

    public housingClassificationReAssessment(submissionData: any) {
        if (this.reportedDjsDetails) {
            submissionData['panel4481182037352658YourName'] = this.getFullName(this.reportedDjsDetails[0]);
        }
        return submissionData;
    }

    public djsHousingClassificationAssessment(submissionData: any) {
        if (this.reportedDjsDetails) {
            submissionData['panel3551413008391684ColumnsTextField'] = this.reportedDjsDetails[0].lastname;
            submissionData['panel3551413008391684ColumnsTextField2'] = this.reportedDjsDetails[0].firstname;
            submissionData['panel3551413008391684YouthDob'] = this.reportedDjsDetails[0].dob;
        }
        return submissionData;
    }

    public youthVulnerabilityAssessmentInstrument(submissionData: any) {
        if (this.reportedDjsDetails) {
            submissionData['panel6379524013801054ColumnsYouthsName'] = this.getFullName(this.reportedDjsDetails[0]);
            submissionData['panel6379524013801054ColumnsSex'] = this.reportedDjsDetails[0].gender;
            submissionData['panel6379524013801054ColumnsDob'] = this.reportedDjsDetails[0].dob;
        }
        return submissionData;
    }

    public fillAppla(submissionData: any) {
       const caseUserDeatails = this._dataStoreService?.getData('caseUserDetails');
        submissionData['userrole'] = this.token.role.name;
        if (this.supervisorName && 
            (submissionData['supervisorname'] === '' ||
            submissionData['supervisorname'] === undefined ||
            submissionData['supervisorname'] == null ) 
            ) {
            submissionData['supervisorname'] = caseUserDeatails ? caseUserDeatails[0].fromusername : this.supervisorName;
        }
        if (this.caseWorkerName&& 
            (submissionData['caseworkername'] === '' ||
            submissionData['caseworkername'] === undefined ||
            submissionData['caseworkername'] == null ) 
            ) {
            submissionData['caseworkername'] =  caseUserDeatails ? caseUserDeatails[0].tousername : this.caseWorkerName;
        }
        return submissionData;
    }

    public b_02735uniform45dayspredischarge(submissionData: any, youthInvolvedPersons: any) {
        submissionData['Date3'] = moment(new Date()).format(this.dtformat1);
        submissionData['Youthsname3'] = youthInvolvedPersons[0].youthname;
        submissionData['Date4'] = youthInvolvedPersons[0].youthdob;
        submissionData['ASSISTPID3'] = youthInvolvedPersons[0].assistpid;
        submissionData['ASSISTPID7'] = youthInvolvedPersons[0].cjamspid;
        submissionData['YouthsCounty'] = youthInvolvedPersons[0].youthjurisdiction;
        submissionData['Facility3'] = youthInvolvedPersons[0].activefacility;
        submissionData['Entertheyouthsprojecteddischargedate3'] = youthInvolvedPersons[0].projecteddischargedate;
        submissionData['ReEntrySpecialistforthiscase3'] = youthInvolvedPersons[0].caseworkercounty;
        return submissionData;
    }

    public b_02736postdischargere_enterytransitionplan(submissionData: any, youthInvolvedPersons: any) {
        submissionData['panel3799845984923247Date'] = moment(new Date()).format(this.dtformat1);
        submissionData['Youthsname'] = youthInvolvedPersons[0].youthname;
        submissionData['panel3799845984923247Date2'] = youthInvolvedPersons[0].youthdob;
        submissionData['ASSISTPID'] = youthInvolvedPersons[0].assistpid;
        submissionData['ASSISTPID2'] = youthInvolvedPersons[0].cjamspid;
        submissionData['Selectthejurisdictionofcurrentresidence'] = youthInvolvedPersons[0].youthjurisdiction;
        submissionData['Youthdischarged'] = youthInvolvedPersons[0].closedfacility;
        submissionData['panel3799845984923247Date3'] = youthInvolvedPersons[0].closeddischargedate;
        submissionData['SelectTheRegionoftheRe-EntrySpecialistforthisCase'] = youthInvolvedPersons[0].caseworkercounty;
        return submissionData;
    }

    public draiFollowUp(submissionData: any, youthInvolvedPersons: any) {
        submissionData['panel8439712137546045Dob'] = youthInvolvedPersons[0].youthdob;
        submissionData['panel8439712137546045YouthName'] = youthInvolvedPersons[0].youthname;
        submissionData['panel8439712137546045ColumnsCjamsid'] = youthInvolvedPersons[0].cjamspid;
        return submissionData;
    }

    public intakedrai(submissionData: any, youthInvolvedPersons: any, formdata: any) {
        switch (formdata.pend_adj) {
            case 1:
                formdata.pend_adj = 8;
                break;
            case 2:
                formdata.pend_adj = 4;
                break;
            case 3:
                formdata.pend_adj = 2;
                break;
            case 4:
                formdata.pend_adj = 0;
                break;
            default:
                formdata.pend_adj = -1;
                break;
        }
        switch (formdata.sus_adj_sup) {
            case 1:
                formdata.sus_adj_sup = 5;
                break;
            case 2:
                formdata.sus_adj_sup = 3;
                break;
            case 3:
                formdata.sus_adj_sup = 2;
                break;
            case 4:
                formdata.sus_adj_sup = 1;
                break;
            case 5:
                formdata.sus_adj_sup = 0;
                break;
            default:
                formdata.sus_adj_sup = -1;
                break;
        }
        switch (formdata.fta) {
            case 1:
                formdata.fta = 5;
                break;
            case 2:
                formdata.fta = 0;
                break;
            default:
                formdata.fta = -1;
                break;
        }
        switch (formdata.awol) {
            case 1:
                formdata.awol = 4;
                break;
            case 2:
                formdata.awol = 0;
                break;
            default:
                formdata.awol = -1;
                break;
        }
        switch (formdata.prior_det) {
            case 1:
                formdata.prior_det = 2;
                break;
            case 2:
                formdata.prior_det = 0;
                break;
            default:
                formdata.prior_det = -1;
                break;
        }
        switch (formdata.age_felony) {
            case 1:
                formdata.age_felony = 4;
                break;
            case 2:
                formdata.age_felony = 0;
                break;
            default:
                formdata.age_felony = -1;
                break;
        }
        submissionData['pc'] = this.intakedraiAA(formdata);
        submissionData['ps'] = this.intakedraiPS(formdata);
        submissionData['hf'] = this.intakedraiHF(formdata);
        submissionData['pd'] = this.intakedraiPD(formdata);
        submissionData['he'] = this.intakedraiHE(formdata);
        submissionData['aa'] = this.intakedraiAA(formdata);
        submissionData['panel86083281892257Columns2YouthName'] = this.intakedraiGetYouthName(youthInvolvedPersons);
        submissionData['panel86083281892257Columns3Cjamsid'] = this.intakedraiGetCJAMSpid(youthInvolvedPersons);
        submissionData['panel86083281892257Columns3DateofBirth'] = this.intakedraiGetDOB(youthInvolvedPersons);
        submissionData['panel86083281892257Columns3Race'] = this.intakedraiGetRace(youthInvolvedPersons);
        submissionData['Workername'] = this.supervisorName;
        submissionData['DRAICompleteddate'] = new Date();
        submissionData['Dateofdecision'] = new Date();
        if (youthInvolvedPersons && youthInvolvedPersons.race) {
            submissionData['panel86083281892257Columns3Race'] = youthInvolvedPersons.raceDescription;
        }
        if (youthInvolvedPersons && youthInvolvedPersons.racetypekey) {
            this._commonHttpService?.getArrayList(
                    {
                        method: 'get',
                        nolimit: true,
                        activeflag: 1,
                        order: 'typedescription'
                    },
                    NewUrlConfig.EndPoint.Intake.RaceTypeUrl + '?filter'
                )
                .subscribe(result => {
                    result.forEach(data => {
                        if (data.racetypekey === youthInvolvedPersons.racetypekey) {
                            submissionData['panel86083281892257Columns3Race'] = data.typedescription;
                        }
                    });
                });
        }
        submissionData['gender'] = this.intakedraiGetGender(youthInvolvedPersons);
        return submissionData;
    }

    intakedraiPC(formdata: { pend_adj: any; }){
        return formdata ? formdata.pend_adj : -1;
    }

    intakedraiPS(formdata: { sus_adj_sup: any; }){
        return formdata ? formdata.sus_adj_sup : -1;
    }

    intakedraiHF(formdata: { fta: any; }){
        return formdata ? formdata.fta : -1;
    }

    intakedraiPD(formdata: { awol: any; }){
        return formdata ? formdata.awol : -1;
    }

    intakedraiHE(formdata: { prior_det: any; }){
        return formdata ? formdata.prior_det : -1;
    }

    intakedraiAA(formdata: { age_felony: any; }){
        return formdata ? formdata.age_felony : -1;
    }

    intakedraiGetYouthName(youthInvolvedPersons: any){
        return youthInvolvedPersons ? youthInvolvedPersons.firstname + ' ' + youthInvolvedPersons.lastname : '';
    }

    intakedraiGetCJAMSpid(youthInvolvedPersons: any){
        return youthInvolvedPersons ? youthInvolvedPersons.cjamspid : '';
    }

    intakedraiGetDOB(youthInvolvedPersons: any){
        return youthInvolvedPersons ? moment(youthInvolvedPersons.dob, this.dtformat).toDate() : '';
    }

    intakedraiGetRace(youthInvolvedPersons: any){
        return youthInvolvedPersons ? youthInvolvedPersons.racetypekey : '';
    }

    intakedraiGetGender(youthInvolvedPersons: any){
        return youthInvolvedPersons ? youthInvolvedPersons.gender : '';
    }

    public shelterPetition(submissionData: any) {
        const countyList = this._dataStoreService?.getData(CASE_STORE_CONSTANTS.COUNTY_LIST);
        const dsdsaction = this._dataStoreService?.getData(CASE_STORE_CONSTANTS.DSDS_ACTIONS_SUMMARY);
        if (dsdsaction) {
            const juri = dsdsaction.countyid;
            if (countyList && countyList.length > 0) {
                countyList.map((county: { countyid: any; countyname: any; }) => {
                    if (county.countyid === juri) {
                        submissionData['CountyNameTextBox1'] = county.countyname;
                        submissionData['JuvenileCourtCounty'] = county.countyname;
                    }
                });
            }
        }
        const childList = this.shelterPetitionChildList(submissionData);
        submissionData['userrole'] = this.token.role.name;

        if (this.careGiverDetails) {
            const parentInfo = this.shelterPetitionParentDetails();
            const parentdetails = parentInfo.parentdetails;
            const parentList = parentInfo.parentList;
            if (this.ifEmptyArray(submissionData.parentdetails)) {
                submissionData['parentdetails'] = parentdetails;
                submissionData['parentlist'] = parentList;
            }
        }

        if (this.ifEmptyArray(submissionData.childrendatagrid)) {
            submissionData['childrendatagrid'] = childList;
        }
        return submissionData;
    }

    shelterPetitionChildList(submissionData: any){

        const childList: any[] = [];
        this.getChildList.forEach(child => {
            const race = (child.race) ? child.race : [];
            if (child.firstname && child.lastname) {
                childList.push({
                    ChildName: child.firstname + ' ' + child.lastname,
                    ChildDoB: this.getFormattedDate(child.dob),
                    Sex: child.gender,
                    Race: race.map(item => item.racetypekey),
                    personid: child.personid
                });
            }
        });
        return childList;
    }

    shelterPetitionParentDetails() {
        const parentdetails = [];
        const parentList = [];
        for (const element of this.careGiverDetails) {
            let fullAddress = '';
            const phonenumber = element.phonenumber;
            const ParentGuardian = element.firstname + ' ' + element.lastname;
            if (element.address) {
                fullAddress = element.address;
            }
            if (element.address2) {
                fullAddress = fullAddress + ' ' + element.address2;
            }
            if (element.city) {
                fullAddress = fullAddress + ' ' + element.city;
            }
            if (element.state) {
                fullAddress = fullAddress + ' ' + element.state;
            }
            if (element.zipcode) {
                fullAddress = fullAddress + ' ' + element.zipcode;
            }
            const Address = fullAddress;
            parentdetails.push({
                ParentGuardian, Address
            });
            parentList.push({
                ParentGuardian, Address, phonenumber
            });
        }

        return {
            parentdetails: parentdetails,
            parentList: parentList
        }
    }

    ifEmptyArray(list: any) {
        if (list.length === 0) { 
            return true;
        } else if (list.length === 1) {
            const ele = list[0];
            let res = true;
            for (const key in ele) {
                if (ele.hasOwnProperty(key)) {
                    const val = ele[key];
                    if ((Array.isArray(val) && val.length) || (!Array.isArray(val) && val !== '')) {
                        res = false;
                    }
                }
            }
            return res;
        } else { return false; }
    }

    public fillDomesticViolence(submissionData: any) {
        submissionData['userrole'] = this.token.role.name;
        if (this.caseWorkerName && 
            (submissionData['Practitioner'] == null 
            || submissionData['Practitioner'] === undefined 
            || submissionData['Practitioner'] === '')) {
            submissionData['Practitioner'] =    this.token.role.name === 'field' ? this.token.user.userprofile.fullname : this.caseWorkerName;
        }
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        submissionData['addedvictims'] = JSON.stringify(this.involvedPersons.map(victim => victim.firstname + ' ' + victim.lastname));
        return submissionData;
    }

    public fillCansFv2(submissionData: any, daNumber: any) {
        submissionData['userrole'] = this.token.role.name;
        submissionData['caseheaddatetime'] = submissionData['caseheaddatetime'] ? submissionData['caseheaddatetime'] : moment(new Date()).format(this.dtformat2);
        submissionData['caseheadid'] = this._dataStoreService?.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        const list = this._dataStoreService?.getData('CASEWORKER_SERVICE_PLAN_LIST');
        submissionData['servicenamelist'] = (Array.isArray(list)) ? list.map(item => item.serviceplanname) : [];
        let caseheadid: any = '';
        if (this.caseHeadDetail.length) {
            caseheadid = this.caseHeadDetail[0].personid;
            submissionData['caseheadname'] =  submissionData['caseheadname'] ? submissionData['caseheadname'] : this.caseHeadDetail.map(item => this.getFullName(item));
            submissionData['caregiverrelationship'] =  submissionData['caregiverrelationship'] ?
                                                                     submissionData['caregiverrelationship'] : titleCase(this.caseHeadDetail[0].relationship);
        }
            submissionData['familygrid'] = [];

            if (this.careGiverDetailsWithHouseHold.length) {
                this.careGiverDetailsWithHouseHold.forEach((child: any) => {
                    child['personfullname'] = this.getFullName(child);
                    submissionData['familygrid'].push({
                        caregiveryouthname: this.getFullName(child),
                        caregiveryouthdob: this.getFormattedDate(child.dob),
                        caregiveryouthage: this.getAge(child.dob),
                        caregiveryouthrelationship: this.getrelationship(child.personid, caseheadid) 
                    });
                });
                submissionData['caregiverList'] = this.legalGuardianCareTakerlist.map(item => this.getFullName(item));
            }
        const childList: any[] = [];
            this.getChildList.forEach(childRecord => {
                if (childRecord.firstname && childRecord.lastname) {
                    childList.push({
                        fg1childname: childRecord.firstname + ' ' + childRecord.lastname,
                        fg1childdob: childRecord.dob,
                        fg1childschool: childRecord.schoolname,
                        fg1childrelationship: this.getrelationship(childRecord.personid, caseheadid),
                        fg1childage: this.getAge(childRecord.dob),
                    });
                }
            });

        submissionData['familygrid1'] = childList;
        submissionData['childlist'] = childList.map(item => item.fg1childname);
        submissionData['cpscaseid'] = this.fillCansFv2CPSCaseId(submissionData, daNumber);
        submissionData['routingsupervisors'] = JSON.stringify(this.routingSupervisors);
        if (this.supervisorName) {
            submissionData['supervisorname'] =  this.fillCansFv2SupervisorName(submissionData);
            submissionData['supervisortitle'] = this.fillCansFv2SupervisorTitle(submissionData);
        }
        if (this.caseWorkerName) {
            submissionData['workersname'] =  this.fillCansFv2WorkerName(submissionData);
            submissionData['workertitle'] = this.fillCansFv2WorkerTitle(submissionData);
            submissionData['workernameandId'] = this.fillCansFv2WorkernameandId(submissionData);
        }
        submissionData['workerdate'] = this.fillCansFv2WorkerDate(submissionData);
        return submissionData;
    }

    fillCansFv2CPSCaseId(submissionData: any, daNumber: any){
        return submissionData['cpscaseid'] ? submissionData['cpscaseid'] : daNumber;
    }

    fillCansFv2SupervisorName(submissionData: { [x: string]: any; }){
        return submissionData['supervisorname'] ? submissionData['supervisorname'] : this.supervisorName;
    }

    fillCansFv2SupervisorTitle(submissionData: { [x: string]: any; }){
        return submissionData['supervisortitle'] ? submissionData['supervisortitle'] : 'Supervisor';
    }

    fillCansFv2WorkerName(submissionData: { [x: string]: any; }){
        return submissionData['workersname'] ? submissionData['workersname'] : this.supervisorName;
    }

    fillCansFv2WorkerTitle(submissionData: { [x: string]: any; }){
        return submissionData['workertitle'] ? submissionData['workertitle'] : 'Supervisor';
    }

    fillCansFv2WorkernameandId(submissionData: { [x: string]: any; }){
        return submissionData['workernameandId'] ? submissionData['workernameandId'] : this.caseWorkerName;
    }

    fillCansFv2WorkerDate(submissionData: { [x: string]: any; }){
        return submissionData['workerdate'] ? submissionData['workerdate'] : moment(new Date()).format(this.dtformat2);
    }

    getProviderInfo(palcements: any, child: any) {
        let providerInfo = null;
        let hasActivePlacement = false;
        if (child && palcements && Array.isArray(palcements)) {
            const childPlacments = palcements.find(item => item.personid === child.personid);
            if (childPlacments && Array.isArray(childPlacments.placements))  {
                const activeChildPlacment = childPlacments.placements.find((item: any) => item.placementtypekey === 'PRPL' && !item.enddate && item.routingstatus === 'Approved' && item.isvoided === 0);
                hasActivePlacement = (activeChildPlacment) ? true : false;
                if (activeChildPlacment && activeChildPlacment.providerdetails) {
                    providerInfo = activeChildPlacment.providerdetails;
                }
            }
        }
        return { providerInfo, hasActivePlacement };
    }

    getProviderAddressLine1(addressInfo: any){
        return (''+ this.getValueOrEmptyString(addressInfo.adr_street_no)
                            + this.getValueOrEmptyString(addressInfo.adr_box_no)
                            + this.getValueOrEmptyString(addressInfo.adr_street_tx)
                            + this.getValueOrEmptyString(addressInfo.adr_street_nm)
                            + this.getValueOrEmptyString(addressInfo.adr_street_suffix_cd)).trim();     
    }

    getProviderAddressLine2(addressInfo: any){
        return (''+ this.getValueOrEmptyString(addressInfo.adr_unit_no_tx)
                            + this.getValueOrEmptyString(addressInfo.adr_city_nm)
                            + this.getValueOrEmptyString(addressInfo.adr_state_cd)).trim();     
    }

    getValueOrEmptyString(value: any){
        return value?value+' ':'';
    }
}
