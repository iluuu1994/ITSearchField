//
//  ITSearchField.h
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

#import <Cocoa/Cocoa.h>

/**
 * ITSearchFieldDelegate
 */
@class ITSearchField;

@protocol ITSearchFieldDelegate <NSTextFieldDelegate>
@optional
- (BOOL)searchFieldShouldExpand:(ITSearchField *)searchField;
- (BOOL)searchFieldShouldCollapse:(ITSearchField *)searchField;
- (void)searchFieldDidExpand:(ITSearchField *)searchField;
- (void)searchFieldDidCollapse:(ITSearchField *)searchField;
@end

@interface ITSearchField : NSSearchField

@property (nonatomic) BOOL isCollapsed;
@property (nonatomic) float animationDuration;
@property (nonatomic) float expandedWidth;

@property (nonatomic, readonly) float collapsedWidth;

- (void)toggleWidth;

// Override delegate setter & getter
- (id<ITSearchFieldDelegate>)delegate;
- (void)setDelegate:(id<ITSearchFieldDelegate>)anObject;

@end
