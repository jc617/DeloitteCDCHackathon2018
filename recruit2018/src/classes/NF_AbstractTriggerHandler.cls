/**
* @File Name:   NF_AbstractTriggerHandler.cls
* @Description:   
* @Author:      Recruiter
* @Group:       Apex
* @Modification Log :
*-------------------------------------------------------------------------------------
* Ver       Date        Author      Modification
* 1.0       2017-05-09  Recruiter    Created the file/class
*/

public with sharing abstract class NF_AbstractTriggerHandler implements NF_TriggerInterface{

    public virtual void beforeBulk(){}

    public virtual void afterBulk(){} 

    public virtual void beforeInsert(){}
 
    public virtual void beforeUpdate(){}

    public virtual void beforeDelete(){}

    public virtual void afterInsert(){}

    public virtual void afterUpdate(){}

    public virtual void afterDelete(){}

    public virtual void afterUndelete(){}

    public virtual void andFinally(){}
}