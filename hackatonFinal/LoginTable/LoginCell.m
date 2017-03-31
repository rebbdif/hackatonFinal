//
//  LoginCell.m
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "LoginCell.h"
#import "LoginsModel.h"

@interface LoginCell()
@property (weak, nonatomic) IBOutlet UILabel *ServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *LoginLabel;


@end

@implementation LoginCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithService:(LoginsModel *)model{
    
    self.ServiceLabel.text = model.service;
    self.LoginLabel.text = model.login;
    
}


@end
