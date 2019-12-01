# apex-batch-delete
Simple Apex Batch class for deleting data inside a Salesforce environment for the objects specified.
The batch class chains over itself until it's processed all objects.

Deploy to Org and run:
`Database.executeBatch(new MassDeleteBatch());`

<a href="https://githubsfdeploy.herokuapp.com/app/githubdeploy/benedwards44/apex-batch-delete">
    <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

