//
//  ISLoginVC.m
//  IOSHuaweiApp
//
//  Created by Smirnov Ivan on 28.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISLoginVC.h"
#import "ISRegVC.h"
#import "MyTouchVC.h"
#import "Sha256.h"
#import "Keychain.h"

#define SERVICE_NAME @"ANY_NAME_FOR_YOU"
#define GROUP_NAME @"YOUR_APP_ID.com.apps.shared" //GROUP NAME should start with appl

@interface ISLoginVC ()<UITextFieldDelegate>

@end

@implementation ISLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"MyTouchStoryboard" bundle:nil];
        MyTouchVC* vc= [sb instantiateViewControllerWithIdentifier:@"touch"];
        vc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        vc.modalPresentationStyle=UIModalPresentationFullScreen;
    /*    [self presentViewController:vc animated:YES completion:^{
        
        }];
*/
    });
   
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

- (IBAction)reg:(UIButton *)sender {
    
   ISRegVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"reg"];
    UITextField* name=[[UITextField alloc]init];
    UITextField* fame=[[UITextField alloc]init];
    name.borderStyle=UITextBorderStyleNone;
    fame.borderStyle=UITextBorderStyleNone;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.keyboardCost.constant=250.f;
        self.heightLabC.constant=135;
        self.botCon.constant=45;
        [self.logButton setBackgroundColor:[UIColor whiteColor]];
        UIColor* c=[UIColor colorWithRed:119.f/255.f green:119.f/255.f blue:119.f/255.f alpha:1];
        UIColor* c2=[UIColor colorWithRed:255.f/255.f green:94.f/255.f blue:86.f/255.f alpha:1];
        [self.logButton setTitleColor:c forState:UIControlStateNormal];
        [self.loginButton setTitleColor:c2 forState:UIControlStateNormal];
        [self.infoButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self presentViewController:vc animated:NO completion:^{
        }];
        
    }];
    
    
}

#pragma mark-UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    

    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.keyboardCost.constant=270.f;
        [self.view layoutIfNeeded];
        
        NSLog(@"gawrg");
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    if ([textField isEqual:self.login]) {
        
        NSString* login=textField.text;
        [self.password becomeFirstResponder];
    } else {
        
        NSString* password=textField.text;
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [textField resignFirstResponder];
            self.keyboardCost.constant=340.f;
            [self.view layoutIfNeeded];
            
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
    
    return YES;
}

- (IBAction)goApp:(UIButton *)sender {
    
    NSInteger i=0;
    for (UITextField* tf in self.textFeldAr) {
        
        if ([tf.text isEqual:@""]) {
            i++;
        }
        
    }
    
    if (i==0) {
        
        NSString* login=self.login.text;
        NSString* pasword=self.password.text;
        NSString* token=[[[UIDevice currentDevice]identifierForVendor] UUIDString];
        NSString* logPlTok=[NSString stringWithFormat:@"%@%@",pasword,token];
        Sha256* sha=[[Sha256 alloc]init];
        NSString* hash=[sha hmacSHA256:login data:logPlTok];
        Keychain* chain=[[Keychain alloc]initWithService:SERVICE_NAME withGroup:nil];
        NSString *key =login;
        NSData * value = [hash dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData * data =[chain find:key];
        if(data == nil)
        {
            NSLog(@"Keychain data not found");
            [self presentAlertWithTitle:@"Проверьте правильность ввода"];
            
         }
            else
         {
             
             NSString* bHash=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data is =%@",bHash);
             
             
             if ([hash isEqualToString:bHash]) {
                 
               
            UITabBarController* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"tab"];
            vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:^{
                
                NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:login forKey:@"login"];
                [userDefaults synchronize];
                NSString* key=[NSString stringWithFormat:@"%@%@",login,token];
                NSData * value = [pasword dataUsingEncoding:NSUTF8StringEncoding];
                [chain insert:key :value];
                
                
                
                
                
                
                
            }];
                
             }else{
                 
                 [self presentAlertWithTitle:@"неверный Логин или PIN"];
                 
                 
             }
             
             
             
            }
        
        
        
    }else{
    
        [self presentAlertWithTitle:@"Одно из полей не заполненно"];
        
        
    }
    
    
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
