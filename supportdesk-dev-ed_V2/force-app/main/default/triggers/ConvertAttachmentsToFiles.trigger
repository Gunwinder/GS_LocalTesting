trigger ConvertAttachmentsToFiles on Case (before insert,after update) {
    for (case c:trigger.new){ /*
		//Get attachment
                Attachment attach = [SELECT Id, OwnerId,Name, Body, ContentType, ParentId From Attachment LIMIT  1];
                 
                //Insert ContentVersion
                ContentVersion cVersion = new ContentVersion();
                cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
                cVersion.PathOnClient = attach.Name;//File name with extention
                cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
                cVersion.OwnerId = attach.OwnerId;//Owner of the file
                cVersion.Title = attach.Name;//Name of the file
                cVersion.VersionData = attach.Body;//File content
                Insert cVersion;
                 
                //After saved the Content Verison, get the ContentDocumentId
                Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
                 
                //Insert ContentDocumentLink
                ContentDocumentLink cDocLink = new ContentDocumentLink();
                cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
                cDocLink.LinkedEntityId = attach.ParentId;//Add attachment parentId
                cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                cDocLink.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
                Insert cDocLink;
     */    
    }
}