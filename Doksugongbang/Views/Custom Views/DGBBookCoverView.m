//
//  DGBBookCoverView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverView.h"
#import "DGBImageStore.h"
#import "DGBDataLoader.h"

static void *DGBBookCoverImageViewContext = &DGBBookCoverImageViewContext;

@interface DGBBookCoverView ()

#pragma mark - Private Properties

@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIImageView *bookCoverImageView;

@end

#pragma mark -

@implementation DGBBookCoverView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
        
        [self.bookCoverImageView addObserver:self
                                  forKeyPath:@"image"
                                     options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                                     context:DGBBookCoverImageViewContext];
    }
    
    return self;
}

#pragma mark - Deallocation

- (void)dealloc {
    [self.bookCoverImageView removeObserver:self
                                 forKeyPath:@"image"];
}

#pragma mark - Key-Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == DGBBookCoverImageViewContext) {
        if (change[NSKeyValueChangeNewKey] == [NSNull null]) {
            [self.spinner startAnimating];
        } else {
            [self.spinner stopAnimating];
        }
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    CGFloat intrinsicCoverViewWidth = 100.0;
    CGFloat intrinsicCoverViewHeight = 140.0;
    CGSize intrinsicCoverViewSize = CGSizeMake(intrinsicCoverViewWidth,
                                               intrinsicCoverViewHeight);
    
    return intrinsicCoverViewSize;
}

#pragma mark - Set Up Methods

- (void)setUpSubviews {
    _bookCoverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.bookCoverImageView setContentMode:UIViewContentModeScaleToFill];
    [self.spinner setHidesWhenStopped:YES];
    
    [self setUpBookCoverImageShadow];
    
    [self addSubview:self.bookCoverImageView];
    [self addSubview:self.spinner];
    
    [self setUpConstraints];
}

- (void)setUpBookCoverImageShadow {
    CALayer *bookCoverImageViewLayer = self.bookCoverImageView.layer;
    
    CGColorRef shadowColor = [UIColor grayColor].CGColor;
    CGFloat shadowOffsetWidth = 5.0;
    CGFloat shadowOffsetHeight = 5.0;
    CGSize shadowOffsetSize = CGSizeMake(shadowOffsetWidth,
                                         shadowOffsetHeight);
    
    [bookCoverImageViewLayer setShadowColor:shadowColor];
    [bookCoverImageViewLayer setShadowOffset:shadowOffsetSize];
    [bookCoverImageViewLayer setShadowOpacity:1.0];
    [bookCoverImageViewLayer setShadowRadius:1.0];
}

- (void)setUpConstraints {
    CGFloat standardMargin = 5.0;
    
    [self.bookCoverImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[[self.bookCoverImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.bottomAnchor constraintEqualToAnchor:self.bookCoverImageView.bottomAnchor
                                                                                constant:standardMargin],
                                              [self.bookCoverImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.trailingAnchor constraintEqualToAnchor:self.bookCoverImageView.trailingAnchor
                                                                                  constant:standardMargin]]];
    
    [NSLayoutConstraint activateConstraints:@[[self.spinner.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                              [self.spinner.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
}

#pragma mark - Public Methods

- (void)updateImageWithURL:(NSURL *)coverURL isbn:(NSString *)isbn {
    _recentURL = coverURL;
    
    DGBImageStore *imageStore = [DGBImageStore sharedInstance];

    if ([imageStore isExistImageForKey:isbn]) {
        UIImage *image = [imageStore imageForKey:isbn];
        [self.bookCoverImageView setImage:image];
    } else {
        __weak typeof(self) weakSelf = self;

        [[DGBDataLoader sharedInstance] fetchDataWithURL:coverURL
                                              completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  UIImage *image = [UIImage imageWithData:data];
                                                  [imageStore setImage:image
                                                                forKey:isbn];

                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if ([weakSelf.recentURL isEqual:response.URL]) {
                                                          [weakSelf.bookCoverImageView setImage:image];
                                                      }
                                                  });
                                              }];
    }
}

- (void)resetBookCoverImage {
    [self.bookCoverImageView setImage:nil];
}

@end
