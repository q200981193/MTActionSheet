//
//  MTActionProxy.m
//  Omnivore
//
//  Created by Marco Tabini on 11-09-20.
//  Copyright (c) 2011 AFK Studio Partnership. All rights reserved.
//

#import "MTActionProxy.h"

@implementation MTActionProxy


#pragma mark - Global proxy list


+ (NSMutableArray *) proxyList {
    static NSMutableArray *proxyList;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxyList = [[NSMutableArray alloc] init];
    });
    
    return proxyList;
}


+ (void) addProxyToList:(MTActionProxy *) actionProxy {
    [[self proxyList] addObject:actionProxy];
}


+ (void) removeProxyFromList:(MTActionProxy *) actionProxy {
    [[self proxyList] removeObject:actionProxy];
}


#pragma mark - Actions


- (void) performActionForButtonAtIndex:(NSInteger) buttonIndex {
    void (^completionBlock)();
    
    completionBlock = [_completionBlocks objectForKey:[NSString stringWithFormat:@"block%d", buttonIndex]];
    
    if (completionBlock) {
        completionBlock();
    }
}


#pragma mark - UIActionSheet delegate


- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self performActionForButtonAtIndex:buttonIndex];
    
    [[self class] removeProxyFromList:self];
}


#pragma mark - UIAlertViewDelegate


- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self performActionForButtonAtIndex:buttonIndex];
    
    [[self class] removeProxyFromList:self];
}


#pragma mark - Initialization and properties


- (void) addActionForButtonAtIndex:(NSInteger)buttonIndex completionBlock:(void (^)())completionBlock {
    [_completionBlocks setObject:[completionBlock copy] forKey:[NSString stringWithFormat:@"block%d", buttonIndex]];
}


- (id) init {
    self = [super init];
    
    if (self) {
        _completionBlocks = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


+ (MTActionProxy *) proxy {
    MTActionProxy *proxy = [[MTActionProxy alloc] init];
    
    [self addProxyToList:proxy];
    
    return proxy;
}


@end
