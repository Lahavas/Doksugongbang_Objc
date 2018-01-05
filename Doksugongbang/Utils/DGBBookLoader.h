//
//  DGBBookLoader.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookLoader : NSObject

#pragma mark - Singleton Method

+ (instancetype)sharedInstance;

#pragma mark - Fetching Methods

- (void)fetchBookListWithURL:(NSURL *)url completion:(void (^)(NSArray<DGBBook *> *bookList))completion;
- (void)fetchCoverImageWithBook:(DGBBook *)book completion:(void (^)(UIImage *image))completion;

@end
