import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TeamManageDetailComponent } from './team-manage-detail.component';

describe('TeamManageDetailComponent', () => {
  let component: TeamManageDetailComponent;
  let fixture: ComponentFixture<TeamManageDetailComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TeamManageDetailComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TeamManageDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
