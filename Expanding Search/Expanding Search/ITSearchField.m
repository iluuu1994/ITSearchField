//
//  ITSearchField.m
//  Expanding Search
//
//  Created by Ilija Tovilo on 12/3/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

// Copyright (c) 2012, Ilija Tovilo
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ITSearchField.h"
#import "ITSearchFieldCell.h"

#import <QuartzCore/QuartzCore.h>
#import "NSView+NSLayoutConstraintFilter.h"
#import "NSAnimationContext+Blocks.h"

#define kCollapsedWidth 26
#define kDefaultExpandedWidth 200.0
#define kDefaultAnimationDuration 0.2

@implementation ITSearchField

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _isCollapsed = YES;
        _expandedWidth = kDefaultExpandedWidth;
        _animationDuration = kDefaultAnimationDuration;
    }
    return self;
}

- (void)toggleWidth {
    self.isCollapsed = !self.isCollapsed;
}

- (BOOL)_canExpand {
    if ([self.delegate respondsToSelector:@selector(searchFieldShouldExpand:)]) {
        return [self.delegate searchFieldShouldExpand:self];
    }
    
    return YES;
}

- (BOOL)_canCollapse {
    if ([self.delegate respondsToSelector:@selector(searchFieldShouldCollapse:)]) {
        return [self.delegate searchFieldShouldCollapse:self];
    }
    
    return YES;
}

#pragma mark Setters & Getters
- (id<ITSearchFieldDelegate>)delegate {
    return super.delegate;
}
- (void)setDelegate:(id<ITSearchFieldDelegate>)anObject {
    [super setDelegate:anObject];
}

- (void)setIsCollapsed:(BOOL)isCollapsed {
    BOOL performAction = (isCollapsed)?[self _canCollapse]:[self _canExpand];
    
    if (performAction) {
        [self.window makeFirstResponder:nil];
        
        float newWidth = (isCollapsed)?kCollapsedWidth:self.expandedWidth;
        
        [NSAnimationContext groupWithDuration:self.animationDuration timingFunctionWithName:kCAMediaTimingFunctionEaseOut completionHandler:^{
            if (!isCollapsed) {
                [self.window makeFirstResponder:self];
            }
            
            // Sometimes the view doesn't redraw when the animation is slow.
            // Therefore we do a redraw the control at the end of the animation.
            [self setNeedsDisplay:YES];
            
            // Notify the delegate
            if (_isCollapsed) {
                if ([self.delegate respondsToSelector:@selector(searchFieldDidCollapse:)]) {
                    [self.delegate searchFieldDidCollapse:self];
                }
            } else {
                if ([self.delegate respondsToSelector:@selector(searchFieldDidExpand:)]) {
                    [self.delegate searchFieldDidExpand:self];
                }
            }
            
            _isCollapsed = isCollapsed;
        } animationBlock:^{
            NSLayoutConstraint *constraint = [self constraintForAttribute:NSLayoutAttributeWidth];
            [[constraint animator] setConstant:newWidth];
        }];    
    
    }
}

- (float)collapsedWidth {
    return kCollapsedWidth;
}

@end
