//
//  DGBDataLoader.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGBDataLoader : NSObject

#pragma mark - Singleton Method

+ (instancetype)sharedInstance;

#pragma mark - Fetching Methods

- (void)fetchDataWithURL:(NSURL *)url completion:(void (^)(NSData *data))completion;

@end
