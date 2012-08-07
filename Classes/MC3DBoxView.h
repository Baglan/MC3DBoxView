//
//  MC3DBoxView.h
//  Faux3d
//
//  Created by Baglan on 8/6/12.
//
//

#import <UIKit/UIKit.h>

@interface MC3DBoxView : UIView

- (id)initWithFrame:(CGRect)frame sideSize:(CGSize)size distance:(CGFloat)distance;

@property (nonatomic,readonly) UIView *frontView;
@property (nonatomic,readonly) UIView *leftView;
@property (nonatomic,readonly) UIView *backView;
@property (nonatomic,readonly) UIView *rightView;

@end
