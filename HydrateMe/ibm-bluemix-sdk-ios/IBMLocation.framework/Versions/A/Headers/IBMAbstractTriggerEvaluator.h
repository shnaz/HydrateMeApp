//-------------------------------------------------------------------------------
// IBM Confidential OCO Source Materials
// XXXX-XXX Copyright IBM Corp. 2013
// The source code for this program is not published or otherwise
// divested of its trade secrets, irrespective of what has
// been deposited with the U.S. Copyright Office.
//-------------------------------------------------------------------------------
//
//  IBMAbstractTriggerEvaluator.h
//  IBMLocation iOS SDK

@class IBMAbstractTrigger;
@class IBMLocationConfiguration;

/**
 * A trigger evaluator wrapper for {@link AbstractTrigger}
 */
@interface IBMAbstractTriggerEvaluator : NSObject

@property id triggerDefinition;

- (id) initWithTriggerDef:(IBMAbstractTrigger*) triggerDef ;
/**
 * Called before a trigger evaluator is discarded (in order to do cleanup)
 */
- (void) preDestroy  ;
/**
 * Called every time there is a configuration update (new start acquisition) for
 * trigger evaluators which are active for the current configuration
 */
- (void) notifyOfConfigurationUpdate : (IBMLocationConfiguration*) config ;

@end

