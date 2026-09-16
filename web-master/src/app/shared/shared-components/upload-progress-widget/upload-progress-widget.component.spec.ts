import { ComponentFixture, TestBed } from '@angular/core/testing';
import { UploadProgressWidgetComponent } from './upload-progress-widget.component';


describe('UploadProgressWidgetComponent', () => {
  let component: UploadProgressWidgetComponent;
  let fixture: ComponentFixture<UploadProgressWidgetComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UploadProgressWidgetComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UploadProgressWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
