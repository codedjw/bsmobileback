//
//  XYMakeCommentController.h
//  BStoreMobile
//
//  Created by Julie on 14-7-30.
//  Copyright (c) 2014年 SJTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYStarRatedView.h"
#import "XYTableViewController.h"

@interface XYMakeCommentController : XYTableViewController<StarRatedViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSString *bookID;
@property (nonatomic, strong) NSString *bname;

@end
