//
//  LoginCell.h
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginsModel;

@interface LoginCell : UITableViewCell

- (void) fillCellWithService:(LoginsModel *)model;

@end
