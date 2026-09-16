import { DashboardTeamstatisticsComponent } from './dashboard-teamstatistics/dashboard-teamstatistics.component';
import { DashboardInputs } from './_entities/home-dash-entities';
import { DashboardMydsdsactionsComponent } from './dashboard-mydsdsactions/dashboard-mydsdsactions.component';
import { DashboardMytodoComponent } from './dashboard-mytodo/dashboard-mytodo.component';
import { DashboardMytasksComponent } from './dashboard-mytasks/dashboard-mytasks.component';
import { DashboardChecklistNotificationComponent } from './dashboard-checklist-notification/dashboard-checklist-notification.component';
import { DashboardMyirComponent } from './dashboard-myir/dashboard-myir.component';
import { DashboardMyarComponent } from './dashboard-myar/dashboard-myar.component';
import { DashboardMyservicecaseComponent } from './dashboard-myservicecase/dashboard-myservicecase.component';
import { DashboardMyadoptioncaseComponent } from './dashboard-myadoptioncase/dashboard-myadoptioncase.component';
import { DashboardMyappsComponent } from './dashboard-myapps/dashboard-myapps.component';
import { DashboardMyrejectedclosedappComponent } from './dashboard-myrejectedclosedapp/dashboard-myrejectedclosedapp.component';
import { DashboardMyappealcaseComponent } from './dashboard-myappealcase/dashboard-myappealcase.component';
import { DashboardAdoptionticklerComponent } from './dashboard-adoptiontickler/dashboard-adoptiontickler.component';
const pendingassignments = 'Pending Assignments';
export class HomeDashboardWidgetConfig {    
    public static master = {
        AS: [
            {
                number: 1,
                cols: 6,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMydsdsactionsComponent,
                title: 'My Actions',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 2,
                cols: 6,
                rows: 1,
                y: 0,
                x: 6,
                component: DashboardChecklistNotificationComponent,
                title: 'Activity Task Reminder',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 3,
                cols: 6,
                rows: 1,
                y: 1,
                x: 0,
                component: DashboardMytasksComponent,
                title: 'My Tasks',
                input: new DashboardInputs(),
                show: true
            }, {
                number: 4,
                cols: 6,
                rows: 1,
                y: 1,
                x: 6,
                component: DashboardTeamstatisticsComponent,
                title: 'Team Statistics',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 5,
                cols: 6,
                rows: 1,
                y: 2,
                x: 0,
                component: DashboardMytodoComponent,
                title: 'My To-Do',
                input: new DashboardInputs(),
                show: true
            },
        ],
        CW: [
            // Moving Service Case to be at the top as per new business request
            {
                number: 8,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyservicecaseComponent,
                title: 'My Service Case',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 6,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: DashboardMyirComponent,
                title: 'My IR Cases',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 7,
                cols: 12,
                rows: 1,
                y: 2,
                x: 0,
                component: DashboardMyarComponent,
                title: 'My AR Cases',
                input: new DashboardInputs(),
                show: true
            },
            // Removing non cps case as all non cps as consider as service case
            /* {
                number: 9,
                cols: 12,
                rows: 1,
                y: 3,
                x: 0,
                component: DashboardMynoncpsComponent,
                title: 'My Non-CPS Intake',
                input: new DashboardInputs(),
                show: true
            }, */
            {
                number: 9,
                cols: 12,
                rows: 1,
                y: 3,
                x: 0,
                component: DashboardMyadoptioncaseComponent,
                title: 'My Adoption Case',
                input: new DashboardInputs(),
                show: true
            },
             // Removing hard coded to do list
            // {
            //     number: 10,
            //     cols: 5,
            //     rows: 1,
            //     y: 4,
            //     x: 0,
            //     component: DashboardMytodoComponent,
            //     title: 'My To-Do',
            //     input: new DashboardInputs(),
            //     show: true
            // },
            {
                number: 10,
                cols: 12,
                rows: 1,
                y: 4,
                x: 0,
                component: DashboardMytasksComponent ,
                title: 'My Tasks',
                input: new DashboardInputs(),
                show: true
            },
           {
                number: 11,
                cols: 12,
                rows: 1,
                y: 5,
                x: 0,
                component: DashboardAdoptionticklerComponent,
                title: 'Adoption/Gap Notification',
                input: new DashboardInputs(),
                show: true
            }
        ],
        FTDM: [
            {
                number: 8,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyservicecaseComponent,
                title: pendingassignments,
                input: new DashboardInputs(),
                show: true
            }
        ],
        QIS: [
            {
                number: 8,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyservicecaseComponent,
                title: pendingassignments,
                input: new DashboardInputs(),
                show: true
            }
        ],
        FTDMQIS: [
            {
                number: 8,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyservicecaseComponent,
                title: pendingassignments,
                input: new DashboardInputs(),
                show: true
            }
        ],
        LDSS: [
            {
                number: 1,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyappsComponent,
                title: 'My Applications',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 2,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DashboardMyrejectedclosedappComponent,
                title: 'Rejected/Closed Applications',
                input: new DashboardInputs(),
                show: true
            },
        ],
        APPEAL:    [        {
            number: 1,
            cols: 12,
            rows: 2,
            y: 3,
            x: 0,
            component: DashboardMyappealcaseComponent,
            title: 'My Appeal Case',
            input: new DashboardInputs(),
            show: true
        },]
    };
}
