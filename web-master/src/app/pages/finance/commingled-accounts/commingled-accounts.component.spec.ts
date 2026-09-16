import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { CommingledAccountsComponent } from './commingled-accounts.component';


describe('CommingledAccountsComponent', () => {
  let component: CommingledAccountsComponent;
  let fixture: ComponentFixture<CommingledAccountsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CommingledAccountsComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CommingledAccountsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
