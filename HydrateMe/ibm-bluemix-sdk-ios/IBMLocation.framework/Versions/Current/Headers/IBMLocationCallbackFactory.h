//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMLocationCallbackFactory.h
//  IBMLocation iOS SDK

@protocol IBMGeoCallback;
@protocol IBMGeoFailureCallback;
@class IBMTriggerCallback;
@class IBMLocationContext;
@class IBMGeoError;
@class IBMPosition;

/**
 A utility class that allows using blocks wherever a callback object is needed in the Location Services API.
 
 The IBMLocation class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMLocationCallbackFactory : NSObject

/**
 Create a IBMTriggerCallback that wraps the given block
 
 @param callbackBlock the block of custom code that executes in the callback.
 @return (IBMTriggerCallback *) The trigger callback created using the provided block
 */
+ (IBMTriggerCallback *)createTriggerCallback:(void (^)(IBMLocationContext *locationContext)) callbackBlock;

/**
 Create a IBMGeoCallback that wraps the given block
 
 @param callbackBlock the block of custom code that executes in the callback.
 @return (id<IBMGeoCallback>) The geo callback created using the provided block
 */
+ (id<IBMGeoCallback>)createGeoCallback:(void (^)(IBMPosition* pos))callbackBlock;

/**
 Create a IBMGeoFailureCallback that wraps the given block
 
 @param callbackBlock the block of custom code that executes in the callback.
 @return (id<IBMGeoFailureCallback>) The geo failure callback created using the provided block
 */
+ (id<IBMGeoFailureCallback>)createGeoFailureCallback:(void (^)(IBMGeoError* error))callbackBlock;

@end
