//
//  DGBDataLoader.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 8..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBDataLoader.h"

@interface DGBDataLoader ()

#pragma mark - Private Properties

@property (strong, nonatomic, readonly) NSURLSession *session;

@end

#pragma mark -

@implementation DGBDataLoader

#pragma mark - Singleton Method

+ (instancetype)sharedInstance {
    static DGBDataLoader *dataLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataLoader = [[DGBDataLoader alloc] initWithPrivate];
    });
    return dataLoader;
}

#pragma mark - Initialization

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [DGBDataLoader sharedInstance]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithPrivate {
    self = [super init];
    
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}

#pragma mark - Fetching Methods

- (void)fetchDataWithURL:(NSURL *)url completion:(void (^)(NSData *data))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         completion(data);
                                                     }];
    [dataTask resume];
}

@end
