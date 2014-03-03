/*
 * Copyright 2012-present Pixate, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ComPixateFreestyleModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiUIView.h"
#import "TiViewProxy.h"
#import "Ti2DMatrix.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import <PixateFreestyle/PixateFreestyle.h>

@implementation ComPixateFreestyleModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"335fc77b-2f61-472d-9c47-9038a90e4b55";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.pixate.framework";
}

#pragma Pixate enums

MAKE_SYSTEM_PROP(PXStylesheetOriginApplication, PXStylesheetOriginApplication);
MAKE_SYSTEM_PROP(PXStylesheetOriginUser,        PXStylesheetOriginUser);
MAKE_SYSTEM_PROP(PXStylesheetOriginView,        PXStylesheetOriginView);

#pragma Pixate API

- (void)styleSheetFromFilePathWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *aFilePath = [TiUtils stringValue:[args valueForKey:@"filename"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];

    PXStylesheet *pxs = [PixateFreestyle styleSheetFromFilePath:aFilePath withOrigin:origin];

    if([args valueForKey:@"monitor"] != nil)
    {
        [pxs setMonitorChanges:[TiUtils boolValue:[args valueForKey:@"monitor"]]];
    }
}

- (void)styleSheetFromSourceWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);

    NSString *source = [TiUtils stringValue:[args valueForKey:@"source"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];

    [PixateFreestyle styleSheetFromSource:source withOrigin:origin];
}

- (void)applyStylesheets:(id)args
{
    NSLog(@"[Pixate applyStylesheets] has been deprecated and has been replaced by [Pixate updateStylesForAllViews]")
    [PixateFreestyle updateStylesForAllViews];
}

- (void)updateStylesForAllViews
{
    [PixateFreestyle updateStylesForAllViews];
}

- (id)refreshStylesWithOrientationChange
{
    return NUMBOOL(PixateFreestyle.refreshStylesWithOrientationChange);
}

-(void)setRefreshStylesWithOrientationChange:(id)val
{
    [PixateFreestyle setRefreshStylesWithOrientationChange: [TiUtils boolValue:val]];
}

- (NSString *)version
{
    return PixateFreestyle.version;
}

- (NSDate *)buildDate
{
    return PixateFreestyle.buildDate;
}

@end

@interface TiViewProxy (Pixate)
@end

@implementation TiViewProxy (Pixate)

+(void)load
{
    [self swizzleMethod:@selector(relayout) withMethod:@selector(px_relayout)];
}

-(void)updateStyles:(id)arg
{
    TiThreadPerformOnMainThread(^{
        if([self.view respondsToSelector:@selector(updateStyles)])
        {
            [[self view] updateStyles];
        }
    }, NO);
}

-(void)updateStylesNonRecursively:(id)arg
{
    TiThreadPerformOnMainThread(^{
        if([self.view respondsToSelector:@selector(updateStylesNonRecursively)])
        {
            [[self view] updateStylesNonRecursively];
        }
    }, NO);
}

-(void)px_relayout
{
    [self px_relayout];
    [self updateStylesNonRecursively:nil];
}

+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel
{
	Class c = self;
    Method origMethod = class_getInstanceMethod(c, orig_sel);
    Method altMethod = class_getInstanceMethod(c, alt_sel);

    if (class_addMethod(c, orig_sel, method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
    {
        class_replaceMethod(c, alt_sel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, altMethod);
    }
}

@end

////////


@interface TiUIView (Pixate)
@end

@implementation TiUIView (Pixate)

- (void)setStyleId_:(id)value
{
    [self.accessibilityElement setStyleId:[TiUtils stringValue:value]];
}

- (void)setStyleClass_:(id)value
{
    [self.accessibilityElement setStyleClass:[TiUtils stringValue:value]];
}

- (void)setStyleCSS_:(id)value
{
    [self.accessibilityElement setStyleCSS:[TiUtils stringValue:value]];
}

- (void)px_set2DTransform:(NSValue *)transform
{
    [self setTransform_:[[Ti2DMatrix alloc] initWithMatrix:[transform CGAffineTransformValue]]];
}

- (void)px_setLayoutInfo:(NSValue *)frame transform:(NSValue *)transform
{
    CGRect frame_ = [frame CGRectValue];
    CGPoint origin_ = frame_.origin;
    CGSize size_ = frame_.size;
    CGAffineTransform transform_ = CGAffineTransformIdentity;

    [transform getValue:&transform_];

    if(CGAffineTransformIsIdentity(transform_) == NO) // && [self isKindOfClass:[UIView class]])
    {
        [self setTransform_:[[Ti2DMatrix alloc] initWithMatrix:CGAffineTransformIdentity]];
    }

    // use Ti API to get to proxy
    TiProxy *tiProxy = self.proxy;

    if([tiProxy isKindOfClass:[TiViewProxy class]])
    {
        TiViewProxy *viewProxy = (TiViewProxy *)tiProxy;

        // Use Ti API to set the 4 settings
        if(origin_.x != MAXFLOAT)
        {
            [viewProxy setLeft:[NSNumber numberWithFloat:origin_.x]];
            //            [proxy performSelector:@selector(setLeft:) withObject:[NSNumber numberWithFloat:context.left]];
        }
        if(origin_.y != MAXFLOAT)
        {
            [viewProxy setTop:[NSNumber numberWithFloat:origin_.y]];
            //            [proxy performSelector:@selector(setTop:) withObject:[NSNumber numberWithFloat:context.top]];
        }
        if(size_.width != 0.0f)
        {
            [viewProxy setWidth:[NSNumber numberWithFloat:size_.width]];
            //            [proxy performSelector:@selector(setWidth:) withObject:[NSNumber numberWithFloat:context.width]];
        }
        if(size_.height != 0.0f)
        {
            [viewProxy setHeight:[NSNumber numberWithFloat:size_.height]];
            //            [proxy performSelector:@selector(setHeight:) withObject:[NSNumber numberWithFloat:context.height]];
        }
    }

    if(CGAffineTransformIsIdentity(transform_) == NO) // && [self isKindOfClass:[UIView class]])
    {
        [self setTransform_:[[Ti2DMatrix alloc] initWithMatrix:transform_]];
    }
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

@end
