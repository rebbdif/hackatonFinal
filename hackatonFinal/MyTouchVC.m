//
//  MyTouchVC.m
//  hackatonFinal
//
//  Created by 1 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "MyTouchVC.h"
@import LocalAuthentication;

@interface MyTouchVC ()
- (IBAction)touchIDButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *touchIDOutlet;
- (IBAction)retryButton:(id)sender;


@end

@implementation MyTouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(  [self canYouUseTouchID]){
        [self checkTouchID];
    }
    
    
}


-(void) checkTouchID{
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *message;
    
    // Show the authentication UI with our reason string.
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Unlock access to locked feature" reply:^(BOOL success, NSError *authenticationError) {
        if (success) {
            message = @"TOUCHID: evaluatePolicy: succes";
        }
        else {
            message = [NSString stringWithFormat:@"TOUCHID: evaluatePolicy: %@", authenticationError.localizedDescription];
            
            
        }
        
        NSLog(@"%@",message);
        if(!success){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You failed to authorize"
                                                                           message:@"Try to swipe HOME button \n wash your hands \n improve your fingerpring in settings \n \n close the app and open it again"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
         /*   UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [[UIApplication sharedApplication]
                                                                       
                                                                      
                                                                  }];
            */
          //  [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}


-(BOOL)canYouUseTouchID{
    
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *message;
    NSError *error;
    BOOL success;
    
    // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
    success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        message = [NSString stringWithFormat:@"Touch ID is available"];
        NSLog(@"SUCCESS %@",message);
        _touchIDOutlet.hidden=NO;
        //здесь добавляем ввод второго пароля или что-то там
    }
    else {
        message = [NSString stringWithFormat:@"Touch ID is not available"];
        NSLog(@"FAILURE %@",message);
        _touchIDOutlet.hidden=YES;
    }
    return success;
    
}



- (IBAction)touchIDButton:(id)sender {
    
    
}
- (IBAction)retryButton:(id)sender {
    
    
    [self checkTouchID];
    
}
@end
