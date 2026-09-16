import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { NotificationEntitesComponent } from './notification-entites.component';

describe('NotificationEntitesComponent', () => {
  let component: NotificationEntitesComponent;
  let fixture: ComponentFixture<NotificationEntitesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ NotificationEntitesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NotificationEntitesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
