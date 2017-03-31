//
//  LoginsModel.m
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "LoginsModel.h"

@implementation LoginsModel

-(instancetype)initWithLogin:(NSString *)service login:(NSString *)login {
    if (self = [super init]){
        _login = login;
        _service = service;
    }
    return self;
}

@end


