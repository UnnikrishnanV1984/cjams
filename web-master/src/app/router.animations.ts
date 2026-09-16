import { animate, state, style, transition, trigger } from '@angular/animations';

const easeanimationtype = '0.5s ease-in-out';
const translatex0 = 'translateX(0%)';
const translatey0 = 'translateY(0%)';
export function routerTransition() {
    return slideToTop();
}

export function slideToRight() {
    return trigger('routerTransition', [
        state('void', style({})),
        state('*', style({})),
        transition(':enter', [
            style({ transform: 'translateX(-100%)' }),
            animate(easeanimationtype, style({ transform: translatex0 }))
        ]),
        transition(':leave', [
            style({ transform: translatex0 }),
            animate(easeanimationtype, style({ transform: 'translateX(100%)' }))
        ])
    ]);
}

export function slideToLeft() {
    return trigger('routerTransition', [
        state('void', style({})),
        state('*', style({})),
        transition(':enter', [
            style({ transform: 'translateX(100%)' }),
            animate(easeanimationtype, style({ transform: translatex0 }))
        ]),
        transition(':leave', [
            style({ transform: translatex0 }),
            animate(easeanimationtype, style({ transform: 'translateX(-100%)' }))
        ])
    ]);
}

export function slideToBottom() {
    return trigger('routerTransition', [
        state('void', style({})),
        state('*', style({})),
        transition(':enter', [
            style({ transform: 'translateY(-100%)' }),
            animate(easeanimationtype, style({ transform: translatey0 }))
        ]),
        transition(':leave', [
            style({ transform: translatey0 }),
            animate(easeanimationtype, style({ transform: 'translateY(100%)' }))
        ])
    ]);
}

export function slideToTop() {
    return trigger('routerTransition', [
        state('void', style({})),
        state('*', style({})),
        transition(':enter', [
            style({ transform: 'translateY(100%)' }),
            animate(easeanimationtype, style({ transform: translatey0 }))
        ]),
        transition(':leave', [
            style({ transform: translatey0 }),
            animate(easeanimationtype, style({ transform: 'translateY(-100%)' }))
        ])
    ]);
}
