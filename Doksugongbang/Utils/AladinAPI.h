//
//  AladinAPI.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AladinAPI : NSObject

#pragma mark - Class Methods

+ (NSURL *)aladinApiURLWithPath:(NSString *)path parameters:(NSDictionary<NSString *, NSString *> *)additionalParameters;

@end
