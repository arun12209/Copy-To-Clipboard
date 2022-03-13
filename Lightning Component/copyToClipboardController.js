({
    doInit : function(component, event, helper) {
        //get the object details from apex
        helper.getsObjectName(component,event,helper);
    },
    copyLink:function(component,event,helper){
		//dynamically creating html component
        var hiddenInputEle = document.createElement("input");
        //get the title of clicked element (record link)
        let val = event.getSource().get("v.title");
        //set value attribute as actual record link
        hiddenInputEle.setAttribute("value", val);
        //append the element in the document body
        document.body.appendChild(hiddenInputEle);
        // select the content
        hiddenInputEle.select();
        // Execute the copy command
        document.execCommand("copy");
        document.body.removeChild(hiddenInputEle); 
        //Show toast message after link copied in the clipboard
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'sticky',
            title: 'Success!',
            message: 'Link has been copied to clipboard.',
            type: 'success'
            
        });
        toastEvent.fire();
        
    }
})
