import { Component, Injector, OnInit } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { PaginationModule } from '../../../../shared/modules/pagination/pagination.module';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { AlertService, AuthService } from '../../../../@core/services';
import { firstValueFrom } from 'rxjs';

interface FamilyFindingHistory {
    source: string;
    firstname: string;
    lastname: string;
    dob: string;
    gender: string;
    cjamspid?: string;
    county: string;
    status: string;
    submittedOn: string;
    submittedBy: string;
    bintiCaseNumber?: string;
    binti_case_number?: string;
    binti_clientid?: string;
    bintifamilyfindingsid?: string;
    binticaselastsearchdate?: string;
}

interface FamilyFindingRelationship {
    actorRelationshipId: number;
    relationshipTypeKey: string;
    cjamsRole: string;
    bintiRole: string;
    relativePersonId: number;
    relativeCjamspid: string;
    firstname: string;
    middlename?: string;
    lastname: string;
    dob: string;
    gender?: string;
    syncStatus: string;
    syncedOn?: string;
    syncedBy?: string;
    canSync: boolean;
    isMapped?: boolean;
}

type InitiateSyncState = 'PENDING' | 'SYNCING' | 'SYNCED' | 'FAILED' | 'SKIPPED';

interface InitiateRelationshipSyncRow {
    actorRelationshipId: number;
    relationshipTypeKey: string;
    cjamsRole: string;
    bintiRole: string;
    relativePersonId: number;
    relativeCjamspid: string;
    firstname: string;
    middlename?: string;
    lastname: string;
    dob: string;
    gender?: string;
    selected: boolean;
    canBeSynced: boolean;
    selectionDisabledReason?: string;
    syncState: InitiateSyncState;
    syncMessage?: string;
}

interface InitiateSyncSummary {
    total: number;
    synced: number;
    failed: number;
    skipped: number;
}

interface SelectedInitiateClient {
    firstname: string;
    lastname: string;
    dob: string;
    gender: string;
    cjamspid: string;
    county: string;
    binti_clientid?: string;
    bintiCaseNumber?: string;
    loadingEligibleRelationships: boolean;
    eligibleLoadError: string | null;
    syncRows: InitiateRelationshipSyncRow[];
    syncProcessing: boolean;
    syncSummary: InitiateSyncSummary | null;
    _ref: OutOfHomeClient;
}

interface OutOfHomeClient {
    firstname: string;
    lastname: string;
    cjamspid: string;
    dob: string;
    userphoto: string | null;
    gender: string;
    removaldate: string;
    exitdate: string;
    showHistory?: boolean;
    roles: string;
    history?: FamilyFindingHistory[];
    historyLoading?: boolean;
    historyError?: string | null;
    canInitiateFamilyFinding?: boolean;
    binti_clientid?: string;
    // Added for UI mapping
    submittedOn?: string;
    submittedBy?: string;
    bintiCaseNumber?: string;
    binti_case_number?: string;
    bintifamilyfindingsid?: string;
    // Pagination for history
    historyPage?: number;
    historyPageSize?: number;
    historyTotalCount?: number;
    showRelationship?: boolean;
    relationship?: FamilyFindingRelationship[];
    relationshipLoading?: boolean;
    relationshipError?: string | null;
    relationshipPage?: number;
    relationshipPageSize?: number;
    relationshipTotalCount?: number;
}

@Component({
    selector: 'app-family-findings',
    templateUrl: './family-findings.component.html',
    styleUrls: ['./family-findings.component.scss'],
    standalone: true,
    imports: [CommonModule, PaginationModule],
    providers: [DatePipe]
})

export class FamilyFindingsComponent implements OnInit {
    // Error state for initiating family finding
    initiateError: string | null = null;
    pageNumber: number = 1;
    pageSize: number = 10;
    totalpagecount: number = 0;
    showInitiateFamilyFindingModal = false;
    selectedClient: SelectedInitiateClient | null = null;
    loadingHistory: boolean = false;
    historyError: string | null = null;
    history: any[] = [];
    showHistory: boolean = false;
    showSuccessMessage: boolean = false;
    public _authService: AuthService;
    public _alertService: AlertService;
    private countyname: string = '';
    countyList: any[] = [];
    public _commonService: CommonHttpService;
    primaryCountyCode: string = '';
    useremail: string = '';
    userid: string = '';

