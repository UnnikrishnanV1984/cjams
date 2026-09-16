import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildAccountsTabComponent } from './child-accounts.component';

describe('ChildAccountsComponent', () => {
  let component: ChildAccountsTabComponent;
  let fixture: ComponentFixture<ChildAccountsTabComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildAccountsTabComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildAccountsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
