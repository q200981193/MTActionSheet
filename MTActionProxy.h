//
//  MTActionProxy.h
//  Omnivore
//
//  Created by Marco Tabini on 11-09-20.
//  Copyright (c) 2011 AFK Studio Partnership. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTActionProxy : NSObject <UIAlertViewDelegate, UIActionSheetDelegate> {
    NSMutableDictionary *_completionBlocks;
}


+ (MTActionProxy *) proxy;


- (void) addActionForButtonAtIndex:(NSInteger) buttonIndex completionBlock:(void (^)()) completionBlock;


@end
