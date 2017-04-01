//
//  LoginController.h
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
- (IBAction)addInfo:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
