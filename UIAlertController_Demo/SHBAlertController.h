//
//  SHBAlertController.h
//  UIAlertController_Demo
//
//  Created by 沈红榜 on 15/11/20.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBAction : NSObject

@property (nonatomic, readonly, copy) NSString            *title;
@property (nonatomic, readonly, copy) dispatch_block_t    action;

+ (SHBAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;
- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end


@interface SHBAlertController : UIViewController

@property (nonatomic, strong, readonly) NSString *content;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image message:(NSString *)message;

- (void)addAction:(SHBAction *)action;

- (void)show;

@end
