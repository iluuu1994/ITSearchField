//
//  NSAnimationContext+Blocks.m
//  Significator 2
//
//  Created by Ilija Tovilo on 12/19/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import "NSAnimationContext+Blocks.h"

@implementation NSAnimationContext (Blocks)

+ (void)groupWithDuration:(NSTimeInterval)duration
   timingFunctionWithName:(NSString *)timingFunction
        completionHandler:(void (^)(void))completionHandler
           animationBlock:(void (^)(void))animationBlock {

    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:duration];
    [[NSAnimationContext currentContext] setCompletionHandler:completionHandler];
    
    if (timingFunction != nil) {
        [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:timingFunction]];
    }
    
    animationBlock();
    
    [NSAnimationContext endGrouping];
    
}

+ (void)groupWithDuration:(NSTimeInterval)duration
        completionHandler:(void (^)(void))completionHandler
           animationBlock:(void (^)(void))animationBlock {

    [self groupWithDuration:duration
     timingFunctionWithName:nil
          completionHandler:completionHandler
             animationBlock:animationBlock];
}

+ (void)groupWithDuration:(NSTimeInterval)duration
           animationBlock:(void (^)(void))animationBlock {
    [self groupWithDuration:duration completionHandler:nil animationBlock:animationBlock];
}
@end
