//
//  ISRegVC.m
//  IOSHuaweiApp
//
//  Created by Smirnov Ivan on 28.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISRegVC.h"
#import "ISLoginVC.h"
#import "ISUser.h"
#import "Sha256.h"
#import <Security/Security.h>
#import "KeychainWrapper.h"
#import "Keychain.h"

#define SERVICE_NAME @"ANY_NAME_FOR_YOU"
#define GROUP_NAME @"YOUR_APP_ID.com.apps.shared" //GROUP NAME should start with appl

@interface ISRegVC ()

@property(strong,nonatomic)NSString* login;
@property(strong,nonatomic)NSString* pasword;


@end


static const UInt8 kKeychainItemIdentifier[]    = "com.apple.dts.KeychainUI\0";


@implementation ISRegVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UITextField* tf in self.anTextFs) {
        
        tf.alpha=0;
    }
    [self.regBut setBackgroundColor:[UIColor whiteColor]];
    self.infoButton.alpha=0;
    UIColor* c=[UIColor colorWithRed:254.f/255.f green:82.f/255.f blue:184.f/255.f alpha:1];
    [self.registButton setTitleColor:c forState:UIControlStateNormal];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.regBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor* c=[UIColor colorWithRed:254.f/255.f green:82.f/255.f blue:184.f/255.f alpha:1];
        [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.regBut setBackgroundColor:c];
        
        self.infoButton.alpha=1;
        
        for (UITextField* tf in self.anTextFs) {
            
            tf.alpha=1;
        }

        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)log:(UIButton *)sender {
    
    ISLoginVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"log"];
    [self presentViewController:vc animated:NO completion:^{
        
    }];
    
}



#pragma mark-UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.kayConst.constant=200.f;
        [self.view layoutIfNeeded];
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if ([textField isEqual:self.mailTF]) {
        NSString* login=textField.text;
        self.login=login;
        
        [self.passwordTF becomeFirstResponder];
    } else
        if([textField isEqual:self.passwordTF])
        {
            NSString* password=textField.text;
            self.pasword=password;
            [self.passwordL becomeFirstResponder];
        } else
        
        {
        
            NSString* fName=textField.text;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [textField resignFirstResponder];
            self.kayConst.constant=250.f;
            [self.view layoutIfNeeded];
            
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
    
    return YES;
}




- (IBAction)regAction:(UIButton *)sender {
    
    NSInteger i=0;
    for (UITextField* tf in self.textFildArr) {
        
        if ([tf.text isEqualToString:@""]) {
            i++;
        }
        
    }
    
    if ((i==0)&&([self.passwordL.text isEqualToString:self.passwordTF.text])) {
        
        ISUser* user=[[ISUser alloc]init];
        user.login=self.mailTF.text;
        user.pasword=self.passwordTF.text;
        Sha256* sha=[[Sha256 alloc]init];
        NSString* token=[[[UIDevice currentDevice]identifierForVendor] UUIDString];
        NSString* login=user.login;
        NSString* pasword=user.pasword;
        NSString* logPlTok=[NSString stringWithFormat:@"%@%@",pasword,token];
        
        NSString* hash=[sha hmacSHA256:login data:logPlTok];
        
        Keychain* chain=[[Keychain alloc]initWithService:SERVICE_NAME withGroup:nil];
        NSString *key =login;
        NSData * value = [hash dataUsingEncoding:NSUTF8StringEncoding];
        NSData * data =[chain find:key];
        if((data == nil)){
        
        
        if([chain insert:key :value])
        {
            NSLog(@"Successfully added data");
        }
        else
            NSLog(@"Failed to  add data");
        
        UITabBarController* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"tab"];
        vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:login forKey:@"login"];
            [userDefaults synchronize];
        [self presentViewController:vc animated:YES completion:^{
            NSString *idf = @"0";
            NSString *idz = @"0";
            NSData *idfData = [idf dataUsingEncoding:NSUTF8StringEncoding];
            NSData *idzData = [idz dataUsingEncoding:NSUTF8StringEncoding];
            NSString *key1 = [NSString stringWithFormat:@"idf%@", login];
            NSString *key2 = [NSString stringWithFormat:@"idz%@", login];
            [chain insert:key1 :idfData];
            [chain insert:key2 :idzData];
            NSString* key=[NSString stringWithFormat:@"%@%@",login,token];
            NSData * value = [pasword dataUsingEncoding:NSUTF8StringEncoding];
            [chain insert:key :value];
            
            
        }];
        }else{
            
            [self presentAlertWithTitle:@"Такой пользователь уже существует"];
            
        }
        
        
    }else
        
        [self presentAlertWithTitle:@"Одно из полей не заполненно"];
    
}


-(void)presentAlertWithTitle:(NSString*)title{
    
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:title
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


@end