    private mapRelationshipRow(row: any): FamilyFindingRelationship {
        return {
            actorRelationshipId: row.actorrelationshipid,
            relationshipTypeKey: row.relationshiptypekey,
            cjamsRole: row.relationshiptype,
            bintiRole: row.bintirolelabel || row.binti_role_label || '--',
            relativePersonId: row.relativepersonid || row.relative_personid,
            relativeCjamspid: row.relativecjamspid || row.relative_cjamspid,
            firstname: row.firstname,
            middlename: row.middlename,
            lastname: row.lastname,
            dob: row.dob,
            gender: row.gender || row.gendertypekey,
            syncStatus: row.syncstatus || 'NOT_SYNCED',
            syncedOn: row.syncedon,
            syncedBy: row.syncedby,
            canSync: !!row.cansync,
            isMapped: row.ismapped === true || row.ismapped === 1 || row.ismapped === '1',
        };
    }

    // Toggle history (no fetch needed)
    onToggleHistory(client: OutOfHomeClient, event: Event): void {
        client.showHistory = !client.showHistory;
        if (client.showHistory) {
            client.showRelationship = false;
            // Initialize pagination if not set
            if (!client.historyPageSize) client.historyPageSize = 10;
            if (!client.historyPage) client.historyPage = 1;
            this.loadFamilyFindingsHistory(client, client.historyPage);
        }
        event.preventDefault();
    }

