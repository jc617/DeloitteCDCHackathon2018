/**
* @File Name:   NF_TriggerInterface.cls
* @Description:   
* @Author:      Recruiter
* @Group:       Apex
* @Modification Log :
*-------------------------------------------------------------------------------------
* Ver       Date        Author      Modification
* 1.0       2017-05-09  Recruiter    Created the file/class
*/
public interface NF_TriggerInterface
{
    void beforeBulk();

    void afterBulk(); 

    void beforeInsert();
 
    void beforeUpdate();

    void beforeDelete();

    void afterInsert();

    void afterUpdate();

    void afterDelete();

    void afterUndelete();

    void andFinally();

}