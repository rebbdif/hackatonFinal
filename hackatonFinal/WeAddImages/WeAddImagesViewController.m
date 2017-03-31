//
//  WeAddImagesViewController.m
//  hackatonFinal
//
//  Created by 1 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "WeAddImagesViewController.h"

@interface WeAddImagesViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)addImagesButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImage;
@property (weak, nonatomic) IBOutlet UITextField *imageDescriptionText;
@property (weak, nonatomic) IBOutlet UIButton *addImageOutlet;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonOutlet;

@end

@implementation WeAddImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    _chosenImage.hidden=YES;
    _imageDescriptionText.hidden=YES;
    _submitButtonOutlet.hidden=YES;
}



- (IBAction)addImagesButton:(UIButton *)sender {
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    _chosenImage.hidden=NO;
    _imageDescriptionText.hidden=NO;
    _addImageOutlet.titleLabel.text=@"change image";
    _submitButtonOutlet.hidden=NO;
}

#pragma mark - ImagePicker

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info: %@", info);
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.chosenImage.image=chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
