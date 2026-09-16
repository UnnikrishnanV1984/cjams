import { Injectable } from '@angular/core';
import { isCaseUuid } from '../../../../@core/common/initializer';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { AuthService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';

@Injectable({ providedIn: 'root' })

export class AttachmentService {
    constructor(
        private readonly _commonService: CommonHttpService,
        private readonly _dataStoreService: DataStoreService,
        private _authService: AuthService) {
    }

    approvedForm1080Persons = [{ type: "form1080a", items: [] },
    { type: "form1080b", items: [] }];

    inProgressOrReviewForm1080PersonRecords = [{ type: "form1080a", items: [] },
    { type: "form1080b", items: [] },{ type: "form1080c", items: [] },];

    getSDMDetailsForForm1080(isServiceCase: any, serviceCaseId: any) {
        // Both sdm endpoints filter on a uuid column, so an unresolved id reaches
        // Postgres as 22P02 and the api flattens that into a bare 400. The caller
        // passes its CASE_UID straight through with no check of its own.
        if (!isCaseUuid(serviceCaseId)) {
            return;
        }
        let sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmvaluesUrl;
        let requestParam;
        if (isServiceCase) {
            sdmUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmServiceCaseUrl; //'servicecase/getservicecasesdm';
            requestParam = {
                servicecaseid: serviceCaseId
            };
        } else {
            requestParam = {
                servicerequestid: serviceCaseId
            };
        }
        this._commonService
            .getArrayList(
                {
                    method: 'get',
                    where: requestParam,
                },
                sdmUrl + '?filter'
            )
            .subscribe((res) => {
                if (res && Array.isArray(res) && res.length) {
                    this._dataStoreService.setData('form1080SDM_Data', res);
                }
            });
    }

    getPersonDetails(isCW: any, isServiceCase: any, id: any) {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        let getpersonlistreq = {};
        if (isCW && isServiceCase) {
            getpersonlistreq = { objectid: id, objecttypekey: 'servicecase', isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: iscaseexpunged};
        } else {
            getpersonlistreq = { intakeserviceid: id, isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: iscaseexpunged};
        }

        if (this.isIntakeMode()) {
            getpersonlistreq = { intakenumber: this.getIntakeNumber(), isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: iscaseexpunged};
        }

        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }

        this._commonService.getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 20,
                personpagelimit: 100,
                method: 'get',
                where: getpersonlistreq
            }),
            url + "?filter"
        ).subscribe((response: any) => {
            const involvedPersonsData = response?.data;
            if (!involvedPersonsData?.length) {
                return;
            };
            this._dataStoreService.setData('involvedPerson', response.data);
        });
    }

    isIntakeMode() {
        return !!this.getIntakeNumber();
    }

    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            return intakeStore.number;
        } else {
            return null;
        }
    }

    childHavingApprovedFormAandB(formtype: any, personid: any) : boolean {
        const type = formtype === 'form1080b' ? 'form1080a' : 'form1080b';
        const approvedForm1080Persons = this._dataStoreService.getData('approvedForm1080Persons');
        const approvedChilds = approvedForm1080Persons?.find((item1: any) => item1.type === type);
        const item = approvedChilds?.items?.includes(personid);
        return !!item;
    }

    childHavingInprogressOrReviewRecordsFormABC(formtype: any, personid: any) : boolean {
        const inProgressOrReviewitemsform1080 = this._dataStoreService.getData('inProgressOrReviewitemsform1080');
        const inProgressOrReviewitems = inProgressOrReviewitemsform1080?.find((item2: any) => item2.type === formtype);
        const item = inProgressOrReviewitems?.items?.includes(personid);
        return !!item;
    }
}