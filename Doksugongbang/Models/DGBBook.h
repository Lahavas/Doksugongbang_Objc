//
//  DGBBook.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGBBook : NSObject

#pragma mark - Public Properties

@property (strong, nonatomic, readonly) NSString *isbn;

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *author;
@property (strong, nonatomic, readonly) NSString *publisher;
@property (strong, nonatomic, readonly) NSDate *pubDate;

@property (assign, nonatomic, readonly) NSUInteger page;
@property (strong, nonatomic, readonly) NSString *category;
@property (strong, nonatomic, readonly) NSString *bookDescription;

@property (strong, nonatomic, readonly) NSString *linkURL;
@property (strong, nonatomic, readonly) NSString *coverURL;

#pragma mark - Initialization

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
