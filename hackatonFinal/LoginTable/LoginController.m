//
//  LoginController.m
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "LoginController.h"
#import "LoginCell.h"
#import "LoginsModel.h"
#import "Keychain.h"

#define GROUP_NAME @"YOUR_APP_ID.com.apps.shared"
#define SERVICE_NAME @"ANY_NAME_FOR_YOU"

@interface LoginController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_modelArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableViewMessege numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableViewMessege heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewMessege cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginCell *cell = [tableViewMessege dequeueReusableCellWithIdentifier:@"LoginCell" forIndexPath:indexPath];
    LoginsModel *model;
    if ([_modelArray[indexPath.row] isMemberOfClass:[LoginsModel class]]) {
        model = _modelArray[indexPath.row];
        [cell fillCellWithService:model];
    }
    return cell;
}

- (void) setupModel {
    
    if (_modelArray != nil){
        [_modelArray removeAllObjects];
    }
    _modelArray = [[NSMutableArray alloc] init];
        
        //TODO
        Keychain *keyChain = [[Keychain alloc] initWithService:SERVICE_NAME withGroup:nil];
        NSString* token=[[[UIDevice currentDevice]identifierForVendor] UUIDString];
        NSUserDefaults *userDeafults = [NSUserDefaults standardUserDefaults];
        NSString *login = [userDeafults objectForKey:@"login"];
        NSInteger idz = [userDeafults objectForKey:@"idz"];
        for (int i = 0; i<idz; i++) {
            NSData *serviceData = [keyChain find:[NSString stringWithFormat:@"%@%@%ld", login, token, (long)idz]];
            NSData *serLoginData = [keyChain find:[NSString stringWithFormat:@"%@%@%ld", login, token, (long)idz]];
            NSString *service = [[NSString alloc]initWithData:serviceData encoding:NSUTF8StringEncoding];
            NSString *serLogin = [[NSString alloc]initWithData:serLoginData encoding:NSUTF8StringEncoding];
            LoginsModel *model = [[LoginsModel alloc]initWithLogin:service login:serLogin];
            [_modelArray addObject:model];
        }
    
    [_tableView reloadData];
}

@end
