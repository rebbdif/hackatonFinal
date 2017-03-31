//
//  KeychainWrapper.h
//  hackatonFinal
//
//  Created by Smirnov Ivan on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainWrapper : NSObject {
    NSMutableDictionary        *keychainData;
    NSMutableDictionary        *genericPasswordQuery;
}

@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)resetKeychainItem;


@end
