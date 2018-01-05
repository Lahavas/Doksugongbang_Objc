//
//  DGBBookLoader.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookLoader.h"
#import "DGBBook.h"
#import "AladinAPI.h"

@interface DGBBookLoader ()

@property (strong, nonatomic) NSURLSession *session;

@end

#pragma mark -

@implementation DGBBookLoader

#pragma mark - Singleton Method

+ (instancetype)sharedInstance {
    static DGBBookLoader *bookLoader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bookLoader = [[DGBBookLoader alloc] initWithPrivate];
    });
    return bookLoader;
}

#pragma mark - Initialization

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [DGBBookLoader sharedInstance]"
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

- (void)fetchBookWithURL:(NSURL *)url completion:(void (^)(DGBBook *book))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         DGBBook *book = [AladinAPI bookParsingFromJSONData:data];
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             completion(book);
                                                         });
                                                     }];
    
    [dataTask resume];
}

- (void)fetchBookListWithURL:(NSURL *)url completion:(void (^)(NSArray<DGBBook *> *bookList))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         NSArray<DGBBook *> *bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             completion(bookList);
                                                         });
                                                     }];
    
    [dataTask resume];
}

- (void)fetchCoverImageWithBook:(DGBBook *)book completion:(void (^)(UIImage *image))completion {
    NSURL *url = [NSURL URLWithString:book.coverURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         UIImage *image = [UIImage imageWithData:data];
                                                         
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             completion(image);
                                                         });
                                                     }];
    
    [dataTask resume];
}

@end
