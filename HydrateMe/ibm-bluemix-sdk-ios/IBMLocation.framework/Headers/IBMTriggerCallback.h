//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMTriggerCallback.h
//  IBMLocation iOS SDK

@class IBMLocationContext;

typedef void (^IBMTriggerCallbackBlock)(IBMLocationContext *locationContext);

/**
 A callback for when a trigger is activated.
 
 The IBMTriggerCallback class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMTriggerCallback : NSObject

/**
 The callback block that is executed when the trigger is activated.
 */
@property (nonatomic,readonly) IBMTriggerCallbackBlock callbackBlock;

/**
 This constructor is used to initialize an IBMTriggerCallback.
 
 @param callbackBlock The callback block that will be exeecuted when the trigger is activated.
 */
-(id) initWithBlock:(IBMTriggerCallbackBlock)callbackBlock;

/**
 The method will be executed when the trigger is activated.
 
 @param locationContext The device context at the time when the trigger is activated.
 */
- (void) execute:(IBMLocationContext *)locationContext;

@end
