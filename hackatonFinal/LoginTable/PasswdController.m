//
//  PasswdController.m
//  hackatonFinal
//
//  Created by devil1001 on 01.04.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "PasswdController.h"

@interface PasswdController ()
@property (weak, nonatomic) IBOutlet UITextField *serviceText;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *pasText;

@end

@implementation PasswdController

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

@end
