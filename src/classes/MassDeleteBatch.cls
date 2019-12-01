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

    // Add objects to this list to chain through objects and clear
    // out all records
    // Ensure to put child objects first, and ones that cause deletes to fail.
    public static final List<String> OBJECT_NAMES = new List<String>{
        'Case',
        'Opportunity',
        'Order',
        'Contact',
        'Account'
    };

    // The object name to query for and replace emails for
    public String currentObjectName;

    // Default Constructor to start on first object in list
    public MassDeleteBatch() {
        // Start with the first object
        this.currentObjectName = OBJECT_NAMES[0];
    }

    // Constructor to accept object name to process job for
    public MassDeleteBatch(String objectName) {
        this.currentObjectName = objectName;
    }

    // Query for all email fields for the object
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Return the query
        return Database.getQueryLocator('SELECT Id FROM ' + currentObjectName);
    }

    // Execute the records
    public void execute(Database.BatchableContext BC, List<SObject> scope) {

        delete scope;
    }

    public void finish(Database.BatchableContext BC) {

        // If we have a next object to process
        // Then we run it again!
        if (getNextObject() != null) {

            Database.executeBatch(new MassDeleteBatch(getNextObject()));
        }
    }

    // Determine which object to do next
    public String getNextObject() {

        for (Integer i = 0; i < OBJECT_NAMES.size(); i++) {

            if (currentObjectName == OBJECT_NAMES[i]) {

                try {

                    return OBJECT_NAMES[i + 1];
                }
                catch (Exception ex) {}
            }
        }

        return null;
    }
}