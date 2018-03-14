/**
* @File Name:	NF_ContactTrigger_Example.trigger
* @Description: An example trigger for testing  
* @Author:   	Recruiter
* @Group:   	Trigger
* @Modification Log	:
*-------------------------------------------------------------------------------------
* Ver       Date        Author      Modification
* 1.0       2017-05-09  Recruiter    Created the file/class
*/
trigger NF_ContactTrigger_Example on Contact (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
	NF_TriggerFactory.CreateHandlerAndExecute(Contact.sObjectType);
}