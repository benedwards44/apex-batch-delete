/**
* @author Ben Edwards (beedwards@deloitte.co.nz)
* @date 1st December 2019
* @description Test class for MassDeleteBatch
*
* CHANGE LOG
**/
@isTest 
public class MassDeleteBatchTest {
    
    @TestSetup
    static void makeData(){

        // Create a test account
        insert new Account(
            Name = 'Test Account'
        );
    }

    @isTest 
    static void testBatch() {

        // Load the batch class and test both constructors
        // Going to force Account here to validate our batch
        MassDeleteBatch testBatch = new MassDeleteBatch();
        testBatch = new MassDeleteBatch('Account');

        Test.startTest();

        Database.executeBatch(testBatch);

        Test.stopTest();

        system.assertEquals(0, [SELECT count() FROM Account], 'All accounts should be deleted.');
    }

}
