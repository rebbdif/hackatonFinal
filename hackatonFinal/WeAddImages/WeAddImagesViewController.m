//
//  WeAddImagesViewController.m
//  hackatonFinal
//
//  Created by 1 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "WeAddImagesViewController.h"
#import "MSCollectionVC.h"


@interface WeAddImagesViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextFieldDelegate>
- (IBAction)addImagesButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImage;
@property (weak, nonatomic) IBOutlet UITextField *imageDescriptionText;
@property (weak, nonatomic) IBOutlet UIButton *addImageOutlet;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonOutlet;
- (IBAction)submitButtonAction:(id)sender;

@property(strong,nonatomic) NSString *photoName;
@end

@implementation WeAddImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chosenImage.hidden=YES;
    _imageDescriptionText.hidden=YES;
    _submitButtonOutlet.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
}



- (IBAction)addImagesButton:(UIButton *)sender {
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    
}

#pragma mark - ImagePicker

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info: %@", info);
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.chosenImage.image=chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            _chosenImage.hidden=NO;
            // _imageDescriptionText.hidden=NO;
            _addImageOutlet.titleLabel.text=@"change image";
            _submitButtonOutlet.hidden=NO;
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Введите название" message:
                                        @"Введите название фото" preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"название фото";
            }];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      _photoName= alert.textFields[0].text;
                                                                      if (!_photoName){
                                                                          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                          NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                                                                          [formatter setLocale:posix];
                                                                          [formatter setDateFormat:@"M.d.y"];
                                                                          NSDate *now = [NSDate date];
                                                                          NSString *prettyDate = [formatter stringFromDate:now];
                                                                          _photoName=  [@"photo" stringByAppendingString: prettyDate];
                                                                      }
                                                                      
                                                                      
                                                                      
                                                                      dispatch_async(dispatch_get_main_queue(),^{
                                                                          self.imageDescriptionText.hidden=NO;
                                                                          self.imageDescriptionText.text=_photoName;
                                                                      });
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)submitButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    return YES;
}

@end