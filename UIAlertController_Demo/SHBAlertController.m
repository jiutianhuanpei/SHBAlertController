//
//  SHBAlertController.m
//  UIAlertController_Demo
//
//  Created by 沈红榜 on 15/11/20.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "SHBAlertController.h"
#import "HexColors.h"
#import "AppDelegate.h"

@implementation SHBAction

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}

+ (SHBAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action {
    SHBAction *ac = [[SHBAction alloc] initWithTitle:title action:action];
    return ac;
}

@end

@interface SHBAlertController ()

@end

CGFloat backViewH = 197.5;

@implementation SHBAlertController {
    NSString            *_title;
    UIImage             *_image;
    NSString            *_message;
    
    UIView              *_backView;
    
    UILabel             *_titleLbl;
    UIImageView         *_photo;
    UILabel             *_messageLbl;
    UITextField         *_textField;
    
    UIButton            *_cancel;
    UIButton            *_send;
    
    UIView              *_hLine;
    UIView              *_vLine;
    
    CGFloat             _backBottom;
    NSLayoutConstraint  *_bottom;
    
    NSMutableArray      *_actions;
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image message:(NSString *)message {
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _message = message;
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    _backBottom = -(CGRectGetHeight(self.view.frame) - backViewH) / 2.;
    
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.translatesAutoresizingMaskIntoConstraints = false;
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = true;
    [self.view addSubview:_backView];
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLbl.translatesAutoresizingMaskIntoConstraints = false;
    _titleLbl.textColor = [UIColor hx_colorWithHexString:@"333333"];
    _titleLbl.font = [UIFont systemFontOfSize:14];
    _titleLbl.text = _title;
    [_backView addSubview:_titleLbl];
    
    _photo = [[UIImageView alloc] initWithFrame:CGRectZero];
    _photo.translatesAutoresizingMaskIntoConstraints = false;
    _photo.layer.cornerRadius = 2;
    _photo.layer.masksToBounds = true;
    _photo.image = _image;
    [_backView addSubview:_photo];
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLbl.translatesAutoresizingMaskIntoConstraints = false;
    _messageLbl.textColor = [UIColor hx_colorWithHexString:@"333333"];
    _messageLbl.font = [UIFont systemFontOfSize:16];
    _messageLbl.text = _message;
    [_backView addSubview:_messageLbl];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.translatesAutoresizingMaskIntoConstraints = false;
    _textField.layer.borderColor = [UIColor hx_colorWithHexString:@"e2e1e1"].CGColor;
    _textField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    _textField.layer.cornerRadius = 2;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"你想说点什么";
    [_backView addSubview:_textField];
    
    
    UIColor *lineColor = [UIColor hx_colorWithHexString:@"e3e1e4"];
    
    _hLine = [[UIView alloc] initWithFrame:CGRectZero];
    _hLine.translatesAutoresizingMaskIntoConstraints = false;
    _hLine.backgroundColor = lineColor;
    [_backView addSubview:_hLine];
    
    _vLine = [[UIView alloc] initWithFrame:CGRectZero];
    _vLine.translatesAutoresizingMaskIntoConstraints = false;
    _vLine.backgroundColor = lineColor;
    [_backView addSubview:_vLine];
    
    _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancel.translatesAutoresizingMaskIntoConstraints = false;
    
    NSString *cancel = [(SHBAction *)_actions[0] title];
    [_cancel setTitle:cancel forState:UIControlStateNormal];
    [_cancel setTitleColor:[UIColor hx_colorWithHexString:@"999999"] forState:UIControlStateNormal];
    _cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancel addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancel.tag = 100;
    [_backView addSubview:_cancel];
    
    _send = [UIButton buttonWithType:UIButtonTypeSystem];
    _send.translatesAutoresizingMaskIntoConstraints = false;
    NSString *send = [(SHBAction *)_actions[1] title];
    [_send setTitle:send forState:UIControlStateNormal];
    [_send setTitleColor:[UIColor hx_colorWithHexString:@"797ca1"] forState:UIControlStateNormal];
    _send.titleLabel.font = [UIFont systemFontOfSize:15];
    [_send addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
    _send.tag = 200;
    [_backView addSubview:_send];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_backView, _titleLbl, _photo, _messageLbl, _textField, _hLine, _vLine, _cancel, _send);
    NSDictionary *met = @{@"one" : @(1 / [UIScreen mainScreen].scale)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_backView]-30-|" options:0 metrics:nil views:views]];
    _bottom = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:_backBottom];
    [self.view addConstraint:_bottom];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_titleLbl]-12-[_photo(50)]-12-[_textField(38)]-12-[_hLine(one)][_cancel(44)]|" options:0 metrics:met views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hLine][_send]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hLine][_vLine]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_titleLbl]-17-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_photo(50)]-10-[_messageLbl]-17-|" options:0 metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_messageLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_photo attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_textField]-17-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_hLine]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_cancel][_vLine(one)][_send(_cancel)]|" options:0 metrics:met views:views]];
    self.view.layer.shouldRasterize = true;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [self registerKeyBoard];
}



- (void)keyBoardShow:(NSNotification *)info {
    
    NSValue *keyBoardRect = [[info userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyRect = [keyBoardRect CGRectValue];
    
    if (_backBottom > -keyRect.size.height) {
        _bottom.constant = -30 - keyRect.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyBoardHidden:(NSNotification *)info {
    _bottom.constant = _backBottom;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)shbClickedBtn:(UIButton *)btn {
    _content = _textField.text;
    if (btn.tag == 100) {
        SHBAction *action = _actions[0];
        if (action.action) {
            action.action();
        }
    } else {
        SHBAction *action = _actions[1];
        if (action.action) {
            action.action();
        }
    }
    [self dismiss];
}

- (void)addAction:(SHBAction *)action {
    [_actions addObject:action];
}


- (void)show {
    UIViewController *result = [self currentController];
    [result addChildViewController:self];
    [result.view addSubview:self.view];
}

- (void)dismiss {
    __weak typeof(self) SHB = self;
    [UIView animateWithDuration:0.1 animations:^{
        [SHB.view removeFromSuperview];
        [SHB removeFromParentViewController];
    } completion:^(BOOL finished) {
        [SHB removeKeyBoard];
    }];
}

- (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        result = nestResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

#pragma mark - Keyboard
- (void)registerKeyBoard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyBoard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
