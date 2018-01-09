//
//  DGBImageStore.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBImageStore : NSObject

#pragma mark - Singleton Methods

+ (instancetype)sharedInstance;

#pragma mark - Image Methods

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;
- (BOOL)isExistImageForKey:(NSString *)key;

@end