    /**
     * Loads family findings history for a client
     */
    loadFamilyFindingsHistory(client: OutOfHomeClient, page = 1) {
        client.historyLoading = true;
        client.historyError = null;
        this._commonService.create(
            {
                where: {
                    cjamspid: client.cjamspid,
                    page: page,
                    limit: client.historyPageSize || 5
                },
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetFamilyFindingsHistory
        ).subscribe({
            next: (resp: any) => {
                if (resp.success) {
                    const history = resp.data || [];
                    client.history = history.map((item: any) => {
                        return {
                            source: item.source || '',
                            firstname: item.firstname || '',
                            lastname: item.lastname || '',
                            dob: item.dob || '',
                            gender: item.gender || '',
                            cjamspid: item.cjamspid || '',
                            status: item.familyfindingstatus || '',
                            submittedOn: item.submitted_on || '',
                            submittedBy: item.submitted_by || '',
                            binti_clientid: item.binti_clientid || '',
                            binti_case_number: item.binti_case_number || ''
                        };
                    });
                    client.historyTotalCount = resp.totalcount || history.length;
                    client.historyPage = page;
                    client.historyLoading = false;
                } else {
                    client.historyError = 'Failed to load history.';
                    client.historyLoading = false;
                }
            },
            error: (err: any) => {
                client.historyError = err?.error?.message || 'Failed to load history.';
                client.historyLoading = false;
            }
        });
    }

    onHistoryPageChanged(client: OutOfHomeClient, page: number) {
        client.historyPage = page;
        this.loadFamilyFindingsHistory(client, page);
    }

    onToggleRelationship(client: OutOfHomeClient, event: Event): void {
        client.showRelationship = !client.showRelationship;
        if (client.showRelationship) {
            client.showHistory = false;
            if (!client.relationshipPageSize) client.relationshipPageSize = 10;
            if (!client.relationshipPage) client.relationshipPage = 1;
            this.loadFamilyFindingRelationships(client, client.relationshipPage);
        }
        event.preventDefault();
    }

    loadFamilyFindingRelationships(client: OutOfHomeClient, page = 1) {
        client.relationshipLoading = true;
        client.relationshipError = null;
        const servicecaseid = this.dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);

        this._commonService.create(
            {
                where: {
                    cjamspid: client.cjamspid,
                    servicecaseid: null,
                    page,
                    limit: client.relationshipPageSize || 10,
                },
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetFamilyFindingRelationships
        ).subscribe({
            next: (resp: any) => {
                if (resp?.success) {
                    const rows = resp.data || [];

                    // Keep client-level Binti markers in sync with relationship payload.
                    if (!this.hasFamilyFindingInitiated(client)) {
                        const first = rows[0] || {};
                        const relationshipCaseNumber = first.binti_case_number || first.binticasenumber;
                        if (relationshipCaseNumber) {
                            client.bintiCaseNumber = relationshipCaseNumber;
                            client.binti_case_number = relationshipCaseNumber;
                        }
                    }

                    if (!client.binti_clientid) {
                        const relationshipChildBintiId = rows[0]?.childbinticlientid || rows[0]?.child_binti_clientid;
                        if (relationshipChildBintiId) {
                            client.binti_clientid = relationshipChildBintiId;
                        }
                    }

                    client.relationship = rows.map((row: any) => ({
                        ...this.mapRelationshipRow(row),
                    }));
                    client.relationshipTotalCount = resp.totalcount || rows.length;
                    client.relationshipPage = page;
                } else {
                    client.relationshipError = resp?.data?.message || 'Failed to load relationships.';
                }
                client.relationshipLoading = false;
            },
            error: (err: any) => {
                client.relationshipError = err?.error?.message || 'Failed to load relationships.';
                client.relationshipLoading = false;
            },
        });
    }

    onRelationshipPageChanged(client: OutOfHomeClient, page: number) {
        client.relationshipPage = page;
        this.loadFamilyFindingRelationships(client, page);
    }

    getRelationshipGenderLabel(gender?: string): string {
        const value = (gender || '').toString().trim().toUpperCase();
        if (!value) {
            return 'Unknown';
        }

        const genderMap: { [key: string]: string } = {
            M: 'Male',
            MALE: 'Male',
            F: 'Female',
            FEMALE: 'Female',
            NB: 'Non-Binary',
            NON_BINARY: 'Non-Binary',
            'NON-BINARY': 'Non-Binary',
            TG: 'Transgender',
            TRANSGENDER: 'Transgender',
            U: 'Unknown',
            UNKNOWN: 'Unknown',
            O: 'Other',
            OTHER: 'Other',
        };

        return genderMap[value] || 'Unknown';
    }

    getRelationshipStatusLabel(status?: string): string {
        const value = (status || '').toString().trim().toUpperCase();
        if (value === 'SYNCED' || value === 'COMPLETED') {
            return 'Synced';
        }
        if (value === 'PENDING' || value === 'SYNCING') {
            return 'Pending';
        }
        return 'Not Synced';
    }

    getRelationshipStatusClass(status?: string): string {
        const value = (status || '').toString().trim().toUpperCase();
        if (value === 'SYNCED' || value === 'COMPLETED') {
            return 'status-synced';
        }
        if (value === 'PENDING' || value === 'SYNCING') {
            return 'status-pending';
        }
        return 'status-not-synced';
    }

    getRelationshipStatusStyle(status?: string): { [key: string]: string } {
        const value = (status || '').toString().trim().toUpperCase();

        if (value === 'SYNCED' || value === 'COMPLETED') {
            return {
                background: '#e6f6ec',
                color: '#166534',
                borderColor: '#b7e4c7',
            };
        }

        if (value === 'PENDING' || value === 'SYNCING') {
            return {
                background: '#fef9c3',
                color: '#854d0e',
                borderColor: '#fde68a',
            };
        }

        return {
            background: '#fff7ed',
            color: '#9a3412',
            borderColor: '#fdba74',
        };
    }

    hasFamilyFindingInitiated(client: OutOfHomeClient): boolean {
        const caseNumber = client?.bintiCaseNumber || client?.binti_case_number;
        return !!(caseNumber || client?.bintifamilyfindingsid);
    }

    private normalizeRoleValue(value?: string): string {
        return (value || '').toString().trim().toUpperCase();
    }

    private hasValidBintiMapping(relationship: FamilyFindingRelationship): boolean {
        if (typeof relationship.isMapped === 'boolean') {
            return relationship.isMapped;
        }

        const normalizedBintiRole = this.normalizeRoleValue(relationship.bintiRole);
        return !!normalizedBintiRole && normalizedBintiRole !== '--' && normalizedBintiRole !== 'UNKNOWN';
    }

    private isEligibleForInitiateSync(relationship: FamilyFindingRelationship): boolean {
        const status = this.normalizeRoleValue(relationship.syncStatus);
        if (status === 'SYNCED') {
            return false;
        }

        return this.hasValidBintiMapping(relationship);
    }

    private toInitiateSyncRow(relationship: FamilyFindingRelationship): InitiateRelationshipSyncRow {
        const canBeSynced = this.isEligibleForInitiateSync(relationship);
        let selectionDisabledReason = '';

        if (!canBeSynced) {
            const status = this.normalizeRoleValue(relationship.syncStatus);
            if (status === 'SYNCED') {
                selectionDisabledReason = 'Already synced.';
            } else if (!this.hasValidBintiMapping(relationship)) {
                selectionDisabledReason = 'No mapping found in reference values.';
            } else {
                selectionDisabledReason = 'Not eligible for sync.';
            }
        }

        return {
            actorRelationshipId: relationship.actorRelationshipId,
            relationshipTypeKey: relationship.relationshipTypeKey,
            cjamsRole: relationship.cjamsRole,
            bintiRole: relationship.bintiRole,
            relativePersonId: relationship.relativePersonId,
            relativeCjamspid: relationship.relativeCjamspid,
            firstname: relationship.firstname,
            middlename: relationship.middlename,
            lastname: relationship.lastname,
            dob: relationship.dob,
            gender: relationship.gender,
            selected: canBeSynced,
            canBeSynced,
            selectionDisabledReason,
            syncState: this.normalizeRoleValue(relationship.syncStatus) === 'SYNCED' ? 'SYNCED' : 'PENDING',
            syncMessage: '',
        };
    }

    private async fetchAllFamilyFindingRelationships(client: OutOfHomeClient): Promise<FamilyFindingRelationship[]> {
        const servicecaseid = this.dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const resp: any = await firstValueFrom(
            this._commonService.create(
                {
                    where: {
                        cjamspid: client.cjamspid,
                        servicaseid: null,
                        page: 1,
                        limit: 500,
                    },
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetFamilyFindingRelationships
            )
        );

        if (!resp?.success) {
            throw new Error(resp?.data?.message || 'Failed to load relationships.');
        }

        return (resp.data || []).map((row: any) => this.mapRelationshipRow(row));
    }

    private async prepareInitiateSyncRows(client: OutOfHomeClient) {
        if (!this.selectedClient) {
            return;
        }

        this.selectedClient.loadingEligibleRelationships = true;
        this.selectedClient.eligibleLoadError = null;
        this.selectedClient.syncRows = [];
        this.selectedClient.syncSummary = null;

        try {
            const relationships = await this.fetchAllFamilyFindingRelationships(client);
            this.selectedClient.syncRows = relationships.map((relationship) => this.toInitiateSyncRow(relationship));
        } catch (err: any) {
            this.selectedClient.eligibleLoadError = err?.message || 'Failed to load eligible relationships.';
        } finally {
            this.selectedClient.loadingEligibleRelationships = false;
        }
    }

    getInitiateSyncStateLabel(state: InitiateSyncState): string {
        if (state === 'SYNCED') {
            return 'Completed';
        }
        if (state === 'SYNCING') {
            return 'Syncing';
        }
        if (state === 'FAILED' || state === 'SKIPPED') {
            return 'Not Synced';
        }
        return 'Pending';
    }

    getInitiateSyncStateIcon(state: InitiateSyncState): string {
        if (state === 'SYNCED') {
            return 'check_circle';
        }
        if (state === 'FAILED') {
            return 'cancel';
        }
        if (state === 'SYNCING') {
            return 'autorenew';
        }
        if (state === 'SKIPPED') {
            return 'remove_circle';
        }
        return 'schedule';
    }

    getInitiateSyncStateClass(state: InitiateSyncState): string {
        if (state === 'SYNCED') {
            return 'sync-state-completed';
        }
        if (state === 'SYNCING') {
            return 'sync-state-syncing';
        }
        if (state === 'FAILED' || state === 'SKIPPED') {
            return 'sync-state-not-synced';
        }
        return 'sync-state-pending';
    }

    areAllSyncRowsSelected(): boolean {
        if (!this.selectedClient || this.selectedClient.syncRows.length === 0) {
            return false;
        }

        const selectableRows = this.selectedClient.syncRows.filter((row) => row.canBeSynced);
        if (selectableRows.length === 0) {
            return false;
        }

        return selectableRows.every((row) => row.selected);
    }

    toggleSelectAllSyncRows(selected: boolean): void {
        if (!this.selectedClient || this.selectedClient.syncProcessing) {
            return;
        }

        this.selectedClient.syncRows.forEach((row) => {
            if (row.canBeSynced) {
                row.selected = selected;
            }
        });
    }

    toggleSyncRowSelection(row: InitiateRelationshipSyncRow, selected: boolean): void {
        if (this.selectedClient?.syncProcessing) {
            return;
        }

        if (!row.canBeSynced) {
            return;
        }

        row.selected = selected;
    }

    private buildSyncPayload(client: SelectedInitiateClient, relationship: InitiateRelationshipSyncRow) {
        return {
            childcjamspid: client.cjamspid,
            child_cjamspid: client.cjamspid,
            childbinticlientid: client.binti_clientid,
            child_binti_clientid: client.binti_clientid,
            binti_case_number: client.bintiCaseNumber,
            relativepersonid: relationship.relativePersonId,
            relative_personid: relationship.relativePersonId,
            relativecjamspid: relationship.relativeCjamspid,
            relative_cjamspid: relationship.relativeCjamspid,
            relationshiptypekey: relationship.relationshipTypeKey,
            relationshiptype: relationship.cjamsRole,
        };
    }

    getCountyList(primaryCountyCode?: string) {
        if (this?.countyList?.length === 0) {
            this._commonService.create({
                where: {
                    activeflag: '1',
                    state: 'MD'
                },
                order: 'countyname asc',
                nolimit: true
            }, CaseWorkerUrlConfig.countyListurl).subscribe((item: any[]) => {
                if (item && item.length) {
                    this.countyList = item;
                    if (primaryCountyCode) {
                        const match = this.countyList.find(
                            (county: any) => county.statecountycode === primaryCountyCode
                        );
                        if (match) {
                            this.countyname = match.binticountyname;
                        }
                    }
                }
            });
        }
    }

    openInitiateFamilyFindingModal(client: OutOfHomeClient) {
        // Map client fields if needed for modal display
        this.selectedClient = {
            firstname: client.firstname || '',
            lastname: client.lastname || '',
            dob: client.dob,
            gender: client.gender || '',
            cjamspid: client.cjamspid,
            county: this.countyname || '',
            binti_clientid: client.binti_clientid,
            bintiCaseNumber: client.bintiCaseNumber || client.binti_case_number,
            loadingEligibleRelationships: false,
            eligibleLoadError: null,
            syncRows: [],
            syncProcessing: false,
            syncSummary: null,
            _ref: client // keep reference to update after initiation
        };
        this.initiateError = null;
        this.showInitiateFamilyFindingModal = true;
        this.prepareInitiateSyncRows(client);
    }

    closeInitiateFamilyFindingModal() {
        if (this.selectedClient?.syncProcessing) {
            return;
        }
        this.showInitiateFamilyFindingModal = false;
        this.selectedClient = null;
    }

    async confirmInitiateFamilyFinding() {
        if (!this.selectedClient) return;
        if (this.selectedClient.syncProcessing || this.selectedClient.loadingEligibleRelationships) return;
        this.initiateError = null;
        const client = this.selectedClient;
        const caseUid = this.dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const body = {
            client: {
                cjamspid: client.cjamspid,
                firstname: client.firstname,
                lastname: client.lastname,
                dob: client.dob,
                gender: client.gender,
                county: client.county,
                caseid: caseUid,
                binticlientid: client.binti_clientid
            },
            search_date: new Date().toISOString().slice(0, 10),
            case_worker: {
                email: this.useremail,
                userid: this.userid,
                securityuserid: this.userid
            }
        };

        client.syncProcessing = true;
        client.syncSummary = null;

        try {
            const initiateResp: any = await firstValueFrom(
                this._commonService.create(
                    body,
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InitFamilyFindings
                )
            );

            if (!initiateResp?.success) {
                const msg = initiateResp?.message || initiateResp?.data?.message || 'Failed to initiate family finding.';
                if (initiateResp?.data?.isDuplicate) {
                    this.initiateError = initiateResp?.data?.message || 'You have already initiated a family finding for this client with same information. No new search has been initiated.';
                } else {
                    this.initiateError = msg;
                }
                return;
            }

            const bintiCaseNumber = initiateResp?.data?.caseId || initiateResp?.search_result?.data?.id || null;
            if (bintiCaseNumber) {
                client.bintiCaseNumber = bintiCaseNumber;
                client._ref.bintiCaseNumber = bintiCaseNumber;
                client._ref.binti_case_number = bintiCaseNumber;
            }

            const selectedRows = client.syncRows.filter((row) => row.selected && row.canBeSynced);

            for (const row of client.syncRows) {
                if (!row.selected || !row.canBeSynced) {
                    row.syncState = 'SKIPPED';
                    row.syncMessage = row.canBeSynced ? 'Skipped by user.' : (row.selectionDisabledReason || 'Skipped.');
                }
            }

            for (const row of selectedRows) {
                row.syncState = 'SYNCING';
                row.syncMessage = '';

                try {
                    const syncResp: any = await firstValueFrom(
                        this._commonService.create(
                            this.buildSyncPayload(client, row),
                            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.SyncFamilyFindingRelationship
                        )
                    );

                    if (syncResp?.success) {
                        row.syncState = 'SYNCED';
                        row.syncMessage = syncResp?.data?.message || 'Synced successfully.';
                    } else {
                        row.syncState = 'FAILED';
                        row.syncMessage = syncResp?.data?.message || 'Failed to sync relationship.';
                    }
                } catch (err: any) {
                    row.syncState = 'FAILED';
                    row.syncMessage = err?.error?.message || err?.error?.data?.message || 'Failed to sync relationship.';
                }
            }

            const summary: InitiateSyncSummary = {
                total: client.syncRows.length,
                synced: client.syncRows.filter((row) => row.syncState === 'SYNCED').length,
                failed: client.syncRows.filter((row) => row.syncState === 'FAILED').length,
                skipped: client.syncRows.filter((row) => row.syncState === 'SKIPPED').length,
            };
            client.syncSummary = summary;

            // Auto-close the popup once initiate + sync batch is completed.
            this.showInitiateFamilyFindingModal = false;

            this.showSuccessMessage = true;
            setTimeout(() => {
                this.showSuccessMessage = false;
            }, 5000);

            this.loadPage(this.pageNumber);
            if (client._ref.showRelationship) {
                this.loadFamilyFindingRelationships(client._ref, client._ref.relationshipPage || 1);
            }
        } catch (err: any) {
            const msg = err?.error?.message || err?.error?.data?.message || 'Failed to initiate family finding.';
            if (err?.error?.isDuplicate) {
                this.initiateError = err?.error?.message || 'You have already initiated a family finding for this client with same information. No new search has been initiated.';
            } else {
                this.initiateError = msg;
            }
        } finally {
            client.syncProcessing = false;
        }
    }
    outOfHomeClients: OutOfHomeClient[] = [];
    hasLoaded = false;

    sortBy(column: string) {
        this.outOfHomeClients.sort((a, b) => {
            const valueA = a[column as keyof OutOfHomeClient] || '';
            const valueB = b[column as keyof OutOfHomeClient] || '';
            return valueA.toString().localeCompare(valueB.toString(), undefined, { numeric: true, sensitivity: 'base' })
        });
    }

    constructor(
        private dataStore: DataStoreService,
        private http: CommonHttpService,
        private injector: Injector
    ) {
        this._authService = this.injector.get(AuthService);
        this._alertService = this.injector.get(AlertService);
        this._commonService = this.injector.get(CommonHttpService);
    }

    ngOnInit(): void {
        const user = this._authService.getCurrentUser();
        const actualuser = user.user;
        this.primaryCountyCode = actualuser?.userprofile?.primarycountycd || '';
        this.useremail = actualuser?.userprofile?.email || '';
        this.userid = actualuser?.userprofile?.securityusersid || '';
        this.getCountyList(this.primaryCountyCode);
        // this.countyname will be set after county list loads
        this.loadPage(this.pageNumber);
    }

    loadPage(page: number) {
        const caseUid = this.dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.pageNumber = page;
        this.hasLoaded = false;
        this.http.getSingle(
            {
                where: { objectid: caseUid },
                page: this.pageNumber,
                limit: this.pageSize,
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetFamilyFindings + '?filter'
        ).subscribe((response: any) => {
            if (response?.success) {
                let findings = response?.data || [];
                this.totalpagecount = response?.totalcount || 0;
                if (findings.length) {
                    findings = findings.filter((client: any) => client.approvalstatus === 'Approved');
                    this.outOfHomeClients = findings.map((client: any) => {
                        // Map API snake_case to camelCase for UI
                        const submittedOn = client.submittedon || null;
                        const submittedBy = client.submittedby || null;
                        const bintiCaseNumber = client.binticasenumber || null;
                        return {
                            ...client,
                            submittedOn,
                            submittedBy,
                            bintiCaseNumber,
                            showHistory: false,
                            canInitiateFamilyFinding: !client.exitdate,
                            history: [],
                            historyLoading: false,
                            historyError: null,
                            showRelationship: false,
                            relationship: [],
                            relationshipLoading: false,
                            relationshipError: null,
                        };
                    });
                } else {
                    this.outOfHomeClients = [];
                }
            } else {
                this._alertService.error('Failed to load family findings.');
            }
            this.hasLoaded = true;
        });
    }

    pageNumberChanged(page: number) {
        this.loadPage(page);
    }
}