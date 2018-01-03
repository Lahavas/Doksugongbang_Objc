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

@property (copy, nonatomic) NSString *isbn;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *publisher;
@property (copy, nonatomic) NSString *pubdate;

@property (assign, nonatomic) NSUInteger page;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *bookDescription;

@property (copy, nonatomic) NSString *linkURL;
@property (copy, nonatomic) NSString *coverURL;

#pragma mark - Initialization

- (instancetype)initFromJSON:(NSDictionary<NSString *, id> *)json;

@end
