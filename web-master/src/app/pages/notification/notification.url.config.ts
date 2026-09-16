export class NotificationUrlConfig {
    public static EndPoint = {
        notification: {
            notificationResult: `Usernotifications/getUserNotification`,
            updateNotification: 'Usernotifications/updateNotification',
            deleteNotification: 'Usernotifications/deleteNotification',
            getDocDetails:  'Documentproperties/getDocumentDetails'
        }
    };
}
