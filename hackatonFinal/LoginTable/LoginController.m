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
#import "PassController.h"

#define GROUP_NAME @"YOUR_APP_ID.com.apps.shared"
#define SERVICE_NAME @"ANY_NAME_FOR_YOU"

@interface LoginController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_modelArray;
}


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self setupModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableViewMessege numberOfRowsInSection:(NSInteger)section {
    
    Keychain *keyChain = [[Keychain alloc] initWithService:SERVICE_NAME withGroup:nil];
    NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
    NSString* login=[userDefaults objectForKey:@"login"];
    NSString* key = [NSString stringWithFormat:@"idz%@", login];
    NSData *idzData = [keyChain find:key];
    NSString *idz = [[NSString alloc] initWithData:idzData encoding:NSUTF8StringEncoding];
    
    return [idz integerValue];
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
    NSString* keyID = [NSString stringWithFormat:@"idz%@", login];
    NSString *keyPas = [NSString stringWithFormat:@"%@%@",login,token];
    NSData *pasData = [keyChain find:keyPas];
    NSString *pass = [[NSString alloc] initWithData:pasData encoding:NSUTF8StringEncoding];
        NSData* idzData = [keyChain find:keyID];
    NSString *idz = [[NSString alloc] initWithData:idzData encoding:NSUTF8StringEncoding];
        for (int i = 0; i<[idz integerValue]; i++) {
            NSString *keyDict = [NSString stringWithFormat:@"%@%d%@",login,i,pass];
            NSData *dataDic = [keyChain find:keyDict];
            NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:dataDic];
            NSString *service = [myDictionary objectForKey:@"service"];
            NSString *serLogin = [myDictionary objectForKey:@"login"];
            LoginsModel *model = [[LoginsModel alloc]initWithLogin:service login:serLogin];
            [_modelArray addObject:model];
        }
    
    [_tableView reloadData];
}

- (IBAction)addInfo:(UIBarButtonItem *)sender {
    
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"TableStoryboard" bundle:nil];
    PassController* vc =[sb instantiateViewControllerWithIdentifier:@"inf"];
    vc.lc=self;
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
}
@end
