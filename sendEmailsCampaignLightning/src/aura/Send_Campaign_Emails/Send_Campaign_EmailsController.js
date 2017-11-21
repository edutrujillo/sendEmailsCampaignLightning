({
	doInit : function(component, event, helper) {
		var main = component.get('c.sendEmails');
        var id = component.get('v.recordId');
        main.setParams({id : id});
        main.setCallback(this, function(response){ 
            $A.get('e.force:refreshView').fire(); 
            $A.get("e.force:closeQuickAction").fire();
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                mode: 'sticky',
                message: 'Emails enviados a los invitados a la campaña'               
            });
            toastEvent.fire();
        });
        $A.enqueueAction(main);
	
	}
})