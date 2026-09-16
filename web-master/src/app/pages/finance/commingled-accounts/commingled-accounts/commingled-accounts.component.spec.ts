import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { CommingledAccountsTabComponent } from './commingled-accounts.component';


describe('CommingledAccountsTabComponent', () => {
  let component: CommingledAccountsTabComponent;
  let fixture: ComponentFixture<CommingledAccountsTabComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CommingledAccountsTabComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CommingledAccountsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });  
});
