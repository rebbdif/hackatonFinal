//
//  KeychainWrapper.h
//  hackatonFinal
//
//  Created by Smirnov Ivan on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainWrapper : NSObject

- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)writeToKeychain;

@end
