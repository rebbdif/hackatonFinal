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
    for (int i = 0; i<10; i++) {
        
        //TODO
        NSString *service = [NSString stringWithFormat:@"Service%d",i];
        NSString *login = [NSString stringWithFormat:@"Login%d",i];
        LoginsModel *model = [[LoginsModel alloc]initWithLogin:service login:login];
        [_modelArray addObject:model];
    }
    [_tableView reloadData];
}

@end
