//
//  NSAnimationContext+Blocks.h
//  Significator 2
//
//  Created by Ilija Tovilo on 12/19/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface NSAnimationContext (Blocks)
+ (void)groupWithDuration:(NSTimeInterval)duration
   timingFunctionWithName:(NSString *)timingFunction
        completionHandler:(void (^)(void))completionHandler
           animationBlock:(void (^)(void))animationBlock;

+ (void)groupWithDuration:(NSTimeInterval)duration
        completionHandler:(void (^)(void))completionHandler
           animationBlock:(void (^)(void))animationBlock;

+ (void)groupWithDuration:(NSTimeInterval)duration
           animationBlock:(void (^)(void))animationBlock;
@end