# Campus Recruitment


## Getting Started

1.	Do a clone of the git Repository https://bitbucket.org/CampusRecruit/recruit2018
2.	Create a “feature” branch to your own repository

### Prerequisites

1.	If not already done, sign up to a salesforce developer account to get access to a developer org : https://developer.salesforce.com/signup
2.	Read up around trigger in salesforce : https://trailhead.salesforce.com/en/modules/apex_triggers/units/apex_triggers_intro
3.	Read up around DML in salesforce : https://trailhead.salesforce.com/en/modules/apex_database/units/apex_database_dml
### Requirement

1.	Login to the salesforce org.
2.	Create a custom text field as a unique external ID on the contact object - labelled "ExternalID" (https://help.salesforce.com/articleView?id=adding_fields.htm&type=5)
3.	Use the "Developer Console" (https://developer.salesforce.com/page/Developer_Console) to create the classes in the salesforce developer environment. If you are more comfortable with an IDE, feel free to use the IDE but this is not required. Using "Developer Console" should be sufficient for the purpose of the current coding exercise. If you use an IDE, make sure it is connected to your Salesforce org so that you can run your changes on the cloud. Otherwise, re-create the files from the repo you cloned in the Developer Console for your org.
4. Reuse the classes provided from the cloned git repository to implement the trigger. Ref to NF_ContactTrigger_Example.trg as the example for the trigger
5. Create a trigger on the account object 
6. The trigger should create a corresponding “contact” that will have the same name as the created “account” and the "ExternalID" on the contact will have the Account ID.
7.  Commit to “feature” branch the changed code
8.	Merge to master
9. 	Upload a screen capture of all the generated contacts 
10.	Provide your repository (Public access) to the reviewer (CampusRecruit)

