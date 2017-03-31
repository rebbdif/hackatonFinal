//
//  LoginsModel.h
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginsModel : NSObject

@property (strong, nonatomic) NSString *service;
@property (strong, nonatomic) NSString *login;

-(instancetype)initWithLogin:(NSString *)service login:(NSString *)login;

@end
