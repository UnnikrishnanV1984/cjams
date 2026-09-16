export class DispositionConfig {
    public static config = {
        'action': [
            {
                'value': 'phone',
                'text': 'Phone'
            },
            {
                'value': 'Email',
                'text': 'Email'
            },
            {
                'value': 'Started an online referral',
                'text': 'Started an online referral'
            },
            {
                'value': ' Forwarded the request to an active worker',
                'text': ' Forwarded the request to an active worker'
            }
        ],
        'initialRecomendation': [
            {
                'value': 'releaseToParents',
                'text': 'Youth can be safely released to his Parents'
            },
            {
                'value': 'releaseToCaregiver',
                'text': 'Youth can be safely released to his Caregiver'
            },
            {
                'value': 'Detention',
                'text': 'Detention'
            }
        ]
    };
}
