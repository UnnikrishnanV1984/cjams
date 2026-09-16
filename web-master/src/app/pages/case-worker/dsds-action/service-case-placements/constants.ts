export class PlacementConstants {
    public static RUN_AWAY = 'RNW';
    public static ACTIONS = {
        EXIT : 'exit',
        EDIT : 'edit',
        VIEW : 'view',
        REVIEW: 'review',
        VOID: 'void',
        ADD: 'add',
        CANCEL:'cancel'
    };

    public static EXIT_TYPES = {
        CHANGE_IN_PLACEMENT_STR : 'CIPS',
        CHANGE_IN_PLACEMENT : 'CIP',
        PERM_LEAVING_CUSTODY : 'PLCC',
        OTHER: 'OTH',
        DEATH: 'DEATHOC',
        RNAWAY: 'RNAWAY',
        CHANG_IN_PLACMENT: 'CIP',
        CHANG_IN_PLACMENT_STRUCTURE: 'CIPS',
        RUNAWAY: 'CIPR',
        CHILD_ISSU_RUNAWAY: 'CIPRA'
    };
    public static ICPCExitTypes = ['AF', 'ARNUFP', 'CMAS', 'CRMLE', 'CRSS', 'LCGO', 'LCRP','LCGR', PlacementConstants.EXIT_TYPES.OTHER, 'PPRQ', 'RHD', 'SSJTWCRS', 
    'TC','UT'];

    public static REASON_FOR_EXIT = {
        TRANSFER_TO_ANOTHER_NON_DHS : 'TTONDA'
    }
}