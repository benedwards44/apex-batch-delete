/**
* @author Ben Edwards (beedwards@deloitte.co.nz)
* @date 1st December 2019
* @description Batch class to mass delete all records in a given environment, in the order specified
*              Run:
*              Database.executeBatch(new MassDeleteBatch()); 
*
* CHANGE LOG
**/
public class MassDeleteBatch implements Database.Batchable<SObject> {

    // Add objects to this list to chain through objects and clear out all records
    // Ensure to put child objects first, and ones that cause deletes to fail.
    public static final List<String> OBJECT_NAMES = new List<String>{
        'Case',
        'Opportunity',
        'Order',
        'Contact',
        'Account'
    };

    // The current object name being run within the batch
    public String currentObjectName;

    // Default Constructor to start on first object in list
    public MassDeleteBatch() {
        this.currentObjectName = OBJECT_NAMES[0];
    }

    // Constructor to accept object name to process job for/
    // This is called in the finish method to process the next object
    public MassDeleteBatch(String objectName) {
        this.currentObjectName = objectName;
    }

    // Query for all records in the current object
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM ' + currentObjectName);
    }

    // Delete all records for the given scope
    public void execute(Database.BatchableContext BC, List<SObject> scope) {

        delete scope;
    }

    // Once finished on the current object, determine if there's another object
    // to process, and if so, run the batch again on the next object
    public void finish(Database.BatchableContext BC) {

        // If we have a next object to process
        // Then we run it again!
        if (getNextObject() != null) {

            Database.executeBatch(new MassDeleteBatch(getNextObject()));
        }
    }

    // Determine which object to do next
    public String getNextObject() {
        
        // Iterate over the objects in the list
        for (Integer i = 0; i < OBJECT_NAMES.size(); i++) {

            // If this is the current object in the list, get the next
            // item in the list
            if (currentObjectName == OBJECT_NAMES[i]) {

                try {

                    // Return the next object in list
                    return OBJECT_NAMES[i + 1];
                }
                // Will fail silently if object isn't found. Will mean
                // We're at end of list so we can stop
                catch (Exception ex) {}
            }
        }

        return null;
    }
}