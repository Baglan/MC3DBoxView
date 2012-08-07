//
//  MC3DBoxView.m
//  Faux3d
//
//  Created by Baglan on 8/6/12.
//
//

#import "MC3DBoxView.h"
#import <QuartzCore/QuartzCore.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface MC3DBoxView () <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    
    UIView *_containerView;
    
    UIView *_frontView;
    UIView *_leftView;
    UIView *_rightView;
    UIView *_backView;
    
    CGFloat _sideWidth;
    CGFloat _distance;
    CGFloat _viewWidth;
    
    CATransform3D _baseTransform;
}

@end

@implementation MC3DBoxView

@synthesize frontView = _frontView;
@synthesize leftView = _leftView;
@synthesize backView = _backView;
@synthesize rightView = _rightView;

- (void)addScrollView
{
    CGRect frame = self.bounds;
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self addSubview:_scrollView];
    _scrollView.hidden = YES;
    [self addGestureRecognizer:_scrollView.panGestureRecognizer];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(frame.size.width * 4, frame.size.height);
    _scrollView.delegate = self;
}

- (id)initWithFrame:(CGRect)frame sideSize:(CGSize)size distance:(CGFloat)distance
{
    self = [super initWithFrame:frame];
    if (self) {
        _sideWidth = size.width;
        _distance = distance;
        _viewWidth = frame.size.width;
        
        CGFloat halfSideWidth = _sideWidth / 2;
        
        _baseTransform = CATransform3DIdentity;
        _baseTransform.m34 = 1.0 / _distance;
        _baseTransform = CATransform3DTranslate(_baseTransform, 0, 0, -halfSideWidth);
        
        CGRect sideRect = CGRectMake((_viewWidth - size.width) / 2, (frame.size.height - size.height) / 2, size.width, size.height);
        
        // Container
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.layer.sublayerTransform = _baseTransform;
        _containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_containerView];
        
        // Front view
        _frontView = [[UIView alloc] initWithFrame:sideRect];
        _frontView.layer.transform = CATransform3DMakeTranslation(0, 0, halfSideWidth);
        [_containerView addSubview:_frontView];
        
        // Left view
        _leftView = [[UIView alloc] initWithFrame:sideRect];
        _leftView.layer.transform = CATransform3DTranslate(CATransform3DMakeRotation(radians(-90), 0, 1, 0), 0, 0, halfSideWidth);
        [_containerView addSubview:_leftView];
        
        // Right view
        _rightView = [[UIView alloc] initWithFrame:sideRect];
        _rightView.layer.transform = CATransform3DTranslate(CATransform3DMakeRotation(radians(90), 0, 1, 0), 0, 0, halfSideWidth);
        [_containerView addSubview:_rightView];
        
        // Back view
        _backView = [[UIView alloc] initWithFrame:sideRect];
        _backView.layer.transform = CATransform3DTranslate(CATransform3DMakeRotation(radians(180), 0, 1, 0), 0, 0, halfSideWidth);
        [_containerView addSubview:_backView];
        
        [self addScrollView];
    }
    return self;
}

#pragma mark -
#pragma mark ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat floatFace = offsetX / _viewWidth;
    int intFace = floatFace;
    
    CGFloat angle = radians(90 * offsetX / _viewWidth);
    
    _containerView.layer.sublayerTransform = CATransform3DRotate(_baseTransform, -angle, 0, 1, 0);
    
    switch (intFace) {
        case 0: // Front
            _frontView.hidden = NO;
            _leftView.hidden = NO;
            _rightView.hidden = NO;
            _backView.hidden = YES;
            break;
            
        case 1: // Right
            _frontView.hidden = NO;
            _leftView.hidden = YES;
            _rightView.hidden = NO;
            _backView.hidden = NO;
            break;
            
        case 2: // Back
            _frontView.hidden = YES;
            _leftView.hidden = NO;
            _rightView.hidden = NO;
            _backView.hidden = NO;
            break;
            
        case 3: // Left
            _frontView.hidden = NO;
            _leftView.hidden = NO;
            _rightView.hidden = YES;
            _backView.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

@end
