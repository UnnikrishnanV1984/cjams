import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildAccountsComponent } from './child-accounts.component';

describe('ChildAccountsComponent', () => {
  let component: ChildAccountsComponent;
  let fixture: ComponentFixture<ChildAccountsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildAccountsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildAccountsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
