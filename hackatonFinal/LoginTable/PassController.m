//
//  PassController.m
//  hackatonFinal
//
//  Created by Smirnov Ivan on 01.04.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "PassController.h"
#import "Keychain.h"
#import "LoginController.h"

#define SERVICE_NAME @"ANY_NAME_FOR_YOU"


@interface PassController ()
@property (weak, nonatomic) IBOutlet UITextField *servText;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UITextField *pasText;

@end

@implementation PassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClicked:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [userDefaults objectForKey:@"login"];
    NSString* token=[[[UIDevice currentDevice]identifierForVendor] UUIDString];
    Keychain *keyChain = [[Keychain alloc] initWithService:SERVICE_NAME withGroup:nil];
    NSString *key = [NSString stringWithFormat:@"%@%@",login,token];
    NSData *passData = [keyChain find:key];
    NSString *pass = [[NSString alloc] initWithData:passData encoding:NSUTF8StringEncoding];
    NSString *idz = [NSString stringWithFormat:@"idz%@",login];
    NSData* dataID=[keyChain find:idz];
    NSString* idZs=[[NSString alloc]initWithData:dataID encoding:NSUTF8StringEncoding];
    
    NSString* service = self.servText.text;
    NSString* newLog = self.loginText.text;
    NSString* newPas = self.pasText.text;
    NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:service,@"service",
                      newLog,@"login",newPas,@"pin" ,nil];
    NSInteger i=[idZs integerValue];
    NSString* keyN=[NSString stringWithFormat:@"%@%@%ld",login,pass,(long)i];
    NSData *nidz=[[NSString stringWithFormat:@"%ld",i+1] dataUsingEncoding:NSUTF8StringEncoding];
    [keyChain update:idz :nidz];
    NSData* dataDic= [NSKeyedArchiver archivedDataWithRootObject:dic];
    [keyChain insert:keyN :dataDic];
    [self.lc.tableView reloadData];
    
    
    
    
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
