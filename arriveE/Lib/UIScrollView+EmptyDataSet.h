//
//  UIScrollView+EmptyDataSet.h
//  DZNEmptyDataSet
//  https://github.com/dzenbot/DZNEmptyDataSet
//
//  Created by Ignacio Romero Zurbuchen on 6/20/14.
//  Copyright (c) 2016 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DZNEmptyDataSetSource;
@protocol DZNEmptyDataSetDelegate;

#define DZNEmptyDataSetDeprecated(instead) DEPRECATED_MSG_ATTRIBUTE(" Use " # instead " instead")


@interface UIScrollView (EmptyDataSet)

/** The empty datasets data source. */
@property (nonatomic, weak, nullable) IBOutlet id <DZNEmptyDataSetSource> emptyDataSetSource;
/** The empty datasets delegate. */
@property (nonatomic, weak, nullable) IBOutlet id <DZNEmptyDataSetDelegate> emptyDataSetDelegate;
/** YES if any empty dataset is visible. */
@property (nonatomic, readonly, getter = isEmptyDataSetVisible) BOOL emptyDataSetVisible;


- (void)reloadEmptyDataSet;

@end


@protocol DZNEmptyDataSetSource <NSObject>
@optional


- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;

- (nullable NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;

/**
 Asks the data source for the image of the dataset.
 
 @param scrollView A scrollView subclass informing the data source.
 @return An image for the dataset.
 */
- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;


/**
 Asks the data source for a tint color of the image dataset. Default is nil.
 
 @param scrollView A scrollView subclass object informing the data source.
 @return A color to tint the image of the dataset.
 */
- (nullable UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView;

/**
 *  Asks the data source for the image animation of the dataset.
 *
 *  @param scrollView A scrollView subclass object informing the delegate.
 *
 *  @return image animation
 */
- (nullable CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView;


- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;


- (nullable UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;


- (nullable UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;


- (nullable UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView;


- (nullable UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;


- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView DZNEmptyDataSetDeprecated(-verticalOffsetForEmptyDataSet:);
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;


- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView;

@end



@protocol DZNEmptyDataSetDelegate <NSObject>
@optional


- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView;


- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView;


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView;

/**
 Asks the delegate for touch permission. Default is YES.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return YES if the empty dataset receives touch gestures.
 */
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;

/**
 Asks the delegate for scroll permission. Default is NO.
 
 @param scrollView A scrollView subclass object informing the delegate.
 @return YES if the empty dataset is allowed to be scrollable.
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView;


- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty dataset view was tapped.
 Use this method either to resignFirstResponder of a textfield or searchBar.
 
 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView DZNEmptyDataSetDeprecated(-emptyDataSet:didTapView:);

/**
 Tells the delegate that the action button was tapped.
 
 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView DZNEmptyDataSetDeprecated(-emptyDataSet:didTapButton:);

/**
 Tells the delegate that the empty dataset view was tapped.
 Use this method either to resignFirstResponder of a textfield or searchBar.
 
 @param scrollView A scrollView subclass informing the delegate.
 @param view the view tapped by the user
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view;

/**
 Tells the delegate that the action button was tapped.
 
 @param scrollView A scrollView subclass informing the delegate.
 @param button the button tapped by the user
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;

/**
 Tells the delegate that the empty data set will appear.

 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set did appear.

 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set will disappear.

 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView;

/**
 Tells the delegate that the empty data set did disappear.

 @param scrollView A scrollView subclass informing the delegate.
 */
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView;

@end

#undef DZNEmptyDataSetDeprecated

NS_ASSUME_NONNULL_END
