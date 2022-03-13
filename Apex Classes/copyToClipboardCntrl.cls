/* Name:copyToClipboardCntrl
 * Description: This Apex class retrieve the sObject details such as Name, record link from database.
 * Created Date: 01/05/2019
 * LastModified Date:01/05/2019
 * Created By: Arun Kumar
 * Version: 1.0
*/
public class copyToClipboardCntrl {
    
    @AuraEnabled
    public static wrapperCls fetchsObjectDetails(Id recId){
        
        string sObjectTypeName = recId.getSObjectType().getDescribe().getName();
        SObject record = Database.query('Select Id, Name From ' + sObjectTypeName + ' Where Id = :recId');
        system.debug('Record = '+record);
        String iconName;
        String recordURL;
        string sObjectName = sObjectTypeName;
        
        List<Schema.DescribeTabSetResult> tabDescList = Schema.describeTabs();
        List<Schema.DescribeTabResult> tabDescResult = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeIconResult> iconDescResult = new List<Schema.DescribeIconResult>();
        
        for(Schema.DescribeTabSetResult tdl : tabDescList) { tabDescResult.addAll(tdl.getTabs()); }
        
        for(Schema.DescribeTabResult tdr : tabDescResult) {
            if( sObjectName == tdr.getSobjectName() ) {
                if( tdr.isCustom() == true ) {
                    iconDescResult.addAll(tdr.getIcons());
                } else {
                    iconName = 'standard:'+sObjectName.toLowerCase();
                }
            }
        }
        for (Schema.DescribeIconResult idr : iconDescResult) {
            if (idr.getContentType() == 'image/svg+xml'){
                iconName = 'custom:' + idr.getUrl().substringBetween('custom/','.svg').substringBefore('_');
                break;
            }
        }
        system.debug('Tab Icon Name'+ iconName);
        String urlInstance = String.valueof(System.URL.getSalesforceBaseURL().gethost());
        String s2 = urlInstance.removeEndIgnoreCase('.my.salesforce.com');
        String finalURL = 'https://'+s2+&#39;.lightning.force.com/lightning/r/'+sObjectTypeName+'/'+recId+'/view';
        
        String fieldValue = (String) record.get('Name');
        system.debug('Record: ' +fieldValue);
        wrapperCls wObject = new wrapperCls(fieldValue,finalURL,iconName);
        
        return wObject;
        
    }
    
    public class wrapperCls{
        @AuraEnabled
        public String sObjectName;
        @AuraEnabled
        public String recUrlLink;
        @AuraEnabled
        public String iconName;
        
        public wrapperCls(string sObjectName,String recUrlLink,String iconName){
            this.sObjectName = sObjectName;
            this.recUrlLink = recUrlLink;
            this.iconName = iconName;
        }
    }
}
