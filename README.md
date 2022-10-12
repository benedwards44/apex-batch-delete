# apex-batch-delete

Simple Apex Batch class for deleting data inside a Salesforce environment for the objects specified.
The batch class chains over itself until it's processed all objects.

To update the list of objects, edit the variable `OBJECT_NAMES` in the `MassDeleteBatch` class.

You need to add the Mass Data Delete Permission Set to the running user in order to run this job as it can be quite destructive.

Deploy to Org and run:
`Database.executeBatch(new MassDeleteBatch());`

<a href="https://githubsfdeploy.herokuapp.com/app/githubdeploy/benedwards44/apex-batch-delete">
    <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

