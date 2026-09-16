import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { ResourceConsultComponent } from './resource-consult.component';


describe('ResourceConsultComponent', () => {
  let component: ResourceConsultComponent;
  let fixture: ComponentFixture<ResourceConsultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ResourceConsultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ResourceConsultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
