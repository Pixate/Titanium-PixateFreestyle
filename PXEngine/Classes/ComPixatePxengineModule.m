/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComPixatePxengineModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiUIView.h"
#import "TiViewProxy.h"

#import <objc/runtime.h>
#import <objc/message.h>

@class PXEngine;
@class PXStylesheet;
@class PXStyleUtils;

@implementation ComPixatePxengineModule

#pragma mark Internal

// this is generated for your module, please do not change it
- (id)moduleGUID
{
	return @"e7b14a43-901c-41eb-9b25-76e859290cdd";
}

// this is generated for your module, please do not change it
- (NSString*)moduleId
{
	return @"com.pixate.pxengine";
}

- (void) licenseKeyForUser:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *user    = [TiUtils stringValue:[args valueForKey:@"licenseUser"]];
    NSString *serial = [TiUtils stringValue:[args valueForKey:@"licenseSerial"]];
    
    [PXEngine licenseKey:serial forUser:user];
}

- (void) styleSheetFromFilePathWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *aFilePath = [TiUtils stringValue:[args valueForKey:@"filename"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];
    
    PXStylesheet *pxs = [PXStylesheet styleSheetFromFilePath:aFilePath withOrigin:origin];

    if([args valueForKey:@"monitor"] != nil)
    {
        [pxs setMonitorChanges:[TiUtils boolValue:[args valueForKey:@"monitor"]]];
    }
}

- (void) styleSheetFromSourceWithOrigin:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *source = [TiUtils stringValue:[args valueForKey:@"source"]];
    int       origin    = [TiUtils intValue:[args valueForKey:@"origin"]];
    
    [PXStylesheet styleSheetFromSource:source withOrigin:origin];
}

- (void) applyStylesheets:(id)args
{
    [PXStylesheet applyStylesheets];
}

- (id)refreshStylesWithOrientationChange
{
    return NUMBOOL([[PXEngine sharedInstance] refreshStylesWithOrientationChange]);
}

-(void)setRefreshStylesWithOrientationChange:(id)val
{
    [[PXEngine sharedInstance] setRefreshStylesWithOrientationChange: [TiUtils boolValue:val]];
}

- (NSString *) version
{
    return [[PXEngine sharedInstance] version];
}

- (NSDate *) buildDate
{
    return [[PXEngine sharedInstance] buildDate];
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

@end
