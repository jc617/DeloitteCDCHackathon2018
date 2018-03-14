/**
* @File Name:   NF_TriggerFactory.cls
* @Description:   
* @Author:      Recruiter
* @Group:       Apex
* @Modification Log :
*-------------------------------------------------------------------------------------
* Ver       Date        Author      Modification
* 1.0       2017-05-09  Recruiter    Created the file/class
*/

public without sharing class NF_TriggerFactory {
    @TestVisible
    private static Map<String, boolean> TriggerSequencer = null;
    @TestVisible
    private static Map<Schema.sObjectType, String> TriggerHandlerMap = null;

    static{
        TriggerHandlerMap = new Map<Schema.sObjectType, String>();
        TriggerHandlerMap.put(Contact.sObjectType, 'NF_ContactTriggerHandler_Sample');
    }
    
    /**
    * @Name          getHandler
    * @Description   Get trigger handler for sObject
    * @Author        Recruiter
    * @CreatedDate   2017-05-09
    * @Param         Schema.sObjectType soType
    * @Return        NF_TriggerInterface
    */
    private static NF_TriggerInterface getHandler(Schema.sObjectType soType)
    {
        if(TriggerHandlerMap.containsKey(soType)){
            String className = TriggerHandlerMap.get(soType);
            return (NF_TriggerInterface)Type.forName(className).newInstance();
        }

        return null;
    } 
    
    /**
    * @Name          CreateHandlerAndExecute
    * @Description   Create Trigger handler and execute
    * @Author        Recruiter
    * @CreatedDate   2017-05-09
    * @Param         Schema.sObjectType soType
    * @Return        void
    */
    public static void CreateHandlerAndExecute(Schema.sObjectType soType)
    {
        NF_TriggerInterface handler = getHandler(soType);
        if(handler == null)
        {
            throw new TriggerException ('No trigger handler registered for Object Type: ' + soType);
        }
        execute(handler);
    }

    /**
    * @Name          execute
    * @Description   Get trigger handler for sObject
    * @Author        Recruiter
    * @CreatedDate   2017-05-09
    * @Param         NF_TriggerInterface
    * @Return        void
    */
    private static void execute(NF_TriggerInterface handler)
    {
        if(Trigger.isBefore)
        {
            handler.beforeBulk();
            
            if(Trigger.isDelete)
            {
               handler.beforeDelete();
            }
            else if(Trigger.isInsert)
            {
               handler.beforeInsert();
            }
            else if(Trigger.isUpdate)
            {
               handler.beforeUpdate();
            }
        }
        else
        {
            handler.afterBulk();
            
            if(Trigger.isDelete)
            {
               handler.afterDelete();
            }
            else if(Trigger.isInsert)
            {
               handler.afterInsert();
            }
            else if(Trigger.isUpdate)
            {
               handler.afterUpdate();
            }
            else if(Trigger.isUndelete)
            {
               handler.afterUndelete();
            }
        }

        handler.andFinally();
    }

    /**
    * @Name          GetClassName
    * @Description   Get Class Name
    * @Author        Recruiter
    * @CreatedDate   2017-05-09
    * @Param         Object handler
    * @Return        string
    */
    private static string GetClassName(Object handler)
    {
        string retVal = '';
        for (string objectName : string.valueof(handler).split(':'))
        {
            retVal = objectName;
            break;
        }
        return retVal;
    }

    /**
    * @Name          TriggerException
    * @Description   Trigger Exception Class
    * @Author        Recruiter
    * @CreatedDate   2017-05-09
    */
    public class TriggerException extends Exception{}
}