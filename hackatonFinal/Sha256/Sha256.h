//
//  Sha256.h
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sha256 : NSObject

-(NSString *)hmacSHA256:(NSString *)key data:(NSString *)data;

@end
