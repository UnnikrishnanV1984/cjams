export class PlacementValidationUrlConfig {
    public static EndPoint = {
        placement: {
            FcReferalListURL: `tb_placement/fostercarereflistforvalidation`,
            PlacementValidationTypeUrl: `tb_picklist_values/getpicklist`,
            AddValidationUrl: `tb_placement/addvalidation`,
            UpdatePlacementValidation: 'tb_placement_validation/updatePlacementValidation'
            // GlobalPersonSearchUrl: 'globalpersonsearches/getPersonSearchData',
            // InvolvedEnititesSearchUrl: 'gloabalagencysearches/getAgencySearchData',
        }
    };
}
