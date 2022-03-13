({
    getsObjectName : function(component, event, helper) {
        let action = component.get("c.fetchsObjectDetails");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result returned: '+result);
                component.set("v.wrapperObj",result);
            }else{
                console.log('Something went wrong!');
            }
        });
        $A.enqueueAction(action);
    }
})
