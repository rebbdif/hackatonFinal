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


@end

@implementation MyTouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)touchIDButton:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *message;
    NSError *error;
    BOOL success;
    
    // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
    success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        message = [NSString stringWithFormat:@"Touch ID is available"];
        NSLog(@"%@",message);
    }
    else {
        message = [NSString stringWithFormat:@"Touch ID is not available"];
        NSLog(@"%@",message);

    }
    

}
@end
