import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonAddEditRoleComponent } from './involved-person-add-edit-role.component';

describe('InvolvedPersonAddEditRoleComponent', () => {
  let component: InvolvedPersonAddEditRoleComponent;
  let fixture: ComponentFixture<InvolvedPersonAddEditRoleComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonAddEditRoleComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonAddEditRoleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
