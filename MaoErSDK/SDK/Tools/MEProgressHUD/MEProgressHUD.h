//
//  MEProgressHUD+WG.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/16.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol MEProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    MEProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    MEProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    MEProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    MEProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    MEProgressHUDModeCustomView,
    /** Shows only labels */
    MEProgressHUDModeText
} MEProgressHUDMode;

typedef enum {
    /** Opacity animation */
    MEProgressHUDAnimationFade,
    /** Opacity + scale animation */
    MEProgressHUDAnimationZoom,
    MEProgressHUDAnimationZoomOut = MEProgressHUDAnimationZoom,
    MEProgressHUDAnimationZoomIn
} MEProgressHUDAnimation;


#ifndef ME_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define ME_INSTANCETYPE instancetype
#else
#define ME_INSTANCETYPE id
#endif
#endif

#ifndef ME_STRONG
#if __has_feature(objc_arc)
#define ME_STRONG strong
#else
#define ME_STRONG retain
#endif
#endif

#ifndef ME_WEAK
#if __has_feature(objc_arc_weak)
#define ME_WEAK weak
#elif __has_feature(objc_arc)
#define ME_WEAK unsafe_unretained
#else
#define ME_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^MEProgressHUDCompletionBlock)();
#endif



@interface MEProgressHUD : UIView


+ (ME_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;

+ (ME_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;


- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;


- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(MEProgressHUDCompletionBlock)completion;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(MEProgressHUDCompletionBlock)completion;


@property (copy) MEProgressHUDCompletionBlock completionBlock;

#endif


@property (assign) MEProgressHUDMode mode;


@property (assign) MEProgressHUDAnimation animationType;

@property (ME_STRONG) UIView *customView;


@property (ME_WEAK) id<MEProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;


@property (ME_STRONG) UIColor *color;


@property (assign) float xOffset;


@property (assign) float yOffset;


@property (assign) float margin;


@property (assign) BOOL diMEackground;


@property (assign) float graceTime;


@property (assign) float minShowTime;


@property (assign) BOOL taskInProgress;


@property (assign) BOOL removeFromSuperViewOnHide;


@property (ME_STRONG) UIFont* labelFont;


@property (ME_STRONG) UIFont* detailsLabelFont;


@property (assign) float progress;


@property (assign) CGSize minSize;


@property (assign, getter = isSquare) BOOL square;

@end


@protocol MEProgressHUDDelegate <NSObject>

@optional

/**
 * Called after the HUD was fully hidden from the screen.
 */
- (void)hudWasHidden:(MEProgressHUD *)hud;

@end


/**
 * A progress view for showing definite progress by filling up a circle (pie chart).
 */
@interface MERoundProgressView : UIView

/**
 * Progress (0.0 to 1.0)
 */
@property (nonatomic, assign) float progress;


@property (nonatomic, ME_STRONG) UIColor *progressTintColor;


@property (nonatomic, ME_STRONG) UIColor *backgroundTintColor;

/*
 * Display mode - NO = round or YES = annular. Defaults to round.
 */
@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end


/**
 * A flat bar progress view.
 */
@interface MEBarProgressView : UIView

/**
 * Progress (0.0 to 1.0)
 */
@property (nonatomic, assign) float progress;

/**
 * Bar border line color.
 * Defaults to white [UIColor whiteColor].
 */
@property (nonatomic, ME_STRONG) UIColor *lineColor;

/**
 * Bar background color.
 * Defaults to clear [UIColor clearColor];
 */
@property (nonatomic, ME_STRONG) UIColor *progressRemainingColor;

/**
 * Bar progress color.
 * Defaults to white [UIColor whiteColor].
 */
@property (nonatomic, ME_STRONG) UIColor *progressColor;

@end
