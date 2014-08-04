//
//  SideMenuController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 23/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuOptions.h"
@interface SideMenuController : UIViewController

/** View controller showed as menu view @see changeMenuViewController:closeMenu: */
@property (nonatomic, strong, readonly) UIViewController *menuViewController;

/** View controller showed as content view @see changeContentViewController:closeMenu: */
@property (nonatomic, strong, readonly) UIViewController *contentViewController;

/** Menu options parameters @see MVSideMenuOptions */
@property (nonatomic, copy) SideMenuOptions *options;

/** Frame of menu view, origin.y value will be ignored and setted to 0. Negative values indicates that will fill parent view.
 By default { origin: { x: 0, y: 0 }, size: { width: parentWidth - 60, heigth: -1 }} */
@property (nonatomic, assign) CGRect menuFrame;

/** This method create an instance of MVYSideMenuController with default options.
 
 @param menuViewController The view controller showed as menu view.
 @param contentViewController The view controller showed as content view.
 @return An instance of SideMenuController.
 */
- (id)initWithMenuViewController:(UIViewController *)menuViewController contentViewController:(UIViewController *)contentViewController;

/** Create an instance of MVYSideMenuController with custom options.
 
 @param menuViewController The view controller showed as menu view.
 @param contentViewController The view controller showed as content view.
 @param options Menu options parameters @see SideMenuOptions.
 @return An instance of SideMenuController.
 */
- (id)initWithMenuViewController:(UIViewController *)menuViewController contentViewController:(UIViewController *)contentViewController options:(SideMenuOptions *)options;

/** Close menu animated. */
- (void)closeMenu;

/** Open menu animated. */
- (void)openMenu;

/** Toggle to closed from opened and vice versa. */
- (void)toggleMenu;

/** Disable gestures. */
- (void)disable;

/** Enable gestures. */
- (void)enable;

/** Change content view.
 
 @param contentViewController The view controller showed as content view.
 @param closeMenu If YES close menu animated.
 */
- (void)changeContentViewController:(UIViewController *)contentViewController closeMenu:(BOOL)closeMenu;

/** Change menu view.
 
 @param menuViewController The view controller showed as menu view.
 @param closeMenu If YES close menu animated.
 */
- (void)changeMenuViewController:(UIViewController *)menuViewController closeMenu:(BOOL)closeMenu;

@end

@interface UIViewController (SideMenuController)
- (SideMenuController *)sideMenuController;
- (void)addLeftMenuButtonWithImage:(UIImage *)buttonImage;
-(void)addrightMenuButtonWithImage:(UIImage *)buttonImage;
@end