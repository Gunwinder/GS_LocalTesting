trigger ConvertAttachmentToFiles on Attachment (before insert) {
    
list<ContentVersion> lstCntVersionsToInsert = new list<ContentVersion>();
list<Attachment> lstAttachments = [SELECT Id, ParentId, Name, IsPrivate, Body, OwnerId, CreatedById, CreatedDate, Description FROM Attachment where ParentId != null];
    
    for(Attachment attIterator : lstAttachments) {
     ContentVersion objCntVersion = new ContentVersion();
     objCntVersion.Title = attIterator.Name;
     objCntVersion.PathOnClient = '/' + attIterator.Name;
     objCntVersion.VersionData = (attIterator.Body == null ? Blob.valueOf('.') : attIterator.Body);
     objCntVersion.Description = attIterator.Description;
     objCntVersion.SharingPrivacy = 'N'; // Can be always public.
     objCntVersion.FirstPublishLocationId = attIterator.ParentId; // Parent Id
     objCntVersion.OwnerId = attIterator.OwnerId;
     // To avoid "Documents in a user's private library must always be owned by that user" error.
     objCntVersion.CreatedById = attIterator.OwnerId; 
     objCntVersion.CreatedDate = attIterator.CreatedDate;
     objCntVersion.FirstPublishLocationId = attIterator.OwnerId;
     lstCntVersionsToInsert.add(objCntVersion);
    }

if(!lstCntVersionsToInsert.isEmpty()) {
    insert lstCntVersionsToInsert;
}
}