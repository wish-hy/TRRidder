//
//  RZCarPlateNoInputAlertView.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/11.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface RZCarPlateNoInputView : UIView
@property (nonatomic, strong) UIView *firstView;

- (instancetype)initWithFrame:(CGRect)frame plateNo:(NSString *)plateNo plateLength:(NSUInteger)length ;
@end

NS_ASSUME_NONNULL_END
